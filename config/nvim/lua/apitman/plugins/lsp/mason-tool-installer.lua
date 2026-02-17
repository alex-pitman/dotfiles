return {
  "WhoIsSethDaniel/mason-tool-installer",
  opts = {
    ensure_installed = {
      -- Go tools
      "gofumpt",
      "goimports",

      -- Java tools
      "java-debug-adapter",
      "java-test",

      -- Lua tools
      "stylua",

      -- Node tools
      "prettier",
    },
  },
}
