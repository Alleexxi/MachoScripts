---@meta

--- *`Macho`*\
---[Documentation](https://machocheats.com/docs/lua/native-hooking/)  
---Hooks a GTA native by 64-bit hash (not JOAAT). CitizenFX natives can't be hooked.  
---Callback runs in isolated environment, receives native args.  
---Return boolean (true = call next/original, false = skip original), plus any return values.
---```lua
---
-----Install our GetPlayerName hook.
---MachoHookNative(0x6D0DE6A7B5DA71F8, function (player_id)
---    --
---    -- This will execute isolated so that you don't risk getting flagged.
---    -- Print who called this hook, and print our real name, then give them a false name.
---    -- 
---    print(GetCurrentResourceName() .. "tried to get our real name: " .. GetPlayerName(player_id))
---    
---    --
---    -- Set our name to "macho-man", and don't call the original.
---    --
---    return false, "macho-man"
---  end)
---
-----
----- Test this actually worked:
-----
---MachoInjectResource("any", [[
---  --
---  -- What's our name?
---  -- 
---  print(GetPlayerName(PlayerId()))
---]])
---```
---@param native integer
---@param callback fun(...): boolean, ...
function MachoHookNative(native, callback) end

--- *`Macho`*\
---[Documentation](https://machocheats.com/docs/lua/resource-injection/)
---
--- This function injects your code into the specified resource.\
--- This enables access to the resource's global functions and data.\
--- The resource name can be found in the Resources tab, or you can use "any" to inject into any resource.\
--- ```lua
---  MachoInjectResource("any", [[ print("Hello World!") ]]) 
--- ```
---@param resource string
---@param code string
function MachoInjectResource(resource, code) end


--- *`Macho`*\
--- This function injects your code into the specified resource.\
--- This enables access to the resource's global functions and data.\
--- The resource name can be found in the Resources tab, or you can use "any" to inject into any resource.\
--- > "MachoInjectResourceRaw" which can be used if you do NOT want the trigger bypass!
--- ```lua
---  MachoInjectResourceRaw("any", [[ print("Hello World!") ]]) 
--- ```
---@param resource string
---@param code string
function MachoInjectResource(resource, code) end


--- *`Macho`*\
--- Injects into a resource using the specified injection type.\
---
--- Injection Types:\
---   `0`: Runs the code as a new thread with the Macho table.\
---   `1`: Runs the code as a new thread without the Macho table (equivalent to MachoInjectResource).\
---   `2`: Runs the code in any existing thread with the Macho table.\
---   `3`: Runs the code in any existing thread without the Macho table.\
---
--- Recommendation:\
---   For injecting triggers, use type 3. This will execute the code in the context of an existing thread.
---@param type integer
---@param resource string
---@param code string
function MachoInjectResource2(type, resource, code) end

---*`Macho`*\
---Injects into a specified Thread.\
--- 
---```lua
--- MachoInjectThread(0, "chat", "main.lua", [[
---     print("Hello from Chat!")
--- ]])
---```
---@param type integer
---@param resource string
---@param threadName string
---@param code string
function MachoInjectThread(type, resource, threadName, code) end

---*`Macho`*\
---Returns if its possible to Inject into the given resource.
---
---@param resource string
---@return boolean
function MachoResourceInjectable(resource) end

---*`Macho`*\
---Macho-stop a resource
---
---@param resource string
function MachoResourceStop(resource) end

---*`Macho`*\
---Macho-start a resource
---
---@param resource string
function MachoResourceStart(resource) end





---@class WindowReference
---@class GroupReference
---@class WidgetReference
---@class TabReference


--- @param PositionX number
--- @param PositionY number
--- @param EndPositionX number
--- @param EndPositionY number
--- @return WindowReference
function MachoMenuWindow(PositionX, PositionY, EndPositionX, EndPositionY) end

--- @param Name string
--- @param PosX number
--- @param PosY number
--- @param SizeX number
--- @param SizeY number
--- @param TabSectionWidth number
--- @return WindowReference
function MachoMenuTabbedWindow(Name, PosX, PosY, SizeX, SizeY, TabSectionWidth) end

--- @param WindowReference WindowReference
function MachoMenuDestroy(WindowReference) end

--- @param WindowReference WindowReference
--- @param r number
--- @param g number
--- @param b number
function MachoMenuSetAccent(WindowReference, r, g, b) end

--- @param WindowReference WindowReference
--- @param Keybind integer
function MachoMenuSetKeybind(WindowReference, Keybind) end

--- @param WindowReference WindowReference | TabReference
--- @param Name string
--- @param PositionX number
--- @param PositionY number
--- @param EndPositionX number
--- @param EndPositionY number
--- @return GroupReference
function MachoMenuGroup(WindowReference, Name, PositionX, PositionY, EndPositionX, EndPositionY) end

--- @param WindowReference WindowReference
--- @param Name string
--- @return TabReference
function MachoMenuAddTab(WindowReference, Name) end

--- @param WindowReference WindowReference
--- @param Text string
function MachoMenuSmallText(WindowReference, Text) end

--- @param GroupReference GroupReference
--- @param Name string
--- @param Callback function
--- @return WidgetReference
function MachoMenuButton(GroupReference, Name, Callback) end

--- @param GroupReference GroupReference
--- @param Name string
--- @param CallbackEnabled fun()
--- @param CallbackDisabled fun()
--- @return WidgetReference
function MachoMenuCheckbox(GroupReference, Name, CallbackEnabled, CallbackDisabled) end

--- @param GroupReference GroupReference
--- @param Name string
--- @param DefaultValue number
--- @param Minimum number
--- @param Maximum number
--- @param Unit string
--- @param DecimalPrecision integer
--- @param Callback fun(value: any)
--- @return WidgetReference
function MachoMenuSlider(GroupReference, Name, DefaultValue, Minimum, Maximum, Unit, DecimalPrecision, Callback) end

--- @param GroupReference GroupReference
--- @param Text string
--- @return WidgetReference
function MachoMenuText(GroupReference, Text) end

--- @param WidgetReference WidgetReference
--- @param Text string
function MachoMenuSetText(WidgetReference, Text) end

--- @param GroupReference GroupReference
--- @param Text string
--- @param Placeholder string
--- @return WidgetReference
function MachoMenuInputbox(GroupReference, Text, Placeholder) end

--- @param WidgetReference WidgetReference
--- @return string
function MachoMenuGetInputbox(WidgetReference) end

--- @param GroupReference GroupReference
--- @param Name string
--- @param Callback function
--- @param ... string
--- @return WidgetReference
function MachoMenuDropDown(GroupReference, Name, Callback, ...) end


--- Create a macho-style notification
--- @param title string
--- @param description string
function MachoMenuNotification(title, description) end


--- Gets the logger state
--- @return integer
function MachoGetLoggerState() end

--- Sets the loggers current state.
--- @param state integer
function MachoSetLoggerState(state) end

--- Locks the event logger
--- @param state integer
function MachoLockLogger(state) end

--- Returns the users auth key.
--- @return string
function MachoAuthenticationKey() end

--- Sends a HTTP GET request to the URL specified and returns the response body.
--- @param url string
--- @return string
function MachoWebRequest(url) end

--- Returns the selected player's server id on the macho player picker. 
--- @return integer
function MachoMenuGetSelectedPlayer() end

--- Returns the selected vehicle on the macho vehicle picker. 
--- @return integer
function MachoMenuGetSelectedVehicle() end

--- @param callback fun(keycode: integer)
function MachoOnKeyUp(callback) end

--- @param callback fun(keycode: integer)
function MachoOnKeyDown(callback) end

---@class duiHandle

--- This will create a DUI window, rendering is handled by us in the backend.\
--- The default dimensions are the same as the games resolution. By default, this menu is hidden.
--- @param url string
--- @return duiHandle
function MachoCreateDui(url) end

--- @param handle duiHandle
function MachoShowDui(handle) end

--- @param handle duiHandle
function MachoHideDui(handle) end

--- @param handle duiHandle
function MachoDestroyDui(handle) end

--- This will post a message event to the DUI window.\ 
--- You can catch this using window.addEventListener("message", ...) inside your javascript code on the page. 
--- @param handle duiHandle
--- @param json string
function MachoSendDuiMessage(handle, json) end

--- This allows you to inject javascript code directly into your DUI window.
--- @param handle duiHandle
--- @param script string
function MachoExecuteDuiScript(handle, script) end

--- This will inject your JavaScript into the Chromium Embedded Framework
--- @param code string
function MachoInjectJavaScript(code) end
