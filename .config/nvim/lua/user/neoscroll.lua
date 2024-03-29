local status_ok, neoscroll = pcall(require, "neoscroll")
if not status_ok then
    return
end

local status_ok_config, neoscroll_config = pcall(require, "neoscroll.config")
if not status_ok_config then
    return
end

neoscroll.setup {
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = { -- "<C-u>", "<C-d>", Disabled to be able to scroll in hover in noice.nvim
        "<C-b>",
        "<C-f>",
        "<C-y>",
        "<C-e>",
        "zt",
        "zz",
        "zb",
    },
    hide_cursor = true, -- Hide cursor while scrolling
    stop_eof = true, -- Stop at <EOF> when scrolling downwards
    respect_scrolloff = true, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = false, -- The cursor will keep on scrolling even if the window cannot scroll further
    -- easing_function = nil, -- Default easing function
    -- pre_hook = nil, -- Function to run before the scrolling animation starts
    -- post_hook = nil, -- Function to run after the scrolling animation ends
    performance_mode = false, -- Disable "Performance Mode" on all buffers.)
}

-- local t = {}

-- t["<c-k>"] = { "scroll", { "-vim.wo.scroll", "true", "250" } }
-- t["<c-j>"] = { "scroll", { "vim.wo.scroll", "true", "250" } }

-- neoscroll_config.set_mappings(t)
