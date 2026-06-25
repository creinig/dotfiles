return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = vim.g.have_nerd_font,
          theme = 'dracula',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          always_divide_middle = true,
          always_show_tabline = true,
          globalstatus = false,
        },
        sections = {
          lualine_a = {'mode', {
            'macro', -- credit: @countless-integers in https://github.com/nvim-lualine/lualine.nvim/issues/1355#issuecomment-2567831390
            fmt = function()
              local reg = vim.fn.reg_recording()
              if reg ~= "" then
                return "Rec @" .. reg
              end
              return nil
            end,
            -- color = { fg = "#ff9e64" },
            draw_empty = false,
          },},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype', 'lsp_status'},
          lualine_y = {'progress'},
          lualine_z = {'location'},
        },
        tabline = {
          lualine_a = {},
          lualine_b = {'branch'},
          lualine_c = {'filename'},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {'tabs'}
        },
        extensions = {},
      }
    end
  },
}