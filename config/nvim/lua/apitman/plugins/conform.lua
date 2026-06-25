return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    format_on_save = function(bufnr)
      -- Skip Java; format it manually with <leader>f instead
      if vim.bo[bufnr].filetype == "java" then
        return
      end
      return { lsp_format = "fallback", timeout_ms = 500 }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "goimports", "gofmt" },
      yaml = { "prettier" },
    },
  },
}
