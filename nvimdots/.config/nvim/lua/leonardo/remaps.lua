vim.g.mapleader = " "
-- vim.keymap.set("{mode}", "{shortcut}", vim.cmd)

-- Usar alt + hjkl para redimensionar as janelas
vim.keymap.set("n", "<M-j>", "<cmd>resize +2<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>resize -2<CR>")
vim.keymap.set("n", "<M-h>", "<cmd>vertical resize +2<CR>")
vim.keymap.set("n", "<M-l>", "<cmd>vertical resize -2<CR>")

-- Utiliza jk para sair do insert mode e já salvar automaticamente
vim.keymap.set("i", "jk", "<Esc><leader>w")

-- <TAB>: completion.
vim.keymap.set('i', '<Tab>', function()
    return vim.fn.pumvisible() == 1 and '<C-N>' or '<Tab>'
end, {expr = true})

-- Use control-c instead of escape
vim.keymap.set("n", "<C-c>", "<Esc>")

-- Better tabbing
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Usar Q para formatar o parágrafo
vim.keymap.set("v", "Q", "gq")
vim.keymap.set("n", "Q", "gqap")

-- Salvar mais rápido
vim.keymap.set("n", "<leader>w", "<cmd>wall<cr>")

-- Contar número de palavras no parágrafo
vim.keymap.set("n", "<leader>tc", "vipg<C-g><Esc>")

-- Usar o ripgrep na palavra sob o cursor
vim.keymap.set("n", "<leader>rg", "yiw<cmd>Rg <C-r>--<cr>")

-- Para atualizar o arquivo
vim.keymap.set("n", "<leader>ck", "<Esc><cmd>checktime<cr>")

-- Inserir docstring
vim.keymap.set("n", "<leader>ds", "<cmd>Dox<cr>")
