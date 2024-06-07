function lazy_plugin_manager_init()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    map_leader_keys_if_required()

	if not (vim.uv or vim.loop).fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)

	require("lazy").setup({
		spec = "singalkunal.lazy_plugins",
		change_detection = { notify = false }
	})
end

function map_leader_keys_if_required()
    local g = vim.g
    local default_leaders = {
        mapleader = " ",
        maplocalleader = "\\"
    }

    for k, v in pairs(default_leaders) do
        g[k] = (g[k] == nil and v or g[k]) -- ternary hack
    end
end
lazy_plugin_manager_init()

