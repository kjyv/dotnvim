return {
  -- allow ib/ab and iq/aq objects to work in any bracket and any quote
  { 'echasnovski/mini.ai', version = '*' },

  {
    'unblevable/quick-scope',
    config = function()
      set_quickscope_highlights = function()
        vim.api.nvim_set_hl(0, "QuickScopePrimary", { fg = "#eeeeee", ctermfg = 255, underline = true })
        vim.api.nvim_set_hl(0, "QuickScopeSecondary", { fg = "#5fffff", ctermfg = 81, underline = true })
      end

      -- Create an augroup to hold the autocmd
      vim.api.nvim_create_augroup("qs_colors", { clear = true })

      -- Register an autocmd on the ColorScheme event that calls our function
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = "qs_colors",
        pattern = "*",
        callback = set_quickscope_highlights,
      })

      -- Call the function immediately so the highlights are set at startup
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          set_quickscope_highlights()
        end
      })
    end
  },

  -- easymotion replacement
  {
    'smoka7/hop.nvim',
    version = "*",
    opts = {}
  },
}
