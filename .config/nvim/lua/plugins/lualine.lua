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
        tabline = {
          lualine_a = {'buffers'},
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