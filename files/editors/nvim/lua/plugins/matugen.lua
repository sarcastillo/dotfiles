return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        -- Try to load Noctalia colorscheme if it exists
        local status, noctalia_colors = pcall(require, "noctalia_colors")
        if status then
          noctalia_colors.setup()
        else
          -- Fallback to tokyonight if Noctalia colors not generated yet
          vim.cmd.colorscheme("tokyonight")
        end
      end,
    },
  },
  {
    -- Create a dummy plugin spec to set up autocommands
    dir = vim.fn.stdpath("config"),
    name = "noctalia-hotload",
    lazy = false,
    priority = 1000,
    config = function()
      local noctalia_colors_path = vim.fn.stdpath("config") .. "/lua/noctalia_colors.lua"

      -- Function to reload the colorscheme
      local function reload_colorscheme()
        -- Clear the module cache
        package.loaded["noctalia_colors"] = nil
        
        -- Try to load and apply the new colors
        local status, noctalia_colors = pcall(require, "noctalia_colors")
        if status then
          noctalia_colors.setup()
          vim.notify("Noctalia colorscheme reloaded", vim.log.levels.INFO)
        else
          vim.notify("Failed to reload Noctalia colorscheme", vim.log.levels.ERROR)
        end
      end

      -- Set up file watcher for the Noctalia colors file
      local function setup_watcher()
        -- Check if the file exists
        local file = io.open(noctalia_colors_path, "r")
        if file then
          file:close()
          
          -- Set up autocommand to watch for file changes
          local augroup = vim.api.nvim_create_augroup("NoctaliaHotload", { clear = true })
          
          -- Watch for changes to the Noctalia colors file
          vim.api.nvim_create_autocmd({ "BufWritePost", "FileChangedShellPost" }, {
            group = augroup,
            pattern = noctalia_colors_path,
            callback = function()
              reload_colorscheme()
            end,
            desc = "Reload Noctalia colorscheme when colors file changes",
          })

          -- Also set up a command for manual reloading
          vim.api.nvim_create_user_command("NoctaliaReload", reload_colorscheme, {
            desc = "Manually reload Noctalia colorscheme",
          })

          -- Load the colorscheme on startup if it exists
          reload_colorscheme()
        end
      end

      -- Set up the watcher
      setup_watcher()
    end,
  },
}
