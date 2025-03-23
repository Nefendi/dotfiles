return {
    {
        "junegunn/vim-slash",
        event = "BufReadPost",
        config = function()
            vim.cmd [[noremap <plug>(slash-after) zz]]
        end,
    },
}
