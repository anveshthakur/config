return {
  "folke/snacks.nvim",
  opts = {
    -- Enable input enhancements for OpenCode's ask() function
    input = {},
    
    -- Enhance picker for OpenCode integration
    picker = {
      ui_select = true, -- Keep AstroNvim compatibility
      
      -- Add OpenCode-specific actions
      actions = {
        opencode_send = function(...)
          return require("opencode").snacks_picker_send(...)
        end,
      },
      
      -- Add OpenCode keybindings within the picker
      win = {
        input = {
          keys = {
            ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
          },
        },
      },
    },
  },
}
