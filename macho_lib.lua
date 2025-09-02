local Lib = {}
Lib.__index = Lib

-- Window class
local Window = {}
Window.__index = Window

function Lib:CreateWindow(opts)
    local title = opts.Title or "Window"
    local size = opts.Size or {x = 800, y = 600}
    local start = opts.StartLocation or {x = 100, y = 100}
    local accent = opts.AccentColor or {r = 137, g = 52, b = 235}
    local keybind = opts.Keybind
    local tabWidth = opts.TabSelectionWidth or 150

    local self = setmetatable({}, Window)
    self._window = MachoMenuTabbedWindow(title, start.x, start.y, size.x, size.y, tabWidth)
    MachoMenuSetAccent(self._window, accent.r, accent.g, accent.b)
    if keybind then MachoMenuSetKeybind(self._window, keybind) end
    self._tabs = {}
    return self
end

function Window:AddTab(name)
    local tabHandle = MachoMenuAddTab(self._window, name)
    local tabObj = setmetatable({
        _tab = tabHandle,
        _groups = {},
        _groupbox_defs = {},
        _window_size = self._window_size or {x = 800, y = 600},
        _tab_start_x = 160,
        _width_padding = 10,
        _pane_gap = 10
    }, Tab)
    table.insert(self._tabs, tabObj)
    return tabObj
end

function Window:AddText(text)
    MachoMenuSmallText(self._window, text)
end

Tab = {}
Tab.__index = Tab

function Tab:_recreateGroups()
    if not self._groupbox_objs then self._groupbox_objs = {} end
    self._groups = {}
    local count = #self._groupbox_defs
    if count == 0 then return end

    local MenuSize = self._window_size or {x = 800, y = 500}
    local TabSelectionStartX = self._tab_start_x or 160
    local WidthPadding = self._width_padding or 10
    local MachoPaneGap = self._pane_gap or 10
    local availableWidth = MenuSize.x - TabSelectionStartX - WidthPadding
    local groupWidth = availableWidth / count
    local groupHeight = MenuSize.y - MachoPaneGap
    local y = MachoPaneGap

    for i, def in ipairs(self._groupbox_defs) do
        local x = TabSelectionStartX + groupWidth * (i - 1)
        local groupHandle = MachoMenuGroup(self._tab, def.title, x, y, x + groupWidth, y + groupHeight)
        local groupObj = self._groupbox_objs[i]
        if not groupObj then
            groupObj = setmetatable({}, Groupbox)
            self._groupbox_objs[i] = groupObj
        end
        groupObj._group = groupHandle
        groupObj._title = def.title
        table.insert(self._groups, groupObj)
    end
    for i = count + 1, #self._groupbox_objs do
        self._groupbox_objs[i] = nil
    end
end

function Tab:AddGroupbox(title)
    if not self._groupbox_defs then self._groupbox_defs = {} end
    if not self._window_size then
        if self._tab and self._tab._window_size then
            self._window_size = self._tab._window_size
        else
            self._window_size = {x = 800, y = 500}
        end
    end
    self._tab_start_x = 160
    self._width_padding = 10
    self._pane_gap = 10
    table.insert(self._groupbox_defs, {title = title})
    self:_recreateGroups()

    if not self._groupbox_objs then self._groupbox_objs = {} end
    return self._groupbox_objs[#self._groupbox_defs]
end

Groupbox = {}
Groupbox.__index = Groupbox

function Groupbox:AddButton(label, callback)
    MachoMenuButton(self._group, label, callback)
end

function Groupbox:AddSlider(label, default, min, max, unit, precision, callback)
    return MachoMenuSlider(self._group, label, default, min, max, unit, precision, callback)
end

function Groupbox:AddDropdown(label, callback, options)
    return MachoMenuDropDown(self._group, label, callback, table.unpack(options))
end

function Groupbox:AddLabel(text)
    MachoMenuText(self._group, text)
end

return setmetatable({}, {__index = Lib})
