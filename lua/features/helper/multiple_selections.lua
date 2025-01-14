local M = {}

function M.exit_dot(word)
    local result = ""
    for i = 1, #word do
        local char = string.sub(word, i, i)
        if char == "." then
            char = "%" .. char
        end
        result = result .. char
    end
    return result
end

return M
