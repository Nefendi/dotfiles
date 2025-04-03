return {
    {
        "windwp/nvim-ts-autotag",
        event = "BufReadPost",
        opts = {
            per_filetype = {
                ["markdown"] = {
                    enable_close = false,
                },
            },
        },
    },
}
