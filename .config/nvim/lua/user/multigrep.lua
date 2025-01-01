-- Source: https://github.com/tjdevries/advent-of-nvim/blob/master/nvim/lua/config/telescope/multigrep.lua
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local conf = require("telescope.config").values
local themes = require "telescope.themes"
local flatten = require("telescope.utils").flatten

local M = {}

M.live_multigrep = function(opts)
    opts = opts or {}
    opts.cwd = opts.cwd or vim.uv.cwd()

    opts = themes.get_dropdown(opts)

    local finder = finders.new_async_job {
        command_generator = function(prompt)
            if not prompt or prompt == "" then
                return nil
            end

            local pieces = vim.split(prompt, "  ")
            local additional_args = {}
            if pieces[1] then
                table.insert(additional_args, "--regexp")
                table.insert(additional_args, pieces[1])
            end

            if pieces[2] then
                table.insert(additional_args, "--glob")
                table.insert(additional_args, pieces[2])
            end

            return flatten {
                conf.vimgrep_arguments,
                additional_args,
            }
        end,
        entry_maker = make_entry.gen_from_vimgrep(opts),
        cwd = opts.cwd,
    }

    pickers
        .new(opts, {
            prompt_title = "Multi Grep",
            finder = finder,
            previewer = conf.grep_previewer(opts),
            sorter = require("telescope.sorters").empty(),
        })
        :find()
end

return M
