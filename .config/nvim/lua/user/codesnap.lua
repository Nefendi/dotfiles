local codesnap_status_ok, codesnap = pcall(require, "codesnap")
if not codesnap_status_ok then
    return
end

codesnap.setup {
    mac_window_bar = false,
    title = "",
    code_font_family = "Comic Code Ligatures",
    watermark_font_family = "Pacifico",
    watermark = "",
    bg_theme = "bamboo",
    breadcrumbs_separator = "/",
    has_breadcrumbs = false,
}
