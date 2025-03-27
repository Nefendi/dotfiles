return {
    {
        "echasnovski/mini.files",
        version = false,
        config = function()
            local mini_files = require "mini.files"

            mini_files.setup {
                mappings = {
                    close = "q",
                    go_in = "",
                    go_in_plus = "L",
                    go_out = "",
                    go_out_plus = "H",
                    mark_goto = "'",
                    mark_set = "m",
                    reset = "<BS>",
                    reveal_cwd = "@",
                    show_help = "g?",
                    synchronize = "=",
                    trim_left = "<",
                    trim_right = ">",
                },
            }

            local show_dotfiles = true

            local filter_show = function(fs_entry)
                return true
            end

            local filter_hide = function(fs_entry)
                return not vim.startswith(fs_entry.name, ".")
            end

            local toggle_dotfiles = function()
                show_dotfiles = not show_dotfiles
                local new_filter = show_dotfiles and filter_show or filter_hide
                mini_files.refresh { content = { filter = new_filter } }
            end

            local map_split = function(buf_id, lhs, direction)
                local rhs = function()
                    -- Make new window and set it as target
                    local cur_target = mini_files.get_explorer_state().target_window
                    local new_target = vim.api.nvim_win_call(cur_target, function()
                        vim.cmd(direction .. " split")
                        return vim.api.nvim_get_current_win()
                    end)

                    mini_files.set_target_window(new_target)

                    -- This intentionally doesn't act on file under cursor in favor of
                    -- explicit "go in" action (`l` / `L`). To immediately open file,
                    -- add appropriate `MiniFiles.go_in()` call instead of this comment.
                    mini_files.go_in()
                end

                -- Adding `desc` will result into `show_help` entries
                local desc = "Split " .. direction
                vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
            end

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    local buf_id = args.data.buf_id
                    -- Tweak keys to your liking
                    map_split(buf_id, "<C-s>", "belowright horizontal")
                    map_split(buf_id, "<C-v>", "belowright vertical")
                    -- map_split(buf_id, "<C-t>", "tab")
                end,
            })

            -- Set focused directory as current working directory
            local set_cwd = function()
                local path = (mini_files.get_fs_entry() or {}).path
                if path == nil then
                    return vim.notify "Cursor is not on valid entry"
                end
                vim.fn.chdir(vim.fs.dirname(path))
            end

            -- Yank in register path of entry under cursor
            ---@param relative boolean
            ---@return nil
            local yank_path = function(relative)
                local path = (mini_files.get_fs_entry() or {}).path

                if path == nil then
                    return vim.notify "Cursor is not on valid entry"
                end

                if relative then
                    path = vim.fn.fnamemodify(path, ":.")
                end

                vim.fn.setreg(vim.v.register, path)
            end

            -- Open path with system default handler (useful for non-text files)
            local ui_open = function()
                vim.ui.open(mini_files.get_fs_entry().path)
            end

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    local b = args.data.buf_id
                    vim.keymap.set("n", "g~", set_cwd, { buffer = b, desc = "Set cwd" })

                    vim.keymap.set("n", "gX", ui_open, { buffer = b, desc = "OS open" })

                    vim.keymap.set("n", "gy", function()
                        yank_path(false)
                    end, { buffer = b, desc = "Yank path" })

                    vim.keymap.set("n", "gY", function()
                        yank_path(true)
                    end, { buffer = b, desc = "Yank relative path" })

                    vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = b, desc = "Toggle hidden" })

                    -- Additional close mapping
                    vim.keymap.set("n", "<leader>e", mini_files.close, { buffer = b, desc = "Close" })
                    vim.keymap.set("n", "<esc>", mini_files.close, { buffer = b, desc = "Close" })

                    vim.keymap.set("n", "<leader>w", mini_files.synchronize, { buffer = b, desc = "Synchronize" })

                    vim.keymap.set("n", "<CR>", function()
                        mini_files.go_in { close_on_file = true }
                    end, { buffer = b, desc = "Go in entry plus" })
                end,
            })
        end,
    },
}
