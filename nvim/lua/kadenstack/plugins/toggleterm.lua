local toggleterm_status, toggleterm = pcall(require, "toggleterm")
if not toggleterm_status then
	return
end

toggleterm.setup()
