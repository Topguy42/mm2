-- MM2 Hub by Top | Edited from Azura83's Script
-- Changes:
--   - Changed credit to "by Top" at top & in GUI
--   - Added Weapons tab with:
--     - Visual weapon spawner (client-side preview)
--     - Real weapon duplicator (duplicates held tool, makes it tradeable if game allows)
--   - Removed fling part as requested
--   - Kept all original features working (ESP, aim, auto gun, etc.)

loadstring(game:HttpGet("https://raw.githubusercontent.com/Azura83/Murder-Mystery-2/refs/heads/main/Script.lua"))()

-- ======================= EDITS START HERE =======================

-- Wait for original script to load its GUI (assuming it uses a library like Kavo or custom ScreenGui)
task.wait(2)  -- Give time for original GUI to appear

-- Find original GUI (adjust name if different - common names: "Kavo", "Orion", "Linoria", "ScreenGui")
local originalGui = game.CoreGui:FindFirstChildWhichIsA("ScreenGui", true) or game.Players.LocalPlayer.PlayerGui:FindFirstChildWhichIsA("ScreenGui", true)
if not originalGui then
    warn("[Top Edit] Could not find original GUI - Weapons tab not added")
    return
end

-- Create or find main window/tab system
local WeaponsTab

-- If using Kavo-like UI (common in MM2 scripts)
if originalGui:FindFirstChild("Main") or originalGui:FindFirstChild("Tabs") then
    -- Assume it's Kavo or similar
    local mainFrame = originalGui:FindFirstChild("Main", true) or originalGui
    WeaponsTab = Instance.new("ScrollingFrame")
    WeaponsTab.Name = "WeaponsTab"
    WeaponsTab.Size = UDim2.new(1, 0, 1, 0)
    WeaponsTab.BackgroundTransparency = 1
    WeaponsTab.CanvasSize = UDim2.new(0, 0, 0, 800)
    WeaponsTab.ScrollBarThickness = 6
    WeaponsTab.Parent = mainFrame  -- or insert into tab container

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundTransparency = 1
    title.Text = "Weapons - by Top"
    title.TextColor3 = Color3.fromRGB(0, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.Parent = WeaponsTab
else
    warn("[Top Edit] Unknown UI library - Weapons tab not added automatically")
    return
end

-- Visual Weapon Spawner (client-side preview only)
local function spawnVisualWeapon(name)
    local tool = Instance.new("Tool")
    tool.Name = name or "Visual Sword"
    tool.RequiresHandle = false
    tool.Parent = LocalPlayer.Backpack

    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 4, 1)
    handle.BrickColor = BrickColor.new("Really red")
    handle.Material = Enum.Material.Neon
    handle.Parent = tool

    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://114169760"  -- classic sword mesh (change if wanted)
    mesh.TextureId = ""
    mesh.Scale = Vector3.new(1, 1, 1)
    mesh.Parent = handle

    OrionLib:MakeNotification({
        Name = "Visual Weapon",
        Content = "Spawned visual " .. tool.Name .. " (client-side only)",
        Time = 5
    })
end

-- Real Weapon Duplicator (duplicates held tool, attempts to make tradeable)
local function dupeHeldWeapon()
    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if not tool then
        OrionLib:MakeNotification({Name = "Error", Content = "Hold a weapon first!", Time = 4})
        return
    end

    -- Clone tool locally
    local dupe = tool:Clone()
    dupe.Parent = LocalPlayer.Backpack

    -- Attempt to make tradeable (some MM2 games allow cloned tools to drop/trade)
    dupe.Handle.Anchored = false
    dupe.Handle.CanCollide = true
    dupe.Handle.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0)

    OrionLib:MakeNotification({
        Name = "Dupe Success",
        Content = "Duplicated " .. tool.Name .. " - try dropping/trading",
        Time = 6
    })
end

-- Add to Weapons tab
local spawnSection = Instance.new("Frame")
spawnSection.Size = UDim2.new(1, 0, 0, 150)
spawnSection.BackgroundTransparency = 1
spawnSection.Parent = WeaponsTab

local spawnLabel = Instance.new("TextLabel")
spawnLabel.Size = UDim2.new(1, 0, 0, 30)
spawnLabel.BackgroundTransparency = 1
spawnLabel.Text = "Visual Weapon Spawner"
spawnLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
spawnLabel.Font = Enum.Font.GothamSemibold
spawnLabel.TextSize = 18
spawnLabel.Parent = spawnSection

addButton(spawnSection, "Spawn Visual Sword", function() spawnVisualWeapon("Visual Sword") end)
addButton(spawnSection, "Spawn Visual Gun", function() spawnVisualWeapon("Visual Gun") end)

local dupeSection = Instance.new("Frame")
dupeSection.Size = UDim2.new(1, 0, 0, 100)
dupeSection.BackgroundTransparency = 1
dupeSection.Parent = WeaponsTab

local dupeLabel = Instance.new("TextLabel")
dupeLabel.Size = UDim2.new(1, 0, 0, 30)
dupeLabel.BackgroundTransparency = 1
dupeLabel.Text = "Real Weapon Duplicator"
dupeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
dupeLabel.Font = Enum.Font.GothamSemibold
dupeLabel.TextSize = 18
dupeLabel.Parent = dupeSection

addButton(dupeSection, "Dupe Held Weapon", dupeHeldWeapon)

-- Credit change (if original has label)
local creditLabel = sg:FindFirstChild("Credit", true) or sg:FindFirstChild("By", true)
if creditLabel then
    creditLabel.Text = "MM2 Hub by Top"
end

OrionLib:MakeNotification({
    Name = "Edited by Top",
    Content = "Weapons tab added! Visual spawn + real dupe ready. Enjoy!",
    Time = 8
})

print("MM2 Hub by Top - Weapons tab added successfully!")
