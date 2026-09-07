#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${NVIM_CONFIG_DIR:-$HOME/.config/nvim}"
MIN_NVIM_VERSION="${MIN_NVIM_VERSION:-0.12.0}"
NEOVIM_CHANNEL="${NEOVIM_CHANNEL:-stable}"

LSP_SERVERS=(
  bashls
  cssls
  clangd
  emmet_ls
  gopls
  html
  jsonls
  lua_ls
  pyright
  rust_analyzer
  ts_ls
  yamlls
)

TREESITTER_PARSERS=(
  json html css vim lua javascript typescript tsx markdown markdown_inline
  kotlin java python c cpp cuda dart go latex sql vue vimdoc
)

info()  { printf '\033[1;34m[INFO]\033[0m %s\n' "$*"; }
warn()  { printf '\033[1;33m[WARN]\033[0m %s\n' "$*" >&2; }
error() { printf '\033[1;31m[ERROR]\033[0m %s\n' "$*" >&2; }
die()   { error "$*"; exit 1; }

command_exists() { command -v "$1" >/dev/null 2>&1; }

version_ge() {
  awk -v a="$1" -v b="$2" 'BEGIN {
    split(a, A, /[.-]/)
    split(b, B, /[.-]/)
    n = length(A) > length(B) ? length(A) : length(B)
    for (i = 1; i <= n; i++) {
      x = A[i] + 0
      y = B[i] + 0
      if (x > y) exit 0
      if (x < y) exit 1
    }
    exit 0
  }'
}

nvim_version() {
  nvim --version | awk 'NR == 1 {
    sub(/^v/, "", $2)
    split($2, parts, "-")
    print parts[1]
  }'
}

detect_os() {
  case "$(uname -s)" in
    Darwin) OS="macos" ;;
    Linux)
      if [ -f /etc/os-release ]; then
        # shellcheck disable=SC1091
        . /etc/os-release
        OS="${ID}"
      else
        OS="linux"
      fi
      ;;
    *) die "Unsupported OS: $(uname -s)" ;;
  esac
}

ensure_local_bin() {
  mkdir -p "$HOME/.local/bin"
  if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
  fi
}

install_arch_deps() {
  info "Installing system dependencies with pacman"
  local packages=(
    neovim git curl wget tar unzip ripgrep fd xsel xclip lazygit
    tree-sitter-cli npm go python python-pip python-pynvim
    gcc make cmake
  )
  sudo pacman -Sy --needed --noconfirm "${packages[@]}"
}

install_debian_deps() {
  info "Installing system dependencies with apt"
  sudo apt-get update
  local packages=(
    neovim git curl wget ca-certificates ripgrep fd-find xsel xclip lazygit
    tree-sitter-cli npm golang-go python3 python3-pip python3-pynvim
    build-essential cmake unzip
  )
  local package
  for package in "${packages[@]}"; do
    if apt-cache show "$package" >/dev/null 2>&1; then
      sudo apt-get install -y "$package"
    else
      warn "Package not available in apt repositories; skipping: $package"
    fi
  done

  if command_exists fdfind && ! command_exists fd; then
    ensure_local_bin
    ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
    info "Created fd symlink: $HOME/.local/bin/fd -> $(command -v fdfind)"
  fi
}

install_fedora_deps() {
  info "Installing system dependencies with dnf"
  sudo dnf install -y \
    neovim git curl wget tar unzip ripgrep fd-find xsel xclip lazygit \
    tree-sitter-cli npm golang python3 python3-pip \
    gcc gcc-c++ make cmake
  python3 -m pip install --user --upgrade pynvim

  if command_exists fdfind && ! command_exists fd; then
    ensure_local_bin
    ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
    info "Created fd symlink: $HOME/.local/bin/fd -> $(command -v fdfind)"
  fi
}

install_macos_deps() {
  info "Installing system dependencies with Homebrew"
  if ! command_exists brew; then
    die "Homebrew is required. Install it first: https://brew.sh"
  fi
  brew install neovim git curl wget ripgrep fd lazygit tree-sitter-cli node go python
  python3 -m pip install --user --upgrade pynvim
}

install_system_deps() {
  detect_os
  case "$OS" in
    arch) install_arch_deps ;;
    ubuntu|debian|linuxmint|pop|elementary) install_debian_deps ;;
    fedora|rhel|centos) install_fedora_deps ;;
    macos) install_macos_deps ;;
    *) die "Unsupported Linux distribution: $OS" ;;
  esac
}

install_neovim_binary() {
  local machine arch
  machine="$(uname -m)"
  case "$machine" in
    x86_64) arch="x86_64" ;;
    arm64|aarch64) arch="arm64" ;;
    *) die "No prebuilt Neovim download for architecture: $machine" ;;
  esac

  local url
  if [ "$NEOVIM_CHANNEL" = "nightly" ]; then
    url="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-${arch}.tar.gz"
  else
    url="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${arch}.tar.gz"
  fi

  local tmpdir
  tmpdir="$(mktemp -d)"
  info "Downloading Neovim ($NEOVIM_CHANNEL) from $url"
  curl -fL "$url" -o "$tmpdir/nvim.tar.gz"
  mkdir -p "$HOME/.local"
  tar -xzf "$tmpdir/nvim.tar.gz" -C "$HOME/.local" --strip-components=1
  ensure_local_bin
  rm -rf "$tmpdir"
}

ensure_neovim() {
  if command_exists nvim; then
    local installed
    installed="$(nvim_version)"
    if version_ge "$installed" "$MIN_NVIM_VERSION"; then
      info "Neovim $installed already satisfies >= $MIN_NVIM_VERSION"
      return
    fi
    warn "Neovim $installed is too old; installing $NEOVIM_CHANNEL build"
  else
    info "Neovim not found; installing $NEOVIM_CHANNEL build"
  fi

  case "$OS" in
    macos)
      brew upgrade neovim || brew install neovim
      ;;
    *)
      install_neovim_binary
      ;;
  esac
}

link_config() {
  if [ "$SCRIPT_DIR" = "$TARGET_DIR" ]; then
    info "Config already lives at $TARGET_DIR"
    return
  fi

  if [ -L "$TARGET_DIR" ] && [ "$(readlink "$TARGET_DIR")" = "$SCRIPT_DIR" ]; then
    info "Config is already linked: $TARGET_DIR -> $SCRIPT_DIR"
    return
  fi

  if [ -e "$TARGET_DIR" ] || [ -L "$TARGET_DIR" ]; then
    local backup
    backup="$TARGET_DIR.bak.$(date +%Y%m%d%H%M%S)"
    mv "$TARGET_DIR" "$backup"
    info "Existing config moved to $backup"
  fi

  mkdir -p "$(dirname "$TARGET_DIR")"
  ln -s "$SCRIPT_DIR" "$TARGET_DIR"
  info "Linked $TARGET_DIR -> $SCRIPT_DIR"
}

sync_plugins() {
  info "Syncing lazy.nvim plugins from lazy-lock.json"
  nvim --headless "+Lazy! sync" +qa
}

install_treesitter_parsers() {
  info "Installing Tree-sitter parsers"
  local lua_list=""
  local parser
  for parser in "${TREESITTER_PARSERS[@]}"; do
    lua_list+="\"$parser\","
  done
  lua_list="${lua_list%,}"

  nvim --headless \
    "+lua require('nvim-treesitter').install({ $lua_list }):wait(600000)" \
    +qa
}

install_lsp_servers() {
  info "Installing LSP servers via mason-lspconfig"
  nvim --headless "+LspInstall ${LSP_SERVERS[*]}" +qa
}

print_next_steps() {
  cat <<EOF

Done. Next steps:
1. Open Neovim: nvim
2. Check plugin health: :Lazy
3. Check LSP servers:   :Mason
4. Check Tree-sitter:   :TSUpdate

If you installed Neovim under \$HOME/.local/bin, make sure your shell has:
  export PATH="\$HOME/.local/bin:\$PATH"
EOF
}

main() {
  ensure_local_bin
  install_system_deps
  ensure_neovim
  link_config
  sync_plugins
  install_treesitter_parsers
  install_lsp_servers
  print_next_steps
}

main "$@"
