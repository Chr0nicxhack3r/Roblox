-- Framework originally created by KavoUI: https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua
-- Modified by Chr0nicxHack3r

local Chr0nicxHack3r = {}
Chr0nicxHack3r.ConfigEnabled = false
local Utility = {}
local ConfigStore = {}
local ALIVE = true
Chr0nicxHack3r.OnGuiDestroyed = nil
Chr0nicxHack3r._ScreenGui = nil
Chr0nicxHack3r._LibName = nil

local tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")

local Connections = {}

local function Track(conn)
    table.insert(Connections, conn)
    return conn
end

function Chr0nicxHack3r:_Shutdown()
    if not ALIVE then return end
    ALIVE = false

    -- Disconnect all tracked connections
    for _, c in ipairs(Connections) do
        pcall(function() c:Disconnect() end)
    end
    table.clear(Connections)

    -- Destroy UI
    if self._ScreenGui then
        local destroyedGui = self._ScreenGui
        pcall(function()
            destroyedGui:Destroy()
        end)
        self._ScreenGui = nil

        if self.OnGuiDestroyed then
            pcall(self.OnGuiDestroyed, destroyedGui)
        end
    end

    self._LibName = nil
end

local ThemeListeners = {}
function Chr0nicxHack3r:OnThemeChange(fn)
    ThemeListeners[fn] = true
    task.defer(fn)
end

local function ApplyTheme()
    for fn in pairs(ThemeListeners) do
        local ok, err = pcall(fn)
        if not ok then
            ThemeListeners[fn] = nil
            warn("Theme listener error:", err)
        end
    end
end

--[[local function SaveConfig()
    pcall(function()
        writefile(Name, HttpService:JSONEncode(SettingsT))
    end)
end]] -- Removed in 2.0, use OnConfigChanged instead. This can be re-added if needed for auto saves.

function Chr0nicxHack3r:DraggingEnabled(frame, parent)
    parent = parent or frame

    local dragging = false
    local dragInput, mousePos, framePos

    Track(frame.InputBegan:Connect(function(inputObj)
        if inputObj.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = inputObj.Position
            framePos = parent.Position

            Track(inputObj.Changed:Connect(function()
                if inputObj.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end))
        end
    end))

    Track(frame.InputChanged:Connect(function(inputObj)
        if inputObj.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = inputObj
        end
    end))

    Track(input.InputChanged:Connect(function(inputObj)
        if inputObj == dragInput and dragging then
            local delta = inputObj.Position - mousePos
            parent.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end))
end

function Utility:FadeAndDestroy(img, duration)
    tween:Create(
        img,
        TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { ImageTransparency = 1 }
    ):Play()

    task.delay(duration, function()
        if img then img:Destroy() end
    end)
end

function Utility:TweenObject(obj, properties, duration, ...)
    tween:Create(obj, tweeninfo(duration, ...), properties):Play()
end

function Utility:SetHover(obj, color)
    obj.BackgroundColor3 = color
end

function Utility:BindHover(opts)
    -- opts.button        : GuiObject
    -- opts.isHoveredRef  : function(get/set)
    -- opts.focusingRef   : function() -> bool
    -- opts.onHover       : function()
    -- opts.onLeave       : function()

    Track(opts.button.MouseEnter:Connect(function()
        if opts.focusingRef and opts.focusingRef() then return end
        if opts.isHoveredRef then opts.isHoveredRef(true) end
        if opts.onHover then opts.onHover() end
    end))

    Track(opts.button.MouseLeave:Connect(function()
        if opts.focusingRef and opts.focusingRef() then return end
        if opts.isHoveredRef then opts.isHoveredRef(false) end
        if opts.onLeave then opts.onLeave() end
    end))
end

local function clamp255(v)
    return math.clamp(v, 0, 255)
end

local function Offset(color, dr, dg, db)
    return Color3.fromRGB(
        clamp255(color.r * 255 + dr),
        clamp255(color.g * 255 + dg),
        clamp255(color.b * 255 + db)
    )
end

local DerivedTheme = {}
local themeList

local function RebuildDerivedTheme(theme)
    DerivedTheme.ElementHover = Offset(theme.ElementColor, 8, 9, 10)
    DerivedTheme.ElementPressed = Offset(theme.ElementColor, -6, -6, -7)
    DerivedTheme.TooltipBackground = Offset(theme.SchemeColor, -14, -17, -13)
    DerivedTheme.PlaceholderText = Offset(theme.SchemeColor, -19, -26, -35)
    DerivedTheme.SliderTrack = Offset(theme.ElementColor, 5, 5, 5)
    DerivedTheme.OptionTextDim = Offset(theme.TextColor, -6, -6, -6)
    DerivedTheme.Scrollbar = Offset(theme.SchemeColor, -16, -15, -28)
end

local themes = {
    SchemeColor = Color3.fromRGB(74, 99, 135),
    Background = Color3.fromRGB(36, 37, 43),
    Header = Color3.fromRGB(28, 29, 34),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(32, 32, 38)
}
local themeStyles = {
    DarkTheme = {
        SchemeColor = Color3.fromRGB(64, 64, 64),
        Background = Color3.fromRGB(0, 0, 0),
        Header = Color3.fromRGB(0, 0, 0),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(20, 20, 20)
    },
    LightTheme = {
        SchemeColor = Color3.fromRGB(150, 150, 150),
        Background = Color3.fromRGB(255, 255, 255),
        Header = Color3.fromRGB(200, 200, 200),
        TextColor = Color3.fromRGB(0, 0, 0),
        ElementColor = Color3.fromRGB(224, 224, 224)
    },
    BloodTheme = {
        SchemeColor = Color3.fromRGB(227, 27, 27),
        Background = Color3.fromRGB(10, 10, 10),
        Header = Color3.fromRGB(5, 5, 5),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(20, 20, 20)
    },
    GrapeTheme = {
        SchemeColor = Color3.fromRGB(166, 71, 214),
        Background = Color3.fromRGB(64, 50, 71),
        Header = Color3.fromRGB(36, 28, 41),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(74, 58, 84)
    },
    Ocean = {
        SchemeColor = Color3.fromRGB(86, 76, 251),
        Background = Color3.fromRGB(26, 32, 58),
        Header = Color3.fromRGB(38, 45, 71),
        TextColor = Color3.fromRGB(200, 200, 200),
        ElementColor = Color3.fromRGB(38, 45, 71)
    },
    Midnight = {
        SchemeColor = Color3.fromRGB(26, 189, 158),
        Background = Color3.fromRGB(44, 62, 82),
        Header = Color3.fromRGB(57, 81, 105),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(52, 74, 95)
    },
    Sentinel = {
        SchemeColor = Color3.fromRGB(230, 35, 69),
        Background = Color3.fromRGB(32, 32, 32),
        Header = Color3.fromRGB(24, 24, 24),
        TextColor = Color3.fromRGB(119, 209, 138),
        ElementColor = Color3.fromRGB(24, 24, 24)
    },
    Synapse = {
        SchemeColor = Color3.fromRGB(46, 48, 43),
        Background = Color3.fromRGB(13, 15, 12),
        Header = Color3.fromRGB(36, 38, 35),
        TextColor = Color3.fromRGB(152, 99, 53),
        ElementColor = Color3.fromRGB(24, 24, 24)
    },
    Serpent = {
        SchemeColor = Color3.fromRGB(0, 166, 58),
        Background = Color3.fromRGB(31, 41, 43),
        Header = Color3.fromRGB(22, 29, 31),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(22, 29, 31)
    }
}
local oldTheme = ""

local function GetThemeNames()
    local names = {}
    for name in pairs(themeStyles) do
        table.insert(names, name)
    end
    table.sort(names)
    return names
end

function Chr0nicxHack3r:SetTheme(themeName)
    local newTheme = themeStyles[themeName]
    if not newTheme then return end

    themeList = table.clone(newTheme)
    RebuildDerivedTheme(themeList)
    ApplyTheme()

    if SettingsT then
        SettingsT.SelectedTheme = themeName
        Chr0nicxHack3r:SaveConfig(false)
    end
end

function Chr0nicxHack3r.GetThemes()
    return GetThemeNames()
end

local SettingsT = {

}

local Name = "Chr0nicxHack3rConfig.JSON"
local CONFIG_VERSION = 1
local SAVE_DEBOUNCE = 0.25
local pendingSave = false
Chr0nicxHack3r.OnUnload = nil

local HttpService = game:GetService("HttpService")

if Chr0nicxHack3r.ConfigEnabled then
    pcall(function()
        if not pcall(function() return readfile(Name) end) then
            writefile(Name, HttpService:JSONEncode(SettingsT))
        end

        local raw = readfile(Name)
        local decoded = HttpService:JSONDecode(raw)

        if type(decoded) == "table" then
            SettingsT = decoded
        else
            SettingsT = {}
        end
        if type(SettingsT.__version) ~= "number" or SettingsT.__version ~= CONFIG_VERSION then
            SettingsT = {}
            SettingsT.__version = CONFIG_VERSION
        end
    end)
end

if SettingsT.SelectedTheme and themeStyles[SettingsT.SelectedTheme] then
    themeList = table.clone(themeStyles[SettingsT.SelectedTheme])
    RebuildDerivedTheme(themeList)
end

--local LibName = tostring(math.random(1, 100)) .. tostring(math.random(1, 50)) .. tostring(math.random(1, 100))
--local LibName = "Chr0nicxUI_" .. game:GetService("HttpService"):GenerateGUID(false)
local LibName = "Roblox_" .. game:GetService("HttpService"):GenerateGUID(false)
Chr0nicxHack3r._LibName = LibName

function Chr0nicxHack3r:ToggleUI()
    local gui = self._ScreenGui
    if not gui then return end
    gui.Enabled = not gui.Enabled
end

local function SaveConfigDebounced()
    if not Chr0nicxHack3r.ConfigEnabled then return end
    if pendingSave then return end

    pendingSave = true
    task.delay(SAVE_DEBOUNCE, function()
        pendingSave = false
        if writefile then
            SettingsT.__version = CONFIG_VERSION
            writefile(Name, HttpService:JSONEncode(SettingsT))
        end
    end)
end

local function SaveConfigImmediate()
    if not Chr0nicxHack3r.ConfigEnabled then return end
    if writefile then
        SettingsT.__version = CONFIG_VERSION
        writefile(Name, HttpService:JSONEncode(SettingsT))
    end
end

function Chr0nicxHack3r:SaveConfig(immediate)
    if immediate then
        SaveConfigImmediate()
    else
        SaveConfigDebounced()
    end
end

function Chr0nicxHack3r.CreateLib(Chr0nicName, themeArg)
    if themeArg and themeStyles[themeArg] then
        themeList = table.clone(themeStyles[themeArg])
    end
    --[[if not themeList then
        themeList = themes
    end
    if themeList == "DarkTheme" then
        themeList = themeStyles.DarkTheme
    elseif themeList == "LightTheme" then
        themeList = themeStyles.LightTheme
    elseif themeList == "BloodTheme" then
        themeList = themeStyles.BloodTheme
    elseif themeList == "GrapeTheme" then
        themeList = themeStyles.GrapeTheme
    elseif themeList == "Ocean" then
        themeList = themeStyles.Ocean
    elseif themeList == "Midnight" then
        themeList = themeStyles.Midnight
    elseif themeList == "Sentinel" then
        themeList = themeStyles.Sentinel
    elseif themeList == "Synapse" then
        themeList = themeStyles.Synapse
    elseif themeList == "Serpent" then
        themeList = themeStyles.Serpent
    else
        themeList.SchemeColor  = themeList.SchemeColor or Color3.fromRGB(74, 99, 135)
        themeList.Background   = themeList.Background or Color3.fromRGB(36, 37, 43)
        themeList.Header       = themeList.Header or Color3.fromRGB(28, 29, 34)
        themeList.TextColor    = themeList.TextColor or Color3.fromRGB(255, 255, 255)
        themeList.ElementColor = themeList.ElementColor or Color3.fromRGB(32, 32, 38)
    end]]
    --RebuildDerivedTheme(themeList)

    --themeList = themeList or {}
    themeList = themeList or table.clone(themeStyles.DarkTheme)
    RebuildDerivedTheme(themeList)
    local selectedTab
    Chr0nicName = Chr0nicName or "Library"
    local ScreenGui = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local MainHeader = Instance.new("Frame")
    local headerCover = Instance.new("UICorner")
    local coverup = Instance.new("Frame")
    local title = Instance.new("TextLabel")
    local close = Instance.new("ImageButton")
    local MainSide = Instance.new("Frame")
    local sideCorner = Instance.new("UICorner")
    local coverup_2 = Instance.new("Frame")
    local tabFrames = Instance.new("Frame")
    local tabListing = Instance.new("UIListLayout")
    local pages = Instance.new("Frame")
    local Pages = Instance.new("Folder")
    local infoContainer = Instance.new("Frame")

    local blurFrame = Instance.new("Frame")
    ScreenGui.Name = LibName
    Chr0nicxHack3r._ScreenGui = ScreenGui

    Chr0nicxHack3r:DraggingEnabled(MainHeader, Main)

    blurFrame.Name = "blurFrame"
    blurFrame.Parent = pages
    blurFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blurFrame.BackgroundTransparency = 1
    blurFrame.BorderSizePixel = 0
    blurFrame.Position = UDim2.new(-0.0222222228, 0, -0.0371747203, 0)
    blurFrame.Size = UDim2.new(0, 376, 0, 289)
    blurFrame.ZIndex = 999

    ScreenGui.Parent = game.CoreGui
    ScreenGui.Name = LibName
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false

    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = themeList.Background
    Main.ClipsDescendants = true
    Main.Position = UDim2.new(0.336503863, 0, 0.275485456, 0)
    Main.Size = UDim2.new(0, 525, 0, 318)

    MainCorner.CornerRadius = UDim.new(0, 4)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    MainHeader.Name = "MainHeader"
    MainHeader.Parent = Main
    MainHeader.BackgroundColor3 = themeList.Header
    MainHeader.Size = UDim2.new(0, 525, 0, 29)
    headerCover.CornerRadius = UDim.new(0, 4)
    headerCover.Name = "headerCover"
    headerCover.Parent = MainHeader

    coverup.Name = "coverup"
    coverup.Parent = MainHeader
    coverup.BackgroundColor3 = themeList.Header
    coverup.BorderSizePixel = 0
    coverup.Position = UDim2.new(0, 0, 0.758620679, 0)
    coverup.Size = UDim2.new(0, 525, 0, 7)

    title.Name = "title"
    title.Parent = MainHeader
    title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1.000
    title.BorderSizePixel = 0
    title.Position = UDim2.new(0.0171428565, 0, 0.344827592, 0)
    title.Size = UDim2.new(0, 204, 0, 8)
    title.Font = Enum.Font.Gotham
    title.RichText = true
    title.Text = Chr0nicName
    title.TextColor3 = Color3.fromRGB(245, 245, 245)
    title.TextSize = 16.000
    title.TextXAlignment = Enum.TextXAlignment.Left

    close.Name = "close"
    close.Parent = MainHeader
    close.BackgroundTransparency = 1.000
    close.Position = UDim2.new(0.949999988, 0, 0.137999997, 0)
    close.Size = UDim2.new(0, 21, 0, 21)
    close.ZIndex = 2
    close.Image = "rbxassetid://3926305904"
    close.ImageRectOffset = Vector2.new(284, 4)
    close.ImageRectSize = Vector2.new(24, 24)
    Track(close.MouseButton1Click:Connect(function()
        if Chr0nicxHack3r.OnUnload then
            pcall(Chr0nicxHack3r.OnUnload)
        end
        Utility:TweenObject(
            close,
            { ImageTransparency = 1 },
            0.1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.InOut
        )
        task.wait(0.1)
        Utility:TweenObject(
            Main,
            {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(
                    0,
                    Main.AbsolutePosition.X + (Main.AbsoluteSize.X / 2),
                    0,
                    Main.AbsolutePosition.Y + (Main.AbsoluteSize.Y / 2)
                )
            },
            0.1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        )
        task.wait(1)
        Chr0nicxHack3r:_Shutdown()
    end))

    MainSide.Name = "MainSide"
    MainSide.Parent = Main
    MainSide.BackgroundColor3 = themeList.Header
    MainSide.Position = UDim2.new(-7.4505806e-09, 0, 0.0911949649, 0)
    MainSide.Size = UDim2.new(0, 149, 0, 289)

    sideCorner.CornerRadius = UDim.new(0, 4)
    sideCorner.Name = "sideCorner"
    sideCorner.Parent = MainSide

    coverup_2.Name = "coverup"
    coverup_2.Parent = MainSide
    coverup_2.BackgroundColor3 = themeList.Header
    coverup_2.BorderSizePixel = 0
    coverup_2.Position = UDim2.new(0.949939311, 0, 0, 0)
    coverup_2.Size = UDim2.new(0, 7, 0, 289)

    tabFrames.Name = "tabFrames"
    tabFrames.Parent = MainSide
    tabFrames.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tabFrames.BackgroundTransparency = 1.000
    tabFrames.Position = UDim2.new(0.0438990258, 0, -0.00066378375, 0)
    tabFrames.Size = UDim2.new(0, 135, 0, 283)

    tabListing.Name = "tabListing"
    tabListing.Parent = tabFrames
    tabListing.SortOrder = Enum.SortOrder.LayoutOrder

    pages.Name = "pages"
    pages.Parent = Main
    pages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    pages.BackgroundTransparency = 1.000
    pages.BorderSizePixel = 0
    pages.Position = UDim2.new(0.299047589, 0, 0.122641519, 0)
    pages.Size = UDim2.new(0, 360, 0, 269)

    Pages.Name = "Pages"
    Pages.Parent = pages

    infoContainer.Name = "infoContainer"
    infoContainer.Parent = Main
    infoContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    infoContainer.BackgroundTransparency = 1.000
    infoContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
    infoContainer.ClipsDescendants = true
    infoContainer.Position = UDim2.new(0.299047619, 0, 0.874213815, 0)
    infoContainer.Size = UDim2.new(0, 368, 0, 33)

    local alive = true
    Chr0nicxHack3r:OnThemeChange(function()
        if not alive or not Main.Parent then
            alive = false
            return
        end
        Main.BackgroundColor3 = themeList.Background
        MainHeader.BackgroundColor3 = themeList.Header
        MainSide.BackgroundColor3 = themeList.Header
        coverup_2.BackgroundColor3 = themeList.Header
        coverup.BackgroundColor3 = themeList.Header
    end)

    function Chr0nicxHack3r:ChangeColor(prope, color)
        if prope == "Background" then
            themeList.Background = color
        elseif prope == "SchemeColor" then
            themeList.SchemeColor = color
        elseif prope == "Header" then
            themeList.Header = color
        elseif prope == "TextColor" then
            themeList.TextColor = color
        elseif prope == "ElementColor" then
            themeList.ElementColor = color
        end
        RebuildDerivedTheme(themeList)
        ApplyTheme()
    end

    local Tabs = {}

    local first = true

    function Tabs:NewTab(tabName)
        tabName = tabName or "Tab"
        local tabButton = Instance.new("TextButton")
        local UICorner = Instance.new("UICorner")
        local page = Instance.new("ScrollingFrame")
        local pageListing = Instance.new("UIListLayout")

        local function UpdateSize()
            local cS = pageListing.AbsoluteContentSize

            Utility:TweenObject(
                page,
                { CanvasSize = UDim2.new(0, cS.X, 0, cS.Y) },
                0.15,
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.In
            )
        end

        page.Name = "Page"
        page.Parent = Pages
        page.Active = true
        page.BackgroundColor3 = themeList.Background
        page.BorderSizePixel = 0
        page.Position = UDim2.new(0, 0, -0.00371747208, 0)
        page.Size = UDim2.new(1, 0, 1, 0)
        page.ScrollBarThickness = 5
        page.Visible = false
        --page.ScrollBarImageColor3 = DerivedTheme.Scrollbar ---CAN DELETE THIS AFTER TESTING IF IT WORKS. FIND "delete this"

        pageListing.Name = "pageListing"
        pageListing.Parent = page
        pageListing.SortOrder = Enum.SortOrder.LayoutOrder
        pageListing.Padding = UDim.new(0, 5)

        tabButton.Name = tabName .. "TabButton"
        tabButton.Parent = tabFrames
        tabButton.BackgroundColor3 = themeList.SchemeColor
        tabButton.Size = UDim2.new(0, 135, 0, 28)
        tabButton.AutoButtonColor = false
        tabButton.Font = Enum.Font.Gotham
        tabButton.Text = tabName
        tabButton.TextColor3 = themeList.TextColor
        tabButton.TextSize = 14.000
        tabButton.BackgroundTransparency = 1

        if first then
            first = false
            page.Visible = true
            tabButton.BackgroundTransparency = 0
            UpdateSize()
        else
            page.Visible = false
            tabButton.BackgroundTransparency = 1
        end

        UICorner.CornerRadius = UDim.new(0, 5)
        UICorner.Parent = tabButton
        table.insert(Tabs, tabName)

        UpdateSize()
        Track(page.ChildAdded:Connect(UpdateSize))
        Track(page.ChildRemoved:Connect(UpdateSize))

        Track(tabButton.MouseButton1Click:Connect(function()
            UpdateSize()
            for i, v in next, Pages:GetChildren() do
                v.Visible = false
            end
            page.Visible = true
            for i, v in next, tabFrames:GetChildren() do
                if v:IsA("TextButton") then
                    if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
                        Utility:TweenObject(v, { TextColor3 = Color3.fromRGB(255, 255, 255) }, 0.2)
                    end
                    if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
                        Utility:TweenObject(v, { TextColor3 = Color3.fromRGB(0, 0, 0) }, 0.2)
                    end
                    Utility:TweenObject(v, { BackgroundTransparency = 1 }, 0.2)
                end
            end
            if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
                Utility:TweenObject(tabButton, { TextColor3 = Color3.fromRGB(0, 0, 0) }, 0.2)
            end
            if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
                Utility:TweenObject(tabButton, { TextColor3 = Color3.fromRGB(255, 255, 255) }, 0.2)
            end
            Utility:TweenObject(tabButton, { BackgroundTransparency = 0 }, 0.2)
        end))
        local Sections = {}

        local alive = true
        Chr0nicxHack3r:OnThemeChange(function()
            if not alive or not page.Parent then
                alive = false
                return
            end
            page.BackgroundColor3 = themeList.Background
            page.ScrollBarImageColor3 = DerivedTheme.Scrollbar
            tabButton.TextColor3 = themeList.TextColor
            tabButton.BackgroundColor3 = themeList.SchemeColor
        end)

        function Sections:NewSection(secName, hidden)
            secName = secName or "Section"
            local sectionFunctions = {}
            local modules = {}
            local focusing = false
            local viewDe = false
            hidden = hidden or false
            local sectionFrame = Instance.new("Frame")
            local sectionlistoknvm = Instance.new("UIListLayout")
            local sectionHead = Instance.new("Frame")
            local sHeadCorner = Instance.new("UICorner")
            local sectionName = Instance.new("TextLabel")
            local sectionInners = Instance.new("Frame")
            local sectionElListing = Instance.new("UIListLayout")

            if hidden then
                sectionHead.Visible = false
            else
                sectionHead.Visible = true
            end

            sectionFrame.Name = "sectionFrame"
            sectionFrame.Parent = page
            sectionFrame.BackgroundColor3 = themeList.Background --36, 37, 43
            sectionFrame.BorderSizePixel = 0

            sectionlistoknvm.Name = "sectionlistoknvm"
            sectionlistoknvm.Parent = sectionFrame
            sectionlistoknvm.SortOrder = Enum.SortOrder.LayoutOrder
            sectionlistoknvm.Padding = UDim.new(0, 5)

            for _, v in ipairs(sectionInners:GetChildren()) do
                if v:IsA("Frame") or v:IsA("TextButton") then
                    Track(v:GetPropertyChangedSignal("Size"):Connect(function()
                        UpdateSize()
                        updateSectionFrame()
                    end))
                end
            end
            sectionHead.Name = "sectionHead"
            sectionHead.Parent = sectionFrame
            sectionHead.BackgroundColor3 = themeList.SchemeColor
            sectionHead.Size = UDim2.new(0, 352, 0, 33)

            sHeadCorner.CornerRadius = UDim.new(0, 4)
            sHeadCorner.Name = "sHeadCorner"
            sHeadCorner.Parent = sectionHead

            sectionName.Name = "sectionName"
            sectionName.Parent = sectionHead
            sectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sectionName.BackgroundTransparency = 1.000
            sectionName.BorderColor3 = Color3.fromRGB(27, 42, 53)
            sectionName.Position = UDim2.new(0.0198863633, 0, 0, 0)
            sectionName.Size = UDim2.new(0.980113626, 0, 1, 0)
            sectionName.Font = Enum.Font.Gotham
            sectionName.Text = secName
            sectionName.RichText = true
            sectionName.TextColor3 = themeList.TextColor
            sectionName.TextSize = 14.000
            sectionName.TextXAlignment = Enum.TextXAlignment.Left
            if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
                Utility:TweenObject(sectionName, { TextColor3 = Color3.fromRGB(0, 0, 0) }, 0.2)
            end
            if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
                Utility:TweenObject(sectionName, { TextColor3 = Color3.fromRGB(255, 255, 255) }, 0.2)
            end

            sectionInners.Name = "sectionInners"
            sectionInners.Parent = sectionFrame
            sectionInners.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sectionInners.BackgroundTransparency = 1.000
            sectionInners.Position = UDim2.new(0, 0, 0.190751448, 0)

            sectionElListing.Name = "sectionElListing"
            sectionElListing.Parent = sectionInners
            sectionElListing.SortOrder = Enum.SortOrder.LayoutOrder
            sectionElListing.Padding = UDim.new(0, 3)

            local alive = true
            Chr0nicxHack3r:OnThemeChange(function()
                if not alive or not sectionFrame.Parent then
                    alive = false
                    return
                end
                sectionFrame.BackgroundColor3 = themeList.Background
                sectionHead.BackgroundColor3 = themeList.SchemeColor
                sectionName.TextColor3 = themeList.TextColor
            end)

            local function updateSectionFrame()
                local innerSc = sectionElListing.AbsoluteContentSize
                sectionInners.Size = UDim2.new(1, 0, 0, innerSc.Y)
                local frameSc = sectionlistoknvm.AbsoluteContentSize
                sectionFrame.Size = UDim2.new(0, 352, 0, frameSc.Y)
            end
            updateSectionFrame()
            UpdateSize()
            local Elements = {}
            function Elements:NewButton(bname, tipINf, callback)
                local showLogo = true
                local ButtonFunction = {}
                tipINf = tipINf or "Tip: Clicking this nothing will happen!"
                bname = bname or "Click Me!"
                callback = callback or function() end

                local buttonElement = Instance.new("TextButton")
                local buttonCorner = Instance.new("UICorner")
                local btnInfo = Instance.new("TextLabel")
                local infoButton = Instance.new("ImageButton")
                local touch = Instance.new("ImageLabel")
                local buttonRippleTemplate = Instance.new("ImageLabel")

                local function ApplyButtonStyle()
                    buttonElement.BackgroundColor3 = themeList.ElementColor
                    btnInfo.TextColor3 = themeList.TextColor

                    local iconColor = themeList.SchemeColor

                    infoButton.ImageColor3 = iconColor
                    touch.ImageColor3 = iconColor
                    buttonRippleTemplate.ImageColor3 = iconColor
                end
                ApplyButtonStyle()

                local alive = true
                Chr0nicxHack3r:OnThemeChange(function()
                    if not alive or not buttonElement.Parent then
                        alive = false
                        return
                    end
                    ApplyButtonStyle()
                    if isHovered then
                        Utility:SetHover(buttonElement, DerivedTheme.ElementHover)
                    else
                        Utility:SetHover(buttonElement, themeList.ElementColor)
                    end
                end)

                table.insert(modules, bname)

                buttonElement.Name = bname
                buttonElement.Parent = sectionInners
                buttonElement.ClipsDescendants = true
                buttonElement.Size = UDim2.new(0, 352, 0, 33)
                buttonElement.AutoButtonColor = false
                buttonElement.Font = Enum.Font.SourceSans
                buttonElement.Text = ""
                buttonElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                buttonElement.TextSize = 14.000

                buttonCorner.CornerRadius = UDim.new(0, 4)
                buttonCorner.Parent = buttonElement

                infoButton.Name = "infoButton"
                infoButton.Parent = buttonElement
                infoButton.BackgroundTransparency = 1.000
                infoButton.LayoutOrder = 9
                infoButton.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
                infoButton.Size = UDim2.new(0, 23, 0, 23)
                infoButton.ZIndex = 2
                infoButton.Image = "rbxassetid://3926305904"
                infoButton.ImageRectOffset = Vector2.new(764, 764)
                infoButton.ImageRectSize = Vector2.new(36, 36)

                buttonRippleTemplate.Name = "buttonRippleTemplate"
                buttonRippleTemplate.Parent = buttonElement
                buttonRippleTemplate.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                buttonRippleTemplate.BackgroundTransparency = 1.000
                buttonRippleTemplate.Image = "http://www.roblox.com/asset/?id=4560909609"
                buttonRippleTemplate.ImageTransparency = 0.600

                local infoTooltip = Instance.new("TextLabel")
                local tipCorner = Instance.new("UICorner")

                infoTooltip.Name = "infoTooltip"
                infoTooltip.Parent = infoContainer
                infoTooltip.BackgroundColor3 = DerivedTheme.TooltipBackground
                infoTooltip.Position = UDim2.new(0, 0, 2, 0)
                infoTooltip.Size = UDim2.new(0, 353, 0, 33)
                infoTooltip.ZIndex = 9
                infoTooltip.Font = Enum.Font.GothamSemibold
                infoTooltip.Text = "  " .. tipINf
                infoTooltip.RichText = true
                infoTooltip.TextColor3 = themeList.TextColor
                infoTooltip.TextSize = 14.000
                infoTooltip.TextXAlignment = Enum.TextXAlignment.Left

                tipCorner.CornerRadius = UDim.new(0, 4)
                tipCorner.Parent = infoTooltip

                touch.Name = "touch"
                touch.Parent = buttonElement
                touch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                touch.BackgroundTransparency = 1.000
                touch.BorderColor3 = Color3.fromRGB(27, 42, 53)
                touch.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                touch.Size = UDim2.new(0, 21, 0, 21)
                touch.Image = "rbxassetid://3926305904"
                touch.ImageColor3 = themeList.SchemeColor
                touch.ImageRectOffset = Vector2.new(84, 204)
                touch.ImageRectSize = Vector2.new(36, 36)
                touch.ImageTransparency = 0

                btnInfo.Name = "btnInfo"
                btnInfo.Parent = buttonElement
                btnInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                btnInfo.BackgroundTransparency = 1.000
                btnInfo.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
                btnInfo.Size = UDim2.new(0, 314, 0, 14)
                btnInfo.Font = Enum.Font.GothamSemibold
                btnInfo.Text = bname
                btnInfo.RichText = true
                btnInfo.TextSize = 14.000
                btnInfo.TextXAlignment = Enum.TextXAlignment.Left

                if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
                    Utility:TweenObject(infoTooltip, { TextColor3 = Color3.fromRGB(0, 0, 0) }, 0.2)
                end
                if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
                    Utility:TweenObject(infoTooltip, { TextColor3 = Color3.fromRGB(255, 255, 255) }, 0.2)
                end

                updateSectionFrame()
                UpdateSize()

                local buttonMouse = game.Players.LocalPlayer:GetMouse()
                local isHovered = false

                local button = buttonElement
                local ripplesample = buttonRippleTemplate

                --[[Track(button.MouseLeave:Connect(function()
                    ApplyButtonStyle()
                end))]]

                Track(button.MouseButton1Click:Connect(function()
                    if not focusing then
                        callback()
                        local c = ripplesample:Clone()
                        c.Parent = button
                        local x, y = (buttonMouse.X - c.AbsolutePosition.X), (buttonMouse.Y - c.AbsolutePosition.Y)
                        c.Position = UDim2.new(0, x, 0, y)
                        local len, size = 0.35, nil
                        if button.AbsoluteSize.X >= button.AbsoluteSize.Y then
                            size = (button.AbsoluteSize.X * 1.5)
                        else
                            size = (button.AbsoluteSize.Y * 1.5)
                        end
                        c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)),
                            'Out', 'Quad', len, true, nil)
                        Utility:FadeAndDestroy(c, len)
                    else
                        for i, v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, { BackgroundTransparency = 1 }, 0.2)
                    end
                end))
                Utility:BindHover({
                    button = button,
                    isHoveredRef = function(v)
                        if v ~= nil then isHovered = v end
                        return isHovered
                    end,
                    focusingRef = function()
                        return focusing
                    end,
                    onHover = function()
                        Utility:SetHover(button, DerivedTheme.ElementHover)
                    end,
                    onLeave = function()
                        Utility:SetHover(button, themeList.ElementColor)
                    end
                })

                Track(infoButton.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for i, v in next, infoContainer:GetChildren() do
                            if v ~= infoTooltip then
                                Utility:TweenObject(v, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                            end
                        end
                        Utility:TweenObject(infoTooltip, { Position = UDim2.new(0, 0, 0, 0) }, 0.2)
                        Utility:TweenObject(blurFrame, { BackgroundTransparency = 0.5 }, 0.2)
                        Utility:TweenObject(button, { BackgroundColor3 = themeList.ElementColor }, 0.2)
                        task.wait(1.5)
                        focusing = false
                        Utility:TweenObject(infoTooltip, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                        Utility:TweenObject(blurFrame, { BackgroundTransparency = 1 }, 0.2)
                        task.wait()
                        viewDe = false
                    end
                end))

                function ButtonFunction:UpdateButton(newTitle)
                    btnInfo.Text = newTitle
                end

                return ButtonFunction
            end

            function Elements:NewTextBox(tname, tTip, callback)
                tname = tname or "Textbox"
                tTip = tTip or "Gets a value of Textbox"
                callback = callback or function() end
                local textboxElement = Instance.new("TextButton")
                local textboxCorner = Instance.new("UICorner")
                local viewInfo = Instance.new("ImageButton")
                local write = Instance.new("ImageLabel")
                local TextBox = Instance.new("TextBox")
                local inputCorner = Instance.new("UICorner")
                local togName = Instance.new("TextLabel")

                local alive = true
                Chr0nicxHack3r:OnThemeChange(function()
                    if not alive or not textboxElement.Parent then
                        alive = false
                        return
                    end
                    textboxElement.BackgroundColor3 = themeList.ElementColor
                    viewInfo.ImageColor3 = themeList.SchemeColor
                    write.ImageColor3 = themeList.SchemeColor
                    togName.TextColor3 = themeList.TextColor
                    TextBox.BackgroundColor3 = Offset(themeList.ElementColor, -6, -6, -7)
                    TextBox.PlaceholderColor3 = DerivedTheme.PlaceholderText
                    TextBox.TextColor3 = themeList.SchemeColor
                end)

                textboxElement.Name = "textboxElement"
                textboxElement.Parent = sectionInners
                textboxElement.BackgroundColor3 = themeList.ElementColor
                textboxElement.ClipsDescendants = true
                textboxElement.Size = UDim2.new(0, 352, 0, 33)
                textboxElement.AutoButtonColor = false
                textboxElement.Font = Enum.Font.SourceSans
                textboxElement.Text = ""
                textboxElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                textboxElement.TextSize = 14.000

                textboxCorner.CornerRadius = UDim.new(0, 4)
                textboxCorner.Parent = textboxElement

                viewInfo.Name = "viewInfo"
                viewInfo.Parent = textboxElement
                viewInfo.BackgroundTransparency = 1.000
                viewInfo.LayoutOrder = 9
                viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
                viewInfo.Size = UDim2.new(0, 23, 0, 23)
                viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"
                viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764, 764)
                viewInfo.ImageRectSize = Vector2.new(36, 36)

                write.Name = "write"
                write.Parent = textboxElement
                write.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                write.BackgroundTransparency = 1.000
                write.BorderColor3 = Color3.fromRGB(27, 42, 53)
                write.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                write.Size = UDim2.new(0, 21, 0, 21)
                write.Image = "rbxassetid://3926305904"
                write.ImageColor3 = themeList.SchemeColor
                write.ImageRectOffset = Vector2.new(324, 604)
                write.ImageRectSize = Vector2.new(36, 36)

                TextBox.Parent = textboxElement
                TextBox.BackgroundColor3 = Offset(themeList.ElementColor, -6, -6, -7)
                TextBox.BorderSizePixel = 0
                TextBox.ClipsDescendants = true
                TextBox.Position = UDim2.new(0.488749921, 0, 0.212121218, 0)
                TextBox.Size = UDim2.new(0, 150, 0, 18)
                TextBox.ZIndex = 99
                TextBox.ClearTextOnFocus = false
                TextBox.Font = Enum.Font.Gotham
                TextBox.PlaceholderColor3 = DerivedTheme.PlaceholderText
                TextBox.PlaceholderText = "Type here!"
                TextBox.Text = ""
                TextBox.TextColor3 = themeList.SchemeColor
                TextBox.TextSize = 12.000

                inputCorner.CornerRadius = UDim.new(0, 4)
                inputCorner.Parent = TextBox

                togName.Name = "togName"
                togName.Parent = textboxElement
                togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                togName.BackgroundTransparency = 1.000
                togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
                togName.Size = UDim2.new(0, 138, 0, 14)
                togName.Font = Enum.Font.GothamSemibold
                togName.Text = tname
                togName.RichText = true
                togName.TextColor3 = themeList.TextColor
                togName.TextSize = 14.000
                togName.TextXAlignment = Enum.TextXAlignment.Left

                local infoTooltip = Instance.new("TextLabel")
                local tipCorner = Instance.new("UICorner")

                infoTooltip.Name = "infoTooltip"
                infoTooltip.Parent = infoContainer
                infoTooltip.BackgroundColor3 = DerivedTheme.TooltipBackground
                infoTooltip.Position = UDim2.new(0, 0, 2, 0)
                infoTooltip.Size = UDim2.new(0, 353, 0, 33)
                infoTooltip.ZIndex = 9
                infoTooltip.Font = Enum.Font.GothamSemibold
                infoTooltip.RichText = true
                infoTooltip.Text = "  " .. tTip
                infoTooltip.TextColor3 = Color3.fromRGB(255, 255, 255)
                infoTooltip.TextSize = 14.000
                infoTooltip.TextXAlignment = Enum.TextXAlignment.Left

                if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
                    Utility:TweenObject(infoTooltip, { TextColor3 = Color3.fromRGB(0, 0, 0) }, 0.2)
                end
                if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
                    Utility:TweenObject(infoTooltip, { TextColor3 = Color3.fromRGB(255, 255, 255) }, 0.2)
                end

                tipCorner.CornerRadius = UDim.new(0, 4)
                tipCorner.Parent = infoTooltip


                updateSectionFrame()
                UpdateSize()

                local textboxButton = textboxElement
                local infoButton    = viewInfo
                local isHovered     = false

                Track(textboxButton.MouseButton1Click:Connect(function()
                    if focusing then
                        for i, v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, { BackgroundTransparency = 1 }, 0.2)
                    end
                end))
                Utility:BindHover({
                    button = textboxButton,
                    isHoveredRef = function(v)
                        if v ~= nil then isHovered = v end
                        return isHovered
                    end,
                    onHover = function()
                        Utility:SetHover(textboxButton, DerivedTheme.ElementHover)
                    end,
                    onLeave = function()
                        Utility:SetHover(textboxButton, themeList.ElementColor)
                    end
                })


                Track(TextBox.FocusLost:Connect(function(EnterPressed)
                    if focusing then
                        for i, v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, { BackgroundTransparency = 1 }, 0.2)
                    end
                    if not EnterPressed then
                        return
                    else
                        callback(TextBox.Text)
                        task.wait(0.18)
                        TextBox.Text = ""
                    end
                end))

                Track(viewInfo.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for i, v in next, infoContainer:GetChildren() do
                            if v ~= infoTooltip then
                                Utility:TweenObject(v, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                            end
                        end
                        Utility:TweenObject(infoTooltip, { Position = UDim2.new(0, 0, 0, 0) }, 0.2)
                        Utility:TweenObject(blurFrame, { BackgroundTransparency = 0.5 }, 0.2)
                        Utility:TweenObject(textboxButton, { BackgroundColor3 = themeList.ElementColor }, 0.2)
                        task.wait(1.5)
                        focusing = false
                        Utility:TweenObject(infoTooltip, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                        Utility:TweenObject(blurFrame, { BackgroundTransparency = 1 }, 0.2)
                        task.wait()
                        viewDe = false
                    end
                end))
            end

            function Elements:NewToggle(tname, nTip, callback)
                local toggled = SettingsT[tname] == true
                local TogFunction = {}
                tname = tname or "Toggle"
                nTip = nTip or "Prints Current Toggle State"
                callback = callback or function() end

                local toggleElement = Instance.new("TextButton")
                local toggleCorner = Instance.new("UICorner")
                local toggleDisabled = Instance.new("ImageLabel")
                local toggleEnabled = Instance.new("ImageLabel")
                local togName = Instance.new("TextLabel")
                local infoButton = Instance.new("ImageButton")
                local toggleRippleTemplate = Instance.new("ImageLabel")

                local alive = true
                Chr0nicxHack3r:OnThemeChange(function()
                    if not alive or not toggleElement.Parent then
                        alive = false
                        return
                    end
                    toggleElement.BackgroundColor3 = themeList.ElementColor
                    toggleDisabled.ImageColor3 = themeList.SchemeColor
                    toggleEnabled.ImageColor3 = themeList.SchemeColor
                    togName.TextColor3 = themeList.TextColor
                    infoButton.ImageColor3 = themeList.SchemeColor
                    toggleRippleTemplate.ImageColor3 = themeList.SchemeColor
                end)

                toggleElement.Name = "toggleElement"
                toggleElement.Parent = sectionInners
                toggleElement.BackgroundColor3 = themeList.ElementColor
                toggleElement.ClipsDescendants = true
                toggleElement.Size = UDim2.new(0, 352, 0, 33)
                toggleElement.AutoButtonColor = false
                toggleElement.Font = Enum.Font.SourceSans
                toggleElement.Text = ""
                toggleElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                toggleElement.TextSize = 14.000

                toggleCorner.CornerRadius = UDim.new(0, 4)
                toggleCorner.Parent = toggleElement

                toggleDisabled.Name = "toggleDisabled"
                toggleDisabled.Parent = toggleElement
                toggleDisabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggleDisabled.BackgroundTransparency = 1.000
                toggleDisabled.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                toggleDisabled.Size = UDim2.new(0, 21, 0, 21)
                toggleDisabled.Image = "rbxassetid://3926309567"
                toggleDisabled.ImageColor3 = themeList.SchemeColor
                toggleDisabled.ImageRectOffset = Vector2.new(628, 420)
                toggleDisabled.ImageRectSize = Vector2.new(48, 48)

                toggleEnabled.Name = "toggleEnabled"
                toggleEnabled.Parent = toggleElement
                toggleEnabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggleEnabled.BackgroundTransparency = 1.000
                toggleEnabled.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                toggleEnabled.Size = UDim2.new(0, 21, 0, 21)
                toggleEnabled.Image = "rbxassetid://3926309567"
                toggleEnabled.ImageColor3 = themeList.SchemeColor
                toggleEnabled.ImageRectOffset = Vector2.new(784, 420)
                toggleEnabled.ImageRectSize = Vector2.new(48, 48)
                --toggleEnabled.ImageTransparency = 1.000
                toggleEnabled.ImageTransparency = toggled and 0 or 1
                function TogFunction:ApplySavedState()
                    pcall(callback, toggled)
                end

                togName.Name = "togName"
                togName.Parent = toggleElement
                togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                togName.BackgroundTransparency = 1.000
                togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
                togName.Size = UDim2.new(0, 288, 0, 14)
                togName.Font = Enum.Font.GothamSemibold
                togName.Text = tname
                togName.RichText = true
                togName.TextColor3 = themeList.TextColor
                togName.TextSize = 14.000
                togName.TextXAlignment = Enum.TextXAlignment.Left

                infoButton.Name = "infoButton"
                infoButton.Parent = toggleElement
                infoButton.BackgroundTransparency = 1.000
                infoButton.LayoutOrder = 9
                infoButton.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
                infoButton.Size = UDim2.new(0, 23, 0, 23)
                infoButton.ZIndex = 2
                infoButton.Image = "rbxassetid://3926305904"
                infoButton.ImageColor3 = themeList.SchemeColor
                infoButton.ImageRectOffset = Vector2.new(764, 764)
                infoButton.ImageRectSize = Vector2.new(36, 36)

                toggleRippleTemplate.Name = "ToggleRippleTemplate"
                toggleRippleTemplate.Parent = toggleElement
                toggleRippleTemplate.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggleRippleTemplate.BackgroundTransparency = 1.000
                toggleRippleTemplate.Image = "http://www.roblox.com/asset/?id=4560909609"
                toggleRippleTemplate.ImageColor3 = themeList.SchemeColor
                toggleRippleTemplate.ImageTransparency = 0.600

                local infoTooltip = Instance.new("TextLabel")
                local tipCorner = Instance.new("UICorner")

                infoTooltip.Name = "infoTooltip"
                infoTooltip.Parent = infoContainer
                infoTooltip.BackgroundColor3 = DerivedTheme.TooltipBackground
                infoTooltip.Position = UDim2.new(0, 0, 2, 0)
                infoTooltip.Size = UDim2.new(0, 353, 0, 33)
                infoTooltip.ZIndex = 9
                infoTooltip.Font = Enum.Font.GothamSemibold
                infoTooltip.RichText = true
                infoTooltip.Text = "  " .. nTip
                infoTooltip.TextColor3 = themeList.TextColor
                infoTooltip.TextSize = 14.000
                infoTooltip.TextXAlignment = Enum.TextXAlignment.Left

                tipCorner.CornerRadius = UDim.new(0, 4)
                tipCorner.Parent = infoTooltip

                local toggleMouse = game.Players.LocalPlayer:GetMouse()

                if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
                    Utility:TweenObject(infoTooltip, { TextColor3 = Color3.fromRGB(0, 0, 0) }, 0.2)
                end
                if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
                    Utility:TweenObject(infoTooltip, { TextColor3 = Color3.fromRGB(255, 255, 255) }, 0.2)
                end

                local toggleButton = toggleElement
                local rippleSample = toggleRippleTemplate
                local toggleEnabledIcon = toggleEnabled
                local isHovered = false

                updateSectionFrame()
                UpdateSize()

                Track(toggleButton.MouseButton1Click:Connect(function()
                    if not focusing then
                        if toggled == false then
                            Utility:TweenObject(
                                toggleEnabledIcon,
                                { ImageTransparency = 0 },
                                0.11,
                                Enum.EasingStyle.Linear,
                                Enum.EasingDirection.In
                            )
                            local c = rippleSample:Clone()
                            c.Parent = toggleButton
                            local x, y = (toggleMouse.X - c.AbsolutePosition.X), (toggleMouse.Y - c.AbsolutePosition.Y)
                            c.Position = UDim2.new(0, x, 0, y)
                            local len, size = 0.35, nil
                            if toggleButton.AbsoluteSize.X >= toggleButton.AbsoluteSize.Y then
                                size = (toggleButton.AbsoluteSize.X * 1.5)
                            else
                                size = (toggleButton.AbsoluteSize.Y * 1.5)
                            end
                            c:TweenSizeAndPosition(UDim2.new(0, size, 0, size),
                                UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                            Utility:FadeAndDestroy(c, len)
                        else
                            Utility:TweenObject(toggleEnabledIcon, { ImageTransparency = 1 },
                                0.11, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
                            local c = rippleSample:Clone()
                            c.Parent = toggleButton
                            local x, y = (toggleMouse.X - c.AbsolutePosition.X), (toggleMouse.Y - c.AbsolutePosition.Y)
                            c.Position = UDim2.new(0, x, 0, y)
                            local len, size = 0.35, nil
                            if toggleButton.AbsoluteSize.X >= toggleButton.AbsoluteSize.Y then
                                size = (toggleButton.AbsoluteSize.X * 1.5)
                            else
                                size = (toggleButton.AbsoluteSize.Y * 1.5)
                            end
                            c:TweenSizeAndPosition(UDim2.new(0, size, 0, size),
                                UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                            Utility:FadeAndDestroy(c, len)
                        end
                        toggled = not toggled
                        SettingsT[tname] = toggled
                        --[[if Chr0nicxHack3r.OnConfigChanged then
                            Chr0nicxHack3r.OnConfigChanged(tname, toggled, SettingsT)
                        end
                        SaveConfigDebounced()]] -- Auto saves on every toggle button click.
                        pcall(callback, toggled)
                    else
                        for i, v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, { BackgroundTransparency = 1 }, 0.2)
                    end
                end))
                Utility:BindHover({
                    button = toggleButton,
                    isHoveredRef = function(v)
                        if v ~= nil then isHovered = v end
                        return isHovered
                    end,
                    focusingRef = function()
                        return focusing
                    end,
                    onHover = function()
                        Utility:SetHover(toggleButton, DerivedTheme.ElementHover)
                    end,
                    onLeave = function()
                        Utility:SetHover(toggleButton, themeList.ElementColor)
                    end
                })


                Track(infoButton.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for i, v in next, infoContainer:GetChildren() do
                            if v ~= infoTooltip then
                                Utility:TweenObject(v, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                            end
                        end
                        Utility:TweenObject(infoTooltip, { Position = UDim2.new(0, 0, 0, 0) }, 0.2)
                        Utility:TweenObject(blurFrame, { BackgroundTransparency = 0.5 }, 0.2)
                        Utility:TweenObject(toggleButton, { BackgroundColor3 = themeList.ElementColor }, 0.2)
                        task.wait(1.5)
                        focusing = false
                        Utility:TweenObject(infoTooltip, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                        Utility:TweenObject(blurFrame, { BackgroundTransparency = 1 }, 0.2)
                        task.wait()
                        viewDe = false
                    end
                end))
                function TogFunction:UpdateToggle(newText, isTogOn)
                    if isTogOn == nil then
                        isTogOn = toggled
                    end
                    if newText ~= nil then
                        togName.Text = newText
                    end
                    if isTogOn then
                        toggled = true
                        Utility:TweenObject(toggleEnabledIcon, { ImageTransparency = 0 }, 0.11, Enum.EasingStyle.Linear,
                            Enum.EasingDirection.In)
                        pcall(callback, toggled)
                    else
                        toggled = false
                        Utility:TweenObject(toggleEnabledIcon, { ImageTransparency = 1 }, 0.11, Enum.EasingStyle.Linear,
                            Enum.EasingDirection.In)
                        pcall(callback, toggled)
                    end
                end

                return TogFunction
            end

            function Elements:NewSlider(slidInf, slidTip, maxvalue, minvalue, startVal, callback)
                slidInf = slidInf or "Slider"
                slidTip = slidTip or "Slider tip here"
                maxvalue = maxvalue or 500
                minvalue = minvalue or 16
                startVal = tonumber(startVal) or 0
                callback = callback or function() end

                local sliderElement = Instance.new("TextButton")
                local sliderCorner = Instance.new("UICorner")
                local togName = Instance.new("TextLabel")
                local viewInfo = Instance.new("ImageButton")
                local sliderTrack = Instance.new("TextButton")
                local trackCorner = Instance.new("UICorner")
                local UIListLayout = Instance.new("UIListLayout")
                local sliderFill = Instance.new("Frame")
                local fillCorner = Instance.new("UICorner")
                local write = Instance.new("ImageLabel")
                local val = Instance.new("TextLabel")

                local alive = true
                Chr0nicxHack3r:OnThemeChange(function()
                    if not alive or not sliderElement.Parent then
                        alive = false
                        return
                    end
                    sliderElement.BackgroundColor3 = themeList.ElementColor
                    sliderFill.BackgroundColor3 = themeList.SchemeColor
                    viewInfo.ImageColor3 = themeList.SchemeColor
                    write.ImageColor3 = themeList.SchemeColor
                    togName.TextColor3 = themeList.TextColor
                    val.TextColor3 = themeList.TextColor
                end)

                sliderElement.Name = "sliderElement"
                sliderElement.Parent = sectionInners
                sliderElement.BackgroundColor3 = themeList.ElementColor
                sliderElement.ClipsDescendants = true
                sliderElement.Size = UDim2.new(0, 352, 0, 33)
                sliderElement.AutoButtonColor = false
                sliderElement.Font = Enum.Font.SourceSans
                sliderElement.Text = ""
                sliderElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                sliderElement.TextSize = 14.000

                sliderCorner.CornerRadius = UDim.new(0, 4)
                sliderCorner.Parent = sliderElement

                togName.Name = "togName"
                togName.Parent = sliderElement
                togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                togName.BackgroundTransparency = 1.000
                togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
                togName.Size = UDim2.new(0, 138, 0, 14)
                togName.Font = Enum.Font.GothamSemibold
                togName.Text = slidInf
                togName.RichText = true
                togName.TextColor3 = themeList.TextColor
                togName.TextSize = 14.000
                togName.TextXAlignment = Enum.TextXAlignment.Left

                viewInfo.Name = "viewInfo"
                viewInfo.Parent = sliderElement
                viewInfo.BackgroundTransparency = 1.000
                viewInfo.LayoutOrder = 9
                viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
                viewInfo.Size = UDim2.new(0, 23, 0, 23)
                viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"
                viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764, 764)
                viewInfo.ImageRectSize = Vector2.new(36, 36)

                sliderTrack.Name = "sliderTrack"
                sliderTrack.Parent = sliderElement
                sliderTrack.BackgroundColor3 = DerivedTheme.SliderTrack
                sliderTrack.BorderSizePixel = 0
                sliderTrack.Position = UDim2.new(0.488749951, 0, 0.393939406, 0)
                sliderTrack.Size = UDim2.new(0, 149, 0, 6)
                sliderTrack.AutoButtonColor = false
                sliderTrack.Font = Enum.Font.SourceSans
                sliderTrack.Text = ""
                sliderTrack.TextColor3 = Color3.fromRGB(0, 0, 0)
                sliderTrack.TextSize = 14.000

                trackCorner.Parent = sliderTrack

                UIListLayout.Parent = sliderTrack
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

                sliderFill.Name = "sliderFill"
                sliderFill.Parent = sliderTrack
                sliderFill.BackgroundColor3 = themeList.SchemeColor
                sliderFill.BorderColor3 = Color3.fromRGB(74, 99, 135)
                sliderFill.BorderSizePixel = 0

                local percent = math.clamp((startVal - minvalue) / (maxvalue - minvalue), 0, 1)
                local trackW = sliderTrack.AbsoluteSize.X
                sliderFill.Size = UDim2.new(0, math.floor(trackW * percent), 1, 0)
                val.Text = tostring(startVal)
                pcall(callback, startVal)

                fillCorner.Parent = sliderFill

                write.Name = "write"
                write.Parent = sliderElement
                write.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                write.BackgroundTransparency = 1.000
                write.BorderColor3 = Color3.fromRGB(27, 42, 53)
                write.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                write.Size = UDim2.new(0, 21, 0, 21)
                write.Image = "rbxassetid://3926307971"
                write.ImageColor3 = themeList.SchemeColor
                write.ImageRectOffset = Vector2.new(404, 164)
                write.ImageRectSize = Vector2.new(36, 36)

                val.Name = "val"
                val.Parent = sliderElement
                val.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                val.BackgroundTransparency = 1.000
                val.Position = UDim2.new(0.352386296, 0, 0.272727281, 0)
                val.Size = UDim2.new(0, 41, 0, 14)
                val.Font = Enum.Font.GothamSemibold
                val.Text = minvalue
                val.TextColor3 = themeList.TextColor
                val.TextSize = 14.000
                val.TextTransparency = 1.000
                val.TextXAlignment = Enum.TextXAlignment.Right

                local infoTooltip = Instance.new("TextLabel")
                local tipCorner = Instance.new("UICorner")
                local isHovered = false

                infoTooltip.Name = "infoTooltip"
                infoTooltip.Parent = infoContainer
                infoTooltip.BackgroundColor3 = DerivedTheme.TooltipBackground
                infoTooltip.Position = UDim2.new(0, 0, 2, 0)
                infoTooltip.Size = UDim2.new(0, 353, 0, 33)
                infoTooltip.ZIndex = 9
                infoTooltip.Font = Enum.Font.GothamSemibold
                infoTooltip.Text = "  " .. slidTip
                infoTooltip.TextColor3 = themeList.TextColor
                infoTooltip.TextSize = 14.000
                infoTooltip.RichText = true
                infoTooltip.TextXAlignment = Enum.TextXAlignment.Left

                tipCorner.CornerRadius = UDim.new(0, 4)
                tipCorner.Parent = infoTooltip

                if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
                    Utility:TweenObject(infoTooltip, { TextColor3 = Color3.fromRGB(0, 0, 0) }, 0.2)
                end
                if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
                    Utility:TweenObject(infoTooltip, { TextColor3 = Color3.fromRGB(255, 255, 255) }, 0.2)
                end


                updateSectionFrame()
                UpdateSize()
                local sliderMouse = game:GetService("Players").LocalPlayer:GetMouse();
                local sliderInput = game:GetService("UserInputService")
                local sliderRoot  = sliderElement
                local infoButton  = viewInfo
                Utility:BindHover({
                    button = sliderRoot,
                    isHoveredRef = function(v)
                        if v ~= nil then isHovered = v end
                        return isHovered
                    end,
                    focusingRef = function()
                        return focusing
                    end,
                    onHover = function()
                        Utility:SetHover(sliderRoot, DerivedTheme.ElementHover)
                    end,
                    onLeave = function()
                        Utility:SetHover(sliderRoot, themeList.ElementColor)
                    end
                })

                local function setSliderFromMouse(x)
                    local trackX = sliderTrack.AbsolutePosition.X
                    local trackW = sliderTrack.AbsoluteSize.X
                    local relative = math.clamp(x - trackX, 0, trackW)
                    local percent  = relative / trackW
                    sliderFill.Size = UDim2.new( 0, math.floor(trackW * percent), 1, 0)
                    local value = math.round(minvalue + (maxvalue - minvalue) * percent)
                    val.Text = tostring(value)
                    callback(value)
                end

                Track(sliderRoot.MouseButton1Down:Connect(function()
                    local dragging = true
                    local sliderMoveConn
                    local sliderReleaseConn
                    if focusing then return end

                    dragging = true

                    Utility:TweenObject(
                        val,
                        { TextTransparency = 0 },
                        0.1,
                        Enum.EasingStyle.Linear,
                        Enum.EasingDirection.In
                    )
                    setSliderFromMouse(sliderMouse.X)

                    Track(sliderMouse.Move:Connect(function()
                        if not dragging then return end
                        setSliderFromMouse(sliderMouse.X)
                    end))

                    Track(sliderInput.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end))
                end))
                Track(viewInfo.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for i, v in next, infoContainer:GetChildren() do
                            if v ~= infoTooltip then
                                Utility:TweenObject(v, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                            end
                        end
                        Utility:TweenObject(infoTooltip, { Position = UDim2.new(0, 0, 0, 0) }, 0.2)
                        Utility:TweenObject(blurFrame, { BackgroundTransparency = 0.5 }, 0.2)
                        Utility:TweenObject(sliderRoot, { BackgroundColor3 = themeList.ElementColor }, 0.2)
                        task.wait(1.5)
                        focusing = false
                        Utility:TweenObject(infoTooltip, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                        Utility:TweenObject(blurFrame, { BackgroundTransparency = 1 }, 0.2)
                        task.wait()
                        viewDe = false
                    end
                end))
            end

            function Elements:NewDropdown(dropname, dropinf, list, callback)
                local DropFunction = {}
                dropname = dropname or "Dropdown"
                list = list or {}
                dropinf = dropinf or "Dropdown info"
                callback = callback or function() end

                local opened = false
                local DropYSize = 33

                local dropFrame = Instance.new("Frame")
                local dropOpen = Instance.new("TextButton")
                local listImg = Instance.new("ImageLabel")
                local itemTextbox = Instance.new("TextLabel")
                local infoButton = Instance.new("ImageButton")
                local dropdownCorner = Instance.new("UICorner")
                local UIListLayout = Instance.new("UIListLayout")
                local dropdownRipple = Instance.new("ImageLabel")

                local alive = true
                Chr0nicxHack3r:OnThemeChange(function()
                    if not alive or not dropFrame.Parent then
                        alive = false
                        return
                    end
                    dropFrame.BackgroundColor3 = themeList.Background
                    dropOpen.BackgroundColor3 = themeList.ElementColor
                    listImg.ImageColor3 = themeList.SchemeColor
                    itemTextbox.TextColor3 = themeList.TextColor
                    infoButton.ImageColor3 = themeList.SchemeColor
                    Utility:SetHover(dropOpen, themeList.ElementColor)
                end)

                local dropdownMouse = game.Players.LocalPlayer:GetMouse()
                dropdownRipple.Name = "dropdownRipple"
                dropdownRipple.Parent = dropOpen
                dropdownRipple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                dropdownRipple.BackgroundTransparency = 1.000
                dropdownRipple.Image = "http://www.roblox.com/asset/?id=4560909609"
                dropdownRipple.ImageColor3 = themeList.SchemeColor
                dropdownRipple.ImageTransparency = 0.600

                dropFrame.Name = "dropFrame"
                dropFrame.Parent = sectionInners
                dropFrame.BackgroundColor3 = themeList.Background
                dropFrame.BorderSizePixel = 0
                dropFrame.Position = UDim2.new(0, 0, 1.23571432, 0)
                dropFrame.Size = UDim2.new(0, 352, 0, 33)
                dropFrame.ClipsDescendants = true
                local rippleSample = dropdownRipple
                local dropdownButton = dropOpen
                dropOpen.Name = "dropOpen"
                dropOpen.Parent = dropFrame
                dropOpen.BackgroundColor3 = themeList.ElementColor
                dropOpen.Size = UDim2.new(0, 352, 0, 33)
                dropOpen.AutoButtonColor = false
                dropOpen.Font = Enum.Font.SourceSans
                dropOpen.Text = ""
                dropOpen.TextColor3 = Color3.fromRGB(0, 0, 0)
                dropOpen.TextSize = 14.000
                dropOpen.ClipsDescendants = true
                Track(dropOpen.MouseButton1Click:Connect(function()
                    if not focusing then
                        if opened then
                            opened = false
                            dropFrame:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
                            task.wait(0.1)
                            updateSectionFrame()
                            UpdateSize()
                            local c = rippleSample:Clone()
                            c.Parent = dropdownButton
                            local x, y = (dropdownMouse.X - c.AbsolutePosition.X),
                                (dropdownMouse.Y - c.AbsolutePosition.Y)
                            c.Position = UDim2.new(0, x, 0, y)
                            local len, size = 0.35, nil
                            if dropdownButton.AbsoluteSize.X >= dropdownButton.AbsoluteSize.Y then
                                size = (dropdownButton.AbsoluteSize.X * 1.5)
                            else
                                size = (dropdownButton.AbsoluteSize.Y * 1.5)
                            end
                            c:TweenSizeAndPosition(UDim2.new(0, size, 0, size),
                                UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                            Utility:FadeAndDestroy(c, len)
                        else
                            opened = true
                            dropFrame:TweenSize(UDim2.new(0, 352, 0, UIListLayout.AbsoluteContentSize.Y), "InOut",
                                "Linear", 0.08, true)
                            task.wait(0.1)
                            updateSectionFrame()
                            UpdateSize()
                            local c = rippleSample:Clone()
                            c.Parent = dropdownButton
                            local x, y = (dropdownMouse.X - c.AbsolutePosition.X),
                                (dropdownMouse.Y - c.AbsolutePosition.Y)
                            c.Position = UDim2.new(0, x, 0, y)
                            local len, size = 0.35, nil
                            if dropdownButton.AbsoluteSize.X >= dropdownButton.AbsoluteSize.Y then
                                size = (dropdownButton.AbsoluteSize.X * 1.5)
                            else
                                size = (dropdownButton.AbsoluteSize.Y * 1.5)
                            end
                            c:TweenSizeAndPosition(UDim2.new(0, size, 0, size),
                                UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                            Utility:FadeAndDestroy(c, len)
                        end
                    else
                        for i, v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, { BackgroundTransparency = 1 }, 0.2)
                    end
                end))

                listImg.Name = "listImg"
                listImg.Parent = dropOpen
                listImg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                listImg.BackgroundTransparency = 1.000
                listImg.BorderColor3 = Color3.fromRGB(27, 42, 53)
                listImg.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                listImg.Size = UDim2.new(0, 21, 0, 21)
                listImg.Image = "rbxassetid://3926305904"
                listImg.ImageColor3 = themeList.SchemeColor
                listImg.ImageRectOffset = Vector2.new(644, 364)
                listImg.ImageRectSize = Vector2.new(36, 36)

                itemTextbox.Name = "itemTextbox"
                itemTextbox.Parent = dropOpen
                itemTextbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                itemTextbox.BackgroundTransparency = 1.000
                itemTextbox.Position = UDim2.new(0.0970000029, 0, 0.273000002, 0)
                itemTextbox.Size = UDim2.new(0, 138, 0, 14)
                itemTextbox.Font = Enum.Font.GothamSemibold
                itemTextbox.Text = dropname
                itemTextbox.RichText = true
                itemTextbox.TextColor3 = themeList.TextColor
                itemTextbox.TextSize = 14.000
                itemTextbox.TextXAlignment = Enum.TextXAlignment.Left

                infoButton.Name = "infoButton"
                infoButton.Parent = dropOpen
                infoButton.BackgroundTransparency = 1.000
                infoButton.LayoutOrder = 9
                infoButton.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
                infoButton.Size = UDim2.new(0, 23, 0, 23)
                infoButton.ZIndex = 2
                infoButton.Image = "rbxassetid://3926305904"
                infoButton.ImageColor3 = themeList.SchemeColor
                infoButton.ImageRectOffset = Vector2.new(764, 764)
                infoButton.ImageRectSize = Vector2.new(36, 36)

                dropdownCorner.CornerRadius = UDim.new(0, 4)
                dropdownCorner.Parent = dropOpen

                local refreshRipple = Instance.new("ImageLabel")

                refreshRipple.Name = "refreshRipple"
                refreshRipple.Parent = dropOpen
                refreshRipple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                refreshRipple.BackgroundTransparency = 1.000
                refreshRipple.Image = "http://www.roblox.com/asset/?id=4560909609"
                refreshRipple.ImageColor3 = themeList.SchemeColor
                refreshRipple.ImageTransparency = 0.600

                UIListLayout.Parent = dropFrame
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Padding = UDim.new(0, 3)

                updateSectionFrame()
                UpdateSize()

                local uis                    = game:GetService("UserInputService")

                local infoTooltip            = Instance.new("TextLabel")
                local infoTooltipCorner      = Instance.new("UICorner")

                infoTooltip.Name             = "infoTooltip"
                infoTooltip.Parent           = infoContainer
                infoTooltip.BackgroundColor3 = DerivedTheme.TooltipBackground
                infoTooltip.Position         = UDim2.new(0, 0, 2, 0)
                infoTooltip.Size             = UDim2.new(0, 353, 0, 33)
                infoTooltip.ZIndex           = 9
                infoTooltip.RichText         = true
                infoTooltip.Font             = Enum.Font.GothamSemibold
                infoTooltip.Text             = "  " .. dropinf
                infoTooltip.TextColor3       = themeList.TextColor
                infoTooltip.TextSize         = 14.000
                infoTooltip.TextXAlignment   = Enum.TextXAlignment.Left

                local isHovered              = false

                Utility:BindHover({
                    button = dropdownButton,
                    isHoveredRef = function(v)
                        if v ~= nil then isHovered = v end
                        return isHovered
                    end,
                    focusingRef = function()
                        return focusing
                    end,
                    onHover = function()
                        Utility:SetHover(dropdownButton, DerivedTheme.ElementHover)
                    end,
                    onLeave = function()
                        Utility:SetHover(dropdownButton, themeList.ElementColor)
                    end
                })

                infoTooltipCorner.CornerRadius = UDim.new(0, 4)
                infoTooltipCorner.Parent = infoTooltip

                if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
                    Utility:TweenObject(infoTooltip, { TextColor3 = Color3.fromRGB(0, 0, 0) }, 0.2)
                end
                if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
                    Utility:TweenObject(infoTooltip, { TextColor3 = Color3.fromRGB(255, 255, 255) }, 0.2)
                end

                Track(infoButton.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for i, v in next, infoContainer:GetChildren() do
                            if v ~= infoTooltip then
                                Utility:TweenObject(v, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                            end
                        end
                        Utility:TweenObject(infoTooltip, { Position = UDim2.new(0, 0, 0, 0) }, 0.2)
                        Utility:TweenObject(blurFrame, { BackgroundTransparency = 0.5 }, 0.2)
                        Utility:TweenObject(dropdownButton, { BackgroundColor3 = themeList.ElementColor }, 0.2)
                        task.wait(1.5)
                        focusing = false
                        Utility:TweenObject(infoTooltip, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                        Utility:TweenObject(blurFrame, { BackgroundTransparency = 1 }, 0.2)
                        task.wait()
                        viewDe = false
                    end
                end))

                for i, v in next, list do
                    local optionSelect = Instance.new("TextButton")
                    local optionCorner = Instance.new("UICorner")
                    local optionRippleTemplate = Instance.new("ImageLabel")

                    optionRippleTemplate.Name = "optionRippleTemplate"
                    optionRippleTemplate.Parent = optionSelect
                    optionRippleTemplate.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    optionRippleTemplate.BackgroundTransparency = 1.000
                    optionRippleTemplate.Image = "http://www.roblox.com/asset/?id=4560909609"
                    optionRippleTemplate.ImageColor3 = themeList.SchemeColor
                    optionRippleTemplate.ImageTransparency = 0.600
                    DropYSize = DropYSize + 33
                    optionSelect.Name = "optionSelect"
                    optionSelect.Parent = dropFrame
                    optionSelect.BackgroundColor3 = themeList.ElementColor
                    optionSelect.Position = UDim2.new(0, 0, 0.235294119, 0)
                    optionSelect.Size = UDim2.new(0, 352, 0, 33)
                    optionSelect.AutoButtonColor = false
                    optionSelect.Font = Enum.Font.GothamSemibold
                    optionSelect.Text = "  " .. v
                    optionSelect.TextColor3 = DerivedTheme.OptionTextDim
                    optionSelect.TextSize = 14.000
                    optionSelect.TextXAlignment = Enum.TextXAlignment.Left
                    optionSelect.ClipsDescendants = true
                    local aliveOption = true
                    Chr0nicxHack3r:OnThemeChange(function()
                        if not aliveOption or not optionSelect.Parent then
                            aliveOption = false
                            return
                        end

                        optionSelect.BackgroundColor3 = themeList.ElementColor
                        optionSelect.TextColor3 = DerivedTheme.OptionTextDim
                    end)

                    Track(optionSelect.MouseButton1Click:Connect(function()
                        if not focusing then
                            opened = false
                            dropdownButton.AutoButtonColor = false
                            task.wait()
                            --callback(v)
                            --itemTextbox.Text = v
                            itemTextbox.Text = v
                            task.defer(callback, v)
                            dropFrame:TweenSize(UDim2.new(0, 352, 0, 33), 'InOut', 'Linear', 0.08)
                            task.wait(0.1)
                            updateSectionFrame()
                            UpdateSize()
                            local c = optionRippleTemplate:Clone()
                            c.Parent = optionSelect
                            local x, y = (dropdownMouse.X - c.AbsolutePosition.X),
                                (dropdownMouse.Y - c.AbsolutePosition.Y)
                            c.Position = UDim2.new(0, x, 0, y)
                            local len, size = 0.35, nil
                            if optionSelect.AbsoluteSize.X >= optionSelect.AbsoluteSize.Y then
                                size = (optionSelect.AbsoluteSize.X * 1.5)
                            else
                                size = (optionSelect.AbsoluteSize.Y * 1.5)
                            end
                            c:TweenSizeAndPosition(UDim2.new(0, size, 0, size),
                                UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                            Utility:FadeAndDestroy(c, len)
                        else
                            for i, v in next, infoContainer:GetChildren() do
                                Utility:TweenObject(v, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                                focusing = false
                            end
                            Utility:TweenObject(blurFrame, { BackgroundTransparency = 1 }, 0.2)
                        end
                    end))

                    optionCorner.CornerRadius = UDim.new(0, 4)
                    optionCorner.Parent = optionSelect

                    Utility:BindHover({
                        button = optionSelect,
                        isHoveredRef = function(v)
                            if v ~= nil then isHovered = v end
                            return isHovered
                        end,
                        focusingRef = function()
                            return focusing
                        end,
                        onHover = function()
                            Utility:SetHover(optionSelect, DerivedTheme.ElementHover)
                        end,
                        onLeave = function()
                            Utility:SetHover(optionSelect, themeList.ElementColor)
                        end
                    })
                end

                function DropFunction:Refresh(newList)
                    newList = newList or {}
                    for i, v in next, dropFrame:GetChildren() do
                        if v.Name == "optionSelect" then
                            v:Destroy()
                        end
                    end
                    for i, v in next, newList do
                        local optionSelect = Instance.new("TextButton")
                        local optionCorner = Instance.new("UICorner")
                        local refreshRipple = Instance.new("ImageLabel")
                        refreshRipple.Name = "refreshRipple"
                        refreshRipple.Parent = optionSelect
                        refreshRipple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        refreshRipple.BackgroundTransparency = 1.000
                        refreshRipple.Image = "http://www.roblox.com/asset/?id=4560909609"
                        refreshRipple.ImageColor3 = themeList.SchemeColor
                        refreshRipple.ImageTransparency = 0.600

                        local refreshRippleSample = refreshRipple
                        DropYSize = DropYSize + 33
                        optionSelect.Name = "optionSelect"
                        optionSelect.Parent = dropFrame
                        optionSelect.BackgroundColor3 = themeList.ElementColor
                        optionSelect.Position = UDim2.new(0, 0, 0.235294119, 0)
                        optionSelect.Size = UDim2.new(0, 352, 0, 33)
                        optionSelect.AutoButtonColor = false
                        optionSelect.Font = Enum.Font.GothamSemibold
                        optionSelect.Text = "  " .. v
                        optionSelect.TextColor3 = DerivedTheme.OptionTextDim
                        optionSelect.TextSize = 14.000
                        optionSelect.TextXAlignment = Enum.TextXAlignment.Left
                        optionSelect.ClipsDescendants = true
                        optionCorner.CornerRadius = UDim.new(0, 4)
                        optionCorner.Parent = optionSelect
                        Track(optionSelect.MouseButton1Click:Connect(function()
                            if not focusing then
                                opened = false
                                callback(v)
                                itemTextbox.Text = v
                                dropFrame:TweenSize(UDim2.new(0, 352, 0, 33), 'InOut', 'Linear', 0.08)
                                task.wait(0.1)
                                updateSectionFrame()
                                UpdateSize()
                                local c = refreshRippleSample:Clone()
                                c.Parent = optionSelect
                                local x, y = (dropdownMouse.X - c.AbsolutePosition.X),
                                    (dropdownMouse.Y - c.AbsolutePosition.Y)
                                c.Position = UDim2.new(0, x, 0, y)
                                local len, size = 0.35, nil
                                if optionSelect.AbsoluteSize.X >= optionSelect.AbsoluteSize.Y then
                                    size = (optionSelect.AbsoluteSize.X * 1.5)
                                else
                                    size = (optionSelect.AbsoluteSize.Y * 1.5)
                                end
                                c:TweenSizeAndPosition(UDim2.new(0, size, 0, size),
                                    UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                                Utility:FadeAndDestroy(c, len)
                            else
                                for i, v in next, infoContainer:GetChildren() do
                                    Utility:TweenObject(v, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                                    focusing = false
                                end
                                Utility:TweenObject(blurFrame, { BackgroundTransparency = 1 }, 0.2)
                            end
                        end))
                        updateSectionFrame()
                        UpdateSize()
                        Utility:BindHover({
                            button = optionSelect,
                            isHoveredRef = function(v)
                                if v ~= nil then isHovered = v end
                                return isHovered
                            end,
                            focusingRef = function()
                                return focusing
                            end,
                            onHover = function()
                                Utility:SetHover(optionSelect, DerivedTheme.ElementHover)
                            end,
                            onLeave = function()
                                Utility:SetHover(optionSelect, themeList.ElementColor)
                            end
                        })
                    end
                    if opened then
                        dropFrame:TweenSize(UDim2.new(0, 352, 0, UIListLayout.AbsoluteContentSize.Y), "InOut", "Linear",
                            0.08, true)
                        task.wait(0.1)
                        updateSectionFrame()
                        UpdateSize()
                    else
                        dropFrame:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
                        task.wait(0.1)
                        updateSectionFrame()
                        UpdateSize()
                    end
                end

                return DropFunction
            end

            function Elements:NewKeybind(keytext, keyinf, first, callback)
                keytext = keytext or "KeybindText"
                keyinf = keyinf or "KebindInfo"
                callback = callback or function() end
                local oldKey = first.Name
                local keybindElement = Instance.new("TextButton")
                local keybindCorner = Instance.new("UICorner")
                local togName = Instance.new("TextLabel")
                local viewInfo = Instance.new("ImageButton")
                local touch = Instance.new("ImageLabel")
                local keybindRippleTemplate = Instance.new("ImageLabel")
                local togName_2 = Instance.new("TextLabel")

                local alive = true
                Chr0nicxHack3r:OnThemeChange(function()
                    if not alive or not keybindElement.Parent then
                        alive = false
                        return
                    end
                    keybindElement.BackgroundColor3 = themeList.ElementColor
                    viewInfo.ImageColor3 = themeList.SchemeColor
                    touch.ImageColor3 = themeList.SchemeColor
                    keybindRippleTemplate.ImageColor3 = themeList.SchemeColor
                    togName.TextColor3 = themeList.TextColor
                    togName_2.TextColor3 = themeList.SchemeColor
                end)

                local ms = game.Players.LocalPlayer:GetMouse()
                local uis = game:GetService("UserInputService")
                local infoButton = viewInfo

                local infoTooltip = Instance.new("TextLabel")
                local tipCorner = Instance.new("UICorner")

                local rippleSample = keybindRippleTemplate
                local waitingForKey = false

                keybindElement.Name = "keybindElement"
                keybindElement.Parent = sectionInners
                keybindElement.BackgroundColor3 = themeList.ElementColor
                keybindElement.ClipsDescendants = true
                keybindElement.Size = UDim2.new(0, 352, 0, 33)
                keybindElement.AutoButtonColor = false
                keybindElement.Font = Enum.Font.SourceSans
                keybindElement.Text = ""
                keybindElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                keybindElement.TextSize = 14.000
                Track(keybindElement.MouseButton1Click:connect(function(e)
                    if not focusing then
                        if waitingForKey then return end
                        waitingForKey = true
                        togName_2.Text = ". . ."

                        local conn
                        Track(uis.InputBegan:Connect(function(a, b)
                            if not waitingForKey then return end

                            if a.KeyCode.Name ~= "Unknown" then
                                togName_2.Text = a.KeyCode.Name
                                oldKey = a.KeyCode.Name
                            end

                            waitingForKey = false
                        end))
                        task.wait(0.3)
                        local c = rippleSample:Clone()
                        c.Parent = keybindElement
                        local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                        c.Position = UDim2.new(0, x, 0, y)
                        local len, size = 0.35, nil
                        if keybindElement.AbsoluteSize.X >= keybindElement.AbsoluteSize.Y then
                            size = (keybindElement.AbsoluteSize.X * 1.5)
                        else
                            size = (keybindElement.AbsoluteSize.Y * 1.5)
                        end
                        c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)),
                            'Out', 'Quad', len, true, nil)
                        Utility:FadeAndDestroy(c, len)
                    else
                        for i, v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, { BackgroundTransparency = 1 }, 0.2)
                    end
                end))

                Track(uis.InputBegan:Connect(function(current, ok)
                    if not ok then
                        if current.KeyCode.Name == oldKey then
                            callback()
                        end
                    end
                end))

                infoTooltip.Name = "infoTooltip"
                infoTooltip.Parent = infoContainer
                infoTooltip.BackgroundColor3 = DerivedTheme.TooltipBackground
                infoTooltip.Position = UDim2.new(0, 0, 2, 0)
                infoTooltip.Size = UDim2.new(0, 353, 0, 33)
                infoTooltip.ZIndex = 9
                infoTooltip.RichText = true
                infoTooltip.Font = Enum.Font.GothamSemibold
                infoTooltip.Text = "  " .. keyinf
                infoTooltip.TextColor3 = themeList.TextColor
                infoTooltip.TextSize = 14.000
                infoTooltip.TextXAlignment = Enum.TextXAlignment.Left

                keybindRippleTemplate.Name = "keybindRippleTemplate"
                keybindRippleTemplate.Parent = keybindElement
                keybindRippleTemplate.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                keybindRippleTemplate.BackgroundTransparency = 1.000
                keybindRippleTemplate.Image = "http://www.roblox.com/asset/?id=4560909609"
                keybindRippleTemplate.ImageColor3 = themeList.SchemeColor
                keybindRippleTemplate.ImageTransparency = 0.600


                togName.Name = "togName"
                togName.Parent = keybindElement
                togName.BackgroundColor3 = themeList.TextColor
                togName.BackgroundTransparency = 1.000
                togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
                togName.Size = UDim2.new(0, 222, 0, 14)
                togName.Font = Enum.Font.GothamSemibold
                togName.Text = keytext
                togName.RichText = true
                togName.TextColor3 = themeList.TextColor
                togName.TextSize = 14.000
                togName.TextXAlignment = Enum.TextXAlignment.Left

                viewInfo.Name = "viewInfo"
                viewInfo.Parent = keybindElement
                viewInfo.BackgroundTransparency = 1.000
                viewInfo.LayoutOrder = 9
                viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
                viewInfo.Size = UDim2.new(0, 23, 0, 23)
                viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"
                viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764, 764)
                viewInfo.ImageRectSize = Vector2.new(36, 36)
                Track(viewInfo.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for i, v in next, infoContainer:GetChildren() do
                            if v ~= infoTooltip then
                                Utility:TweenObject(v, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                            end
                        end
                        Utility:TweenObject(infoTooltip, { Position = UDim2.new(0, 0, 0, 0) }, 0.2)
                        Utility:TweenObject(blurFrame, { BackgroundTransparency = 0.5 }, 0.2)
                        Utility:TweenObject(keybindElement, { BackgroundColor3 = themeList.ElementColor }, 0.2)
                        task.wait(1.5)
                        focusing = false
                        Utility:TweenObject(infoTooltip, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                        Utility:TweenObject(blurFrame, { BackgroundTransparency = 1 }, 0.2)
                        task.wait()
                        viewDe = false
                    end
                end))
                updateSectionFrame()
                UpdateSize()
                local isHovered = false
                Utility:BindHover({
                    button = keybindElement,
                    isHoveredRef = function(v)
                        if v ~= nil then isHovered = v end
                        return isHovered
                    end,
                    focusingRef = function()
                        return focusing
                    end,
                    onHover = function()
                        Utility:SetHover(keybindElement, DerivedTheme.ElementHover)
                    end,
                    onLeave = function()
                        Utility:SetHover(keybindElement, themeList.ElementColor)
                    end
                })


                tipCorner.CornerRadius = UDim.new(0, 4)
                tipCorner.Parent = infoTooltip

                if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
                    Utility:TweenObject(infoTooltip, { TextColor3 = Color3.fromRGB(0, 0, 0) }, 0.2)
                end
                if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
                    Utility:TweenObject(infoTooltip, { TextColor3 = Color3.fromRGB(255, 255, 255) }, 0.2)
                end

                keybindCorner.CornerRadius = UDim.new(0, 4)
                keybindCorner.Parent = keybindElement

                touch.Name = "touch"
                touch.Parent = keybindElement
                touch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                touch.BackgroundTransparency = 1.000
                touch.BorderColor3 = Color3.fromRGB(27, 42, 53)
                touch.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                touch.Size = UDim2.new(0, 21, 0, 21)
                touch.Image = "rbxassetid://3926305904"
                touch.ImageColor3 = themeList.SchemeColor
                touch.ImageRectOffset = Vector2.new(364, 284)
                touch.ImageRectSize = Vector2.new(36, 36)

                togName_2.Name = "togName"
                togName_2.Parent = keybindElement
                togName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                togName_2.BackgroundTransparency = 1.000
                togName_2.Position = UDim2.new(0.727386296, 0, 0.272727281, 0)
                togName_2.Size = UDim2.new(0, 70, 0, 14)
                togName_2.Font = Enum.Font.GothamSemibold
                togName_2.Text = oldKey
                togName_2.TextColor3 = themeList.SchemeColor
                togName_2.TextSize = 14.000
                togName_2.TextXAlignment = Enum.TextXAlignment.Right
            end

            function Elements:NewColorPicker(colText, colInf, defcolor, callback)
                colText = colText or "ColorPicker"
                callback = callback or function() end
                defcolor = defcolor or Color3.fromRGB(1, 1, 1)
                local h, s, v = Color3.toHSV(defcolor)
                local ms = game.Players.LocalPlayer:GetMouse()
                local colorOpened = false
                local colorElement = Instance.new("TextButton")
                local pickerCorner = Instance.new("UICorner")
                local colorHeader = Instance.new("Frame")
                local headerCorner = Instance.new("UICorner")
                local touch = Instance.new("ImageLabel")
                local togName = Instance.new("TextLabel")
                local viewInfo = Instance.new("ImageButton")
                local colorCurrent = Instance.new("Frame")
                local previewCorner = Instance.new("UICorner")
                local UIListLayout = Instance.new("UIListLayout")
                local colorInners = Instance.new("Frame")
                local innerCorner = Instance.new("UICorner")
                local rgbPicker = Instance.new("ImageButton")
                local rgbCorner = Instance.new("UICorner")
                local rbgcircle = Instance.new("ImageLabel")
                local darkness = Instance.new("ImageButton")
                local darkCorner = Instance.new("UICorner")
                local darkcircle = Instance.new("ImageLabel")
                local toggleDisabled = Instance.new("ImageLabel")
                local toggleEnabled = Instance.new("ImageLabel")
                local onrainbow = Instance.new("TextButton")
                local togName_2 = Instance.new("TextLabel")
                local colorRippleTemplate = Instance.new("ImageLabel")

                local alive = true
                Chr0nicxHack3r:OnThemeChange(function()
                    if not alive or not colorElement.Parent then
                        alive = false
                        return
                    end
                    colorHeader.BackgroundColor3 = themeList.ElementColor
                    colorInners.BackgroundColor3 = themeList.ElementColor
                    touch.ImageColor3 = themeList.SchemeColor
                    viewInfo.ImageColor3 = themeList.SchemeColor
                    colorRippleTemplate.ImageColor3 = themeList.SchemeColor
                    togName.TextColor3 = themeList.TextColor
                    togName_2.TextColor3 = themeList.TextColor
                    toggleDisabled.ImageColor3 = themeList.SchemeColor
                    toggleEnabled.ImageColor3 = themeList.SchemeColor
                end)

                --Properties:
                colorRippleTemplate.Name = "colorRippleTemplate"
                colorRippleTemplate.Parent = colorHeader
                colorRippleTemplate.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                colorRippleTemplate.BackgroundTransparency = 1.000
                colorRippleTemplate.Image = "http://www.roblox.com/asset/?id=4560909609"
                colorRippleTemplate.ImageColor3 = themeList.SchemeColor
                colorRippleTemplate.ImageTransparency = 0.600

                local btn = colorHeader

                colorElement.Name = "colorElement"
                colorElement.Parent = sectionInners
                colorElement.BackgroundColor3 = themeList.ElementColor
                colorElement.BackgroundTransparency = 1.000
                colorElement.ClipsDescendants = true
                colorElement.Position = UDim2.new(0, 0, 0.566834569, 0)
                colorElement.Size = UDim2.new(0, 352, 0, 33)
                colorElement.AutoButtonColor = false
                colorElement.Font = Enum.Font.SourceSans
                colorElement.Text = ""
                colorElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                colorElement.TextSize = 14.000
                Track(colorElement.MouseButton1Click:Connect(function()
                    if not focusing then
                        if colorOpened then
                            colorOpened = false
                            colorElement:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
                            task.wait(0.1)
                            updateSectionFrame()
                            UpdateSize()
                            local c = colorRippleTemplate:Clone()
                            c.Parent = btn
                            local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                            c.Position = UDim2.new(0, x, 0, y)
                            local len, size = 0.35, nil
                            if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                                size = (btn.AbsoluteSize.X * 1.5)
                            else
                                size = (btn.AbsoluteSize.Y * 1.5)
                            end
                            c:TweenSizeAndPosition(UDim2.new(0, size, 0, size),
                                UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                            Utility:FadeAndDestroy(c, len)
                        else
                            colorOpened = true
                            colorElement:TweenSize(UDim2.new(0, 352, 0, 141), "InOut", "Linear", 0.08, true)
                            task.wait(0.1)
                            updateSectionFrame()
                            UpdateSize()
                            local c = colorRippleTemplate:Clone()
                            c.Parent = btn
                            local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                            c.Position = UDim2.new(0, x, 0, y)
                            local len, size = 0.35, nil
                            if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                                size = (btn.AbsoluteSize.X * 1.5)
                            else
                                size = (btn.AbsoluteSize.Y * 1.5)
                            end
                            c:TweenSizeAndPosition(UDim2.new(0, size, 0, size),
                                UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                            Utility:FadeAndDestroy(c, len)
                        end
                    else
                        for i, v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, { BackgroundTransparency = 1 }, 0.2)
                    end
                end))
                pickerCorner.CornerRadius = UDim.new(0, 4)
                pickerCorner.Parent = colorElement

                colorHeader.Name = "colorHeader"
                colorHeader.Parent = colorElement
                colorHeader.BackgroundColor3 = themeList.ElementColor
                colorHeader.Size = UDim2.new(0, 352, 0, 33)
                colorHeader.ClipsDescendants = true

                headerCorner.CornerRadius = UDim.new(0, 4)
                headerCorner.Parent = colorHeader

                touch.Name = "touch"
                touch.Parent = colorHeader
                touch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                touch.BackgroundTransparency = 1.000
                touch.BorderColor3 = Color3.fromRGB(27, 42, 53)
                touch.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                touch.Size = UDim2.new(0, 21, 0, 21)
                touch.Image = "rbxassetid://3926305904"
                touch.ImageColor3 = themeList.SchemeColor
                touch.ImageRectOffset = Vector2.new(44, 964)
                touch.ImageRectSize = Vector2.new(36, 36)

                togName.Name = "togName"
                togName.Parent = colorHeader
                togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                togName.BackgroundTransparency = 1.000
                togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
                togName.Size = UDim2.new(0, 288, 0, 14)
                togName.Font = Enum.Font.GothamSemibold
                togName.Text = colText
                togName.TextColor3 = themeList.TextColor
                togName.TextSize = 14.000
                togName.RichText = true
                togName.TextXAlignment = Enum.TextXAlignment.Left

                local infoTooltip = Instance.new("TextLabel")
                local tipCorner = Instance.new("UICorner")

                infoTooltip.Name = "infoTooltip"
                infoTooltip.Parent = infoContainer
                infoTooltip.BackgroundColor3 = DerivedTheme.TooltipBackground
                infoTooltip.Position = UDim2.new(0, 0, 2, 0)
                infoTooltip.Size = UDim2.new(0, 353, 0, 33)
                infoTooltip.ZIndex = 9
                infoTooltip.Font = Enum.Font.GothamSemibold
                infoTooltip.Text = "  " .. colInf
                infoTooltip.TextColor3 = themeList.TextColor
                infoTooltip.TextSize = 14.000
                infoTooltip.RichText = true
                infoTooltip.TextXAlignment = Enum.TextXAlignment.Left

                tipCorner.CornerRadius = UDim.new(0, 4)
                tipCorner.Parent = infoTooltip

                viewInfo.Name = "viewInfo"
                viewInfo.Parent = colorHeader
                viewInfo.BackgroundTransparency = 1.000
                viewInfo.LayoutOrder = 9
                viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
                viewInfo.Size = UDim2.new(0, 23, 0, 23)
                viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"
                viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764, 764)
                viewInfo.ImageRectSize = Vector2.new(36, 36)
                Track(viewInfo.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for i, v in next, infoContainer:GetChildren() do
                            if v ~= infoTooltip then
                                Utility:TweenObject(v, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                            end
                        end
                        Utility:TweenObject(infoTooltip, { Position = UDim2.new(0, 0, 0, 0) }, 0.2)
                        Utility:TweenObject(blurFrame, { BackgroundTransparency = 0.5 }, 0.2)
                        Utility:TweenObject(colorElement, { BackgroundColor3 = themeList.ElementColor }, 0.2)
                        task.wait(1.5)
                        focusing = false
                        Utility:TweenObject(infoTooltip, { Position = UDim2.new(0, 0, 2, 0) }, 0.2)
                        Utility:TweenObject(blurFrame, { BackgroundTransparency = 1 }, 0.2)
                        task.wait()
                        viewDe = false
                    end
                end))

                colorCurrent.Name = "colorCurrent"
                colorCurrent.Parent = colorHeader
                colorCurrent.BackgroundColor3 = defcolor
                colorCurrent.Position = UDim2.new(0.792613626, 0, 0.212121218, 0)
                colorCurrent.Size = UDim2.new(0, 42, 0, 18)

                previewCorner.CornerRadius = UDim.new(0, 4)
                previewCorner.Parent = colorCurrent

                UIListLayout.Parent = colorElement
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Padding = UDim.new(0, 3)

                colorInners.Name = "colorInners"
                colorInners.Parent = colorElement
                colorInners.BackgroundColor3 = themeList.ElementColor
                colorInners.Position = UDim2.new(0, 0, 0.255319148, 0)
                colorInners.Size = UDim2.new(0, 352, 0, 105)

                innerCorner.CornerRadius = UDim.new(0, 4)
                innerCorner.Parent = colorInners

                rgbPicker.Name = "rgbPicker"
                rgbPicker.Parent = colorInners
                rgbPicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                rgbPicker.BackgroundTransparency = 1.000
                rgbPicker.Position = UDim2.new(0.0198863633, 0, 0.0476190485, 0)
                rgbPicker.Size = UDim2.new(0, 211, 0, 93)
                rgbPicker.Image = "http://www.roblox.com/asset/?id=6523286724"

                rgbCorner.CornerRadius = UDim.new(0, 4)
                rgbCorner.Parent = rgbPicker

                rbgcircle.Name = "rbgcircle"
                rbgcircle.Parent = rgbPicker
                rbgcircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                rbgcircle.BackgroundTransparency = 1.000
                rbgcircle.Size = UDim2.new(0, 14, 0, 14)
                rbgcircle.Image = "rbxassetid://3926309567"
                rbgcircle.ImageColor3 = Color3.fromRGB(0, 0, 0)
                rbgcircle.ImageRectOffset = Vector2.new(628, 420)
                rbgcircle.ImageRectSize = Vector2.new(48, 48)

                darkness.Name = "darkness"
                darkness.Parent = colorInners
                darkness.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                darkness.BackgroundTransparency = 1.000
                darkness.Position = UDim2.new(0.636363626, 0, 0.0476190485, 0)
                darkness.Size = UDim2.new(0, 18, 0, 93)
                darkness.Image = "http://www.roblox.com/asset/?id=6523291212"

                darkCorner.CornerRadius = UDim.new(0, 4)
                darkCorner.Parent = darkness

                darkcircle.Name = "darkcircle"
                darkcircle.Parent = darkness
                darkcircle.AnchorPoint = Vector2.new(0.5, 0)
                darkcircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                darkcircle.BackgroundTransparency = 1.000
                darkcircle.Size = UDim2.new(0, 14, 0, 14)
                darkcircle.Image = "rbxassetid://3926309567"
                darkcircle.ImageColor3 = Color3.fromRGB(0, 0, 0)
                darkcircle.ImageRectOffset = Vector2.new(628, 420)
                darkcircle.ImageRectSize = Vector2.new(48, 48)

                toggleDisabled.Name = "toggleDisabled"
                toggleDisabled.Parent = colorInners
                toggleDisabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggleDisabled.BackgroundTransparency = 1.000
                toggleDisabled.Position = UDim2.new(0.704659104, 0, 0.0657142699, 0)
                toggleDisabled.Size = UDim2.new(0, 21, 0, 21)
                toggleDisabled.Image = "rbxassetid://3926309567"
                toggleDisabled.ImageColor3 = themeList.SchemeColor
                toggleDisabled.ImageRectOffset = Vector2.new(628, 420)
                toggleDisabled.ImageRectSize = Vector2.new(48, 48)

                toggleEnabled.Name = "toggleEnabled"
                toggleEnabled.Parent = colorInners
                toggleEnabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggleEnabled.BackgroundTransparency = 1.000
                toggleEnabled.Position = UDim2.new(0.704999983, 0, 0.0659999996, 0)
                toggleEnabled.Size = UDim2.new(0, 21, 0, 21)
                toggleEnabled.Image = "rbxassetid://3926309567"
                toggleEnabled.ImageColor3 = themeList.SchemeColor
                toggleEnabled.ImageRectOffset = Vector2.new(784, 420)
                toggleEnabled.ImageRectSize = Vector2.new(48, 48)
                toggleEnabled.ImageTransparency = 1.000

                onrainbow.Name = "onrainbow"
                onrainbow.Parent = toggleEnabled
                onrainbow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                onrainbow.BackgroundTransparency = 1.000
                onrainbow.Position = UDim2.new(2.90643607e-06, 0, 0, 0)
                onrainbow.Size = UDim2.new(1, 0, 1, 0)
                onrainbow.Font = Enum.Font.SourceSans
                onrainbow.Text = ""
                onrainbow.TextColor3 = Color3.fromRGB(0, 0, 0)
                onrainbow.TextSize = 14.000

                togName_2.Name = "togName"
                togName_2.Parent = colorInners
                togName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                togName_2.BackgroundTransparency = 1.000
                togName_2.Position = UDim2.new(0.779999971, 0, 0.100000001, 0)
                togName_2.Size = UDim2.new(0, 278, 0, 14)
                togName_2.Font = Enum.Font.GothamSemibold
                togName_2.Text = "Rainbow"
                togName_2.TextColor3 = themeList.TextColor
                togName_2.TextSize = 14.000
                togName_2.TextXAlignment = Enum.TextXAlignment.Left

                if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
                    Utility:TweenObject(infoTooltip, { TextColor3 = Color3.fromRGB(0, 0, 0) }, 0.2)
                end
                if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
                    Utility:TweenObject(infoTooltip, { TextColor3 = Color3.fromRGB(255, 255, 255) }, 0.2)
                end
                local isHovered = false
                Utility:BindHover({
                    button = colorElement,
                    isHoveredRef = function(v)
                        if v ~= nil then isHovered = v end
                        return isHovered
                    end,
                    focusingRef = function()
                        return focusing
                    end,
                    onHover = function()
                        Utility:SetHover(colorElement, DerivedTheme.ElementHover)
                    end,
                    onLeave = function()
                        Utility:SetHover(colorElement, themeList.ElementColor)
                    end
                })


                if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
                    Utility:TweenObject(infoTooltip, { TextColor3 = Color3.fromRGB(0, 0, 0) }, 0.2)
                end
                if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
                    Utility:TweenObject(infoTooltip, { TextColor3 = Color3.fromRGB(255, 255, 255) }, 0.2)
                end
                updateSectionFrame()
                UpdateSize()
                local plr = game.Players.LocalPlayer
                local colorMouse = plr:GetMouse()
                local colorInput = game:GetService('UserInputService')
                local renderService = game:GetService("RunService")
                local colorpicker = false
                local darkDragging = false
                local darkBar = darkness
                local rgbCursor = rbgcircle
                local darkCursor = darkcircle
                local color = { 1, 1, 1 }
                local rainbow = false
                local counter = 0
                --
                local function zigzag(X) return math.acos(math.cos(X * math.pi)) / math.pi end
                counter = 0
                local function mouseLocation()
                    return plr:GetMouse()
                end
                local function cp()
                    if colorpicker then
                        local ml = mouseLocation()
                        local x, y = ml.X - rgbPicker.AbsolutePosition.X, ml.Y - rgbPicker.AbsolutePosition.Y
                        local maxX, maxY = rgbPicker.AbsoluteSize.X, rgbPicker.AbsoluteSize.Y
                        if x < 0 then x = 0 end
                        if x > maxX then x = maxX end
                        if y < 0 then y = 0 end
                        if y > maxY then y = maxY end
                        x = x / maxX
                        y = y / maxY
                        local cx = rgbCursor.AbsoluteSize.X / 2
                        local cy = rgbCursor.AbsoluteSize.Y / 2
                        rgbCursor.Position = UDim2.new(x, -cx, y, -cy)
                        color = { 1 - x, 1 - y, color[3] }
                        local realcolor = Color3.fromHSV(color[1], color[2], color[3])
                        colorCurrent.BackgroundColor3 = realcolor
                        callback(realcolor)
                    end
                    if darkDragging then
                        local ml = mouseLocation()
                        local y = ml.Y - darkBar.AbsolutePosition.Y
                        local maxY = darkBar.AbsoluteSize.Y
                        if y < 0 then y = 0 end
                        if y > maxY then y = maxY end
                        y = y / maxY
                        local cy = darkCursor.AbsoluteSize.Y / 2
                        darkCursor.Position = UDim2.new(0.5, 0, y, -cy)
                        darkCursor.ImageColor3 = Color3.fromHSV(0, 0, y)
                        color = { color[1], color[2], 1 - y }
                        local realcolor = Color3.fromHSV(color[1], color[2], color[3])
                        colorCurrent.BackgroundColor3 = realcolor
                        callback(realcolor)
                    end
                end

                local function setcolor(tbl)
                    local cx = rgbCursor.AbsoluteSize.X / 2
                    local cy = rgbCursor.AbsoluteSize.Y / 2
                    color = { tbl[1], tbl[2], tbl[3] }
                    rgbCursor.Position = UDim2.new(color[1], -cx, color[2] - 1, -cy)
                    darkCursor.Position = UDim2.new(0.5, 0, color[3] - 1, -cy)
                    local realcolor = Color3.fromHSV(color[1], color[2], color[3])
                    colorCurrent.BackgroundColor3 = realcolor
                end
                local function setrgbcolor(tbl)
                    local cx = rgbCursor.AbsoluteSize.X / 2
                    local cy = rgbCursor.AbsoluteSize.Y / 2
                    color = { tbl[1], tbl[2], color[3] }
                    rgbCursor.Position = UDim2.new(color[1], -cx, color[2] - 1, -cy)
                    local realcolor = Color3.fromHSV(color[1], color[2], color[3])
                    colorCurrent.BackgroundColor3 = realcolor
                    callback(realcolor)
                end
                local rainbowRenderConn = Track(renderService.RenderStepped:Connect(function()
                    if not rainbow then return end
                    setrgbcolor({ zigzag(counter), 1, 1 })
                    counter = counter + 0.01
                end))
                local function togglerainbow()
                    rainbow = not rainbow

                    Utility:TweenObject(
                        toggleEnabled, { ImageTransparency = rainbow and 0 or 1 }, 0.1, Enum.EasingStyle.Linear,
                        Enum.EasingDirection.InOut)
                end


                Track(onrainbow.MouseButton1Click:Connect(togglerainbow))
                --
                Track(colorMouse.Move:connect(cp))
                Track(rgbPicker.MouseButton1Down:connect(function() colorpicker = true end))
                Track(darkBar.MouseButton1Down:connect(function() darkDragging = true end))
                Track(colorInput.InputEnded:Connect(function(input)
                    if input.UserInputType.Name == 'MouseButton1' then
                        if darkDragging then darkDragging = false end
                        if colorpicker then colorpicker = false end
                    end
                end))
                setcolor({ h, s, v })
            end

            function Elements:NewLabel(title)
                local labelFunctions = {}
                local label = Instance.new("TextLabel")
                local labelCorner = Instance.new("UICorner")
                label.Name = "label"
                label.Parent = sectionInners
                label.BackgroundColor3 = themeList.SchemeColor
                label.BorderSizePixel = 0
                label.ClipsDescendants = true
                label.Text = title
                label.Size = UDim2.new(0, 352, 0, 33)
                label.Font = Enum.Font.Gotham
                label.Text = "  " .. title
                label.RichText = true
                label.TextColor3 = themeList.TextColor
                label.TextSize = 14.000
                label.TextXAlignment = Enum.TextXAlignment.Left

                labelCorner.CornerRadius = UDim.new(0, 4)
                labelCorner.Parent = label

                if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
                    Utility:TweenObject(label, { TextColor3 = Color3.fromRGB(0, 0, 0) }, 0.2)
                end
                if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
                    Utility:TweenObject(label, { TextColor3 = Color3.fromRGB(255, 255, 255) }, 0.2)
                end

                local alive = true
                Chr0nicxHack3r:OnThemeChange(function()
                    if not alive or not label.Parent then
                        alive = false
                        return
                    end
                    label.BackgroundColor3 = themeList.SchemeColor
                    label.TextColor3 = themeList.TextColor
                end)
                updateSectionFrame()
                UpdateSize()
                function labelFunctions:UpdateLabel(newText)
                    if label.Text ~= "  " .. newText then
                        label.Text = "  " .. newText
                    end
                end

                return labelFunctions
            end

            return Elements
        end

        return Sections
    end

    -- =========================
    -- Notification System
    -- =========================

    local NOTIF_MARGIN = 16
    local NOTIF_MAX_WIDTH = 360
    local NOTIF_MIN_WIDTH = 180
    local NOTIF_PADDING = 10
    local MAX_NOTIFICATIONS = 4

    local NotificationContainer = Instance.new("Frame")
    NotificationContainer.Name = "NotificationContainer"
    NotificationContainer.Parent = ScreenGui
    NotificationContainer.AnchorPoint = Vector2.new(1, 1)
    NotificationContainer.Position = UDim2.new(1, -NOTIF_MARGIN, 1, -NOTIF_MARGIN)
    --NotificationContainer.Size = UDim2.new(0, NOTIF_MAX_WIDTH, 0, 1)
    NotificationContainer.Size = UDim2.new(0, NOTIF_MAX_WIDTH, 1, 0)
    NotificationContainer.BackgroundTransparency = 1
    NotificationContainer.ZIndex = 1000

    local notifLayout = Instance.new("UIListLayout")
    notifLayout.Parent = NotificationContainer
    notifLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    notifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    notifLayout.Padding = UDim.new(0, 8)

    function Chr0nicxHack3r:Notify(titleText, messageText, duration)
        if not ALIVE then return end

        local notifs = {}

        for _, child in ipairs(NotificationContainer:GetChildren()) do
            if child:IsA("Frame") then
                table.insert(notifs, child)
            end
        end

        if #notifs >= MAX_NOTIFICATIONS then
            table.sort(notifs, function(a, b)
                return a.AbsolutePosition.Y < b.AbsolutePosition.Y
            end)
            notifs[1]:Destroy()
        end

        titleText = tostring(titleText or "")
        messageText = tostring(messageText or "")
        duration = tonumber(duration) or 3

        -- Root frame
        local notif = Instance.new("Frame")
        notif.BackgroundColor3 = themeList.ElementColor
        notif.BackgroundTransparency = 0
        notif.BorderSizePixel = 0
        notif.ClipsDescendants = true
        notif.ZIndex = 1001
        notif.Size = UDim2.new(0, NOTIF_MIN_WIDTH, 0, 0)
        notif.Parent = NotificationContainer

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = notif

        -- Title
        local title = Instance.new("TextLabel")
        title.BackgroundTransparency = 1
        title.TextWrapped = true
        title.RichText = true
        title.Font = Enum.Font.GothamBold
        title.TextSize = 14
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.TextYAlignment = Enum.TextYAlignment.Top
        title.TextColor3 = themeList.TextColor
        title.Text = titleText
        title.Parent = notif

        -- Message
        local message = Instance.new("TextLabel")
        message.BackgroundTransparency = 1
        message.TextWrapped = true
        message.RichText = true
        message.Font = Enum.Font.Gotham
        message.TextSize = 12
        message.TextXAlignment = Enum.TextXAlignment.Left
        message.TextYAlignment = Enum.TextYAlignment.Top
        message.TextColor3 = DerivedTheme.OptionTextDim
        message.Text = messageText
        message.Parent = notif

        -- Auto sizing
        title.Size = UDim2.new(0, NOTIF_MAX_WIDTH - (NOTIF_PADDING * 2), 0, 1000)
        message.Size = UDim2.new(0, NOTIF_MAX_WIDTH - (NOTIF_PADDING * 2), 0, 1000)

        local titleSize = title.TextBounds
        local msgSize = message.TextBounds

        local width = math.clamp(
            math.max(titleSize.X, msgSize.X) + (NOTIF_PADDING * 2),
            NOTIF_MIN_WIDTH,
            NOTIF_MAX_WIDTH
        )

        local height =
            titleSize.Y +
            msgSize.Y +
            (NOTIF_PADDING * 2) +
            4

        notif.Size = UDim2.new(0, width, 0, height)

        title.Position = UDim2.new(0, NOTIF_PADDING, 0, NOTIF_PADDING)
        title.Size = UDim2.new(1, -NOTIF_PADDING * 2, 0, titleSize.Y)

        message.Position = UDim2.new(
            0,
            NOTIF_PADDING,
            0,
            NOTIF_PADDING + titleSize.Y + 4
        )
        message.Size = UDim2.new(1, -NOTIF_PADDING * 2, 0, msgSize.Y)

        -- Initial state (slide in)
        notif.Position = UDim2.new(0, 40, 0, 8)
        notif.BackgroundTransparency = 1

        Utility:TweenObject(
            notif,
            { Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 0 },
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        )

        local alive = true
        Chr0nicxHack3r:OnThemeChange(function()
            if not alive or not notif.Parent then
                alive = false
                return
            end
            notif.BackgroundColor3 = themeList.ElementColor
            title.TextColor3 = themeList.TextColor
            message.TextColor3 = DerivedTheme.OptionTextDim
        end)

        -- Auto dismiss
        task.delay(duration, function()
            if not alive then return end
            if notif and notif.Parent then
                Utility:TweenObject(
                    notif,
                    { Position = UDim2.new(0, 40, 0, 0), BackgroundTransparency = 1 },
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.In
                )
                task.wait(0.3)
                if notif then notif:Destroy() end
            end
        end)
    end

    return Tabs
end

return Chr0nicxHack3r
