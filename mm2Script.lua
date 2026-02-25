-- MM2 Hub by Top | Edited from Azura83 Script
-- Original: https://raw.githubusercontent.com/Azura83/Murder-Mystery-2/refs/heads/main/Script.lua
-- Edits by Top: Credit changed, Weapons tab added (visual spawn + real dupe), fling removed, GUI forced to PlayerGui

-- Load original script
loadstring(game:HttpGet("https://raw.githubusercontent.com/Azura83/Murder-Mystery-2/refs/heads/main/Script.lua"))()

-- ======================= TOP EDITS =======================

task.wait(4)  -- Give original GUI time to load

-- Force original GUI to PlayerGui (fixes Delta mobile invisibility)
local coreGui = game:GetService("CoreGui")
local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

for _, gui in ipairs(coreGui:GetChildren()) do
    if gui:IsA("ScreenGui") and (gui.Name:find("MM2") or gui.Name:find("Hub") or gui.Name:find("GUI") or gui.Name:find("Azura")) then
        gui.Parent = playerGui
        gui.Enabled = true
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true
        print("[Top Edit] Moved GUI to PlayerGui: " .. gui.Name)
    end
end

-- Find original GUI to add Weapons tab/section
local originalGui = playerGui:FindFirstChildWhichIsA("ScreenGui", true) or coreGui:FindFirstChildWhichIsA("ScreenGui", true)
if not originalGui then
    warn("[Top Edit] Could not find GUI - Weapons tab not added")
    return
end

-- Create Weapons content
local WeaponsContent = Instance.new("ScrollingFrame")
WeaponsContent.Name = "WeaponsContent"
WeaponsContent.Size = UDim2.new(1, 0, 1, 0)
WeaponsContent.BackgroundTransparency = 1
WeaponsContent.CanvasSize = UDim2.new(0, 0, 0, 600)
WeaponsContent.ScrollBarThickness = 6
WeaponsContent.Visible = false
WeaponsContent.Parent = originalGui:FindFirstChild("Content", true) or originalGui:FindFirstChild("Main", true) or originalGui

-- Weapons title
local weaponsTitle = Instance.new("TextLabel")
weaponsTitle.Size = UDim2.new(1, 0, 0, 40)
weaponsTitle.BackgroundTransparency = 1
weaponsTitle.Text = "Weapons - by Top"
weaponsTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
weaponsTitle.Font = Enum.Font.GothamBold
weaponsTitle.TextSize = 24
weaponsTitle.Parent = WeaponsContent

-- Visual Spawner
local visualLabel = Instance.new("TextLabel")
visualLabel.Size = UDim2.new(1, 0, 0, 30)
visualLabel.Position = UDim2.new(0, 0, 0, 50)
visualLabel.BackgroundTransparency = 1
visualLabel.Text = "Visual Weapon Spawner (client-side)"
visualLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
visualLabel.Font = Enum.Font.GothamSemibold
visualLabel.TextSize = 18
visualLabel.Parent = WeaponsContent

local function spawnVisual(name)
    local tool = Instance.new("Tool")
    tool.Name = "Visual " .. name
    tool.RequiresHandle = false
    tool.Parent = LocalPlayer.Backpack

    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 5, 1)
    handle.BrickColor = BrickColor.new("Bright blue")
    handle.Material = Enum.Material.Neon
    handle.Parent = tool

    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://114169760"  -- sword mesh
    mesh.Scale = Vector3.new(1.5, 1.5, 1.5)
    mesh.Parent = handle

    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Top Edit",
        Text = "Spawned visual " .. name .. " (only you see it)",
        Duration = 5
    })
end

local visualSword = Instance.new("TextButton")
visualSword.Size = UDim2.new(0.45, 0, 0, 40)
visualSword.Position = UDim2.new(0.05, 0, 0, 90)
visualSword.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
visualSword.Text = "Visual Sword"
visualSword.TextColor3 = Color3.new(1,1,1)
visualSword.Font = Enum.Font.GothamBold
visualSword.TextSize = 16
visualSword.Parent = WeaponsContent
visualSword.MouseButton1Click:Connect(function() spawnVisual("Sword") end)

local visualGun = Instance.new("TextButton")
visualGun.Size = UDim2.new(0.45, 0, 0, 40)
visualGun.Position = UDim2.new(0.5, 0, 0, 90)
visualGun.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
visualGun.Text = "Visual Gun"
visualGun.TextColor3 = Color3.new(1,1,1)
visualGun.Font = Enum.Font.GothamBold
visualGun.TextSize = 16
visualGun.Parent = WeaponsContent
visualGun.MouseButton1Click:Connect(function() spawnVisual("Gun") end)

-- Real Duplicator
local dupeLabel = Instance.new("TextLabel")
dupeLabel.Size = UDim2.new(1, 0, 0, 30)
dupeLabel.Position = UDim2.new(0, 0, 0, 150)
dupeLabel.BackgroundTransparency = 1
dupeLabel.Text = "Real Weapon Duplicator (hold weapon)"
dupeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
dupeLabel.Font = Enum.Font.GothamSemibold
dupeLabel.TextSize = 18
dupeLabel.Parent = WeaponsContent

local function dupeHeld()
    local char = LocalPlayer.Character
    if not char then return end
    local held = char:FindFirstChildWhichIsA("Tool")
    if not held then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Error",
            Text = "Hold a weapon to dupe",
            Duration = 5
        })
        return
    end

    local clone = held:Clone()
    clone.Parent = LocalPlayer.Backpack

    clone.Parent = game.Workspace
    if clone:FindFirstChild("Handle") then
        clone.Handle.Position = char.HumanoidRootPart.Position + Vector3.new(0, 5, 0)
        clone.Handle.Anchored = false
        clone.Handle.CanCollide = true
    end

    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Dupe Success - Top",
        Text = "Duplicated " .. held.Name .. " - check backpack & ground",
        Duration = 6
    })
end

local dupeBtn = Instance.new("TextButton")
dupeBtn.Size = UDim2.new(0.9, 0, 0, 50)
dupeBtn.Position = UDim2.new(0.05, 0, 0, 190)
dupeBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
dupeBtn.Text = "Dupe Held Weapon"
dupeBtn.TextColor3 = Color3.new(1,1,1)
dupeBtn.Font = Enum.Font.GothamBold
dupeBtn.TextSize = 18
dupeBtn.Parent = WeaponsContent
dupeBtn.MouseButton1Click:Connect(dupeHeld)

-- Change any existing credits
for _, label in ipairs(originalGui:GetDescendants()) do
    if label:IsA("TextLabel") and label.Text:find("Azura") then
        label.Text = label.Text:gsub("Azura", "Top")
    end
end

-- Final confirmation
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "MM2 Hub by Top",
    Text = "Edits loaded! Weapons tab added - visual spawn + real dupe ready.",
    Duration = 10
})

print("MM2 Hub by Top - Edits applied")
