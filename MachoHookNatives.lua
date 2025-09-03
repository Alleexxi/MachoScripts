local natives_json = MachoWebRequest("https://raw.githubusercontent.com/Alleexxi/MachoScripts/refs/heads/main/natives_simplified.json")
local natives = json.decode(natives_json)

print("Hooking natives")

for i,v in ipairs(natives) do

    local native_name = type(v.name) == "table" and v.hash or v.name
    load(([[
        MachoHookNative(%s, function(...)
    local resource = GetCurrentResourceName();
    if resource == nil then return true end
    --if type(resource) == "string" and resource ~= "WaveShield" then return true end
    local args = {...}

    print(resource .. " called native " .. "%s" .. " with args: " .. json.encode(args))

    return true
  end)
    ]]):format(v.hash, native_name, native_name))()
end
