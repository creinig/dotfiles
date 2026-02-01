local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set( "n", "<leader>ca",
  function()
    vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
  end,
  { silent = true, buffer = bufnr, desc = "[C]ode [A]ctions" }
)

vim.keymap.set( "n", "K",  -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function() vim.cmd.RustLsp({'hover', 'actions'}) end,
  { silent = true, buffer = bufnr, desc = "Hover with actions" })

vim.keymap.set("n", "<leader>ce",
  function() vim.cmd.RustLsp({'renderDiagnostic', 'current'}) end,
  { silent = true, buffer = bufnr, desc = "[C]ode: show [E]rror / warning in current line" } )

vim.keymap.set("n", "<leader>cE",
  function() vim.cmd.RustLsp({'renderDiagnostic', 'cycle'}) end,
  { silent = true, buffer = bufnr, desc = "[C]ode: show next [E]rror / warning (starting in current line)" } )

vim.keymap.set({"n", "x"}, "<leader>cJ",
  function() vim.cmd.RustLsp({'joinLines'}) end,
  { silent = true, buffer = bufnr, desc = "[C]ode: Smart [J]oin lines" } )

vim.keymap.set("n", "<leader>cr",
  function() vim.cmd.RustLsp({'runnables'}) end,
  { silent = true, buffer = bufnr, desc = "[C]ode: Show & run [R]unnables" } )

vim.keymap.set("n", "<leader>cR",
  function() vim.cmd.RustLsp({'runnables', bang = true}) end,
  { silent = true, buffer = bufnr, desc = "[C]ode: Re-run last [R]unnable" } )

vim.keymap.set("n", "<leader>ct",
  function() vim.cmd.RustLsp({'testables'}) end,
  { silent = true, buffer = bufnr, desc = "[C]ode: Show & run [T]estables" } )

vim.keymap.set("n", "<leader>cT",
  function() vim.cmd.RustLsp({'testables', bang = true}) end,
  { silent = true, buffer = bufnr, desc = "[C]ode: Re-run last [T]estable" } )

vim.keymap.set("n", "<leader>c?",
  function() vim.cmd.RustLsp({'openDocs'}) end,
  { silent = true, buffer = bufnr, desc = "[C]ode: Open docs.rs for the symbol under the cursor" } )

vim.keymap.set("n", "<leader>c/",
  function() vim.cmd.RustLsp({'workspaceSymbol', 'allSymbols'}) end,
  { silent = true, buffer = bufnr, desc = "[C]ode: Search symbol in workspace" } )