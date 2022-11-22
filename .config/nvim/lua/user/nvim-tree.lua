local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
    return
end
local icons = require "user.icons"

local tree_cb = nvim_tree_config.nvim_tree_callback

local utils = require "nvim-tree.utils"

local function notify_level(_)
    return function(msg)
        vim.schedule(function()
            vim.api.nvim_echo({ { msg, "WarningMsg" } }, false, {})
        end)
    end
end

utils.notify.warn = notify_level(vim.log.levels.WARN)
utils.notify.error = notify_level(vim.log.levels.ERROR)
utils.notify.info = notify_level(vim.log.levels.INFO)
utils.notify.debug = notify_level(vim.log.levels.DEBUG)

nvim_tree.setup {
    respect_buf_cwd = true,
    update_cwd = true,
    hijack_directories = {
        enable = false,
    },
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {
        "alpha",
    },
    renderer = {
        add_trailing = false,
        group_empty = true,
        highlight_git = true,
        highlight_opened_files = "all",
        root_folder_modifier = ":t",
        indent_markers = {
            enable = true,
        },
        icons = {
            webdev_colors = true,
            git_placement = "after",
            padding = " ",
            symlink_arrow = " " .. icons.ui.ThinRightArrow .. " ",
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
            glyphs = {
                default = icons.documents.PageWithText,
                symlink = icons.ui.Symlink,
                folder = {
                    arrow_open = icons.ui.DownChevron,
                    arrow_closed = icons.ui.RightChevron,
                    default = icons.ui.ClosedFullFolder,
                    open = icons.ui.OpenedFullFolder,
                    empty = icons.ui.ClosedEmptyFolder,
                    empty_open = icons.ui.OpenedEmptyFolder,
                    symlink = icons.ui.DirectorySymlink,
                    symlink_open = icons.ui.DirectorySymlink,
                },
                git = {
                    unstaged = icons.misc.SmallDot,
                    staged = icons.ui.Check,
                    unmerged = icons.git.Unmerged,
                    renamed = icons.ui.RightArrow,
                    untracked = icons.git.Untracked,
                    deleted = icons.git.Removed,
                    ignored = icons.misc.EmptyDot,
                },
            },
        },
    },
    diagnostics = {
        enable = true,
        icons = {
            hint = icons.diagnostics.Hint,
            info = icons.diagnostics.Info,
            warning = icons.diagnostics.Warning,
            error = icons.diagnostics.Error,
        },
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 500,
    },
    view = {
        adaptive_size = true,
        hide_root_folder = false,
        side = "left",
        mappings = {
            custom_only = false,
            list = {
                { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
                { key = "h", cb = tree_cb "close_node" },
                { key = "v", cb = tree_cb "vsplit" },
                { key = "H", cb = tree_cb "dir_up" },
                { key = "L", cb = tree_cb "cd" },
            },
        },
    },
    filters = {
        custom = {
            --[[ Some null-ls builtins create temporary files with long names and their sudden
                 appearance and disappearance with view.adaptive_size = true is extremely annoying
            --]]
            "^\\.null-ls_",
        },
    },
}
