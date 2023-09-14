local putils = require("telescope.previewers.utils")
local filetype_hook = function(filepath, bufnr, opts)
  -- you could analogously check opts.ft for filetypes
  local excluded = vim.tbl_filter(function(ending)
    return filepath:match(ending)
  end, {
    "/?dist/.+%.js$",
    "/?dist/.+%.css$",
  })
  if not vim.tbl_isempty(excluded) then
    putils.set_preview_message(bufnr, opts.winid, "Preview disabled for dist files!")
    return false
  end
  return true
end

return filetype_hook
