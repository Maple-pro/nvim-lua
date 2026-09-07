local ok, schemastore = pcall(require, "schemastore")

local settings = {
  json = {},
}

if ok and schemastore.json and schemastore.json.schemas then
  settings.json.schemas = schemastore.json.schemas()
end

return {
  settings = settings,
}
