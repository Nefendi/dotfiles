-- Inspiration: https://github.com/Jarmos-san/dotfiles/blob/94039365fab7704f3a9462a81c37d3ca0c072604/dotfiles/.config/nvim/filetype.lua

vim.filetype.add {
    extension = {
        gotmpl = "gotmpl",
        env = "dotenv",
        log = "log",
    },
    pattern = {
        [".*/templates/.*%.tpl"] = "helm",
        [".*/templates/.*%.ya?ml"] = "helm",
        ["helmfile.*%.ya?ml"] = "helm",

        [".*/roles/.*%.ya?ml"] = "yaml.ansible",
        [".*/ansible/.*%.ya?ml%.j2"] = "yaml",

        -- INFO: Match filenames like - ".env.example", ".env.local" and so on
        ["%.env%.[%w_.-]+"] = "dotenv",
    },
    filename = {
        [".env"] = "dotenv",
        ["env"] = "dotenv",
    },
}
