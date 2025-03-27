return {
    {
        "NvChad/nvim-colorizer.lua",
        event = "BufReadPost",
        config = function()
            local colorizer = require "colorizer"

            colorizer.setup {
                filetypes = { "*", css = { css = true } },
                user_default_options = {
                    -- Settings for all modes
                    RGB = true, -- #RGB hex codes
                    RRGGBB = true, -- #RRGGBB hex codes
                    RRGGBBAA = true, -- #RRGGBBAA hex codes
                    rgb_fn = true, -- CSS rgb() and rgba() functions
                    hsl_fn = true, -- CSS hsl() and hsla() functions
                    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                    names = false,
                    mode = "background",
                },
            }
        end,
    },
}
