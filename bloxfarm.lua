-- Blox Fruit Auto Ice Farm Script
-- เข้ากับเลเวลปัจจุบันของตัวละคร
local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ตรวจสอบเลเวล
local function getLevel()
    return player:FindFirstChild("Data") and player.Data:FindFirstChild("Level") and player.Data.Level.Value or 0
end

-- เลือกแมพตามเลเวล
local function selectMap(level)
    if level < 2000 then
        return "StarterIsland"
    elseif level < 5000 then
        return "MidIsland"
    else
        return "HighIsland"
    end
end

-- ใช้ Ice Skill
local function useIceSkill(target)
    if target and target:FindFirstChild("HumanoidRootPart") then
        ReplicatedStorage.Events.IceAttack:FireServer(target)
    end
end

-- ฟังก์ชันฟาร์มอัตโนมัติ
local function farm()
    while true do
        local level = getLevel()
        local map = selectMap(level)
        local monsters = workspace:FindFirstChild(map) and workspace[map]:GetChildren() or {}
        
        for _, mob in pairs(monsters) do
            if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                -- บินรอบมอนสเตอร์
                player.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0,5,0)
                useIceSkill(mob)
                wait(0.5) -- ปรับตามสกิล
            end
        end
        wait(1)
    end
end

-- เริ่มฟาร์ม
farm()
