-- this gives nice finding and option menu
-- telescope specific bindings are set here
-- telescope interface is also used in my LSP config
return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = {'nvim-lua/plenary.nvim'},
	config = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

        local telescope = require("telescope")
        telescope.setup({
                defaults = {
                    layout_strategy = "flex",
                    layout_config = {
                            flex = {
                                    width = 0.9,
                                    height = 0.9,
                                    flip_columns = 120
                            }
                    },
                }
        })
	end
}
