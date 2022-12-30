local fn = vim.fn

-- Automatically install packer
local ensure_packer = function()
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()


-- Autocommand that reloads neovim whenever you save the packer.lua file
--vim.cmd [[
--    augroup packer_user_config
--    autocmd!
--    autocmd BufWritePost packer.lua source <afile> | PackerSync
--    augroup end
--]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end


packer.init {
    -- Have packer use a popup window
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}


return packer.startup(function(use)
    use "nvim-tree/nvim-tree.lua"
    use "wbthomason/packer.nvim"

    use "sainnhe/gruvbox-material"

    use "numToStr/Comment.nvim"

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }

    use "windwp/nvim-autopairs"
    use "p00f/nvim-ts-rainbow"

    -- Completion ---------------------
    -- snippet engine
    use "L3MON4D3/LuaSnip"
    -- cmp
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "saadparwaiz1/cmp_luasnip"
    use "hrsh7th/cmp-nvim-lsp"
    -----------------------------------


    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })


    use "folke/which-key.nvim"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end

end)
