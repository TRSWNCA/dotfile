return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    dir_path = "attachments",
    prompt_for_file_name = true,
    file_name = "%Y-%m-%d-%H-%M-%S",
    relative_to_current_file = false,
    opts = function(_, opts)
      opts.icons = {
        rules = {
          { pattern = "img-clip", icon = LazyVim.config.icons.kinds.Copilot, color = "orange" },
        },
      }
    end,
  },
  keys = {
    -- suggested keymap
    { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
  },
  filetypes = {
    markdown = {
      -- encode spaces and special characters in file path
      url_encode_path = true, ---@type boolean

      -- -- The template is what specifies how the alternative text and path
      -- -- of the image will appear in your file
      --
      -- -- $CURSOR will paste the image and place your cursor in that part so
      -- template = "![$CURSOR]($FILE_PATH)", ---@type string
    },
  },
}
