return {
    -- This is needed to overcome the issue with multiple offset encodings:
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
    capabilities = { offsetEncoding = { "utf-16" } },
    filetypes = {
        "c",
        "cpp",
        "objc",
        "objcpp",
        "cuda",
        -- Removed because of protobuf files
        -- "proto"
    },
}
