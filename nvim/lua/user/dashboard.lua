local status_ok, dashboard = pcall(require, "dashboard")
if not status_ok then
  return
end

dashboard.custom_header = {
	[[]],
	[[███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
	[[████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
	[[██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
	[[██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
	[[██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
	[[╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
	[[]],
}

dashboard.custom_center = {
	{
		icon = "  ",
		desc = "Recent files                            ",
		shortcut = "SPC r",
		action = "Telescope oldfiles theme=dropdown",
	},
	{
		icon = "  ",
		desc = "Open file                               ",
		shortcut = "SPC f",
		action = "Telescope find_files theme=dropdown",
	},
	{
		icon = "  ",
		desc = "New file                                ",
		shortcut = ":enew",
		action = "enew",
	},
	{
		icon = "  ",
		desc = "Search token                            ",
		shortcut = "SPC w",
		action = "Telescope live_grep theme=dropdown",
	},
	{
		icon = "  ",
		desc = "Close neovim                             ",
		shortcut = ":qa!",
		action = "qa!",
	},
}

