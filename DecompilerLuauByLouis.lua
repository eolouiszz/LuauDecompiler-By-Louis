--========================================================================
-- [LOCAL SCRIPT] - RECON DECOMPILER PANEL V2.1
-- Author: Louis (://github.com)
-- Purpose: Cybersecurity Research & Code Auditing Utility
-- Target Environment: Xeno Executor / Modern Luau Environments
--========================================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

-- Environment Validation
if typeof(decompile) ~= "function" then
    warn([[
======================================================
[LOUIS-RECON ERROR]
Execution environment does not support 'decompile'.
Make sure you are running a high-tier executor (e.g., Xeno).
======================================================]])
    return
end

-- Clear existing GUI instances to prevent duplication
if player.PlayerGui:FindFirstChild("LouisReconDecompiler") then
    player.PlayerGui.LouisReconDecompiler:Destroy()
end

-- 1. MAIN INTERFACE CREATION (Cyberpunk Dark Theme)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LouisReconDecompiler"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 550, 0, 470)
frame.Position = UDim2.new(0.5, -275, 0.5, -235)
frame.BackgroundColor3 = Color3.fromRGB(11, 11, 14)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 6)
uiCorner.Parent = frame

-- Neon accent top bar
local topAccent = Instance.new("Frame")
topAccent.Size = UDim2.new(1, 0, 0, 3)
topAccent.BackgroundColor3 = Color3.fromRGB(0, 255, 150) -- Neon Mint
topAccent.BorderSizePixel = 0
topAccent.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 0, 0, 3)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Text = "  ⚡ Decompiler "
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.Code
title.TextSize = 15
title.Parent = frame

-- Footer Credit Stamp
local credits = Instance.new("TextLabel")
credits.Size = UDim2.new(1, -20, 0, 20)
credits.Position = UDim2.new(0, 10, 1, -22)
credits.BackgroundTransparency = 1
credits.TextColor3 = Color3.fromRGB(100, 100, 115)
credits.Text = "Developed by Louis (gh: eolouiszz)"
credits.TextXAlignment = Enum.TextXAlignment.Right
credits.Font = Enum.Font.Code
credits.TextSize = 11
credits.Parent = frame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -38, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(25, 20, 25)
closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 14
closeBtn.Parent = frame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 4)
closeCorner.Parent = closeBtn
closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

-- SEARCH FILTER INPUT
local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, -20, 0, 32)
searchBox.Position = UDim2.new(0, 10, 0, 50)
searchBox.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.PlaceholderText = "Filter by script name..."
searchBox.PlaceholderColor3 = Color3.fromRGB(80, 80, 90)
searchBox.Text = ""
searchBox.Font = Enum.Font.SourceSans
searchBox.TextSize = 14
searchBox.Parent = frame

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 4)
searchCorner.Parent = searchBox

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -20, 1, -125)
scroll.Position = UDim2.new(0, 10, 0, 95)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 4
scroll.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 150)
scroll.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 5)
layout.Parent = scroll

local rawScriptList = {}
local createdButtons = {}

-- 2. DISCOVERY & PRE-MAPPING PIPELINE
local function collectScripts(targetInstance)
    for _, obj in ipairs(targetInstance:GetDescendants()) do
        if obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
            if obj.Name == "LouisReconDecompiler" then continue end
            table.insert(rawScriptList, obj)
        end
    end
end

-- Gather scripts from all vulnerable environments
if player:FindFirstChild("PlayerGui") then collectScripts(player.PlayerGui) end
if player:FindFirstChild("PlayerScripts") then collectScripts(player.PlayerScripts) end
collectScripts(ReplicatedStorage)
collectScripts(Workspace)

-- ALPHABETICAL SORTING MECHANISM (A-Z)
table.sort(rawScriptList, function(a, b)
    return a.Name:lower() < b.Name:lower()
end)

-- 3. RENDER ORDERED BUTTONS TO THE PANEL
for _, obj in ipairs(rawScriptList) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    btn.TextColor3 = Color3.fromRGB(200, 200, 210)
    btn.Text = "  [" .. obj.ClassName:sub(1,6) .. "] " .. obj.Name
    btn.Font = Enum.Font.Code
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = scroll
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn
    
    table.insert(createdButtons, {Instance = btn, LowName = obj.Name:lower()})
    
    -- Extraction Pipeline Click Event
    btn.MouseButton1Click:Connect(function()
        btn.Text = "  ⚡ Decompiling..."
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 25)
        btn.TextColor3 = Color3.fromRGB(255, 200, 50)
        
        task.defer(function()
            local success, sourceCode = pcall(function() return decompile(obj) end)
            if success and sourceCode then
                if typeof(toclipboard) == "function" then
                    toclipboard(sourceCode)
                    btn.Text = "  ✓ Copied to Clipboard!"
                    btn.BackgroundColor3 = Color3.fromRGB(15, 40, 25)
                    btn.TextColor3 = Color3.fromRGB(50, 255, 150)
                else
                    -- Fallback print framework structured by Louis
                    print("\n=======================================================")
                    print("[LOUIS RECON EXTRACED SOURCE] -> " .. obj:GetFullName())
                    print("=======================================================\n")
                    print(sourceCode)
                    print("\n=======================================================\n")
                    btn.Text = "  ✓ Dumped to F9 Console"
                    btn.BackgroundColor3 = Color3.fromRGB(20, 30, 45)
                    btn.TextColor3 = Color3.fromRGB(100, 180, 255)
                end
            else
                btn.Text = "  Well, Well, Well: Decompilation Failed"
                btn.BackgroundColor3 = Color3.fromRGB(45, 20, 20)
                btn.TextColor3 = Color3.fromRGB(255, 100, 100)
            end
            
            task.wait(2.5)
            btn.Text = "  [" .. obj.ClassName:sub(1,6) .. "] " .. obj.Name
            btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
            btn.TextColor3 = Color3.fromRGB(200, 200, 210)
        end)
    end)
end

scroll.CanvasSize = UDim2.new(0, 0, 0, #createdButtons * 40)

-- SEARCH FILTER LOGIC (Maintains Alphabetical Structure)
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local filter = searchBox.Text:lower()
    local visibleCount = 0
    for _, item in ipairs(createdButtons) do
        if item.LowName:find(filter) then
            item.Instance.Visible = true
            visibleCount = visibleCount + 1
        else
            item.Instance.Visible = false
        end
    end
    scroll.CanvasSize = UDim2.new(0, 0, 0, visibleCount * 40)
end)

print([[

======================================================
    ⚡ By Louis 14/10/2026 ⚡
    Author GitHub: https://github.com/eolouiszz/
    Ready for auditing client-side assets.
======================================================
]])