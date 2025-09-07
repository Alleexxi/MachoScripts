MachoInjectResource2(3, "any", [[
local name, value = debug.getupvalue(_G.StartPlayerTeleport, 6)
InverseSubstitution = value["InverseSubstitution"]
Substitution = value["Substitution"]

function EncryptString(str)
    local result = {}
    for i = 1, #str do
        local c = str:sub(i, i)
        local encrypted = Substitution[c]
        table.insert(result, encrypted or c)
    end
    return table.concat(result)
end

function DecryptString(str)
    local result = {}
    for i = 1, #str do
        local c = str:sub(i, i)
        local plain = InverseSubstitution[c]
        table.insert(result, plain or c)
    end
    return table.concat(result)
end

print(EncryptString("_WS:"))
]])