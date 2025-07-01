local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- INFO: status line
-- Enable global statusline
vim.opt.laststatus = 3 -- 3 means global statusline (single line at the bottom)

-- INFO: NEO TREE
-- Keybinding for toggling Neo-tree
vim.api.nvim_set_keymap('n', '<Leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true })
-- this is for nvim tree
-- vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

-- INFO: DAP KEYMAPS

-- Keymap configuration for debugging C++
vim.api.nvim_set_keymap('n', '<F5>', ':lua require"dap".continue()<CR>', { noremap = true, silent = true, desc = 'Continue' })
vim.api.nvim_set_keymap('n', '<F10>', ':lua require"dap".step_over()<CR>', { noremap = true, silent = true, desc = 'Step Over' })
vim.api.nvim_set_keymap('n', '<F11>', ':lua require"dap".step_into()<CR>', { noremap = true, silent = true, desc = 'Step Into' })
vim.api.nvim_set_keymap('n', '<F12>', ':lua require"dap".step_out()<CR>', { noremap = true, silent = true, desc = 'Step Out' })
vim.api.nvim_set_keymap('n', '<Leader>db', ':lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true, desc = 'Toggle Breakpoint' })
vim.api.nvim_set_keymap('n', '<Leader>dr', ':lua require"dap".repl.open()<CR>', { noremap = true, silent = true, desc = 'Open REPL' })
vim.api.nvim_set_keymap('n', '<Leader>dl', ':lua require"dap".run_last()<CR>', { noremap = true, silent = true, desc = 'Run Last' })

-- Keybinding to open the DAP UI
vim.api.nvim_set_keymap('n', '<Leader>du', ':lua require("dapui").open()<CR>', { noremap = true, silent = true })

-- Keybinding to close the DAP UI
vim.api.nvim_set_keymap('n', '<Leader>dc', ':lua require("dapui").close()<CR>', { noremap = true, silent = true })

-- Change the color of the current line number to red
vim.cmd 'highlight LineNr guifg=LightBlue' -- Relative line numbers (light blue)
vim.cmd 'highlight CursorLineNr guifg=Red' -- Current line number (red)

-- Insert tab in Normal mode (using spaces if soft tabs are enabled)
vim.api.nvim_set_keymap('n', '<Tab>', '>>', { noremap = true, silent = true })

-- Insert tab in Visual mode (indent the selected text)
vim.api.nvim_set_keymap('v', '<Tab>', '>gv', { noremap = true, silent = true })

-- Unindent using Shift+Tab in Normal and Visual modes
vim.api.nvim_set_keymap('n', '<S-Tab>', '<<', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-Tab>', '<gv', { noremap = true, silent = true })

-- Ensure soft tab (spaces) is set
vim.o.expandtab = false -- Use spaces instead of tabs
vim.o.shiftwidth = 4 -- Number of spaces to use for indentation
vim.o.softtabstop = 4 -- Number of spaces for a tab in insert mode
vim.o.tabstop = 4 -- Number of spaces a tab character represents

-- INFO : DAP LOG LEVEL
vim.g.dap_log_level = 'TRACE'

-- Map Shift-K to show hover information
-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Show LSP hover information' })
-- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
--   -- Use rounded borders and set a border color
--   border = { '┏', '━', '┛', '┃', '┏', '━', '┛', '┃' },
--   winblend = 10, -- Transparency effect (10 is slightly transparent)
--   max_width = 80, -- Set a max width for the hover window
--   max_height = 20, -- Set a max height for the hover window
-- })

-- Optional: Change the highlight groups for hover content
vim.cmd [[
    highlight LspHoverBorder guifg=#50fa7b
    highlight LspHoverContent guifg=#f8f8f2
    highlight LspHoverTitle guifg=#ff79c6
]]

autocmd({'InsertLeave', 'FocusLost'}, {
  callback = function()
    if vim.bo.modifiable and vim.bo.filetype ~= '' and vim.bo.buftype == '' then
      vim.cmd ' write!'
    end
  end,
})

autocmd('BufLeave', {
  pattern = '*',
  callback = function()
    if vim.bo.modifiable and not vim.bo.readonly then
      vim.cmd 'silent! write'
    end
  end,
})

autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    vim.cmd [[
      " Set transparent background
      highlight Normal guibg=none
      highlight NonText guibg=none

      " Change the color of comments
      highlight Comment guifg=#B0B0B0 gui=italic

      " Change the color of line numbers
      highlight LineNr guifg=#e599f5 guibg=none

      " Change the current line number color (optional)
      highlight CursorLineNr guifg=#ff9e64 guibg=none
    ]]
  end,
})

-- LSP Hover highlights
augroup('LspHoverHighlights', { clear = true })
autocmd('ColorScheme', {
  group = 'LspHoverHighlights',
  callback = function()
    vim.cmd [[
      highlight LspHoverBorder guifg=#50fa7b
      highlight LspHoverContent guifg=#f8f8f2
      highlight LspHoverTitle guifg=#ff79c6
    ]]
  end,
})
