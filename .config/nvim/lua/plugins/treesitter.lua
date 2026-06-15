return {
{ -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
     config = function()
        local ts = require 'nvim-treesitter'
        local parsers = {
          "bash",
          "c",
          "comment",
          "css",
          "diff",
          "dockerfile",
          "git_config",
          "gitcommit",
          "gitignore",
          "groovy",
          "helm",
          "html",
          "http",
          "java",
          "javascript",
          "jsdoc",
          "json",
          "json5",
          "lua",
          "luadoc",
          "make",
          "markdown_inline",
          "markdown",
          "python",
          "query",
          "regex",
          "rst",
          "ruby",
          "rust",
          "scss",
          "sql",
          "ssh_config",
          "terraform",
          "toml",
          "tsx",
          "typescript",
          "typst",
          "vim",
          "vimdoc",
          "yaml",
        }

        for _, parser in ipairs(parsers) do
            ts.install(parser)
        end

        -- Not every tree-sitter parser is the same as the file type detected
        -- So the patterns need to be registered more cleverly
        local patterns = {}
        for _, parser in ipairs(parsers) do
            local parser_patterns = vim.treesitter.language.get_filetypes(parser)
            for _, pp in pairs(parser_patterns) do
                table.insert(patterns, pp)
            end
        end

        vim.filetype.add({
          filename = {
            [".sqlfluff"] = "dosini",
          },
          pattern = {
            [".*/waybar/config"] = "jsonc",
            [".*/mako/config"] = "dosini",
            [".*/kitty/.+%.conf"] = "kitty",
            ["%.env%.[%w_.-]+"] = "sh",
          },
        })
        vim.treesitter.language.register("bash", "kitty")
        vim.treesitter.language.register("groovy", "Jenkinsfile")

        vim.api.nvim_create_autocmd('FileType', {
            pattern = patterns,
            callback = function()
                vim.treesitter.start()
                vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                vim.wo[0][0].foldmethod = 'expr'
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
  }
}