-- ====================================
-- BRAINROT SCANNER - COMPLETE VERSION
-- With Discord Bot Integration
-- ====================================

-- Configuration
local WEBHOOK_URL = "https://discord.com/api/webhooks/1452120328364101693/XSaMuA_dNl_GShp3ONOOEmNnkakZeMctfvyKXVV-hJDxgK8H6ZTUoCApFxBw4Nzbo5_8"
local CONTROL_WEBHOOK_URL = "https://discord.com/api/webhooks/1452120328364101693/XSaMuA_dNl_GShp3ONOOEmNnkakZeMctfvyKXVV-hJDxgK8H6ZTUoCApFxBw4Nzbo5_8"
local GLOBAL_CONFIG_KEY = "brainrot_scanner_global_config"
local USER_SETTINGS_KEY = "brainrot_scanner_user_settings_"
local HOP_DELAY = 3
local CONFIG_CHECK_INTERVAL = 30

-- Filter Settings
local MIN_MS_FILTER = 1
local MAX_MS_FILTER = 999999999999
local AUTO_HOP_ENABLED = true
local lastConfigCheck = 0

-- Services
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Complete list of all brainrot names
local BRAINROT_NAMES = {
    "Noobini Pizzanini", "Lirili Larila", "Tim Cheese", "Fluriflura", "Talpa Di Fero", "Noobini Santanini", "Svinina Bombardino", "Raccooni Jandelini", "Pipi Kiwi", "Tartaragno", "Pipi Corni", "Trippi Troppi", "Tung Tung Tung Sahur", "Gangster Footera", "Bandito Bobritto", "Boneca Ambalabu", "Cacto Hipopotamo", "Ta Ta Ta Ta Sahur", "Tric Trac Baraboom", "Frogo Elgo", "Pipi Avocado", "Cupcake Koala", "Pinealotto Fruttarino", "Cappuccino Assassino", "Bandito Axolito", "Brr Brr Patapim", "Avocadini Antilopini", "Trulimero Trulicina", "Bambini Crostini", "Malame Amarele", "Bananita Dolphinita", "Perochello Lemonchello", "Brri Brri Bicus Dicus Bombicus", "Avocadini Guffo", "Ti Ti Ti Sahur", "Mangolini Parrocini", "Frogato Pirato", "Salamino Penguino", "Doi Doi Do", "Penguin Tree", "Wombo Rollo", "Penguino Cocosino", "Mummio Rappitto", "Burbaloni Loliloli", "Chimpanzini Bananini", "Tirilikalika Tirilikalako", "Ballerina Cappuccina", "Chef Crabracadabra", "Lionel Cactuseli", "Glorbo Fruttodrillo", "Quivioli Ameleonni", "Blueberrinni Octopusini", "Clickerino Crabo", "Caramello Filtrello", "Pipi Potato", "Strawberrelli Flamingelli", "Cocosini Mama", "Pandaccini Bananini", "Quackula", "Pi Pi Watermelon", "Signore Carapace", "Sigma Boy", "Sigma Girl", "Chocco Bunny", "Puffaball", "Sealo Regalo", "Buho de Fuego", "Frigo Camelo", "Orangutini Ananassini", "Rhino Toasterino", "Bombardiro Crocodilo", "Brutto Gialutto", "Spioniro Golubiro", "Bombombini Gusini", "Zibra Zubra Zibralini", "Tigrilini Watermelini", "Avocadorilla", "Cavallo Virtuoso", "Te Te Te Sahur", "Gorillo Subwoofero", "Gorillo Watermelondrillo", "Stoppo Luminino", "Tracoducotulu Delapeladustuz", "Tob Tobi Tobi", "Lerulerulerule", "Ganganzelli Trulala", "Magi Ribbitini", "Rhino Helicopterino", "Jingle Jingle Sahur", "Los Noobinis", "Cachorrito Melonito", "Carloooo", "Elefanto Frigo", "Carrotini Brainini", "Centrucci Nuclucci", "Toiletto Focaccino", "Jacko Spaventosa", "Bananito Bandito", "Tree Tree Tree Sahur", "Cocofanto Elefanto", "Antonio", "Girafa Celestre", "Gattatino Nyanino", "Gattatino Neonino", "Chihuanini Taconini", "Matteo", "Tralalero Tralala", "Los Crocodillitos", "Tigroligre Frutonni", "Odin Din Din Dun", "Orcalero Orcala", "Money Money Man", "Alessio", "Unclito Samito", "Statutino Libertino", "Tipi Topi Taco", "Tralalita Tralala", "Tukanno Banana", "Extinct Ballerina", "Vampira Cappucina", "Espresso Signora", "Trenozosturzzo Turbo 3000", "Bulbito Bandito Traktorito", "Urubini Flamenguini", "Jacko Jack Jack", "Trippi Troppi Troppa Trippa", "Capi Taco", "Los Chihuaninis", "Gattito Tacoto", "Las Capuchinas", "Ballerino Lololo", "Los Tungtungtungcitos", "Pakrahmatmamat", "Ballerina Peppermintina", "Piccione Macchina", "Pakrahmatmatina", "Los Bombinitos", "Tractoro Dinosauro", "Brr Es Teh Patipum", "Cacasito Satalito", "Orcalita Orcala", "Aquanaut", "Tartaruga Cisterna", "Snailenzo", "Corn Corn Corn Sahur", "Squalanana", "Mummy Ambalabu", "Los Orcalitos", "Dug Dug Dug", "Ginger Globo", "Yeti Claus", "Crabbo Limonetta", "Los Tipi Tacos", "Granchiello Spiritell", "Frio Ninja", "Piccionetta Macchina", "Mastodontico Telepiedone", "Los Gattitos", "Bambu Bambu Sahur", "Chrismasmamat", "Anpali Babel", "Cappuccino Clownino", "Bombardini Tortinii", "Brasilini Berimbini", "Belula Beluga", "Krupuk Pagi Pagi", "Skull Skull Skull", "Cocoa Assassino", "Tentacolo Tecnico", "Ginger Cisterna", "Pop Pop Sahur", "Noo La Polizia", "La Vacca Saturno Saturnita", "Pandanini Frostini", "Bisonte Giuppitere", "Blackhole Goat", "Jackorilla", "Agarrini La Palini", "Chachechi", "Karkerkar Kurkur", "Los Tortus", "Los Matteos", "Sammyni Spyderini", "Trenostruzzo Turbo 4000", "Chimpanzini Spiderini", "Boatito Auratito", "Fragola La La La", "Dul Dul Dul", "La Vacca Prese Presente", "Frankentteo", "Karker Sahur", "Torrtuginni Dragonfrutini", "Los Tralaleritos", "Zombie Tralala", "La Cucaracha", "Vulturino Skeletono", "Guerriro Digitale", "Extinct Tralalero", "Yess My Examine", "Extinct Matteo", "Las Tralaleritas", "Reindeer Tralala", "Las Vaquitas Saturnitas", "Pumpkin Spyderini", "Job Job Job Sahur", "Los Karkeritos", "Graipuss Medussi", "Santteo", "La Vacca Jacko Linterino", "Triplito Tralaleritos", "Trickolino", "Giftini Spyderini", "Los Spyderinis", "Perrito Burrito", "1x1x1x1", "Los Cucarachas", "Please My Present", "Cuadramat and Pakrahmatmamat", "Los Jobcitos", "Nooo My Hotspot", "Pot Hotspot", "Noo My Examine", "Telemorte", "La Sahur Combinasion", "List List List Sahur", "To To To Sahur", "Pirulitoita Bicicletaire", "25", "Santa Hotspot", "Horegini Boom", "Quesadilla Crocodila", "Pot Pumpkin", "Naughty Naughty", "Ho Ho Ho Sahur", "Chicleteira Bicicleteira", "Spaghetti Tualetti", "Esok Sekolah", "Quesadillo Vampiro", "Burrito Bandito", "Chicleteirina Bicicleteirina", "Los Quesadillas", "Noo My Candy", "Los Nooo My Hotspotsitos", "La Grande Combinassion", "Rang Ring Bus", "Guest 666", "Los Chicleteiras", "67", "Mariachi Corazoni", "Los Burritos", "Los 25", "Swag Soda", "Chimnino", "Los Combinasionas", "Chicleteira Noelteira", "Fishino Clownino", "Tacorita Bicicleta", "Nuclearo Dinosauro", "Las Sis", "La Karkerkar Combinasion", "Chillin Chili", "Chipso and Queso", "Money Money Puggy", "Celularcini Viciosini", "Los Planitos", "Los Mobilis", "Los 67", "Mieteteira Bicicleteira", "La Spooky Grande", "Los Spooky Combinasionas", "Los Candies", "Los Hotspositos", "Los Puggies", "W or L", "Tralalalaledon", "La Extinct Grande Combinasion", "Tralaledon", "La Jolly Grande", "Los Primos", "Eviledon", "Los Tacoritas", "Tang Tang Kelentang", "Ketupat Kepat", "Los Bros", "Tictac Sahur", "La Supreme Combinasion", "Gingerat Gerat", "Orcaledon", "Ketchuru and Masturu", "Garama and Madundung", "Festive 67", "La Ginger Sekolah", "Spooky and Pumpky", "Lavadorito Spinito", "Los Spaghettis", "La Casa Boo", "Fragrama and Chocrama", "La Secret Combinasion", "Reinito Sleighito", "Burguro and Fryuro", "Dragon Cannelloni", "Cooki and Milki", "Capitano Moby", "Headless Horseman", "Strawberry Elephant", "Meowl", "2", "6", "Admin Lucky Block", "Brainrot God", "Brainrot God Lucky Block", "Brainrot Trader", "Ice Dragon", "John Pork", "Christmas Brainrots", "Festive Lucky Block", "Arachnid Family", "Combinasions Family", "Karkerkur Family", "Limited Stock Brainrots"
}

-- Create lookup table
local BRAINROT_LOOKUP = {}
for _, name in pairs(BRAINROT_NAMES) do
    BRAINROT_LOOKUP[name:lower()] = name
end

-- Rarity tiers
local RARITY_ORDER = {
    ["common"] = 1, ["rare"] = 2, ["epic"] = 3, ["legendary"] = 4,
    ["mythic"] = 5, ["brainrot god"] = 6, ["secret"] = 7, ["og"] = 8,
    ["admin"] = 9, ["taco"] = 10, ["spooky"] = 11, ["festive"] = 12
}

local RARITY_DISPLAY = {
    [1] = "⚪ Common", [2] = "🟢 Rare", [3] = "🔵 Epic", [4] = "🟡 Legendary",
    [5] = "🟣 Mythic", [6] = "🧠 Brainrot God", [7] = "✨ Secret", [8] = "👑 OG",
    [9] = "🔴 Admin", [10] = "🌮 Taco", [11] = "🎃 Spooky", [12] = "🎄 Festive"
}

-- Helper Functions
local function isBrainrot(itemName)
    return BRAINROT_LOOKUP[itemName:lower()] ~= nil
end

local function getRarityScore(itemName)
    local lowerName = itemName:lower()
    local highestScore = 0
    local matchedRarity = ""
    
    if lowerName:match("brainrot god") then
        return 6, "brainrot god"
    end
    
    for rarityName, score in pairs(RARITY_ORDER) do
        if lowerName:match(rarityName) then
            if score > highestScore then
                highestScore = score
                matchedRarity = rarityName
            end
        end
    end
    
    return highestScore, matchedRarity
end

local function formatMs(ms)
    if ms >= 1000000000 then
        return string.format("%.2fB", ms / 1000000000)
    elseif ms >= 1000000 then
        return string.format("%.2fM", ms / 1000000)
    elseif ms >= 1000 then
        return string.format("%.2fK", ms / 1000)
    else
        return tostring(ms)
    end
end

-- Settings Management
local function loadUserSettings()
    local success, result = pcall(function()
        return window.storage.get(USER_SETTINGS_KEY .. LocalPlayer.UserId, false)
    end)
    
    if success and result and result.value then
        local settings = HttpService:JSONDecode(result.value)
        MIN_MS_FILTER = settings.minMs or 0
        MAX_MS_FILTER = settings.maxMs or math.huge
        AUTO_HOP_ENABLED = settings.autoHop ~= nil and settings.autoHop or true
        print("✅ Loaded your saved settings:")
        print("   Min M/s:", MIN_MS_FILTER)
        print("   Max M/s:", MAX_MS_FILTER)
        print("   Auto-Hop:", AUTO_HOP_ENABLED and "ON" or "OFF")
        return settings
    else
        print("📝 No saved settings found, using defaults")
        return {minMs = 0, maxMs = math.huge, autoHop = true}
    end
end

local function saveUserSettings(minMs, maxMs, autoHop)
    local settings = {
        minMs = minMs,
        maxMs = maxMs,
        autoHop = autoHop,
        lastSaved = os.time()
    }
    
    local success = pcall(function()
        window.storage.set(USER_SETTINGS_KEY .. LocalPlayer.UserId, HttpService:JSONEncode(settings), false)
    end)
    
    if success then
        print("💾 Saved your settings!")
    else
        warn("❌ Failed to save settings")
    end
end

local function loadGlobalConfig()
    local success, result = pcall(function()
        return window.storage.get(GLOBAL_CONFIG_KEY, true)
    end)
    
    if success and result and result.value then
        local config = HttpService:JSONDecode(result.value)
        MIN_MS_FILTER = config.minMs or 0
        MAX_MS_FILTER = config.maxMs or math.huge
        print("✅ Loaded global config: Min =", MIN_MS_FILTER, "| Max =", MAX_MS_FILTER)
        print("   Last updated by:", config.lastUser or "Unknown")
        return config
    else
        print("⚠️ No global config found, using defaults")
        return {minMs = 0, maxMs = math.huge, lastUser = "System", timestamp = os.time()}
    end
end

local function checkConfigUpdates()
    local currentTime = os.time()
    if currentTime - lastConfigCheck >= CONFIG_CHECK_INTERVAL then
        lastConfigCheck = currentTime
        
        local success, result = pcall(function()
            return window.storage.get(GLOBAL_CONFIG_KEY, true)
        end)
        
        if success and result and result.value then
            local config = HttpService:JSONDecode(result.value)
            local oldMin = MIN_MS_FILTER
            local oldMax = MAX_MS_FILTER
            
            MIN_MS_FILTER = config.minMs or 0
            MAX_MS_FILTER = config.maxMs or math.huge
            
            if oldMin ~= MIN_MS_FILTER or oldMax ~= MAX_MS_FILTER then
                print("📢 CONFIG UPDATED FROM DISCORD!")
                print("   New: Min =", MIN_MS_FILTER, "| Max =", MAX_MS_FILTER)
                return true
            end
        end
    end
    return false
end

local function saveGlobalConfig(minMs, maxMs, updatedBy)
    local config = {
        minMs = minMs,
        maxMs = maxMs,
        lastUser = updatedBy,
        timestamp = os.time(),
        dateTime = os.date("%Y-%m-%d %H:%M:%S")
    }
    
    pcall(function()
        window.storage.set(GLOBAL_CONFIG_KEY, HttpService:JSONEncode(config), true)
    end)
end

-- Server Hopping
local function serverHop(retryCount)
    retryCount = retryCount or 0
    local MAX_RETRIES = 5
    
    if retryCount >= MAX_RETRIES then
        warn("❌ Max retries reached. Attempting fallback...")
        pcall(function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
        end)
        wait(30)
        serverHop(0)
        return
    end
    
    print("🔄 Server hopping... (Attempt " .. (retryCount + 1) .. "/" .. MAX_RETRIES .. ")")
    
    local TeleportService = game:GetService("TeleportService")
    
    local success = pcall(function()
        local servers = {}
        local cursor = ""
        
        repeat
            local url = string.format(
                "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100&cursor=%s",
                game.PlaceId, cursor
            )
            
            local response = game:HttpGet(url)
            local data = HttpService:JSONDecode(response)
            
            for _, server in pairs(data.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    table.insert(servers, server.id)
                end
            end
            
            cursor = data.nextPageCursor or ""
        until cursor == "" or #servers >= 50
        
        if #servers > 0 then
            local randomServer = servers[math.random(1, #servers)]
            print("🎯 Teleporting...")
            TeleportService:TeleportToPlaceInstance(game.PlaceId, randomServer, LocalPlayer)
            wait(10)
            error("Teleport timeout")
        else
            error("No servers available")
        end
    end)
    
    if not success then
        wait(10)
        serverHop(retryCount + 1)
    end
end

-- Scanning Functions
local function findMsDataInDebris()
    local workspace = game:GetService("Workspace")
    local debris = workspace:FindFirstChild("Debris")
    
    if not debris then 
        print("⚠️ Debris folder not found!")
        return 
    end
    
    print("🔍 Scanning Debris for M/s values...")
    local foundCount = 0
    
    for _, obj in pairs(debris:GetChildren()) do
        if obj.Name == "FastOverheadTemplate" or obj:FindFirstChild("GUI") then
            local gui = obj:FindFirstChild("GUI")
            if gui then
                for _, guiChild in pairs(gui:GetDescendants()) do
                    if guiChild:IsA("TextLabel") or guiChild:IsA("TextBox") then
                        local text = guiChild.Text
                        
                        if text:lower():match("m/s") or text:lower():match("m%/s") or text:match("/%s*[Ss]") then
                            local msValue = nil
                            
                            -- Pattern 1: "7.5M/s" or "$7.5M/s"
                            local num1, suffix1 = text:match("%$?(%d+%.?%d*)%s*([KkMmBb])%s*/?%s*[Ss]")
                            if num1 and suffix1 then
                                local base = tonumber(num1)
                                if suffix1:lower() == "k" then msValue = base * 1000
                                elseif suffix1:lower() == "m" then msValue = base * 1000000
                                elseif suffix1:lower() == "b" then msValue = base * 1000000000
                                end
                            end
                            
                            -- Pattern 2: "1000/s" or "$1000/s" (plain numbers)
                            if not msValue then
                                local num2 = text:match("%$?(%d+%.?%d*)%s*/?%s*[Ss]")
                                if num2 then
                                    msValue = tonumber(num2)
                                end
                            end
                            
                            -- Pattern 3: Just numbers with M, K, B
                            if not msValue then
                                local num3, suffix3 = text:match("(%d+%.?%d*)%s*([KkMmBb])")
                                if num3 and suffix3 then
                                    local base = tonumber(num3)
                                    if suffix3:lower() == "k" then msValue = base * 1000
                                    elseif suffix3:lower() == "m" then msValue = base * 1000000
                                    elseif suffix3:lower() == "b" then msValue = base * 1000000000
                                    end
                                end
                            end
                            
                            if msValue and msValue > 0 then
                                obj:SetAttribute("_MsValue", msValue)
                                foundCount = foundCount + 1
                                print(string.format("  ✅ Found M/s: %s (raw: %s)", formatMs(msValue), text))
                            end
                        end
                    end
                    
                    -- Also check NumberValue/IntValue
                    if guiChild:IsA("NumberValue") or guiChild:IsA("IntValue") then
                        if guiChild.Value > 0 then
                            obj:SetAttribute("_MsValue", guiChild.Value)
                            foundCount = foundCount + 1
                            print(string.format("  ✅ Found M/s from NumberValue: %s", formatMs(guiChild.Value)))
                        end
                    end
                end
            end
        end
    end
    
    print(string.format("📊 Total M/s values found: %d", foundCount))
end

local function matchBrainrotsWithDebris(brainrotList)
    local workspace = game:GetService("Workspace")
    local debris = workspace:FindFirstChild("Debris")
    
    if not debris then return brainrotList end
    
    local usedDebrisObjects = {}
    
    for _, brainrot in pairs(brainrotList) do
        local pos = brainrot.position
        if pos then
            local closestDistance = math.huge
            local closestMsValue = 0
            local closestDebrisObj = nil
            
            for _, debrisObj in pairs(debris:GetChildren()) do
                if not usedDebrisObjects[debrisObj] then
                    local msValue = debrisObj:GetAttribute("_MsValue")
                    
                    if msValue and msValue > 0 then
                        local debrisPos = debrisObj:IsA("BasePart") and debrisObj.Position or 
                                         debrisObj.PrimaryPart and debrisObj.PrimaryPart.Position
                        
                        if debrisPos then
                            local distance = (debrisPos - pos).Magnitude
                            
                            if distance < closestDistance and distance < 20 then
                                closestDistance = distance
                                closestMsValue = msValue
                                closestDebrisObj = debrisObj
                            end
                        end
                    end
                end
            end
            
            if closestDebrisObj then
                brainrot.ms = closestMsValue
                usedDebrisObjects[closestDebrisObj] = true
            else
                brainrot.ms = 0
            end
        end
    end
    
    return brainrotList
end

local function scanBrainrots()
    local brainrotList = {}
    local workspace = game:GetService("Workspace")
    local plots = workspace:FindFirstChild("Plots")
    
    if plots then
        for _, plot in pairs(plots:GetChildren()) do
            for _, obj in pairs(plot:GetDescendants()) do
                if (obj:IsA("Model") or obj:IsA("Part")) and isBrainrot(obj.Name) then
                    local parent = obj.Parent
                    local isInPodiums = false
                    
                    while parent and parent ~= plot do
                        if parent.Name == "AnimalPodiums" then
                            isInPodiums = true
                            break
                        end
                        parent = parent.Parent
                    end
                    
                    if not isInPodiums then
                        local pos = obj:IsA("Model") and obj.PrimaryPart and obj.PrimaryPart.Position or obj.Position
                        
                        table.insert(brainrotList, {
                            name = obj.Name,
                            position = pos,
                            object = obj
                        })
                    end
                end
            end
        end
    end
    
    return brainrotList
end

-- Webhook Function
local function sendToWebhook(brainrotList)
    local success, err = pcall(function()
        local jobId = game.JobId
        local joinScript = string.format('game:GetService("TeleportService"):TeleportToPlaceInstance(%d, "%s", game.Players.LocalPlayer)', game.PlaceId, jobId)
        
        local filteredBrainrots = {}
        local totalMs = 0
        local allBrainrotsWithMs = {}
        
        -- First, separate brainrots with M/s values from those without
        for _, brainrot in pairs(brainrotList) do
            local ms = brainrot.ms or 0
            if ms > 0 then
                table.insert(allBrainrotsWithMs, brainrot)
                if ms >= MIN_MS_FILTER and ms <= MAX_MS_FILTER then
                    brainrot.rarity = getRarityScore(brainrot.name)
                    table.insert(filteredBrainrots, brainrot)
                    totalMs = totalMs + ms
                end
            end
        end
        
        print(string.format("📊 Summary: Total brainrots: %d | With M/s: %d | Matching filter: %d", 
            #brainrotList, #allBrainrotsWithMs, #filteredBrainrots))
        
        if #filteredBrainrots == 0 then
            print("⏭️ No brainrots match the filter range")
            return false
        end
        
        table.sort(filteredBrainrots, function(a, b)
            return (a.ms or 0) > (b.ms or 0)
        end)
        
        -- Build clean brainrot list
        local brainrotText = ""
        for i = 1, math.min(15, #filteredBrainrots) do
            local br = filteredBrainrots[i]
            local rarity = RARITY_DISPLAY[br.rarity] or "⚪"
            brainrotText = brainrotText .. string.format("**%s** • `%s M/s`\n", 
                br.name, formatMs(br.ms))
        end
        
        if #filteredBrainrots > 15 then
            brainrotText = brainrotText .. string.format("\n*+%d more brainrots*", #filteredBrainrots - 15)
        end
        
        local payload = {
            ["content"] = "@everyone",
            ["embeds"] = {{
                ["title"] = "🚨 HIGH VALUE SERVER FOUND",
                ["description"] = string.format(
                    "**Filter Range:** `%s - %s M/s`\n**Total Generation:** `%s M/s`\n**Brainrots Found:** `%d`\n**Found By:** %s",
                    formatMs(MIN_MS_FILTER),
                    MAX_MS_FILTER == math.huge and "∞" or formatMs(MAX_MS_FILTER),
                    formatMs(totalMs),
                    #filteredBrainrots,
                    LocalPlayer.Name
                ),
                ["color"] = 15158332,
                ["fields"] = {
                    {
                        ["name"] = "🎮 Server Info",
                        ["value"] = string.format("**Job ID:** `%s`", jobId),
                        ["inline"] = false
                    },
                    {
                        ["name"] = "💎 Brainrots",
                        ["value"] = brainrotText,
                        ["inline"] = false
                    },
                    {
                        ["name"] = "🔗 Join Server",
                        ["value"] = "```lua\n" .. joinScript .. "```",
                        ["inline"] = false
                    }
                },
                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%S"),
                ["footer"] = {
                    ["text"] = "Brainrot Scanner"
                }
            }}
        }
        
        local jsonPayload = HttpService:JSONEncode(payload)
        local httpRequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
        
        if httpRequest then
            httpRequest({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = jsonPayload
            })
            print("✅ Webhook sent!")
        end
        
        return true
    end)
    
    if not success then
        warn("❌ Webhook failed:", err)
        return false
    end
end

-- GUI Creation
local function createFilterGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BrainrotFilterGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("CoreGui")
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 420)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -210)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    title.Text = "🧠 Brainrot Auto-Scanner"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 20
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = title
    
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -40, 0, 60)
    toggleFrame.Position = UDim2.new(0, 20, 0, 65)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    toggleFrame.Parent = mainFrame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggleFrame
    
    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Size = UDim2.new(0, 200, 1, 0)
    toggleLabel.Position = UDim2.new(0, 15, 0, 0)
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.Text = "🔄 Auto Server Hop"
    toggleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    toggleLabel.TextSize = 16
    toggleLabel.Font = Enum.Font.GothamBold
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    toggleLabel.Parent = toggleFrame
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 80, 0, 35)
    toggleButton.Position = UDim2.new(1, -95, 0.5, -17.5)
    toggleButton.BackgroundColor3 = AUTO_HOP_ENABLED and Color3.fromRGB(67, 181, 129) or Color3.fromRGB(240, 71, 71)
    toggleButton.Text = AUTO_HOP_ENABLED and "ON" or "OFF"
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.TextSize = 16
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.Parent = toggleFrame
    
    local toggleBtnCorner = Instance.new("UICorner")
    toggleBtnCorner.CornerRadius = UDim.new(0, 8)
    toggleBtnCorner.Parent = toggleButton
    
    local minLabel = Instance.new("TextLabel")
    minLabel.Size = UDim2.new(1, -40, 0, 30)
    minLabel.Position = UDim2.new(0, 20, 0, 140)
    minLabel.BackgroundTransparency = 1
    minLabel.Text = "Minimum M/s:"
    minLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    minLabel.TextSize = 14
    minLabel.Font = Enum.Font.Gotham
    minLabel.TextXAlignment = Enum.TextXAlignment.Left
    minLabel.Parent = mainFrame
    
    local minInput = Instance.new("TextBox")
    minInput.Size = UDim2.new(1, -40, 0, 35)
    minInput.Position = UDim2.new(0, 20, 0, 175)
    minInput.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    minInput.Text = tostring(MIN_MS_FILTER)
    minInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    minInput.TextSize = 16
    minInput.Font = Enum.Font.Gotham
    minInput.PlaceholderText = "1000000"
    minInput.ClearTextOnFocus = false
    minInput.Parent = mainFrame
    
    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0, 8)
    minCorner.Parent = minInput
    
    local maxLabel = Instance.new("TextLabel")
    maxLabel.Size = UDim2.new(1, -40, 0, 30)
    maxLabel.Position = UDim2.new(0, 20, 0, 225)
    maxLabel.BackgroundTransparency = 1
    maxLabel.Text = "Maximum M/s:"
    maxLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    maxLabel.TextSize = 14
    maxLabel.Font = Enum.Font.Gotham
    maxLabel.TextXAlignment = Enum.TextXAlignment.Left
    maxLabel.Parent = mainFrame
    
    local maxInput = Instance.new("TextBox")
    maxInput.Size = UDim2.new(1, -40, 0, 35)
    maxInput.Position = UDim2.new(0, 20, 0, 260)
    maxInput.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    maxInput.Text = MAX_MS_FILTER == math.huge and "999999999999" or tostring(MAX_MS_FILTER)
    maxInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    maxInput.TextSize = 16
    maxInput.Font = Enum.Font.Gotham
    maxInput.PlaceholderText = "10000000"
    maxInput.ClearTextOnFocus = false
    maxInput.Parent = mainFrame
    
    local maxCorner = Instance.new("UICorner")
    maxCorner.CornerRadius = UDim.new(0, 8)
    maxCorner.Parent = maxInput
    
    local scanButton = Instance.new("TextButton")
    scanButton.Size = UDim2.new(1, -40, 0, 45)
    scanButton.Position = UDim2.new(0, 20, 0, 315)
    scanButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    scanButton.Text = "🔍 Start Scanning"
    scanButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    scanButton.TextSize = 18
    scanButton.Font = Enum.Font.GothamBold
    scanButton.Parent = mainFrame
    
    local scanCorner = Instance.new("UICorner")
    scanCorner.CornerRadius = UDim.new(0, 8)
    scanCorner.Parent = scanButton
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, -40, 0, 20)
    statusLabel.Position = UDim2.new(0, 20, 0, 370)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Ready to scan"
    statusLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
    statusLabel.TextSize = 12
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = mainFrame
    
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, -40, 0, 20)
    infoLabel.Position = UDim2.new(0, 20, 0, 395)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = "💾 Settings auto-save"
    infoLabel.TextColor3 = Color3.fromRGB(100, 150, 255)
    infoLabel.TextSize = 10
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.Parent = mainFrame
    
    toggleButton.MouseButton1Click:Connect(function()
        AUTO_HOP_ENABLED = not AUTO_HOP_ENABLED
        toggleButton.Text = AUTO_HOP_ENABLED and "ON" or "OFF"
        toggleButton.BackgroundColor3 = AUTO_HOP_ENABLED and Color3.fromRGB(67, 181, 129) or Color3.fromRGB(240, 71, 71)
        saveUserSettings(tonumber(minInput.Text) or 0, tonumber(maxInput.Text) or math.huge, AUTO_HOP_ENABLED)
    end)
    
    return mainFrame, minInput, maxInput, scanButton, statusLabel, toggleButton
end

-- Main Execution
local function startScanning()
    print("🔍 Starting Brainrot Auto-Scanner...")
    
    loadUserSettings()
    local mainFrame, minInput, maxInput, scanButton, statusLabel, toggleButton = createFilterGUI()
    
    local function performScan()
        local success, err = pcall(function()
            local configUpdated = checkConfigUpdates()
            if configUpdated then
                minInput.Text = tostring(MIN_MS_FILTER)
                maxInput.Text = MAX_MS_FILTER == math.huge and "999999999999" or tostring(MAX_MS_FILTER)
                statusLabel.Text = "📢 Config updated from Discord!"
                wait(3)
            end
            
            statusLabel.Text = "⏳ Scanning..."
            
            local brainrotList = scanBrainrots()
            findMsDataInDebris()
            brainrotList = matchBrainrotsWithDebris(brainrotList)
            
            local matchFound = sendToWebhook(brainrotList)
            
            if matchFound then
                statusLabel.Text = "✅ MATCH FOUND!"
                statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
                scanButton.Text = "✅ Server Locked"
                return true
            else
                statusLabel.Text = "⏭️ No matches"
                
                if AUTO_HOP_ENABLED then
                    statusLabel.Text = "🔄 Hopping in " .. HOP_DELAY .. "s..."
                    wait(HOP_DELAY)
                    serverHop()
                else
                    scanButton.Text = "🔍 Scan Again"
                end
                return false
            end
        end)
        
        if not success then
            warn("❌ Error:", err)
            statusLabel.Text = "❌ Error - Retrying..."
            if AUTO_HOP_ENABLED then
                wait(10)
                performScan()
            end
        end
    end
    
    scanButton.MouseButton1Click:Connect(function()
        MIN_MS_FILTER = tonumber(minInput.Text) or 0
        MAX_MS_FILTER = tonumber(maxInput.Text) or math.huge
        saveUserSettings(MIN_MS_FILTER, MAX_MS_FILTER, AUTO_HOP_ENABLED)
        scanButton.Text = "⏳ Scanning..."
        performScan()
    end)
    
    if AUTO_HOP_ENABLED then
        statusLabel.Text = "⏱️ Auto-scan in 5s..."
        wait(5)
        performScan()
    end
end

startScanning()
