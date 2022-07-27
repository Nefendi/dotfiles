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
            cpp = "clang++ % -o $fileBase && ./$fileBase",
            go = "go run %",
            sh = "sh %",
        },
    },
    behavior = {
        default = "float",
        startinsert = false,
        wincmd = false,
        autosave = true,
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
