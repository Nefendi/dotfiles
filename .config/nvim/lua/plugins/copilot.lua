return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
            markdown = true,
            help = true,
        },
        server_opts_overrides = {
            settings = {
                telemetry = {
                    telemetryLevel = "off",
                },
            },
        },
    },
    config = function(_, opts)
        Snacks.toggle({
            name = "Github Copilot",
            get = function()
                return vim.g.copilot_enabled
            end,
            set = function(state)
                if state then
                    require("copilot").setup(opts) -- setting up for the very first time
                    require("copilot.command").enable()

                    vim.g.copilot_enabled = true
                else
                    require("copilot.command").disable()

                    vim.g.copilot_enabled = false
                end
            end,
        }):map "<leader>Ac"
    end,
}
