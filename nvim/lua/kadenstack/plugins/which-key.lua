local whichkey_status, whichkey = pcall(require, "which-key")
if not whichkey_status then
	return
end

vim.o.timeout = true
vim.o.timeoutlen = 300

whichkey.setup()
