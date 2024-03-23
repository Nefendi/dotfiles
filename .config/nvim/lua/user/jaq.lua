local status_ok, jaq_nvim = pcall(require, "jaq-nvim")
if not status_ok then
    return
end

jaq_nvim.setup {
    cmds = {
        external = {
            javascript = "node %",
            python = "python3 %",
            rust = "cargo run",
            cpp = "g++ -Wall -Wextra -Werror -Wshadow -Wswitch-enum % -o $fileBase && ./$fileBase && rm -f $fileBase",
            c = "cc -Wall -Wextra -Werror -Wshadow -Wswitch-enum % -o $fileBase && ./$fileBase && rm -f $fileBase",
            go = "go run %",
            sh = "sh %",
            lua = "lua %",
            cs = "dotnet run",
            php = "php %",
            ruby = "ruby %",
            java = "java %",
            elixir = "elixir %",
        },
    },
    behavior = {
        default = "float",
        startinsert = false,
        wincmd = false,
        autosave = false,
    },
    ui = {
        float = {
            border = "rounded",
            winhl = "Normal",
            borderhl = "FloatBorder",
            height = 0.8,
            width = 0.8,
            x = 0.5,
            y = 0.5,
            winblend = 0,
        },
        terminal = {
            position = "vert",
            line_no = false,
            size = 60,
        },
    },
}
