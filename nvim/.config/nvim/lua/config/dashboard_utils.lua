local M = {}

---@type string[][]
local quotes = {
    {
        "I swear, by my life and my love of it, that I will never live for the sake of another man, nor ask another man to live for mine. ",
        "",
        "— John Galt",
        "",
        "",
        'Ayn Rand, "Atlas Shrugged"',
    },
    {
        'Until the day when God shall deign to reveal the future to man, all human wisdom is contained in these two words—"Wait and hope."',
        "",
        "— Edmond Dantès",
        "",
        "",
        'Alexandre Dumas, "The Count of Monte Christo"',
    },
    {
        "To sell your soul is the easiest thing in the world. That's what everybody does every hour of his life. If I asked you to keep your soul - would you understand why that's much harder? ",
        "",
        "— Howard Roark",
        "",
        "",
        'Ayn Rand, "The Fountainhead"',
    },
    {
        "I could die for you. But I couldn't, and wouldn't, live for you.",
        "",
        "— Howard Roark",
        "",
        "",
        'Ayn Rand, "The Fountainhead"',
    },
    {
        "Let me give you a tip on a clue to men's characters: the man who damns money has obtained it dishonorably; the man who respects it has earned it.",
        "",
        "— Francisco d'Anconia",
        "",
        "",
        'Ayn Rand, "Atlas Shrugged"',
    },
    {
        "Joy is the goal of existence, and joy is not to be stumbled upon, but to be achieved, and the act of treason is to let its vision drown in the swamp of the moment's torture.",
        "",
        "",
        'Ayn Rand, "Atlas Shrugged"',
    },
}

-- Stolen from: https://github.com/folke/snacks.nvim/issues/137
---@param input_table string[]
---@param width integer
---@return string
local wrap_text = function(input_table, width)
    ---@type string[]
    local wrapped_lines = {}

    for _, line in ipairs(input_table) do
        if line == "" then
            table.insert(wrapped_lines, "")
        else
            local line_start = 1
            while line_start <= #line do
                local line_end = math.min(line_start + width - 1, #line)

                if line_end < #line then
                    local space_pos = line:sub(line_start, line_end):find " [^ ]*$"
                    if space_pos then
                        line_end = line_start + space_pos - 1
                    end
                end

                local segment = line:sub(line_start, line_end):gsub("^%s*", "")
                if segment ~= "" then
                    table.insert(wrapped_lines, segment)
                end

                line_start = line_end + 1
            end
        end
    end

    return table.concat(wrapped_lines, "\n")
end

---@param width integer
---@return string
M.random_quote = function(width)
    math.randomseed(os.time())

    local choice = quotes[math.random(#quotes)]

    return wrap_text(choice, width)
end

return M
