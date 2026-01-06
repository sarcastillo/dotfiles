return {
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          opencode = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = "OPENCODE_API_KEY",
              },
              url = "https://api.opencode.ai/v1/chat/completions",
              schema = {
                model = {
                  default = "opencode-v1",
                },
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = "opencode",
          },
          inline = {
            adapter = "opencode",
          },
          agent = {
            adapter = "opencode",
          },
        },
      })
    end,
  },
}
