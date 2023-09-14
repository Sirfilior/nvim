local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")

local flatten = vim.tbl_flatten

local files = {}

-- i would like to be able to do telescope
-- and have telescope do some filtering on files and some grepping

files.multi_rg = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()
  opts.shortcuts = opts.shortcuts
    or {
      ["l"] = "*.lua",
      ["v"] = "*.vim",
      ["n"] = "*.{vim,lua}",
      ["c"] = "*.css",
      ["s"] = "*.{scss,sass,less}",
      ["h"] = "*.html",
      ["r"] = "*.rs",
      ["g"] = "*.go",
    }
  opts.pattern = opts.pattern or "%s"

  local custom_grep = finders.new_job(function(prompt)
    if not prompt or prompt == "" then
      return nil
    end

    local prompt_split = vim.split(prompt, "  ")

    local args = { "rg" }
    if prompt_split[1] then
      table.insert(args, "-e")
      table.insert(args, prompt_split[1])
    end

    if prompt_split[2] then
      table.insert(args, "-g")

      local pattern
      if opts.shortcuts[prompt_split[2]] then
        pattern = opts.shortcuts[prompt_split[2]]
      else
        pattern = prompt_split[2]
      end

      table.insert(args, string.format(opts.pattern, pattern))
    end

    return flatten({
      args,
      { "--with-filename", "--line-number", "--column", "--smart-case" },
    })
  end, opts.entry_maker or make_entry.gen_from_vimgrep(opts), opts.max_results, opts.cwd)

  pickers
    .new(opts, {
      prompt_title = "Live Grep (with shortcuts)",
      finder = custom_grep,
      previewer = conf.grep_previewer(opts),
      sorter = require("telescope.sorters").highlighter_only(opts),
    })
    :find()
end

return files
