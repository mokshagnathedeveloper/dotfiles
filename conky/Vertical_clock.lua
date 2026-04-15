function conky_verticalize(format, offset_value)
local raw_str = conky_parse(format)
if raw_str == nil then return "" end

    local str = raw_str:gsub("%s+", "")
    local vertical_str = ""
    local offset_val = offset_value or 0

    for i = 1, #str do
        local char = string.sub(str, i, i)
        -- We apply the offset and the character as a parsed command
        vertical_str = vertical_str .. "${offset " .. offset_val .. "}" .. char .. "\n"
        end

        -- IMPORTANT: This parses the string so Conky 'executes' the offsets
        return conky_parse(vertical_str)
        end
