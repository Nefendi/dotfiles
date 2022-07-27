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

nvim_tree.setup {
    respect_buf_cwd = true,
    update_cwd = true,
    hijack_directories = {
        enable = true,
    },
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {
        "alpha",
    },
    renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        highlight_opened_files = "none",
        root_folder_modifier = ":t",
        icons = {
            webdev_colors = true,
            git_placement = "before",
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
                    staged = "S",
                    unmerged = icons.git.Unmerged,
                    renamed = icons.ui.RightArrow,
                    untracked = "U",
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
            info = icons.diagnostics_codicons.Info,
            warning = icons.diagnostics_codicons.Warning,
            error = icons.diagnostics_codicons.Error,
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
        width = 50,
        height = 30,
        hide_root_folder = false,
        side = "left",
        mappings = {
            custom_only = false,
            list = {
                { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
                { key = "h", cb = tree_cb "close_node" },
                { key = "v", cb = tree_cb "vsplit" },
            },
        },
    },
}
