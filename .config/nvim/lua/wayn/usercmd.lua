-- Toggle List Characters Command
vim.api.nvim_create_user_command("ToggleListChars", function()
	vim.opt.list = not vim.opt.list:get()
	if vim.opt.list then
		vim.opt.listchars = "trail:·,tab:»·"
	end
end, { desc = "Toggle list characters" })

vim.api.nvim_create_user_command("I", function(args)
	local evaluated_obj = vim.fn.luaeval(args.args)
	vim.print(evaluated_obj)
end, { nargs = 1 })
