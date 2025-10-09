-- CelestineHub
-- GUI Library by WindUI

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local script_url = "https://raw.githubusercontent.com/CelestineHub/C-Hub/refs/heads/main/BuildAZoo.lua"
local HttpService = game:GetService("HttpService")
local NewCode = ""

if not getgenv().CelestineHub then
    getgenv().CelestineHub = {}
end

local g = getgenv().CelestineHub

g.Players = game:GetService("Players")
g.ReplicatedStorage = game:GetService("ReplicatedStorage")
g.RunService = game:GetService("RunService")
g.LocalPlayer = g.Players.LocalPlayer
g.PetsFolder = g.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Data"):WaitForChild("Pets")
g.Remote = g.ReplicatedStorage:WaitForChild("Remote"):WaitForChild("CharacterRE")
g.player = g.LocalPlayer
g.TeleportService = game:GetService("TeleportService")
g.TweenService = game:GetService("TweenService")
g.EggsFolder = g.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Data"):WaitForChild("Egg")
g.userId = game:GetService("Players").LocalPlayer.UserId
g.AutoCoin = false
g.AutoFishing = false
g.CoinDelay = 10
g.FishingPos = nil
g.FBait = "FishingBait3"
g.FishFarmSnow = false
g.SavedCFrame = nil
g.SelectedPotion = "Potion_Coin"
g.AutoUsePotion = false
g.AutoGift = false
g.AutoGiftThread = nil
g.WasAutoFishing = false
g.WasGifting = false
g.SnowWasLost = false
g.SelectedFruits = {}
g.SelectedEggs = {}
g.SelectedMutations = {}
g.SelectedItem = "Pet"
g.SelectedTickets = 1
g.AutoFruits = false
g.AutoEggs = false
g.AutoTickets = false
g.MyIsland = ""
g.eggName = "Unknown"
g.eggMutate = "None"
g.SelectedPet = ""
g.SelectedFeed = ""
g.AutoFeed = false
g.SelectedPlayer = ""
g.SelectedUserId = nil
g.AutoLike = false
g.AutoGiftThread = nil
g.SelectedEggsG = {}
g.SelectedMutationsG = {}
g.EggList = {
    "AnglerfishEgg","BasicEgg","BoneDragonEgg","BowserEgg","CornEgg","DarkGoatyEgg","DemonEgg","EpicEgg",
    "GeneralKongEgg","HyperEgg","LegendEgg","LionfishEgg","OctopusEgg", "PegasusEgg", "PrismaticEgg","RareEgg","RhinoRockEgg",
    "SaberCubEgg","SailfishEgg","SharkEgg","SnowbunnyEgg","SuperRareEgg","UltraEgg","UnicornEgg","UnicornProEgg","VoidEgg"
}
g.MutationList = {"None","Golden","Diamond","Electric","Fire","Dino","Snow"}
g.SetSpeed = 29
g.SetJump = 9
g.FlyMode = false
g.FlySpeed = 50
g.FlyConnection = nil
g.FlyGyro = nil
g.FlyVel = nil
g.NoClip = false
g.NoClipConnection = nil
g.WebhookUrl = ""
g.SendWebhook = false
g.AutoRejoin = false
g.AutoRejoinDelay = 900
g.CurrentInstanceId = ""
g.AutoGiftPaused = false
g.SelectedSellEggs = {}
g.SelectedSellMutations = {}
g.AutoSellEggs = false
g.AutoHatch = false
g.LessCoin = 0

local Window = WindUI:CreateWindow({
    Title = "CelestineHub",
    Icon = "door-open",
    Author = "Mapu",
    Folder = "CelestineHub",
    
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,

    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
        end
    },
    
    KeySystem = {
        Note = "30 Hours Key System",
        API = {
            {
                Type = "pandadevelopment",
                ServiceId = "celestinehub",
            },
        },
    },
})

Window.User:SetAnonymous(false)
Window:SetIconSize(30)
Window:CreateTopbarButton("theme-switcher", "moon", function()
    WindUI:SetTheme(WindUI:GetCurrentTheme() == "Dark" and "Light" or "Dark")
    WindUI:Notify({
        Title = "Theme Changed",
        Content = "Current theme: "..WindUI:GetCurrentTheme(),
        Duration = 2
    })
end, 990)

local Sections = {
    Info = Window:Section({ Title = "Info", Opened = true }),
    Main = Window:Section({ Title = "Features", Opened = false }),
    Settings = Window:Section({ Title = "Settings", Opened = false }),
}

local Tabs = {
    Auth = Sections.Info:Tab({ Title = "Author", Icon = "contact" }),
    Script = Sections.Info:Tab({ Title = "Script", Icon = "file-code" }),
    Farm = Sections.Main:Tab({ Title = "Farm", Icon = "circle-dollar-sign" }),
    Shop = Sections.Main:Tab({ Title = "Shop", Icon = "shopping-bag" }),
    Pets = Sections.Main:Tab({ Title = "Pets", Icon = "cat" }),
    More = Sections.Main:Tab({ Title = "More", Icon = "sparkle" }),
    Misc = Sections.Main:Tab({ Title = "Misc", Icon = "wrench" }),
    Theme = Sections.Settings:Tab({ Title = "Theme", Icon = "swatch-book" }),
    Config = Sections.Settings:Tab({ Title = "Config", Icon = "columns-3-cog" }),
}

Tabs.Auth:Section({
    Title = "CelestineHub",
    TextSize = 20,
})

Tabs.Auth:Section({
    Title = "Build a Zoo Script",
    TextSize = 16,
    TextTransparency = .25,
})

Tabs.Auth:Divider()

local Social = Tabs.Auth:Section({
    Title = "Social",
    Icon = "globe",
    Opened = true,
})

local YouTube = Social:Paragraph({
    Title = "YouTube",
    Desc = "Subs and watch the scripts preview",
    Color = "Red",
    Locked = false,
    Buttons = {
        {
            Icon = "copy",
            Title = "Subscribe",
            Callback = function() setclipboard("https://youtube.com/@mapumaukaya") end,
        }
    }
})

local Discord = Social:Paragraph({
    Title = "Discord Server",
    Desc = "» Sharing discussion\n» Get new info faster\n» Report bug",
    Color = "Blue",
    Locked = false,
    Buttons = {
        {
            Icon = "copy",
            Title = "Join",
            Callback = function() setclipboard("https://discord.gg/Jw7XN2aDK") end,
        }
    }
})

Tabs.Auth:Divider()

local Support = Tabs.Auth:Section({
    Title = "Support",
    Icon = "banknote-arrow-up",
})

local Donate = Support:Paragraph({
    Title = "SociaBuzz",
    Desc = "Help me to keep the scripts up to date",
    Color = "Green",
    Locked = false,
    Buttons = {
        {
            Icon = "copy",
            Title = "Donate",
            Callback = function() setclipboard("https://sociabuzz.com/celestinemapu/support") end,
        }
    }
})

local Buy = Support:Paragraph({
    Title = "Lifetime Key",
    Desc = "Support me by buy Lifetime Key",
    Color = "Orange",
    Locked = false,
    Buttons = {
        {
            Icon = "copy",
            Title = "Buy",
            Callback = function() setclipboard("https://discord.gg/GSRgsWxS") end,
        }
    }
})

Tabs.Script:Paragraph({
    Title = "What's New",
    Desc = "» Egg Monitor\n» Auto Sell Selected Eggs\n» Auto Hatch All Eggs\n» Auto Dupe\n» Fixed for PC",
    Image = "code",
    ImageSize = 20,
    Color = "White"
})

Tabs.Script:Divider()

Tabs.Script:Code({
    Title = "Build a Zoo",
    Code = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/CelestineHub/C-Hub/refs/heads/main/BuildAZoo.lua"))()]],
    OnCopy = function()
    end
})

Tabs.Script:Code({
    Title = "Fish It",
    Code = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/CelestineHub/C-Hub/refs/heads/main/FishIt.lua"))()]],
    OnCopy = function()
    end
})

Tabs.Script:Code({
    Title = "More",
    Code = [[soon!]],
    OnCopy = function()
    end
})

function ClaimCoin()
    local folder = workspace:FindFirstChild("Pets")
    if not folder then return end

    local myUserId = g.LocalPlayer.UserId
    local listChild = {}

    for _, v in ipairs(folder:GetChildren()) do
        if v:GetAttribute("UserId") == myUserId then
            table.insert(listChild, v.Name)
        end
    end

    for _, childName in ipairs(listChild) do
        local success, err = pcall(function()
            local pet = folder:FindFirstChild(childName)
            if pet and pet:FindFirstChild("RootPart") and pet.RootPart:FindFirstChild("RE") then
                pet.RootPart.RE:FireServer("Claim")
            end
        end)
    end
end

local function Fishing()
    local remote = g.ReplicatedStorage:FindFirstChild("Remote")
    if not remote then return end

    local charRE = remote:FindFirstChild("CharacterRE")
    local fishRE = remote:FindFirstChild("FishingRE")
    if not charRE or not fishRE then return end

    charRE:FireServer("Focus", "FishRob")
    task.wait(0.5)
    fishRE:FireServer("Start")
    task.wait(0.5)
    fishRE:FireServer("Throw", { Bait = g.FBait, Pos = g.FishingPos.Position })
    task.wait(0.5)
    fishRE:FireServer("POUT", { SUC = 1 })
end

function UsePotion()
    local success, err = pcall(function()
        local ShopRE = g.ReplicatedStorage:WaitForChild("Remote"):WaitForChild("ShopRE")
        ShopRE:FireServer("UsePotion", g.SelectedPotion)
    end)
end

local function CountAndDisplayEggs()
    local eggCounts = {}
    
    for _, child in ipairs(g.EggsFolder:GetChildren()) do
        -- Hanya proses child yang tidak memiliki subchild (telur yang belum ditetaskan)
        if #child:GetChildren() == 0 then
            local eggType = child:GetAttribute("T") or "Unknown"
            local eggMutation = child:GetAttribute("M")
            
            if eggMutation == nil then
                eggMutation = "Normal"
            end
            
            local key = eggType .. "_" .. eggMutation
            
            if not eggCounts[key] then
                eggCounts[key] = {
                    type = eggType,
                    mutation = eggMutation,
                    count = 0
                }
            end
            
            eggCounts[key].count = eggCounts[key].count + 1
        end
    end
    
    local displayText = ""
    
    if next(eggCounts) == nil then
        displayText = "No eggs found in inventory"
    else
        local sortedEggs = {}
        for _, data in pairs(eggCounts) do
            table.insert(sortedEggs, data)
        end
        
        table.sort(sortedEggs, function(a, b)
            return a.type < b.type
        end)
        
        for _, data in ipairs(sortedEggs) do
            displayText = displayText .. string.format("[%s] %s = %d\n", data.mutation, data.type, data.count)
        end
    end
    
    return displayText
end

Tabs.Farm:Paragraph({
    Title = "Farm section",
    Desc = "Easy to collect and farm",
    Image = "hand-coins",
    ImageSize = 20,
    Color = "White"
})

Tabs.Farm:Divider()

Tabs.Farm:Button({
    Title = "Collect All Coins",
    Icon = "mouse-pointer-click",
    Callback = function()
        ClaimCoin()
    end
})

local ClaimDelay = Tabs.Farm:Slider({
    Title = "Claim Delay",
    Desc = "",
    Value = { Min = 5, Max = 360, Default = g.CoinDelay },
    Callback = function(value)
        g.CoinDelay = value
    end
})

local ACoin = Tabs.Farm:Toggle({
    Title = "Auto Claim Coins",
    Desc = "",
    Value = g.AutoCoin,
    Callback = function(state)
        g.AutoCoin = state
        if g.AutoCoin then
            task.spawn(function()
                while g.AutoCoin do
                    ClaimCoin()
                    task.wait(g.CoinDelay)
                end
            end)        
        end
    end
})

Tabs.Farm:Divider()

local FishingBait = Tabs.Farm:Dropdown({
    Title = "Fishing Bait",
    Values = {"FishingBait1","FishingBait2","FishingBait3"},
    SearchBarEnabled = false,
    MenuWidth = 280,
    Value = g.FBait,
    Callback = function(bait)
        g.FBait = bait
    end
})

Tabs.Farm:Button({
    Title = "Save Fishing Position",
    Icon = "mouse-pointer-click",
    Callback = function()
        local character = g.LocalPlayer.Character or g.LocalPlayer.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        g.FishingPos = humanoidRootPart.CFrame
        WindUI:Notify({
            Title = "Position Saved",
            Content = "Fishing Position Saved!",
            Icon = "save",
            Duration = 1
        })
    end
})

local AFishing = Tabs.Farm:Toggle({
    Title = "Auto Fishing",
    Value = g.AutoFishing,
    Callback = function(state)
        g.AutoFishing = state

        if g.AutoFishing and g.FBait ~= nil then
            task.spawn(function()
                while g.AutoFishing do
                    local character = g.LocalPlayer.Character or g.LocalPlayer.CharacterAdded:Wait()
                    local hrp = character:WaitForChild("HumanoidRootPart")
                    hrp.CFrame = g.FishingPos
                    hrp.Anchored = true
                    Fishing()
                    task.wait(3)
                end
            end)
        else
            AFishing:Set(false)
            local args = {"Focus"}
            game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("CharacterRE"):FireServer(unpack(args))
            local character = g.LocalPlayer.Character or g.LocalPlayer.CharacterAdded:Wait()
            local hrp = character:WaitForChild("HumanoidRootPart")
            hrp.Anchored = false
            WindUI:Notify({
            Title = "Position?",
            Content = "Save Position First!",
            Icon = "save",
            Duration = 2
            })
            local character = g.LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.Anchored = false
            end
        end
    end
})

local AFishSnow = Tabs.Farm:Toggle({
    Title = "Auto Fishing Snow",
    Value = false,
    Callback = function(state)
        g.FishFarmSnow = state

        if not state then
            local char = g.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.Anchored = false
            end
        end
    end
})

task.spawn(function()
    while task.wait(1) do
        if g.FishFarmSnow then
            local fishPoints = workspace:FindFirstChild("FishPoints")
            if not fishPoints then continue end

            local activeScope = nil
            for _, point in ipairs(fishPoints:GetChildren()) do
                local fx = point:FindFirstChild("FX_Fish_Special")
                local scope = fx and fx:FindFirstChild("Scope")
                if scope then
                    activeScope = scope
                    break
                end
            end

            if activeScope then
                if g.SnowWasLost then
                    g.SnowWasLost = false
                    g.WasAutoFishing = g.AutoFishing
                    g.WasGifting = g.AutoGift

                    g.AutoGiftPaused = true
                    if g.AutoGiftThread then
                        pcall(task.cancel, g.AutoGiftThread)
                        g.AutoGiftThread = nil
                    end

                    g.AutoFishing = false
                end

                local pos = activeScope.Position + Vector3.new(0, 2, 0)
                local char = g.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local hrp = char.HumanoidRootPart
                    hrp.CFrame = CFrame.new(pos, pos + activeScope.CFrame.LookVector)
                    hrp.Anchored = true
                end

                local remote = g.ReplicatedStorage:FindFirstChild("Remote")
                if remote then
                    local charRE = remote:FindFirstChild("CharacterRE")
                    local fishRE = remote:FindFirstChild("FishingRE")
                    if charRE and fishRE then
                        charRE:FireServer("Focus", "FishRob")
                        task.wait(0.5)
                        fishRE:FireServer("Start")
                        task.wait(0.5)
                        fishRE:FireServer("Throw", { Bait = g.FBait, Pos = pos })
                        task.wait(1)
                        fishRE:FireServer("POUT", { SUC = 1 })
                    end
                end
            else
                if not g.SnowWasLost then
                    g.SnowWasLost = true
                    local char = g.LocalPlayer.Character or g.LocalPlayer.CharacterAdded:Wait()
                    local hrp = char:WaitForChild("HumanoidRootPart")
                    hrp.Anchored = false

                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid.Health = 0
                    else
                    char:BreakJoints()
                    end

                    local newChar = g.LocalPlayer.CharacterAdded:Wait()
                    local newHrp = newChar:WaitForChild("HumanoidRootPart")
                    newHrp.Anchored = false

                    if g.WasAutoFishing then g.AutoFishing = true end

                    if g.WasGifting then
                        g.AutoGiftPaused = false
                        g.AutoGift = true
                        AutoGiftLoop()
                    end
                end
            end
        elseif g.AutoFishing then
            local char = g.LocalPlayer.Character or g.LocalPlayer.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")
            if g.FishingPos then
                hrp.CFrame = g.FishingPos
                hrp.Anchored = true
                Fishing()
            else
                hrp.Anchored = false
                WindUI:Notify({ Title = "Position?", Content = "Save Position First!", Icon = "save", Duration = 2 })
                g.AutoFishing = false
            end
        else
            local char = g.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.Anchored = false
            end
        end
    end
end)

Tabs.Farm:Divider()

local Potion = Tabs.Farm:Dropdown({
    Title = "Potion",
    Values = { "Potion_Luck", "Potion_Coin", "Potion_Hatch", "Potion_3in1" },
    Value = g.SelectedPotion,
    Callback = function(selected)
        g.SelectedPotion = selected
    end,
})

local APotion = Tabs.Farm:Toggle({
    Title = "Auto Use Potion",
    Default = false,
    Callback = function(state)
        g.AutoUsePotion = state
        if g.AutoUsePotion then
            task.spawn(function()
                while g.AutoUsePotion do
                    UsePotion()
                    task.wait(300)
                end
            end)
        end
    end,
})

Tabs.Farm:Divider()

local EggCounterParagraph = Tabs.Farm:Paragraph({
    Title = "Egg Monitor",
    Desc = "Counting eggs...",
    Image = "egg",
    ImageSize = 20,
    Color = "White"
})

local function UpdateEggCounter()
    local eggInfo = CountAndDisplayEggs()
    EggCounterParagraph:SetDesc(eggInfo)
end

task.spawn(function()
    while task.wait(2) do
        UpdateEggCounter()
    end
end)

local function contains(tbl, val)
    if not tbl then return false end
    for _, v in ipairs(tbl) do
        if v == val then
            return true
        end
    end
    return false
end

function SendEggLog()
    if not g.SendWebhook then 
        return 
    end
    
    if g.WebhookUrl == "" or string.sub(g.WebhookUrl, 1, 4) ~= "http" then 
        WindUI:Notify({
            Title = "Webhook Error",
            Content = "URL not valid!",
            Duration = 5
        })
        return 
    end
    
    if g.eggName == "Unknown" then
        return
    end
    
    local embedData = {
        {
            title = "🥚 Egg Purchased Notification",
            description = "New egg purchased in Build a Zoo!",
            color = 16763904,
            fields = {
                {
                    name = "👤 Player",
                    value = "```" .. g.LocalPlayer.Name .. "```",
                    inline = true
                },
                {
                    name = "🔮 User ID", 
                    value = "```" .. tostring(g.LocalPlayer.UserId) .. "```",
                    inline = true
                },
                {
                    name = "🥚 Egg Name", 
                    value = "```" .. tostring(g.eggName) .. "```",
                    inline = true
                },
                {
                    name = "✨ Mutation",
                    value = "```" .. tostring(g.eggMutate) .. "```", 
                    inline = true
                },
                {
                    name = "🕒 Time",
                    value = "```" .. os.date("%Y-%m-%d %H:%M:%S") .. "```",
                    inline = false 
                }
            },
            footer = {
                text = "CelestineHub • Build a Zoo"
            },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }
    }
    
    local data = {
        content = "",
        embeds = embedData,
        username = "CelestineHub Notifier",
        avatar_url = "https://i.postimg.cc/05KMwhzz/20250818-104205.jpg"
    }

    local success, result = pcall(function()
        local HttpService = game:GetService("HttpService")
        local jsonData = HttpService:JSONEncode(data)
        
        local httpRequest
        if syn and syn.request then
            httpRequest = syn.request
        elseif request then
            httpRequest = request
        elseif http and http.request then
            httpRequest = http.request
        elseif http_request then
            httpRequest = http_request
        else
            error("Tidak ada metode HTTP request yang tersedia")
        end
        
        local response = httpRequest({
            Url = g.WebhookUrl,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = jsonData
        })
        
        if response.Success then
            return true
        else
            return false
        end
    end)
end

function BuyFruit()
    for _, fruitName in ipairs(g.SelectedFruits) do
        local success, err = pcall(function()
            g.ReplicatedStorage:WaitForChild("Remote"):WaitForChild("FoodStoreRE"):FireServer(fruitName)
        end)
    end
end

local function ScanMyIsland()
    local artFolder = workspace:FindFirstChild("Art")
    if not artFolder then return end

    for _, island in ipairs(artFolder:GetChildren()) do
        local occId = island:GetAttribute("OccupyingPlayerId")
        if occId and occId == g.LocalPlayer.UserId then
            g.MyIsland = island.Name
            break
        end
    end
end

local function GetBuyId()
    if g.MyIsland == "" then 
        return nil 
    end

    local eggsFolder = g.ReplicatedStorage:FindFirstChild("Eggs")
    if not eggsFolder then 
        return nil 
    end

    local myEggsFolder = eggsFolder:FindFirstChild(g.MyIsland)
    if not myEggsFolder then 
        return nil 
    end

    local foundEggId = nil
    local tempEggName = "Unknown"
    local tempEggMutate = "None"

    for _, egg in ipairs(myEggsFolder:GetChildren()) do
        local tVal = egg:GetAttribute("T")
        local mVal = egg:GetAttribute("M") or "None"

        if g.SelectedEggs and contains(g.SelectedEggs, tVal) then
            if g.SelectedMutations and #g.SelectedMutations > 0 then
                if contains(g.SelectedMutations, mVal) then
                    tempEggName = tVal
                    tempEggMutate = mVal
                    foundEggId = egg.Name
                    break
                elseif contains(g.SelectedMutations, "None") and mVal == "None" then
                    tempEggName = tVal
                    tempEggMutate = "None"
                    foundEggId = egg.Name
                    break
                end
            else
                tempEggName = tVal
                tempEggMutate = mVal
                foundEggId = egg.Name
                break
            end
        end
    end

    if foundEggId then
        g.eggName = tempEggName
        g.eggMutate = tempEggMutate
    end

    return foundEggId
end

local function BuyEgg()
    local success, err = pcall(function()
        if g.MyIsland == "" then
            ScanMyIsland()
            if g.MyIsland == "" then
                return
            end
        end

        local buyId = GetBuyId()
        
        if buyId then
            SendEggLog()
            local args = { "BuyEgg", buyId }
            g.ReplicatedStorage:WaitForChild("Remote"):WaitForChild("CharacterRE"):FireServer(unpack(args))
        end
    end)
end

function SellItem()
    local remoteFolder = g.ReplicatedStorage:WaitForChild("Remote")
    local remote = remoteFolder:WaitForChild("PetRE")

    if not g.SelectedItem or g.SelectedItem == "" then
        return
    end

    local success, err = pcall(function()
        if g.SelectedItem == "All" then
            remote:FireServer("SellAll", "All", "All")
        else
            remote:FireServer("SellAll", "All", g.SelectedItem)
        end
    end)
end

function Gacha()
    local args = {{event = "lottery", count = g.SelectedTickets}}
    game:GetService("ReplicatedStorage")
    :WaitForChild("Remote")
    :WaitForChild("LotteryRE")
    :FireServer(unpack(args))
end

function SellSelectedEggs()
    local soldCount = 0
    
    for _, child in ipairs(g.EggsFolder:GetChildren()) do
        local eggType = child:GetAttribute("T") or ""
        local eggMutation = child:GetAttribute("M")
        
        if eggMutation == nil then
            eggMutation = "None"
        end
        
        local typeMatch = false
        for _, selectedEgg in ipairs(g.SelectedSellEggs) do
            if string.find(eggType, selectedEgg) then
                typeMatch = true
                break
            end
        end
        
        local mutationMatch = false
        for _, selectedMutation in ipairs(g.SelectedSellMutations) do
            if selectedMutation == "None" then
                if eggMutation == "None" then
                    mutationMatch = true
                    break
                end
            elseif string.find(eggMutation, selectedMutation) then
                mutationMatch = true
                break
            end
        end
        
        if typeMatch and mutationMatch then
            local success, err = pcall(function()
                local args = {
                    "Sell",
                    child.Name,
                    true
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("PetRE"):FireServer(unpack(args))
                soldCount = soldCount + 1
            end)
        end
    end
    
    if soldCount > 0 then
        
    else
        
       
    end
end

Tabs.Shop:Paragraph({
    Title = "Shop section",
    Desc = "Easy to get by remotely",
    Image = "store",
    ImageSize = 20,
    Color = "White"
})

Tabs.Shop:Divider()

local Fruits = Tabs.Shop:Dropdown({
    Title = "Fruits",
    Values = {"Strawberry","Blueberry","Watermelon","Apple","Orange","Corn","Banana","Grape","Pear","Pineapple","DragonFruit","GoldMango","BloodstoneCycad","ColossalPinecone","VoltGinkgo","DeepseaPearlFruit","Durian"},
    SearchBarEnabled = true,
    MenuWidth = 280,
    Value = g.SelectedFruits,
    Multi = true,
    Callback = function(selected)
        g.SelectedFruits = selected
    end
})

local AFruits = Tabs.Shop:Toggle({
    Title = "Auto Buy Fruits",
    Desc = "",
    Value = g.AutoFruits,
    Callback = function(state)
        g.AutoFruits = state
        task.spawn(function()
                while g.AutoFruits do
                    BuyFruit()
                    task.wait(60)
                end
            end)
    end
})

Tabs.Shop:Divider()

local Eggs = Tabs.Shop:Dropdown({
    Title = "Eggs",
    Values = {"BasicEgg","BoneDragonEgg","BowserEgg","CornEgg","DarkGoatyEgg","DemonEgg","EpicEgg", "GeneralKongEgg","HyperEgg","LegendEgg","PrismaticEgg","RareEgg","RhinoRockEgg","SaberCubEgg", "SnowbunnyEgg","SuperRareEgg","UltraEgg","UnicornEgg","UnicornProEgg","VoidEgg"},
    SearchBarEnabled = true,
    MenuWidth = 280,
    Value = {},
    Multi = true,
    Callback = function(selected)
        g.SelectedEggs = selected
    end
})

local Mutations = Tabs.Shop:Dropdown({
    Title = "Mutations",
    Values = {"None","Golden","Diamond","Electirc","Fire","Dino","Snow"},
    SearchBarEnabled = true,
    MenuWidth = 280,
    Value = {},
    Multi = true,
    Callback = function(selected)
        g.SelectedMutations = selected
    end
})

local AEggs = Tabs.Shop:Toggle({
    Title = "Auto Buy Eggs",
    Desc = "Unselect none if u want mutation",
    Default = false,
    Callback = function(state)
        g.AutoEggs = state
        if g.AutoEggs then
            ScanMyIsland()
            task.spawn(function()
                while g.AutoEggs do
                    BuyEgg()
                    task.wait(2)
                end
            end)
        end
    end,
})

Tabs.Shop:Divider()

local SellEggsDropdown = Tabs.Shop:Dropdown({
    Title = "Eggs",
    Values = g.EggList,
    Multi = true,
    Default = {},
    Callback = function(values)
        g.SelectedSellEggs = values or {}
    end
})

local SellMutationsDropdown = Tabs.Shop:Dropdown({
    Title = "Mutations",
    Values = g.MutationList,
    Multi = true,
    Default = {"None"},
    Callback = function(values)
        g.SelectedSellMutations = values or {}
    end
})

Tabs.Shop:Button({
    Title = "Sell Selected Eggs",
    Icon = "mouse-pointer-click",
    Callback = function()
        SellSelectedEggs()
    end
})

local AutoSellEggsToggle = Tabs.Shop:Toggle({
    Title = "Auto Sell Eggs",
    Value = g.AutoSellEggs,
    Callback = function(state)
        g.AutoSellEggs = state
        if g.AutoSellEggs then
            task.spawn(function()
                while g.AutoSellEggs do
                    SellSelectedEggs()
                    task.wait(2)
                end
            end)
        end
    end
})

Tabs.Shop:Divider()

local Selli = Tabs.Shop:Dropdown({
    Title = "Item",
    Values = {"All","Pet","Egg"},
    SearchBarEnabled = false,
    MenuWidth = 280,
    Value = "Pet",
    Callback = function(item)
        g.SelectedItem = item
    end
})

Tabs.Shop:Button({
    Title = "Sell Selected Item",
    Icon = "mouse-pointer-click",
    Callback = function()
        SellItem()
    end
})

Tabs.Shop:Divider()

local Tickets = Tabs.Shop:Dropdown({
    Title = "Tickets",
    Values = {1,3,10},
    SearchBarEnabled = false,
    MenuWidth = 280,
    Value = 1,
    Callback = function(tickets)
        g.SelectedTickets = tickets
    end
})

local ATickets = Tabs.Shop:Toggle({
    Title = "Auto Gacha Tickets",
    Desc = "",
    Value = g.AutoTickets,
    Callback = function(state)
        g.AutoTickets = state
        if g.AutoTickets then
            task.spawn(function()
                while g.AutoTickets do
                    Gacha()
                    task.wait(1)
                end
            end)
        end
    end
})

local function GetBigPet()
    local list = {}
    for _, pet in ipairs(g.PetsFolder:GetChildren()) do
        local bpskValue = pet:GetAttribute("BPSK")
        if bpskValue then
            table.insert(list, bpskValue)
        end
    end
    return list
end

function FeedFruit()
    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("DeployRE"):FireServer({event = "deploy",uid = g.SelectedFeed})
    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("CharacterRE"):FireServer("Focus",g.SelectedFeed)
end

function FeedPet()
    local args = {"Feed",g.SelectedPet}
    g.ReplicatedStorage:WaitForChild("Remote"):WaitForChild("PetRE"):FireServer(unpack(args))
end

local function RecallNonBPSKPets()
    for _, pet in ipairs(g.PetsFolder:GetChildren()) do
        if pet:GetAttribute("BPSK") == nil then
            local args = {
                "Del",
                pet.Name
            }
            g.Remote:FireServer(unpack(args))
        end
    end
end

local function AutoHatchScan()
    local builtBlocks = workspace:FindFirstChild("PlayerBuiltBlocks")
    if not builtBlocks then return end

    local myUserId = g.LocalPlayer.UserId
    local hatchTargets = {}

    for _, folder in ipairs(builtBlocks:GetChildren()) do
        if folder:GetAttribute("UserId") == myUserId then
            local exMark = folder:FindFirstChild("ExclamationMark")
            local root = folder:FindFirstChild("RootPart")
            if exMark and root then
                local rf = root:FindFirstChild("RF")
                if rf and rf:IsA("RemoteFunction") then
                    table.insert(hatchTargets, rf)
                end
            end
        end
    end

    for _, rf in ipairs(hatchTargets) do
        task.spawn(function()
            pcall(function()
                rf:InvokeServer("Hatch")
            end)
        end)
        task.wait(0.05)
    end
end

Tabs.Pets:Paragraph({
    Title = "Pets section",
    Desc = "Take care of your pets easily",
    Image = "paw-print",
    ImageSize = 20,
    Color = "White"
})

Tabs.Pets:Divider()

local AHatch = Tabs.Pets:Toggle({
    Title = "Auto Hatch Eggs",
    Value = g.AutoHatch,
    Callback = function(state)
        g.AutoHatch = state
        if g.AutoHatch then
            task.spawn(function()
                while g.AutoHatch do
                    AutoHatchScan()
                    task.wait(2)
                end
            end)
        end
    end
})

Tabs.Pets:Divider()

local BigPet = Tabs.Pets:Dropdown({
    Title = "Big Pet",
    Values = GetBigPet(),
    SearchBarEnabled = false,
    MenuWidth = 280,
    Value = g.SelectedPet,
    Callback = function(bpet)
        for _, pet in ipairs(g.PetsFolder:GetChildren()) do
            if pet:GetAttribute("BPSK") == bpet then
                g.SelectedPet = pet.Name
                break
            end
        end
    end
})

local Feed = Tabs.Pets:Dropdown({
    Title = "Feed",
    Values = {"Strawberry","Blueberry","Watermelon","Apple","Orange","Corn","Banana","Grape","Pear","Pineapple","DragonFruit","GoldMango","BloodstoneCycad","ColossalPinecone","VoltGinkgo","DeepseaPearlFruit","Durian"},
    SearchBarEnabled = true,
    MenuWidth = 280,
    Value = g.SelectedFeed,
    Callback = function(feed)
        g.SelectedFeed = feed
    end
})

local AFeed = Tabs.Pets:Toggle({
    Title = "Auto Feed Big Pet",
    Desc = "",
    Value = g.AutoFeed,
    Callback = function(state)
        g.AutoFeed = state
        FeedFruit()
        if g.AutoFeed then
            if g.SelectedFeed then
                task.spawn(function()
                    while g.AutoFeed do
                        FeedPet()
                        task.wait(60)
                    end
                end)
            end
        end
    end
})

Tabs.Pets:Divider()

local LessVal = Tabs.Pets:Input({
    Title = "Coin",
    Default = "",
    Placeholder = "0",
    Callback = function(value)
        g.LessCoin = tonumber(value)
    end
})

Tabs.Pets:Button({
    Title = "Recall Less than Coin",
    Icon = "mouse-pointer-click",
    Callback = function()
        local PetsFolder = workspace:FindFirstChild("Pets")
        if not PetsFolder then
            WindUI:Notify({
                Title = "Error",
                Content = "Folder doesn't found!",
                Icon = "x",
                Duration = 3
            })
            return
        end

        local myUserId = g.LocalPlayer.UserId
        local recalledCount = 0

        for _, pet in ipairs(PetsFolder:GetChildren()) do
            if pet:GetAttribute("UserId") == myUserId then
                local root = pet:FindFirstChild("RootPart")
                if root and root:GetAttribute("ProduceSpeed") then
                    local ps = tonumber(root:GetAttribute("ProduceSpeed"))
                    if ps and ps < g.LessCoin then
                        local args = {
                            "Del",
                            pet.Name
                        }
                        g.ReplicatedStorage:WaitForChild("Remote"):WaitForChild("CharacterRE"):FireServer(unpack(args))
                        recalledCount += 1
                        task.wait(0.1)
                    end
                end
            end
        end

        WindUI:Notify({
            Title = "Recall Successfully",
            Content = "Pets: " .. recalledCount .. " With Less Than: " .. ProduceSpeedInputValue,
            Icon = "check",
            Duration = 3
        })
    end
})

Tabs.Pets:Button({
    Title = "Recall All Pets",
    Icon = "mouse-pointer-click",
    Callback = function()
        RecallNonBPSKPets()
    end,
})

local function GetPlayersList()
    local players = {}
    for _, plr in ipairs(g.Players:GetPlayers()) do
        if plr ~= g.LocalPlayer then
            table.insert(players, plr.Name .. " (" .. plr.UserId .. ")")
        end
    end
    return players
end

function Like()
    g.ReplicatedStorage:WaitForChild("Remote"):WaitForChild("CharacterRE"):FireServer("GiveLike", g.SelectedUserId)
end

function Tele()
    if not g.SelectedPlayer or g.SelectedPlayer == "" then
        return
    end

    local targetModel = workspace:FindFirstChild(g.SelectedPlayer)
    if not targetModel then
        return
    end

    local head = targetModel:FindFirstChild("Head")
    if not head then
        return
    end

    local headCFrame = head.CFrame

    local character = g.LocalPlayer.Character or g.LocalPlayer.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    hrp.CFrame = headCFrame
end

function GiftPlayer()
    game.ReplicatedStorage.Remote.GiftRE:FireServer(g.Players:WaitForChild(g.SelectedPlayer))
end

function Redeem()
    local args = {{event = "usecode",code = NewCode}}
    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("RedemptionCodeRE"):FireServer(unpack(args))
end

Tabs.More:Paragraph({
    Title = "More section",
    Desc = "Useful features isn't?",
    Image = "sparkles",
    ImageSize = 20,
    Color = "White"
})

Tabs.More:Divider()

local User = Tabs.More:Dropdown({
    Title = "Player",
    Values = GetPlayersList(),
    SearchBarEnabled = true,
    MenuWidth = 280,
    Value = "",
    Callback = function(user)
        local Name, UserId = string.match(user or "", "^(.-) %((%d+)%)$")
        if Name and UserId then
            g.SelectedPlayer = Name
            g.SelectedUserId = tonumber(UserId)
        else
            g.SelectedPlayer = ""
            g.SelectedUserId = nil
        end
    end,
})

Tabs.More:Button({
    Title = "Like Player's Plot",
    Icon = "mouse-pointer-click",
    Callback = function()
        Like()
    end
})

local ALike = Tabs.More:Toggle({
    Title = "Auto Like Player's Plot",
    Desc = "",
    Value = g.AutoLike,
    Callback = function(state)
        g.AutoLike = state
        if g.AutoLike then
            task.spawn(function()
                while g.AutoLike do
                    if g.SelectedPlayer and g.SelectedUserId then
                        Like()
                    end
                    task.wait(30)
                end
            end)
        end
    end
})

Tabs.More:Button({
    Title = "TP and Gift to Player",
    Desc = "Hold item to gift",
    Icon = "mouse-pointer-click",
    Callback = function()
        Tele()
        task.wait(1.5)
        GiftPlayer()
    end
})

local SelEgg = Tabs.More:Dropdown({
    Title = "Eggs",
    Values = g.EggList,
    Multi = true,
    Default = {},
    Callback = function(values)
        g.SelectedEggsG = values or {}
    end
})

local SelMut = Tabs.More:Dropdown({
    Title = "Mutations",
    Values = g.MutationList,
    Multi = true,
    Default = {"None"},
    Callback = function(values)
        g.SelectedMutations = values or {}
    end
})

local function FindMatchingEgg()
    for _, child in ipairs(g.EggsFolder:GetChildren()) do
        if #child:GetChildren() == 0 then
            local T = child:GetAttribute("T") or ""
            local M = child:GetAttribute("M") or ""

            local eggMatch = false
            for _, egg in ipairs(g.SelectedEggsG) do
                if string.find(T, egg) then
                    eggMatch = true
                    break
                end
            end

            if eggMatch then
                for _, mut in ipairs(g.SelectedMutations) do
                    if mut == "None" then
                        if (not M or M == "") then
                            return child.Name
                        end
                    elseif string.find(M, mut) then
                        return child.Name
                    end
                end
            end
        end
    end
    return nil
end

local function TweenToPlayer()
    if not g.SelectedPlayer or g.SelectedPlayer == "" then return false end
    local target = workspace:FindFirstChild(g.SelectedPlayer)
    if not target or not target:FindFirstChild("HumanoidRootPart") then return false end

    local hrp = g.LocalPlayer.Character and g.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    local goal = {CFrame = target.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)}
    local tween = g.TweenService:Create(hrp, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), goal)
    tween:Play()
    tween.Completed:Wait()
    return true
end

local function SendGift(eggUID)
    if not eggUID or not g.SelectedPlayer then return end
    local Remote = game.ReplicatedStorage.Remote

    Remote.DeployRE:FireServer({{event = "deploy", uid = eggUID}})
    Remote.CharacterRE:FireServer("Focus", eggUID)
    Remote.GiftRE:FireServer(g.Players:WaitForChild(g.SelectedPlayer))
end

local function AutoGiftLoop()
    if g.AutoGiftThread then
        pcall(task.cancel, g.AutoGiftThread)
        g.AutoGiftThread = nil
    end

    g.AutoGiftThread = task.spawn(function()
        while g.AutoGift do
            if g.AutoGiftPaused then
                task.wait(0.5)
            else
                if g.SelectedPlayer and #g.SelectedEggsG > 0 then
                    local foundEgg = FindMatchingEgg()
                    if foundEgg then
                        if TweenToPlayer() then
                            SendGift(foundEgg)
                        end
                    end
                end
                task.wait(1)
            end
        end
    end)
end

local AGift = Tabs.More:Toggle({
    Title = "Auto Gift to Player",
    Value = false,
    Callback = function(state)
        g.AutoGift = state
        g.WasGifting = state
        if g.AutoGift then
            AutoGiftLoop()
        else
            if g.AutoGiftThread then
                task.cancel(g.AutoGiftThread)
                g.AutoGiftThread = nil
            end
        end
    end
})

Tabs.More:Divider()

local DupeEggDropdown = Tabs.More:Dropdown({
    Title = "Eggs",
    Values = g.EggList,
    SearchBarEnabled = true,
    MenuWidth = 280,
    Value = "",
    Callback = function(selected)
        g.SelectedDupeEgg = selected
    end
})

local ADupe = Tabs.More:Toggle({
    Title = "Auto Dupe",
    Desc = "Select Player first!",
    Value = false,
    Callback = function(state)
        g.AutoDupe = state
        if state then
            -- kirim 1x SetEggQuickSell
            pcall(function()
                local FishingRE = g.ReplicatedStorage:WaitForChild("Remote"):WaitForChild("FishingRE")
                FishingRE:FireServer("SetEggQuickSell", {
                    ["1"] = "\255",
                    Diamond = false,
                    ["3"] = true,
                    ["2"] = false,
                    ["5"] = false,
                    ["4"] = false,
                    ["6"] = false,
                    Golden = false,
                    Fire = false,
                    Electirc = false,
                    Dino = false,
                    Snow = false
                })
            end)

            -- mulai hitung mundur rejoin (selalu dipanggil)
            task.delay(60, function()
                if g.AutoDupe then
                    g.AutoDupe = false
                    g.CurrentInstanceId = tostring(game.JobId)
                    RejoinServer()
                end
            end)

            -- jalankan loop spam
            task.spawn(function()
                local char = g.LocalPlayer.Character or g.LocalPlayer.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart")
                local target = workspace:FindFirstChild(g.SelectedPlayer)
                if target and target:FindFirstChild("HumanoidRootPart") then
                    hrp.CFrame = target.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                end

                while g.AutoDupe do
                    local Remote = g.ReplicatedStorage:WaitForChild("Remote")
                    local CharRE = Remote:WaitForChild("CharacterRE")
                    local GiftRE = Remote:WaitForChild("GiftRE")
                    local TargetPlayer = g.Players:FindFirstChild(g.SelectedPlayer)

                    if not TargetPlayer then
                        task.wait(0.1)
                        continue
                    end

                    -- cari egg tanpa subchild & atribut T cocok
                    local foundEgg = nil
                    for _, egg in ipairs(g.EggsFolder:GetChildren()) do
                        if #egg:GetChildren() == 0 then
                            local T = egg:GetAttribute("T")
                            if T == g.SelectedDupeEgg then
                                foundEgg = egg
                                break
                            end
                        end
                    end

                    if foundEgg then
                        CharRE:FireServer("Focus", foundEgg.Name)
                    else
                        local fruits = {"Grape", "Banana", "Orange", "DragonFruit"}
                        CharRE:FireServer("Focus", fruits[math.random(1, #fruits)])
                    end

                    -- spam GiftRE cepat
                    for i = 1, 3 do
                        pcall(function()
                            GiftRE:FireServer(TargetPlayer)
                        end)
                        task.wait(0.03)
                    end

                    task.wait(0.1)
                end
            end)
        end
    end
})

Tabs.More:Divider()

Tabs.More:Button({
    Title = "Redeem New Code",
    Icon = "mouse-pointer-click",
    Callback = function()
        if NewCode ~= "" then
            Redeem()
        else
        WindUI:Notify({
            Title = "Empty Code",
            Content = "There's no valid Redeem Code right now",
            Duration = 5
        })
        end
    end
})

function MoveSpeed()
    local char = g.LocalPlayer.Character or g.LocalPlayer.CharacterAdded:Wait()
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        local speed = tonumber(g.SetSpeed)
        if speed then
            hum.WalkSpeed = math.clamp(speed, 1, 250)
            if SpeedInput then SpeedInput:Set(tostring(hum.WalkSpeed)) end
        end
    end
end

function JumpHeight()
    local char = g.LocalPlayer.Character or g.LocalPlayer.CharacterAdded:Wait()
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.UseJumpPower = false
        local jump = tonumber(g.SetJump)
        if jump then
            hum.JumpHeight = math.clamp(jump, 1, 250)
            if JumpInput then JumpInput:Set(tostring(hum.JumpHeight)) end
        end
    end
end

local function StartFlying()
    local character = g.LocalPlayer.Character or g.LocalPlayer.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")

    humanoid.PlatformStand = true

    g.FlyGyro = Instance.new("BodyGyro")
    g.FlyGyro.P = 9e4
    g.FlyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    g.FlyGyro.CFrame = hrp.CFrame
    g.FlyGyro.Parent = hrp

    g.FlyVel = Instance.new("BodyVelocity")
    g.FlyVel.Velocity = Vector3.new(0,0,0)
    g.FlyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    g.FlyVel.Parent = hrp

    g.FlyConnection = g.RunService.Heartbeat:Connect(function()
        if not g.FlyMode then return end
        local moveDir = humanoid.MoveDirection
        local camCF = workspace.CurrentCamera.CFrame
        local lookVec = camCF.LookVector
        local rightVec = camCF.RightVector

        local localX = moveDir:Dot(rightVec)
        local localZ = moveDir:Dot(lookVec)
        local move = (lookVec * localZ + rightVec * localX) * g.FlySpeed

        g.FlyVel.Velocity = move
        g.FlyGyro.CFrame = CFrame.new(hrp.Position, hrp.Position + Vector3.new(lookVec.X, 0, lookVec.Z))
    end)
end

local function SetNoClip(state)
    g.NoClip = state

    if g.NoClip then
        g.NoClipConnection = g.RunService.Stepped:Connect(function()
            if g.LocalPlayer.Character then
                for _, part in pairs(g.LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if g.NoClipConnection then
            g.NoClipConnection:Disconnect()
            g.NoClipConnection = nil
        end
        if g.LocalPlayer.Character then
            for _, part in pairs(g.LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

local function GetLeastPopulatedServer()
    local HttpService = game:GetService("HttpService")
    local url = string.format(
        "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100",
        game.PlaceId
    )

    local success, response = pcall(function()
        return game:HttpGet(url)
    end)

    if success and response then
        local data = HttpService:JSONDecode(response)
        if data and data.data then
            table.sort(data.data, function(a, b)
                return a.playing < b.playing
            end)
            for _, server in ipairs(data.data) do
                if server.id ~= game.JobId then
                    return server.id
                end
            end
        end
    end
    return nil
end

local function RejoinServer()
    local TeleportService = game:GetService("TeleportService")
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer

    if g.CurrentInstanceId and g.CurrentInstanceId ~= "" then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, g.CurrentInstanceId, Player)
    else
        local serverId = GetLeastPopulatedServer()
        if serverId then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, serverId, Player)
        else
            TeleportService:Teleport(game.PlaceId, Player)
        end
    end
end

Tabs.Misc:Paragraph({
    Title = "Miscellaneous section",
    Desc = "Set some necessary features",
    Image = "store",
    ImageSize = 20,
    Color = "White"
})

Tabs.Misc:Divider()

local ARejoin = Tabs.Misc:Toggle({
    Title = "Auto Rejoin",
    Desc = "Doesn't work on Private Server",
    Value = g.AutoRejoin,
    Callback = function(state)
        g.AutoRejoin = state
        if g.AutoRejoin then
            g.CurrentInstanceId = tostring(game.JobId or "")
            task.spawn(function()
                while g.AutoRejoin do
                    task.wait(g.AutoRejoinDelay)
                    if g.AutoRejoin then
                        RejoinServer()
                    end
                end
            end)
        end
    end
})

Tabs.Misc:Divider()

Tabs.Misc:Input({
    Title = "Move Speed",
    Value = "",
    Type = "Input",
    Placeholder = "1-250",
    Callback = function(value)
        local num = tonumber(value)
        if not num or num == 0 then
            g.SetSpeed = "29"
        else
            g.SetSpeed = value
        end
        MoveSpeed()
    end
})

Tabs.Misc:Input({
    Title = "Jump Height",
    Value = "",
    Type = "Input",
    Placeholder = "1-250",
    Callback = function(value)
        local num = tonumber(value)
        if not num or num == 0 then
            g.SetJump = "9"
        else
            g.SetJump = value
        end
        JumpHeight()
    end
})

Tabs.Misc:Divider()

local FSpeed = Tabs.Misc:Slider({
    Title = "Fly Speed",
    Desc = "",
    Value = { Min = 10, Max = 300, Default = g.FlySpeed },
    Callback = function(value)
        g.FlySpeed = value
    end
})

local FlyingToggle = Tabs.Misc:Toggle({
    Title = "Fly Mode",
    Desc = "Enable or disable flying",
    Value = g.FlyMode,
    Callback = function(state)
        g.FlyMode = state
        if g.FlyMode then
            StartFlying()
        else
            if g.FlyConnection then
                g.FlyConnection:Disconnect()
                g.FlyConnection = nil
            end
            if g.FlyGyro then g.FlyGyro:Destroy() g.FlyGyro = nil end
            if g.FlyVel then g.FlyVel:Destroy() g.FlyVel = nil end

            local character = g.LocalPlayer.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.PlatformStand = false
                end
            end
        end
    end
})

Tabs.Misc:Divider()

local Wallhack = Tabs.Misc:Toggle({
    Title = "No Clip",
    Desc = "Through the Objects",
    Default = false,
    Callback = function(value)
        SetNoClip(value)
    end
})

Tabs.Misc:Divider()

local URLHook = Tabs.Misc:Input({
    Title = "Discord Webhook URL",
    Default = "",
    Placeholder = "URL",
    Callback = function(Value)
        g.WebhookUrl = tostring(Value)
    end
})

local AHook = Tabs.Misc:Toggle({
    Title = "Send Webhook on Egg Hatch",
    Default = false,
    Callback = function(Value)
        g.SendWebhook = Value
    end
})

local themes = {}
for themeName, _ in pairs(WindUI:GetThemes()) do
    table.insert(themes, themeName)
end
table.sort(themes)

local canchangetheme = true
local canchangedropdown = true

Tabs.Theme:Paragraph({
    Title = "Customize Interface",
    Desc = "Personalize your experience",
    Image = "palette",
    ImageSize = 20,
    Color = "White"
})

Tabs.Theme:Divider()

local themeDropdown = Tabs.Theme:Dropdown({
    Title = "Select Theme",
    Values = themes,
    SearchBarEnabled = true,
    MenuWidth = 280,
    Value = "Dark",
    Callback = function(theme)
        canchangedropdown = false
        WindUI:SetTheme(theme)
        WindUI:Notify({
            Title = "Theme Applied",
            Content = theme,
            Icon = "palette",
            Duration = 2
        })
        canchangedropdown = true
    end
})

local transparencySlider = Tabs.Theme:Slider({
    Title = "Transparency",
    Value = { 
        Min = 0,
        Max = 1,
        Default = 0,
    },
    Step = 0.1,
    Callback = function(value)
        WindUI.TransparencyValue = tonumber(value)
        Window:ToggleTransparency(tonumber(value) > 0)
    end
})

local ThemeToggle = Tabs.Theme:Toggle({
    Title = "Enable Dark Mode",
    Desc = "Use dark color scheme",
    Value = true,
    Callback = function(state)
        if canchangetheme then
            WindUI:SetTheme(state and "Dark" or "Light")
        end
        if canchangedropdown then
            themeDropdown:Select(state and "Dark" or "Light")
        end
    end
})

WindUI:OnThemeChange(function(theme)
    canchangetheme = false
    ThemeToggle:Set(theme == "Dark")
    canchangetheme = true
end)

local ConfigManager = Window.ConfigManager

local configName = g.userId
local configFile = nil

Tabs.Config:Paragraph({
    Title = "Configuration Manager",
    Desc = "Save and load your settings",
    Image = "save",
    ImageSize = 20,
    Color = "White"
})

Tabs.Config:Divider()

local Keybind = Tabs.Config:Keybind({
    Title = "=",
    Desc = "Keybind to open ui",
    Value = "G",
    Callback = function(v)
        Window:SetToggleKey(Enum.KeyCode[v])
    end
})

Tabs.Config:Divider()

Tabs.Config:Input({
    Title = "Config Name",
    Value = configName,
    Callback = function(value)
        configName = value or "Default"
    end
})

if ConfigManager then
    ConfigManager:Init(Window)

    Tabs.Config:Button({
        Title = "Save Config",
        Icon = "save",
        Variant = "Primary",
        Callback = function()
            local configFile = ConfigManager:CreateConfig(configName)

            configFile:Register("ClaimDelay", ClaimDelay)
            configFile:Register("ACoin", ACoin)
            configFile:Register("Fruits", Fruits)
            configFile:Register("AFruits", AFruits)
            configFile:Register("Eggs", Eggs)
            configFile:Register("Mutations", Mutations)
            configFile:Register("AEggs", AEggs)
            configFile:Register("Potion", Potion)
            configFile:Register("APotion", APotion)
            configFile:Register("ARejoin", ARejoin)
            configFile:Register("URLHook", URLHook)
            configFile:Register("AHook", AHook)
            configFile:Register("AFishing", AFishing)
            configFile:Register("AFishSnow", AFishSnow)
            configFile:Register("User", User)
            configFile:Register("ALike", ALike)
            configFile:Register("SelEgg", SelEgg)
            configFile:Register("SelMut", SelMut)
            configFile:Register("AGift", AGift)
            configFile:Register("SellEggsDropdown", SellEggsDropdown)
            configFile:Register("SellMutationsDropdown", SellMutationsDropdown)
            configFile:Register("AutoSellEggsToggle", AutoSellEggsToggle)
            configFile:Register("AHatch", AHatch)
            configFile:Register("themeDropdown", themeDropdown)
            configFile:Register("transparencySlider", transparencySlider)

            configFile:Set("cDelay", g.CoinDelay)
            configFile:Set("aCoin", g.AutoCoin)
            configFile:Set("sFruits", g.SelectedFruits)
            configFile:Set("aFruits", g.AutoFruits)
            configFile:Set("sEggs", g.SelectedEggs)
            configFile:Set("sMutations", g.SelectedMutations)
            configFile:Set("aEggs", g.AutoEggs)
            configFile:Set("sPotion", g.SelectedPotion)
            configFile:Set("aPotion", g.AutoUsePotion)
            configFile:Set("aRejoin", g.AutoRejoin)
            configFile:Set("sHook", g.WebhookUrl)
            configFile:Set("aHook", g.SendWebhook)
            configFile:Set("sPos", g.FishingPos)
            configFile:Set("aFishing", g.AutoFishing)
            configFile:Set("aFSnow", g.FishFarmSnow)
            configFile:Set("sPlayer", g.SelectedPlayer)
            configFile:Set("sId", g.SelectedUserId)
            configFile:Set("aLike", g.AutoLike)
            configFile:Set("sE", g.SelectedEggsG)
            configFile:Set("sM", g.SelectedMutationsG)
            configFile:Set("aGift", g.AutoGift)
            configFile:Set("sSellEggs", g.SelectedSellEggs)
            configFile:Set("sSellMutations", g.SelectedSellMutations)
            configFile:Set("aSellEggs", g.AutoSellEggs)
            configFile:Set("aHatch", g.AutoHatch)
            configFile:Set("lastSave", os.date("%Y-%m-%d %H:%M:%S"))

            if configFile:Save() then
                WindUI:Notify({
                    Title = "Config Saved!",
                    Content = "Saved as: " .. configName,
                    Icon = "check",
                    Duration = 3
                })
            else
                WindUI:Notify({
                    Title = "Error",
                    Content = "Failed to save config",
                    Icon = "x",
                    Duration = 3
                })
            end
        end
    })

    Tabs.Config:Button({
        Title = "Load Config",
        Icon = "folder",
        Callback = function()
            local configFile = ConfigManager:CreateConfig(configName)
            local loadedData = configFile:Load()

            if loadedData then
                if loadedData.cDelay then
                    g.CoinDelay = loadedData.cDelay
                    ClaimDelay:Set(g.CoinDelay)
                end

                if loadedData.aCoin then
                    g.AutoCoin = loadedData.aCoin
                    ACoin:Set(g.AutoCoin)
                end

                if loadedData.sFruits then
                    g.SelectedFruits = loadedData.sFruits
                    Fruits:Select(g.SelectedFruits)
                end

                if loadedData.aFruits then
                    g.AutoFruits = loadedData.aFruits
                    AFruits:Set(g.AutoFruits)
                end

                if loadedData.sEggs then
                    g.SelectedEggs = loadedData.sEggs
                    Eggs:Select(g.SelectedEggs)
                end

                if loadedData.sMutations then
                    g.SelectedMutations = loadedData.sMutations
                    Mutations:Select(g.SelectedMutations)
                end

                if loadedData.aEggs then
                    g.AutoEggs = loadedData.aEggs
                    AEggs:Set(g.AutoEggs)
                end
                
                if loadedData.sPotion then
                    g.SelectedPotion = loadedData.sPotion
                    Potion:Select(g.SelectedPotion)
                end
                
                if loadedData.aRejoin then
                    g.AutoRejoin = loadedData.aRejoin
                    ARejoin:Set(g.AutoRejoin)
                end
                
                if loadedData.sPos then
                    g.FishingPos = loadedData.sPos
                end
                
                if loadedData.aFishing then
                    g.AutoFishing = loadedData.aFishing
                    AFishing:Set(g.AutoFishing)
                end
                
                if loadedData.aFSnow then
                    g.FishFarmSnow = loadedData.aFSnow
                    AFishSnow:Set(g.FishFarmSnow)
                end
                
                if loadedData.sPlayer and loadedData.sId then
                    g.SelectedPlayer = loadedData.sPlayer
                    g.SelectedUserId = loadedData.sId
                    User:Select(g.SelectedPlayer .. " (" .. g.SelectedUserId .. ")")
                end
                
                if loadedData.aLike then
                    g.AutoLike = loadedData.aLike
                    ALike:Set(g.AutoLike)
                end
                
                if loadedData.sE then
                    g.SelectedEggsG = loadedData.sE
                    SelEgg:Select(g.SelectedEggsG)
                end
                
                if loadedData.sM then
                    g.SelectedMutationsG = loadedData.sM
                    SelMut:Select(g.SelectedMutationsG)
                end
                
                if loadedData.aGift then
                    g.AutoGift = loadedData.aGift
                    AGift:Set(g.AutoGift)
                end

                if loadedData.sSellEggs then
                    g.SelectedSellEggs = loadedData.sSellEggs
                    SellEggsDropdown:Select(g.SelectedSellEggs)
                end

                if loadedData.sSellMutations then
                    g.SelectedSellMutations = loadedData.sSellMutations
                    SellMutationsDropdown:Select(g.SelectedSellMutations)
                end

                if loadedData.aSellEggs then
                    g.AutoSellEggs = loadedData.aSellEggs
                    AutoSellEggsToggle:Set(g.AutoSellEggs)
                end

                if loadedData.aHatch then
                    g.AutoHatch = loadedData.aHatch
                    AHatch:Set(g.AutoHatch)
                end
                
                if loadedData.sHook then
                    g.WebhookUrl = loadedData.sHook
                    URLHook:Set(g.WebhookUrl)
                end

                if loadedData.aHook then
                    g.SendWebhook = loadedData.aHook
                    AHook:Set(g.SendWebhook)
                end

                local lastSave = loadedData.lastSave or "Unknown"

                WindUI:Notify({
                    Title = "Config Loaded",
                    Content = "Loaded: " .. configName .. "\nLast save: " .. lastSave,
                    Icon = "refresh-cw",
                    Duration = 5
                })
            end
        end
    })
end

g.Players.PlayerAdded:Connect(function()
    User:Refresh(GetPlayersList())
end)

g.Players.PlayerRemoving:Connect(function()
    User:Refresh(GetPlayersList())
end)

task.spawn(function()
    task.wait(2)
    local configFile = ConfigManager:CreateConfig(configName)
    local loadedData = configFile:Load()

    if loadedData then
        if loadedData.cDelay then
            g.CoinDelay = loadedData.cDelay
            ClaimDelay:Set(g.CoinDelay)
        end

        if loadedData.aCoin then
            g.AutoCoin = loadedData.aCoin
            ACoin:Set(g.AutoCoin)
        end

        if loadedData.sFruits then
            g.SelectedFruits = loadedData.sFruits
            Fruits:Select(g.SelectedFruits)
        end

        if loadedData.aFruits then
            g.AutoFruits = loadedData.aFruits
            AFruits:Set(g.AutoFruits)
        end

        if loadedData.sEggs then
            g.SelectedEggs = loadedData.sEggs
            Eggs:Select(g.SelectedEggs)
        end

        if loadedData.sMutations then
            g.SelectedMutations = loadedData.sMutations
            Mutations:Select(g.SelectedMutations)
        end

        if loadedData.aEggs then
            g.AutoEggs = loadedData.aEggs
            AEggs:Set(g.AutoEggs)
        end
        
        if loadedData.sPotion then
            g.SelectedPotion = loadedData.sPotion
            Potion:Select(g.SelectedPotion)
        end
        
        if loadedData.sPos then
            g.FishingPos = loadedData.sPos
        end
                
        if loadedData.aFishing then
            g.AutoFishing = loadedData.aFishing
            AFishing:Set(g.AutoFishing)
        end
                
        if loadedData.aFSnow then
            g.FishFarmSnow = loadedData.aFSnow
            AFishSnow:Set(g.FishFarmSnow)
        end
        
        if loadedData.sPlayer and loadedData.sId then
            g.SelectedPlayer = loadedData.sPlayer
            g.SelectedUserId = loadedData.sId
            User:Select(g.SelectedPlayer .. " (" .. g.SelectedUserId .. ")")
        end
                
        if loadedData.aLike then
            g.AutoLike = loadedData.aLike
            ALike:Set(g.AutoLike)
        end
                
        if loadedData.sE then
            g.SelectedEggsG = loadedData.sE
            SelEgg:Select(g.SelectedEggsG)
        end
                
        if loadedData.sM then
            g.SelectedMutationsG = loadedData.sM
            SelMut:Select(g.SelectedMutationsG)
        end
                
        if loadedData.aGift then
            g.AutoGift = loadedData.aGift
            AGift:Set(g.AutoGift)
        end

        if loadedData.sSellEggs then
            g.SelectedSellEggs = loadedData.sSellEggs
            SellEggsDropdown:Select(g.SelectedSellEggs)
        end

        if loadedData.sSellMutations then
            g.SelectedSellMutations = loadedData.sSellMutations
            SellMutationsDropdown:Select(g.SelectedSellMutations)
        end

        if loadedData.aSellEggs then
            g.AutoSellEggs = loadedData.aSellEggs
            AutoSellEggsToggle:Set(g.AutoSellEggs)
        end

        if loadedData.aHatch then
            g.AutoHatch = loadedData.aHatch
            AHatch:Set(g.AutoHatch)
        end
        
        if loadedData.aRejoin then
            g.AutoRejoin = loadedData.aRejoin
            ARejoin:Set(g.AutoRejoin)
        end

        if loadedData.sHook then
            g.WebhookUrl = loadedData.sHook
            URLHook:Set(g.WebhookUrl)
        end

        if loadedData.aHook then
            g.SendWebhook = loadedData.aHook
            AHook:Set(g.SendWebhook)
        end

        local lastSave = loadedData.lastSave or "Unknown"

        WindUI:Notify({
            Title = "Config Loaded",
            Content = "Loaded: " .. configName .. "\nLast save: " .. lastSave,
            Icon = "refresh-cw",
            Duration = 5
        })
    end
end)

Tabs.Auth:Select()

Window:EditOpenButton({
    Title = "CelestineHub",
    Icon = "door-open",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("FFC400"), 
        Color3.fromHex("FFC400")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

Window:OnClose(function()
    if ConfigManager and configFile then
        configFile:Set("cDelay", g.CoinDelay)
        configFile:Set("aCoin", g.AutoCoin)
        configFile:Set("sFruits", g.SelectedFruits)
        configFile:Set("aFruits", g.AutoFruits)
        configFile:Set("sEggs", g.SelectedEggs)
        configFile:Set("sMutations", g.SelectedMutations)
        configFile:Set("aEggs", g.AutoEggs)
        configFile:Set("sPotion", g.SelectedPotion)
        configFile:Set("aPotion", g.AutoUsePotion)
        configFile:Set("aRejoin", g.AutoRejoin)
        configFile:Set("sPos", g.FishingPos)
        configFile:Set("aFishing", g.AutoFishing)
        configFile:Set("aFSnow", g.FishFarmSnow)
        configFile:Set("sHook", g.WebhookUrl)
        configFile:Set("aHook", g.SendWebhook)
        configFile:Set("sPlayer", g.SelectedPlayer)
        configFile:Set("sId", g.SelectedUserId)
        configFile:Set("aLike", g.AutoLike)
        configFile:Set("sE", g.SelectedEggsG)
        configFile:Set("sM", g.SelectedMutationsG)
        configFile:Set("aGift", g.AutoGift)
        configFile:Set("sSellEggs", g.SelectedSellEggs)
        configFile:Set("sSellMutations", g.SelectedSellMutations)
        configFile:Set("aSellEggs", g.AutoSellEggs)
        configFile:Set("aHatch", g.AutoHatch)
        configFile:Set("lastSave", os.date("%Y-%m-%d %H:%M:%S"))
    end
end)

Window:OnDestroy(function()
g.AutoCoin = false
g.AutoFishing = false
g.CoinDelay = 10
g.FishingPos = nil
g.FBait = "FishingBait3"
g.FishFarmSnow = false
g.SavedCFrame = nil
g.SelectedPotion = "Potion_Coin"
g.AutoUsePotion = false
g.SelectedFruits = {}
g.SelectedEggs = {}
g.SelectedMutations = {}
g.SelectedItem = "Pet"
g.SelectedTickets = 1
g.AutoFruits = false
g.AutoEggs = false
g.AutoTickets = false
g.MyIsland = ""
g.eggName = "Unknown"
g.eggMutate = "None"
g.SelectedPet = ""
g.SelectedFeed = ""
g.AutoFeed = false
g.SelectedPlayer = ""
g.SelectedUserId = nil
g.AutoLike = false
g.SetSpeed = 29
g.SetJump = 9
g.FlyMode = false
g.FlySpeed = 50
g.FlyConnection = nil
g.FlyGyro = nil
g.FlyVel = nil
g.NoClip = false
g.NoClipConnection = nil
g.WebhookUrl = ""
g.SendWebhook = false
g.AutoRejoin = false
g.AutoRejoinDelay = 1000
g.CurrentInstanceId = ""
g.AutoLike = false
g.SelectedEggsG = {}
g.SelectedMutationsG = {}
g.AutoGift = false
g.SelectedSellEggs = {}
g.SelectedSellMutations = {}
g.AutoSellEggs = false
g.AutoHatch = false
end)

Window:OnOpen(function()
end)

if syn and syn.queue_on_teleport then
    syn.queue_on_teleport(string.format([[
        loadstring(game:HttpGet("%s"))()
    ]], script_url))
elseif queue_on_teleport then
    queue_on_teleport(string.format([[
        loadstring(game:HttpGet("%s"))()
    ]], script_url))
elseif script and script.Parent and script.Parent.QueueTeleport then
    script.Parent.QueueTeleport(script, string.format([[
        loadstring(game:HttpGet("%s"))()
    ]], script_url))
end
