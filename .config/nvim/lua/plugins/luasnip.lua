return {
  {
    "L3MON4D3/LuaSnip",
    version = 'v2.*',
    dependencies = {
      {
        'honza/vim-snippets',
        config = function()
          require("luasnip.loaders.from_snipmate").lazy_load()
        end
      },
      {
        'benfowler/telescope-luasnip.nvim',
        config = function()
          require('telescope').load_extension('luasnip')
        end
      },
    },
  },
}