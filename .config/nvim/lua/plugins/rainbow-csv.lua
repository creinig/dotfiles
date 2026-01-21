return {
    'cameron-wags/rainbow_csv.nvim',
    config = true,
    ft = {
        'csv',
        'tsv',
        'csv_semicolon',
        'csv_whitespace',
        'csv_pipe',
        'rfc_csv',
        'rfc_semicolon'
    },
    cmd = {
        'RainbowDelim',
        'RainbowDelimSimple',
        'RainbowDelimQuoted',
        'RainbowMultiDelim'
    },
    keys = {
      { "<leader>tc+", ':RainbowAlign<cr>', desc = "ALign [C]SV columns" },
      { "<leader>tc-", ':RainbowAlign<cr>', desc = "Compact [C]SV columns" },
      { "<leader>tc,", ':set ft=csv<cr>', desc = "Interpret file as [C]SV with comma delimiter" },
      { "<leader>tc;", ':set ft=csv_semicolon<cr>', desc = "Interpret file as [C]SV with semicolon delimiter" },
      { "<leader>tct", ':set ft=tsv<cr>', desc = "Interpret file as [C]SV with tab delimiter" },
      { "<leader>tcs", ':Select ', desc = "Query [C]SV with Rainbow [S]elect" },
    },
}