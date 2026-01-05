return {
    "yetone/avante.nvim",
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = vim.fn.has "win32" ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
        or "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    keys = {
        -- {
        --     "<leader>an",
        --     "<CMD>AvanteChat<CR>",
        --     desc = "Start Chat Session",
        -- },
        -- {
        --     "<leader>aN",
        --     "<CMD>AvanteChatNew<CR>",
        --     desc = "Start New Chat Session",
        -- },
        {
            "<leader>ax",
            "<CMD>AvanteClear<CR>",
            desc = "avante: clear current chat",
        },
    },
    ---@module 'avante'
    ---@type avante.Config
    opts = {
        mode = "legacy",
        -- add any opts here
        -- this file can contain specific instructions for your project
        instructions_file = "avante.md",
        -- for example
        provider = "copilot",
        auto_suggestions_provider = "copilot",
        providers = {
            -- copilot = {
            --     model = "claude-haiku-4.5",
            -- },
        },
        behaviour = {
            auto_apply_diff_after_generation = true,
            auto_approve_tool_permissions = false,
            auto_set_keymaps = true,
        },
        selection = {
            enabled = false,
            hint_display = "delayed",
        },
        -- system_prompt as function ensures LLM always has latest MCP server state
        -- This is evaluated for every message, even in existing chats
        system_prompt = function()
            local hub = require("mcphub").get_hub_instance()
            return hub and hub:get_active_servers_prompt() or ""
        end,
        -- Using function prevents requiring mcphub before it's loaded
        custom_tools = function()
            return {
                require("mcphub.extensions.avante").mcp_tool(),
            }
        end,
        -- Disable to avoid duplication with MCP HUB's neovim built-in tools
        disabled_tools = {
            "list_files", -- Built-in file operations
            "search_files",
            "read_file",
            "create_file",
            "rename_file",
            "delete_file",
            "create_dir",
            "rename_dir",
            "delete_dir",
            "bash", -- Built-in terminal access
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "nvim-mini/mini.pick", -- for file_selector provider mini.pick
        "folke/snacks.nvim", -- for input provider snacks
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua", -- for providers='copilot'
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },
        {
            -- Make sure to set this up properly if you have lazy=true
            "MeanderingProgrammer/render-markdown.nvim",
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
}
