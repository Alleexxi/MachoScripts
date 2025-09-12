--$$\      $$\            $$\               $$\                       $$\            $$\           $$\
--$$$\    $$$ |           $$ |              \__|                      $$ |           $$ |          $$ |
--$$$$\  $$$$ | $$$$$$\ $$$$$$\    $$$$$$\  $$\ $$\   $$\        $$$$$$$ | $$$$$$\ $$$$$$\         $$ |$$\   $$\  $$$$$$\
--$$\$$\$$ $$ | \____$$\\_$$  _|  $$  __$$\ $$ |\$$\ $$  |      $$  __$$ |$$  __$$\\_$$  _|        $$ |$$ |  $$ | \____$$\
--$$ \$$$  $$ | $$$$$$$ | $$ |    $$ |  \__|$$ | \$$$$  /       $$ /  $$ |$$ /  $$ | $$ |          $$ |$$ |  $$ | $$$$$$$ |
--$$ |\$  /$$ |$$  __$$ | $$ |$$\ $$ |      $$ | $$  $$<        $$ |  $$ |$$ |  $$ | $$ |$$\       $$ |$$ |  $$ |$$  __$$ |
--$$ | \_/ $$ |\$$$$$$$ | \$$$$  |$$ |      $$ |$$  /\$$\       \$$$$$$$ |\$$$$$$  | \$$$$  |      $$ |\$$$$$$  |\$$$$$$$ |
--\__|     \__| \_______|  \____/ \__|      \__|\__/  \__|       \_______| \______/   \____/       \__| \______/  \_______|

MatrixLua = {
    hotkey = 0x2E,
    visible = true,

    shiftDown = false,

    inputbox = {
        enabled = false,
        text = "",
        title = "",
    },

    menu = {
        name = "Matrix Menu",
        type = "menu",
        entries = {
        }
    },

    playersMenu = nil,

    selectedIndex = { 1 },

    dui = nil
}

local a = {
    [0x30] = { "0", ")" },
    [0x31] = { "1", "!" },
    [0x32] = { "2", "@" },
    [0x33] = { "3", "#" },
    [0x34] = { "4", "$" },
    [0x35] = { "5", "%" },
    [0x36] = { "6", "^" },
    [0x37] = { "7", "&" },
    [0x38] = { "8", "*" },
    [0x39] = { "9", "(" },
    [0x41] = { "a", "A" },
    [0x42] = { "b", "B" },
    [0x43] = { "c", "C" },
    [0x44] = { "d", "D" },
    [0x45] = { "e", "E" },
    [0x46] = { "f", "F" },
    [0x47] = { "g", "G" },
    [0x48] = { "h", "H" },
    [0x49] = { "i", "I" },
    [0x4A] = { "j", "J" },
    [0x4B] = { "k", "K" },
    [0x4C] = { "l", "L" },
    [0x4D] = { "m", "M" },
    [0x4E] = { "n", "N" },
    [0x4F] = { "o", "O" },
    [0x50] = { "p", "P" },
    [0x51] = { "q", "Q" },
    [0x52] = { "r", "R" },
    [0x53] = { "s", "S" },
    [0x54] = { "t", "T" },
    [0x55] = { "u", "U" },
    [0x56] = { "v", "V" },
    [0x57] = { "w", "W" },
    [0x58] = { "x", "X" },
    [0x59] = { "y", "Y" },
    [0x5A] = { "z", "Z" },
    [0x20] = { " ", " " },
    [0x0D] = { "\n", "\n" },
    [0x08] = { "\b", "\b" },
    [0x09] = { "\t", "\t" },
    [0xBB] = { "=", "+" },
    [0xBC] = { ",", "<" },
    [0xBD] = { "-", "_" },
    [0xBE] = { ".", ">" },
    [0xBF] = { "/", "?" },
    [0xC0] = { "`", "~" },
    [0xDB] = { "[", "{" },
    [0xDC] = { "\\", "|" },
    [0xDD] = { "]", "}" },
    [0xDE] = { "'", "\"" }
}
function ToAscii(b, c)
    local d = a[b]
    if not d then return false end; return d[c and 2 or 1]
end

local WeaponsLists = {
    "WEAPON_KNIFE", "WEAPON_NIGHTSTICK", "WEAPON_HAMMER", "WEAPON_BAT", "WEAPON_CROWBAR",
    "WEAPON_GOLFCLUB", "WEAPON_BOTTLE", "WEAPON_DAGGER", "WEAPON_HATCHET", "WEAPON_KNUCKLE",
    "WEAPON_MACHETE", "WEAPON_SWITCHBLADE", "WEAPON_WRENCH", "WEAPON_BATTLEAXE", "WEAPON_POOLCUE",
    "WEAPON_STONE_HATCHET", "WEAPON_CANDYCANE", "WEAPON_ANTIQUE_CABINET", "WEAPON_BROOM",
    "WEAPON_GUSENBERG", "WEAPON_MUSKET", "WEAPON_DBSHOTGUN", "WEAPON_AUTOSHOTGUN", "WEAPON_SWEEPERSHOTGUN",
    "WEAPON_ASSAULTRIFLE", "WEAPON_CARBINERIFLE", "WEAPON_ADVANCEDRIFLE", "WEAPON_SPECIALCARBINE",
    "WEAPON_BULLPUPRIFLE", "WEAPON_COMPACTRIFLE", "WEAPON_MILITARYRIFLE", "WEAPON_HEAVYRIFLE",
    "WEAPON_TACTICALRIFLE", "WEAPON_PISTOL", "WEAPON_COMBATPISTOL", "WEAPON_APPISTOL",
    "WEAPON_PISTOL50", "WEAPON_SNSPISTOL", "WEAPON_HEAVYPISTOL", "WEAPON_VINTAGEPISTOL",
    "WEAPON_FLAREGUN", "WEAPON_MARKSMANPISTOL", "WEAPON_MACHINEPISTOL", "WEAPON_VPISTOL",
    "WEAPON_PISTOLXM3", "WEAPON_CERAMICPISTOL", "WEAPON_GADGETPISTOL", "WEAPON_MICROSMG",
    "WEAPON_SMG", "WEAPON_SMG_MK2", "WEAPON_ASSAULTSMG", "WEAPON_COMBATPDW", "WEAPON_GUSENBERG",
    "WEAPON_MACHINEPISTOL", "WEAPON_MG", "WEAPON_COMBATMG", "WEAPON_COMBATMG_MK2", "WEAPON_PUMPSHOTGUN",
    "WEAPON_SWEEPERSHOTGUN", "WEAPON_SAWNOFFSHOTGUN", "WEAPON_BULLPUPSHOTGUN", "WEAPON_ASSAULTSHOTGUN",
    "WEAPON_MUSKET", "WEAPON_HEAVYSHOTGUN", "WEAPON_DBSHOTGUN", "WEAPON_AUTOSHOTGUN", "WEAPON_SNIPERRIFLE",
    "WEAPON_HEAVYSNIPER", "WEAPON_HEAVYSNIPER_MK2", "WEAPON_MARKSMANRIFLE", "WEAPON_MARKSMANRIFLE_MK2",
    "WEAPON_GRENADELAUNCHER", "WEAPON_GRENADELAUNCHER_SMOKE", "WEAPON_RPG", "WEAPON_MINIGUN",
    "WEAPON_FIREWORK", "WEAPON_RAILGUN", "WEAPON_HOMINGLAUNCHER", "WEAPON_GRENADE", "WEAPON_BZGAS",
    "WEAPON_SMOKEGRENADE", "WEAPON_FLARE", "WEAPON_MOLOTOV", "WEAPON_STICKYBOMB", "WEAPON_PROXMINE",
    "WEAPON_SNOWBALL", "WEAPON_PIPEBOMB", "WEAPON_BALL", "WEAPON_PETROLCAN", "WEAPON_HAZARDCAN",
    "WEAPON_FERTILIZERCAN", "WEAPON_FLAREGUN", "WEAPON_BALL", "WEAPON_KNUCKLE", "WEAPON_HATCHET",
    "WEAPON_MACHETE", "WEAPON_SWITCHBLADE", "WEAPON_WRENCH", "WEAPON_BATTLEAXE", "WEAPON_POOLCUE",
    "WEAPON_STONE_HATCHET", "WEAPON_CANDYCANE", "WEAPON_ANTIQUE_CABINET", "WEAPON_BROOM"
}

local VehicleList = GetAllVehicleModels();
local VehicleClasses = {
    [0] = "Compacts",
    [1] = "Sedans",
    [2] = "SUVs",
    [3] = "Coupes",
    [4] = "Muscle",
    [5] = "Sports Classics",
    [6] = "Sports",
    [7] = "Super",
    [8] = "Motorcycles",
    [9] = "Off-road",
    [10] = "Industrial",
    [11] = "Utility",
    [12] = "Vans",
    [13] = "Cycles",
    [14] = "Boats",
    [15] = "Helicopters",
    [16] = "Planes",
    [17] = "Service",
    [18] = "Emergency",
    [19] = "Military",
    [20] = "Commercial",
    [21] = "Trains",
    [22] = "Open Wheel"
}


local validchars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,."
local Utils = load(MachoWebRequest("http://localhost/macho_utils.lua"))()

MatrixLua.AntiCheats = Utils.GetAntiCheats();

local Category = {}
Category.__index = Category

function Category:AddButton(label, callback)
    local btn = { name = label, type = "button", callback = callback }
    table.insert(self.entries, btn)
    return btn
end

function Category:AddToggle(label, callback, default, data)
    local tgl = { name = label, type = "toggle", value = default or false, callback = callback, data = data or {} }
    table.insert(self.entries, tgl)
    return tgl
end

function Category:AddSlider(label, default, min, max, step, callback)
    local sld = {
        name = label,
        type = "slider",
        value = default or min,
        settings = { min = min, max = max, step = step or 1 },
        callback = callback
    }
    table.insert(self.entries, sld)
    return sld
end

function Category:AddOptions(label, options, callback, defaultIndex)
    local opt = {
        name = label,
        type = "options",
        options = options,
        index = defaultIndex or 1,
        callback = callback
    }
    table.insert(self.entries, opt)
    return opt
end

function Category:AddCategory(label)
    local cat = setmetatable({ name = label, type = "menu", entries = {} }, Category)
    table.insert(self.entries, cat)
    return cat
end

function Category:RemoveByName(label)
    for i, entry in ipairs(self.entries) do
        if entry.name == label then
            table.remove(self.entries, i)
            return true
        end
    end
    return false
end

function Category:RemoveToggleById(id)
    for i, entry in ipairs(self.entries) do
        if entry.type == "toggle" and entry.id == id then
            table.remove(self.entries, i)
            return true
        end
    end
    return false
end

function Category:AddPlayerToggles()
    self.toggledIds = self.toggledIds or {}
    for _, playerId in ipairs(GetActivePlayers()) do
        local name = GetPlayerName(playerId)
        local default = self.toggledIds[playerId] == true
        self:AddToggle(name, function(val)
            self.toggledIds[playerId] = val
        end, default, { id = playerId })
    end
end

function Category:ClearPlayerToggles()
    local i = 1
    while i <= #self.entries do
        local entry = self.entries[i]
        if entry.type == "toggle" and entry.data and entry.data.id then
            table.remove(self.entries, i)
        else
            i = i + 1
        end
    end
    self.toggledIds = {}
end

function Category:RefreshPlayerToggles()
    self.toggledIds = self.toggledIds or {}
    local activeIds = {}
    for _, playerId in ipairs(GetActivePlayers()) do
        activeIds[playerId] = true
    end

    for i = #self.entries, 1, -1 do
        local entry = self.entries[i]
        if entry.type == "toggle" and entry.data and entry.data.id and (not activeIds[entry.data.id] or entry.name == "**Invalid**") then
            table.remove(self.entries, i)
            if MatrixLua:getCurrentMenu() == self then
                local depth = #MatrixLua.selectedIndex
                local idx = MatrixLua.selectedIndex[depth]
                if idx > #self.entries then
                    MatrixLua.selectedIndex[depth] = math.max(1, #self.entries)
                end
            end
        end
    end

    local existingIds = {}
    for i = 1, #self.entries do
        local entry = self.entries[i]
        if entry.type == "toggle" and entry.data and entry.data.id then
            existingIds[entry.data.id] = true
        end
    end

    for _, playerId in ipairs(GetActivePlayers()) do
        if not existingIds[playerId] then
            local name = GetPlayerName(playerId)
            local default = self.toggledIds[playerId] == true
            self:AddToggle(name, function(val)
                self.toggledIds[playerId] = val
            end, default, { id = playerId })
        end
    end
end

function Category:GetAllSelectedPlayers()
    local toggled = {}
    self.toggledIds = self.toggledIds or {}

    for i = 1, #self.entries do
        local entry = self.entries[i]
        if entry.type == "toggle" and entry.data and entry.data.id and entry.value then
            table.insert(toggled, entry.data.id)
        end
    end

    return toggled
end

-- MatrixLua API
function MatrixLua:NewCategory(label)
    local cat = setmetatable({ name = label, type = "menu", entries = {} }, Category)
    table.insert(self.menu.entries, cat)
    return cat
end

function MatrixLua:getCurrentMenu()
    local menu = self.menu
    local idxStr = table.concat(self.selectedIndex, ",")
    for i = 1, #self.selectedIndex - 1 do
        local idx = self.selectedIndex[i]
        if menu.entries and menu.entries[idx] then
            menu = menu.entries[idx]
        else
            break
        end
    end
    return menu
end

local function stripMenuOfEntries(menu)
    local result = {}
    local entries = {}
    result.name = menu.name
    if menu.entries then
        for i, entry in ipairs(menu.entries) do
            local copy = {}
            for k, v in pairs(entry) do
                if k ~= "entries" then
                    copy[k] = v
                end
            end
            table.insert(entries, copy)
        end
    end
    result.entries = entries
    return result
end

function MatrixLua:InputBox(title, callback) --TODO: Rework to MachoGUI
    self.inputbox.enabled = true
    self.inputbox.title = title
    self.inputbox.callback = callback

    MachoSendDuiMessage(MatrixLua.dui, json.encode({
        event = "popup",
        args = self.inputbox
    }))
end

function MatrixLua:UpdateInputBox(text)
    self.inputbox.text = text

    MachoSendDuiMessage(MatrixLua.dui, json.encode({
        event = "popup_update",
        args = self.inputbox
    }))
end

function MatrixLua:DisableInputbox()
    self.inputbox.enabled = false
    self.inputbox.text = ""
    self.inputbox.callback = nil

    MachoSendDuiMessage(MatrixLua.dui, json.encode({
        event = "popup",
        args = self.inputbox
    }))
end

function MatrixLua:UpdateUI()
    local menu = self:getCurrentMenu()
    local entries = menu.entries
    local depth = #self.selectedIndex
    local idx = self.selectedIndex[depth]

    local menu_stripped = stripMenuOfEntries(menu)

    if self.playersMenu then
        pcall(function()
            self.playersMenu:RefreshPlayerToggles()
        end)
    end

    if entries and entries[idx] then
        MachoSendDuiMessage(MatrixLua.dui, json.encode({
            event = "menu",
            args = {
                ["Menu"] = menu_stripped, ["index"] = idx
            }
        }))
    end
end

function MatrixLua:InitMenu()
    self.dui = MachoCreateDui("http://localhost/")
    if self.visible then
        MachoShowDui(self.dui)
    end

    MatrixLua:UpdateUI()

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            MatrixLua:UpdateUI()
        end
    end)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(150)
            if self.playersMenu then
                pcall(function()
                    self.playersMenu:RefreshPlayerToggles()
                end)
            end
        end
    end)
end

local VK_LEFT   = 0x25
local VK_UP     = 0x26
local VK_RIGHT  = 0x27
local VK_DOWN   = 0x28
local VK_RETURN = 0x0D
local VK_BACK   = 0x08
local VK_ESCAPE = 0x1B
local VK_SHIFT  = 0x10

function MatrixLua:handleKeydown(keycode)
    local menu     = self:getCurrentMenu()
    local entries  = menu.entries
    local depth    = #self.selectedIndex
    local idx      = self.selectedIndex[depth]
    local selected = entries[idx]

    if keycode == VK_SHIFT then
        self.shiftDown = true
    end

    if self.inputbox.enabled then
        if keycode == VK_BACK then
            if self.inputbox.text ~= "" then
                self:UpdateInputBox(self.inputbox.text:sub(1, -2))
                return
            end
        end
        if keycode == VK_RETURN then
            if self.inputbox.callback then
                self.inputbox.callback(self.inputbox.text)
            end
            self:DisableInputbox()
            return
        end

        if keycode == VK_ESCAPE then
            self:DisableInputbox()
            return
        end
        local char = ToAscii(keycode, self.shiftDown)
        if not char then return end

        if keycode == VK_LEFT or keycode == VK_RIGHT or keycode == VK_UP or keycode == VK_DOWN then
            return
        end

        if not string.find(validchars, string.upper(char)) then return end
        self:UpdateInputBox(self.inputbox.text .. char)
        return
    end

    if self.hotkey and self.hotkey == keycode then
        self.visible = not self.visible
        if self.visible then
            MachoShowDui(self.dui)
        else
            MachoHideDui(self.dui)
        end
    end

    if not self.visible then
        return
    end

    if keycode == VK_UP then
        if idx > 1 then
            self.selectedIndex[depth] = idx - 1
        else
            self.selectedIndex[depth] = #entries
        end
    elseif keycode == VK_DOWN then
        if idx < #entries then
            self.selectedIndex[depth] = idx + 1
        else
            self.selectedIndex[depth] = 1
        end
    elseif keycode == VK_LEFT then
        if selected.type == "options" then
            local index = entries[idx].index
            if index > 1 then
                entries[idx].index = index - 1
            else
                entries[idx].index = #entries[idx].options
            end
        elseif selected.type == "slider" then
            local settings = selected.settings or {}
            local min = settings.min or 0
            local step = settings.step or 1
            local value = selected.value or min
            value = value - step
            if value < min then value = min end
            entries[idx].value = value
        end
    elseif keycode == VK_RIGHT then
        if selected.type == "options" then
            local index = entries[idx].index
            if index < #entries[idx].options then
                entries[idx].index = index + 1
            else
                entries[idx].index = 1
            end
        elseif selected.type == "slider" then
            local settings = selected.settings or {}
            local max = settings.max or 100
            local step = settings.step or 1
            local value = selected.value or settings.min or 0
            value = value + step
            if value > max then value = max end
            entries[idx].value = value
        end
    elseif keycode == VK_RETURN then
        if selected.type == "menu" then
            table.insert(self.selectedIndex, 1)
        elseif selected.type == "button" and selected.callback then
            selected.callback()
        elseif selected.type == "options" and selected.callback then
            selected.callback(entries[idx].options[entries[idx].index])
        elseif selected.type == "toggle" then
            entries[idx].value = not entries[idx].value
            if selected.callback then
                selected.callback(entries[idx].value)
            end
        elseif selected.type == "slider" and selected.callback then
            selected.callback(selected.value)
        end
    elseif keycode == VK_BACK then
        if depth > 1 then
            table.remove(self.selectedIndex)
        end
    end

    local menu = self:getCurrentMenu()
    local entries = menu.entries
    local depth = #self.selectedIndex
    local idx = self.selectedIndex[depth]

    local menu_stripped = stripMenuOfEntries(menu)

    if entries and entries[idx] then
        MachoSendDuiMessage(MatrixLua.dui, json.encode({
            event = "menu",
            args = {
                ["Menu"] = menu_stripped, ["index"] = idx
            }
        }))
    end
end

MachoOnKeyDown(function(keycode)
    MatrixLua:handleKeydown(keycode)
end)

MachoOnKeyUp(function(keycode)
    if keycode == VK_SHIFT then
        MatrixLua.shiftDown = false
    end
end)

MatrixLua:InitMenu()

--$$\                                $$\ $$\                           $$\      $$\
--$$ |                               $$ |\__|                          $$$\    $$$ |
--$$ |      $$$$$$\   $$$$$$\   $$$$$$$ |$$\ $$$$$$$\   $$$$$$\        $$$$\  $$$$ | $$$$$$\  $$$$$$$\  $$\   $$\
--$$ |     $$  __$$\  \____$$\ $$  __$$ |$$ |$$  __$$\ $$  __$$\       $$\$$\$$ $$ |$$  __$$\ $$  __$$\ $$ |  $$ |
--$$ |     $$ /  $$ | $$$$$$$ |$$ /  $$ |$$ |$$ |  $$ |$$ /  $$ |      $$ \$$$  $$ |$$$$$$$$ |$$ |  $$ |$$ |  $$ |
--$$ |     $$ |  $$ |$$  __$$ |$$ |  $$ |$$ |$$ |  $$ |$$ |  $$ |      $$ |\$  /$$ |$$   ____|$$ |  $$ |$$ |  $$ |
--$$$$$$$$\\$$$$$$  |\$$$$$$$ |\$$$$$$$ |$$ |$$ |  $$ |\$$$$$$$ |      $$ | \_/ $$ |\$$$$$$$\ $$ |  $$ |\$$$$$$  |
--\________|\______/  \_______| \_______|\__|\__|  \__| \____$$ |      \__|     \__| \_______|\__|  \__| \______/
--                                                     $$\   $$ |
--                                                     \$$$$$$  |
--                                                      \______/


----- PLAYER STUFF
Utils.RegisterScript("revive", [[
if GetResourceState("es_extended") == "started" then
    TriggerEvent('esx_ambulancejob:revive')
end

if GetResourceState("qb-core") == "started" then
    TriggerEvent('hospital:client:Revive')
end

if GetResourceState("visn_are") == "started" then
    TriggerEvent('visn_are:resetHealthBuffer')
end
]])

Utils.RegisterScript("txAdmin:setMode", [[
TriggerEvent("txcl:setPlayerMode", %s, %s)
]], "any")

Utils.RegisterScript("txAdmin:setAdmin", [[
TriggerEvent("txcl:setAdmin", "Macho", {"all_permissions"}, "")
]], "any")

Utils.RegisterScript("tpToWaypoint", [[
function FindZForCoords(x, y) -- Stole from txAdmin
    local found = true
    local START_Z = 1500
    local z = START_Z
    while found and z > 0 do
        local _found, _z = GetGroundZAndNormalFor_3dCoord(x + 0.0, y + 0.0, z - 1.0)
        if _found then
            z = _z + 0.0
        end
        found = _found
        Wait(0)
    end
    if z == START_Z then return nil end
    return z + 0.0
end

if not IsWaypointActive() then return end
local waypoint = GetFirstBlipInfoId(GetWaypointBlipEnumId())
local destCoords = GetBlipInfoIdCoord(waypoint)

local ped = PlayerPedId()
local veh = GetVehiclePedIsIn(ped, false)
SetPedCoordsKeepVehicle(ped, destCoords.x, destCoords.y, 100.0)
FreezeEntityPosition(ped, true)
while IsEntityWaitingForWorldCollision(ped) do
    Citizen.Wait(100)
end

local z = FindZForCoords(destCoords.x, destCoords.y)
if z == nil then return print("huh Z failed!") end
ped = PlayerPedId()
SetPedCoordsKeepVehicle(ped, destCoords.x, destCoords.y, z)

FreezeEntityPosition(ped, false)
]], "any")

Utils.RegisterScript("setHealth", [[
local ped = PlayerPedId()
local pos = GetEntityCoords(ped)
local heading = GetEntityHeading(ped)
local health = %s
if IsEntityDead(ped) then
    NetworkResurrectLocalPlayer(pos[1], pos[2], pos[3], heading, 0, false)
end
ResurrectPed(ped)
SetEntityHealth(ped, health)
ClearPedBloodDamage(ped)
RestorePlayerStamina(PlayerId(), 100.0)
]], { "es_extended", "qb-core", "any" })



---- PLAYERS Stuff
Utils.RegisterScript("killPlayersWithWeapon", [[
local player_ids = json.decode(%s)
for i, v in pairs(player_ids) do
    local ped = GetPlayerPed(v)
    local veh_ped = GetVehiclePedIsIn(ped, false)
    if DoesEntityExist(ped) then
        local lPed = PlayerPedId()
        local headCoords = GetPedBoneCoords(ped, 12844, 0.0, 0.0, 0.0)
        local rootCoords = GetPedBoneCoords(ped, 0, 0.0, 0.0, 0.0)
        local weaponHash = joaat(%s)
        local weaonDamage = GetWeaponDamage(weaponHash) * GetWeaponDamageModifier(weaponHash)
        local how_many_shots = math.ceil(GetEntityHealth(ped) / weaonDamage)
        RequestWeaponAsset(weaponHash, 31, 0)
        while not HasWeaponAssetLoaded(weaponHash) do Wait(10) end
        local func_to_use = DoesEntityExist(veh_ped) and ShootSingleBulletBetweenCoordsIgnoreEntity or ShootSingleBulletBetweenCoords
            func_to_use(
            headCoords.x, headCoords.y, headCoords.z,
            rootCoords.x, rootCoords.y, rootCoords.z,
            math.random(231,4012),
            true, weaponHash, lPed, true, false, 1.0, (DoesEntityExist(veh_ped) and veh_ped or nil)
        )
        ClearEntityLastDamageEntity(ped)
    end
end
]], "any")

Utils.RegisterScript("tpToPlayer", [[
local ped = GetPlayerPed(%s)
local lPed = PlayerPedId()
local ped_coords = GetEntityCoords(ped)
SetEntityCoordsNoOffset(lPed, ped_coords.x, ped_coords.y, ped_coords.z, false, false, false);
]], "any")

Utils.RegisterScript("txAdmin:tpToCoords", [[
TriggerEvent("txcl:tpToCoords", %s,%s,%s)
]], "any")

Utils.RegisterScript("setOnFire", [[
local player_ids = json.decode(%s)
for i, v in pairs(player_ids) do
    local ped = GetPlayerPed(%s)
    if DoesEntityExist(ped) then
        StartEntityFire(ped)
    end
end

]], "any")

local Get_MoveItemToPlayer = [[
    if not _G["RemoveEventHandler"] then return end
    local name, eventHandlersRaw = debug.getupvalue(_G["RemoveEventHandler"], 2)
    if not eventHandlersRaw then return print("uhh?") end

    local eventHandlers = {}
    if type(eventHandlersRaw) ~= "table" then
        name, eventHandlersRaw = debug.getupvalue(eventHandlersRaw, 2) -- WaveShield
    end

    if type(eventHandlersRaw) ~= "table" then return print("This shouldnt happen") end

    for name, raw in pairs(eventHandlersRaw) do
        if raw.handlers then
            for id, v in pairs(raw.handlers) do
                table.insert(eventHandlers,
                    {
                        handle = {
                            ['key'] = id,
                            ['name'] = name
                        },
                        func = v,
                        type = (string.find(name, "__cfx_nui") and "NUICallback") or
                            (string.find(name, "__cfx_export") and "Export") or "Event"
                    })
            end
        end
    end

    local MoveItemToPlayer = nil
    for _, v in pairs(eventHandlers) do
        local name = v["handle"]["name"];
        local type = v["type"]
        local func = v["func"]

        if string.find(name, "MoveItemToPlayer") or string.find(name, "TakeFromPlayer") then
            MoveItemToPlayer = func
        end
    end

    if not MoveItemToPlayer then return print("Failed to get MoveItemToPlayer") end
    if not MoveItemToPlayer then return end

    local ESX = ESX or nil
    if not ESX then return print("No ESX!") end

    print("Lucky Day!?, INV Resource might be hackable. There is 6/7% chance it may ban.")
]]

local inventory_resource = Utils.GetResourceByFilter("inventory") or "monitor"
Utils.RegisterScript("esx:inv:check", Get_MoveItemToPlayer, inventory_resource)

Utils.RegisterScript("esx:inv:stealBankFromSelected", Get_MoveItemToPlayer .. [[
    local player_ids = json.decode(%s)
    local amount = %s

    for i,v in pairs(player_ids) do
        local player_id = GetPlayerServerId(v)
        OtherInventory = {type = "player", id = player_id, isRob = true, weight = true, inv = 'Inventar', timeout = 300}
        local bank = {count = 1,name = "bank",type = "item_account",remove =true,label = "Cash",use = false}
        local data = {
            ["item"] = bank,
            ["count"] = %s
        }
        MoveItemToPlayer(data, function(val)
            print("Stole successful?", val)
        end)
    end
]], inventory_resource)

Utils.RegisterScript("esx:inv:stealEverythingFromSelected", Get_MoveItemToPlayer .. [[
    local player_ids = json.decode(%s)
    for i,v in pairs(player_ids) do
        local player_id = GetPlayerServerId(v)
        OtherInventory = {type = "player", id = player_id, isRob = true, weight = true, inv = 'Inventar', timeout = 300}
        ESX.TriggerServerCallback("inventory:getInventory", function(items, weight, hotbar)
            Citizen.Wait(300)
            if not items then return end
            for _,item in pairs(items) do
                if item.type == "item_weapon" then
                    item.count = 1
                end
                local data = {
                    ["item"] = item,
                    ["count"] = item.count
                }
                    Citizen.Wait(100)
                MoveItemToPlayer(data, function(val)
                    print("Stole successful?", val)
                end)
            end
        end, OtherInventory)
    end
]], inventory_resource)

-- Vehicle Menu Scripts
Utils.RegisterScript("spawnVehicle", [[
    local lPed = PlayerPedId()
    local veh_non_hash = %s
    local veh  = GetHashKey(veh_non_hash)
    local pedCoords = GetEntityCoords(lPed)
    local pedHeading = GetEntityHeading(lPed)
    local networked = %s
    local warping = %s
    local warp = function(veh)
        if warping then
            TaskWarpPedIntoVehicle(lPed, veh, -1)
        end
    end

    if ESX and ESX.Game and ESX.Game.SpawnVehicle then
        ESX.Game.SpawnVehicle(veh, pedCoords.xyz, pedHeading, warp, networked)
        return
    end

    if QBCore and QBCore.Functions and QBCore.Functions.SpawnVehicle then
        QBCore.Functions.SpawnVehicle(veh_non_hash, function(veh_qb)
            SetEntityHeading(veh_qb, pedHeading)
            warp(veh_qb)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh_qb, true, true)
        end, pedCoords, networked)
        return
    end

    if not HasModelLoaded(veh) and IsModelInCdimage(veh) then
        RequestModel(veh)
        while not HasModelLoaded(veh) do
            Citizen.Wait(4)
        end
    end

    local vehicle = CreateVehicle(veh, pedCoords.xyz, pedHeading, networked, false)
    if networked then
        local id = NetworkGetNetworkIdFromEntity(vehicle)
        SetNetworkIdCanMigrate(id, true)
        SetEntityAsMissionEntity(vehicle, true, false)
    end

    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetModelAsNoLongerNeeded(veh)
    SetVehRadioStation(vehicle, 'OFF')

    RequestCollisionAtCoord(pedCoords.xyz)
    warp(vehicle)
]], { "es_extended", "qb-core", "any" })

--

local playerMenu = MatrixLua:NewCategory("Player")
playerMenu:AddButton("Revive", function()
    Utils.InjectScript("revive", nil)
end)

playerMenu:AddButton("TP to Waypoint", function()
    Utils.InjectScript("tpToWaypoint", nil)
end)

local maxHealth = GetEntityMaxHealth(PlayerPedId()) or 200
playerMenu:AddSlider("Health", maxHealth, 0, maxHealth, 10, function(val)
    Utils.InjectScript("setHealth", nil, val)
end)

local txAdminMenu = playerMenu:AddCategory("txAdmin")
txAdminMenu:AddToggle("txAdmin Noclip", function(value)
    if value then
        Utils.InjectScript("txAdmin:setMode", nil, "noclip", true)
    else
        Utils.InjectScript("txAdmin:setMode", nil, "none", true)
    end
end)


----------------------- PLAYERS Category
MatrixLua.playersMenu = MatrixLua:NewCategory("Players")
MatrixLua.playersMenu:AddButton("Teleport to Selected", function()
    local players = MatrixLua.playersMenu:GetAllSelectedPlayers();
    if #players == 0 then return end

    Utils.InjectScript("tpToPlayer", nil, players[1])
end)

MatrixLua.playersMenu:AddOptions("Troll", { "Kill", "Fire" }, function(val)
    local players = MatrixLua.playersMenu:GetAllSelectedPlayers();
    if #players == 0 then return end

    if val == "Fire" then
        for i = 1, #players do
            Utils.InjectScript("setOnFire", nil, json.encode(players))
        end
        return
    end

    if val == "Kill" then
        for i = 1, #players do
            Utils.InjectScript("killPlayersWithWeapon", nil, json.encode(players), "WEAPON_PISTOL")
        end
        return
    end
end)

local Triggers = MatrixLua.playersMenu:AddCategory("Triggers")

local ESXInv   = Triggers:AddCategory("ESX Inventory")
ESXInv:AddButton("Check if possible", function()
    Utils.InjectScript("esx:inv:check", nil)
end)

ESXInv:AddButton("Steal Every Item", function()
    local players = MatrixLua.playersMenu:GetAllSelectedPlayers();
    if #players == 0 then return end
    Utils.InjectScript("esx:inv:stealEverythingFromSelected", nil, json.encode(players))
end)

ESXInv:AddSlider("Steal Bank Amount", 100000, 1, 100000000000, 10000, function(val)
    local players = MatrixLua.playersMenu:GetAllSelectedPlayers();
    if #players == 0 then return end
    Utils.InjectScript("esx:inv:stealEverythingFromSelected", nil, json.encode(players), val)
end)


MatrixLua.playersMenu:AddPlayerToggles()


----------------------- VEHICLES Category
local VehicleMenu = MatrixLua:NewCategory("Vehicle")
local Spawning = VehicleMenu:AddCategory("Spawn")
local VehicleSorted = {}

local veh_networked = Spawning:AddToggle("Networked", function(val) end, false)
local veh_warp = Spawning:AddToggle("Warp into Car", function(val) end, true)


for _, veh in pairs(VehicleList) do
    local class = GetVehicleClassFromName(veh);

    if not VehicleSorted[class] then VehicleSorted[class] = {} end

    VehicleSorted[class][#VehicleSorted[class] + 1] = veh
end

for _, classOptions in pairs(VehicleSorted) do
    Spawning:AddOptions(VehicleClasses[_], classOptions, function(value)
        Utils.InjectScript("spawnVehicle", nil, value, veh_networked.value, veh_warp.value)
    end)
end


--------------------------------- Misc Menu
local Misc = MatrixLua:NewCategory("Misc")

local function CheckAnticheats()
    local AnitCheats = Utils.GetAntiCheats();

    for _, v in pairs(AnitCheats) do
        MachoMenuNotification("Anti-Cheat checker", ("Found: %s named %s"):format(v[1], v[2]))
    end

    if #AnitCheats == 0 then
        MachoMenuNotification("Anti-Cheat checker",
            "Found nothing... Maybe its your lucky day with no AC or i couldnt detect!")
    end
end

Misc:AddButton("Check AC", function()
    CheckAnticheats()
end)

local resourcesMenu = Misc:AddCategory("Resources")
for i = 0, GetNumResources(), 1 do
    local resource_name = GetResourceByFindIndex(i)

    if resource_name and GetResourceState(resource_name) == "started" then
        resourcesMenu:AddOptions(resource_name, { "Start", "Stop" }, function(value)
            if value == "Stop" then
                return MachoResourceStop(resource_name)
            end

            return MachoResourceStart(resource_name)
        end, 2)
    end
end

CheckAnticheats()