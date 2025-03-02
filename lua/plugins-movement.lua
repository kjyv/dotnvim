return {
  -- allow ib/ab and iq/aq objects to work in any bracket and any quote
  { 'echasnovski/mini.ai', version = '*' },

  {
    --   'unblevable/quick-scope',
    "jinh0/eyeliner.nvim",
    config = function()
      set_eyeliner_highlights = function()
        -- vim.api.nvim_set_hl(0, "QuickScopePrimary", { fg = "#eeeeee", ctermfg = 255, underline = true })
        -- vim.api.nvim_set_hl(0, "QuickScopeSecondary", { fg = "#5fffff", ctermfg = 81, underline = true })
        vim.api.nvim_set_hl(0, 'EyelinerPrimary', { fg = "#eeeeee", underline = true })
        vim.api.nvim_set_hl(0, 'EyelinerSecondary', { fg = "#5fffff", underline = true })
      end

      -- Create an augroup to hold the autocmd
      vim.api.nvim_create_augroup("qs_colors", { clear = true })

      -- Register an autocmd on the ColorScheme event that calls our function
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = "qs_colors",
        pattern = "*",
        callback = set_eyeliner_highlights,
      })

      -- Call the function immediately so the highlights are set at startup
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          set_eyeliner_highlights()
        end
      })
    end
  },

  -- enhanced % matching
  { 'chrisbra/matchit' },

  -- easymotion replacement
  {
    'smoka7/hop.nvim',
    version = "*",
    opts = {},
    config = function()
      local hop = require('hop')
      hop.setup()
      local directions = require('hop.hint').HintDirection
      vim.keymap.set('', '<leader>w', function()
        hop.hint_words({ direction = directions.AFTER_CURSOR, current_line_only = false })
      end, { remap = true })
      vim.keymap.set('', '<leader>b', function()
        hop.hint_words({ direction = directions.BEFORE_CURSOR, current_line_only = false })
      end, { remap = true })
    end
  },
}
