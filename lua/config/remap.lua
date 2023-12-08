local Util = require("util")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>sp", [["+p]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "Q", "@qj")
vim.keymap.set("x", "Q", ":norm @q<CR>")

-- visual mode "fix"
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww teux-sessionizer<CR>")

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>")
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

vim.keymap.set("n", "[q", vim.cmd.cprevious, { silent = true })
vim.keymap.set("n", "]q", vim.cmd.cnext, { silent = true })

local diagnostics_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

vim.keymap.set("n", "]d", diagnostics_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostics_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostics_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostics_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostics_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostics_goto(false, "WARN"), { desc = "Prev Warning" })

-- Toggle
vim.keymap.set("n", "<leader>ud", function()
  Util.toggle.diagnostics()
end, { desc = "Toggle Diagnostics" })
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  Util.format({ force = true })
end, { desc = "Format" })
vim.keymap.set("n", "<leader>uf", function()
  Util.format.toggle()
end, { desc = "Toggle auto format (global)" })
vim.keymap.set("n", "<leader>uF", function()
  Util.format.toggle(true)
end, { desc = "Toggle auto format (buffer)" })

local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
vim.keymap.set("n", "<leader>uc", function()
  Util.toggle("conceallevel", false, { 0, conceallevel })
end, { desc = "Toggle Conceal" })
if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
  vim.keymap.set("n", "<leader>uh", function()
    Util.format.inlay_hint()
  end, { desc = "Toggle Inlay Hints" })
end

vim.keymap.set("n", "<leader>us", function()
  Util.toggle("spell")
end, { desc = "Toggle spelling" })

vim.keymap.set("n", "<leader>uw", function()
  Util.toggle("wrap")
end, { desc = "Toggle wrap" })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- windows and splits
vim.keymap.set("n", "<C-J>", "<C-W><C-J>", { noremap = true, desc = "Easier Moving between splits" })
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", { noremap = true, desc = "Easier Moving between splits" })
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", { noremap = true, desc = "Easier Moving between splits" })
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", { noremap = true, desc = "Easier Moving between splits" })

vim.keymap.set("n", "<c-,>", "<C-W><", { noremap = true, desc = "Sizing window horizontally" })
vim.keymap.set("n", "<c-.>", "<C-W>>", { noremap = true, desc = "Sizing window horizontally" })
vim.keymap.set("n", "<A-,>", "<C-W>5<", { noremap = true, desc = "Sizing window horizontally" })
vim.keymap.set("n", "<A-.>", "<C-W>5>", { noremap = true, desc = "Sizing window horizontally" })

vim.keymap.set("n", "<A-t>", "<C-W>+", { noremap = true, desc = "Sizing window vertically - taller" })
vim.keymap.set("n", "<A-s>", "<C-W>-", { noremap = true, desc = "Sizing window vertically - shorter" })
