return {
	"nvzone/showkeys",
	-- cmd = "ShowkeysToggle",
	event = "VeryLazy",
	opts = {
		maxkeys = 5,
	},
	config = function(_, opts)
		local showkeys = require("showkeys")
		showkeys.setup(opts)
		showkeys.open()
	end,
}
