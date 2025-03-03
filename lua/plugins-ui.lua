return {
  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    --    "NLKNguyen/papercolor-theme",
    config = function()
      -- Explicitly reapply the colorscheme after Lazy has initialized
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          -- vim.cmd("colorscheme PaperColor")
          vim.cmd("colorscheme tokyonight-moon")
          vim.opt.termguicolors = true
          vim.opt.background = "dark"

          require("lualine").setup { options = {
            theme = "gruvbox",
            contrast = "medium", -- or "soft"/"medium"
          }
          }

          -- set hop colors again after theme as they are otherwise overwritten
          vim.api.nvim_set_hl(0, "HopNextKey", { fg = "#ffcc00" })  -- Yellow for primary key
          vim.api.nvim_set_hl(0, "HopNextKey1", { fg = "#00ffcc" }) -- Cyan for secondary key
          vim.api.nvim_set_hl(0, "HopNextKey2", { fg = "#ffaa00" }) -- Orange for lesser hints
          vim.api.nvim_set_hl(0, "HopUnmatched", { fg = "#555555" })
        end,
      })
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup { options = { theme = "auto" } }
    end,
  },

  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        theme = 'hyper',
        config = {
          week_header = {
            enable = false,
          },
          header = require("dashboard-header"),
          shortcut = {
            {
              icon = ' ',
              icon_hl = '@variable',
              desc = 'Empty buffer',
              group = 'Label',
              action = 'enew', -- Opens an empty buffer
              key = 'e',
            },
            { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
            {
              icon = '󰱼 ',
              icon_hl = '@variable',
              desc = 'Files',
              group = 'Label',
              action = 'Telescope find_files',
              key = 't',
            },
            {
              icon = ' ',
              icon_hl = '@variable',
              desc = 'Search',
              group = 'Label',
              action = 'Telescope live_grep',
              key = 'f',
            },
            {
              desc = '󱈫 Check health',
              group = 'Number',
              action = 'checkhealth',
              key = 'c',
            },
          },
        },
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  },

  -- -- show indent guides
  -- { "lukas-reineke/indent-blankline.nvim",
  --   main = "ibl",
  --   ---@module "ibl"
  --   ---@type ibl.config
  --   opts = {},
  --   config = function()
  --       require("ibl").setup {
  --           indent = { highlight = "NonText" },
  --           scope = { enabled = true },
  --       }
  --   end
  -- },

  -- { "folke/which-key.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  -- },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>t",  "<cmd>Telescope git_files<cr>",                     desc = "Find Files (root dir)" },
      { "<leader>bb", "<cmd>Telescope buffers<cr>",                       desc = "Find Buffers" },
      { "<leader>bf", "<cmd>Telescope current_buffer_fuzzy_find<cr>",     desc = "Current Buffer Fuzzy" },
      { "<leader>f",  "<cmd>Telescope live_grep<cr>",                     desc = "Search Project" },
      { "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>",          desc = "Search Document Symbols" },
      { "<leader>sw", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Search Workspace Symbols" },
    },
    opts = {
      extensions = {
        zf = {
          file = {
            smart_case = true,
          }
        }
      },
    },
    config = function()
      -- show file name left most, followed by path
      local function filenameFirst(_, path)
        local tail = vim.fs.basename(path)
        local parent = vim.fs.dirname(path)
        if parent == "." then
          return tail
        end
        return string.format("%s\t\t%s", tail, parent)
      end

      require("telescope").setup({
        pickers = {
          find_files = {
            path_display = filenameFirst,
          },
          git_files = {
            path_display = filenameFirst,
          },
        },
      })
    end
  },

  {
    'natecraddock/telescope-zf-native.nvim',
    config = function()
      require('telescope').load_extension('zf-native')
    end
  },

  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     -- add any options here
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     -- "rcarriga/nvim-notify",
  --     }
  -- },
  -- {'hrsh7th/cmp-cmdline'},
  --
  { "jeffkreeftmeijer/vim-numbertoggle" },


  -- {"OXY2DEV/markview.nvim"}
}
