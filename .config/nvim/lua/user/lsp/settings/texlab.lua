return {
    settings = {
        texlab = {
            auxDirectory = ".",
            bibtexFormatter = "latexindent",
            build = {
                args = { "--interaction=nonstopmode", "--synctex=1", "--shell-escape", "%f" },
                executable = "lualatex",
                forwardSearchAfter = false,
                onSave = false,
            },
            chktex = {
                onOpenAndSave = true,
                onEdit = true,
            },
            diagnosticsDelay = 300,
            formatterLineLength = 80,
            forwardSearch = {
                executable = "zathura",
                args = { "--synctex-forward", "%l:1:%f", "%p" },
            },
            latexFormatter = "latexindent",
            latexindent = {
                modifyLineBreaks = true,
            },
        },
    },
}
