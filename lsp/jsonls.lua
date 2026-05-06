return {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
}
