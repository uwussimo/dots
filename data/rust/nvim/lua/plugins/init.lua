local packer = require "plugins.packerInit"
local use = packer.use

return packer.startup(function()
    use { "wbthomason/packer.nvim" }

    -- UI (Color, statusline, dashboard...)
    use { "goolord/alpha-nvim", config = require "plugins.configs.alpha" }
    use { "ellisonleao/gruvbox.nvim" }
    use { "rmehri01/onenord.nvim" }

    use { "kyazdani42/nvim-web-devicons", config = require "plugins.configs.icons" }
    use {
        "nvim-lualine/lualine.nvim",
        config = require "plugins.configs.lualine",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    }
    use {
        "akinsho/bufferline.nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
        config = require "plugins.configs.bufferline",
    }
    use { "folke/which-key.nvim" }

    -- Coding utilities
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = require "plugins.configs.treesitter" }
    use { "windwp/nvim-ts-autotag" }
    use { "p00f/nvim-ts-rainbow" }
    use {
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
        config = require "plugins.configs.nvimtree",
    }
    -- -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-node-modules.nvim",
            "nvim-telescope/telescope-github.nvim",
        },
        config = require "plugins.configs.telescope",
    }
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

    use { "lukas-reineke/indent-blankline.nvim", config = require "plugins.configs.indent" }
    use { "windwp/nvim-autopairs", config = require "plugins.configs.autopairs" }
    use { "karb94/neoscroll.nvim", config = require "plugins.configs.neoscroll" }
    use { "tpope/vim-surround" }
    use { "norcalli/nvim-colorizer.lua", config = require "plugins.configs.colorizer" }

    -- LSP
    use { "neovim/nvim-lspconfig" }
    use { "williamboman/nvim-lsp-installer" }

    -- -- Lint
    use { "folke/lsp-colors.nvim" }
    use { "tami5/lspsaga.nvim" }
    use { "folke/trouble.nvim" }
    -- use { "ray-x/lsp_signature.nvim",branch="neovim-0.6" }

    -- -- Comment
    use { "numToStr/Comment.nvim", config = require "plugins.configs.comment" }

    -- -- Completion
    use { "hrsh7th/nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lsp" }
    use { "hrsh7th/cmp-nvim-lua" }
    use { "hrsh7th/cmp-buffer" }
    use { "hrsh7th/cmp-path" }
    use { "hrsh7th/cmp-cmdline" }
    use { "hrsh7th/cmp-nvim-lsp-document-symbol" }
    use { "hrsh7th/cmp-vsnip" }
    use { "hrsh7th/vim-vsnip" }
    use { "hrsh7th/cmp-nvim-lsp-signature-help" }
    use { "hrsh7th/cmp-emoji" }

    -- -- Snippets
    use { "kitagry/vs-snippets" }
    use { "dsznajder/vscode-es7-javascript-react-snippets", run = "yarn install --frozen-lockfile && yarn compile" }

    -- -- Formatter and Linting
    use {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("null-ls").setup()
        end,
        requires = { "nvim-lua/plenary.nvim" },
    }

    -- Tmux
    use { "aserowy/tmux.nvim", config = require "plugins.configs.tmux" }

    -- Git
    use {
        "lewis6991/gitsigns.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = require "plugins.configs.gitsigns",
    }

    -- Markdown
    use { "davidgranstrom/nvim-markdown-preview" }
end)
