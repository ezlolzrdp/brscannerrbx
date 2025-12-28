-- ====================================
-- BRAINROT SCANNER - DUAL WEBHOOK VERSION
-- ====================================

-- Configuration
local DISCORD_WEBHOOK_URL = "https://discord.com/api/webhooks/1452120328364101693/XSaMuA_dNl_GShp3ONOOEmNnkakZeMctfvyKXVV-hJDxgK8H6ZTUoCApFxBw4Nzbo5_8"
local REPLIT_WEBHOOK_URL = "https://nodejs--bugpvpalt.replit.app/webhook"
local HOP_DELAY = 1
local DEBUG_MODE = true

-- /s Filter Settings (EDIT THESE) - Note: these are in /s not m/s!
local MIN_FILTER = 20000000 -- Minimum /s value (e.g., 100 = 100/s)
local MAX_FILTER = math.huge  -- Maximum /s value
local AUTO_SCAN_ON_JOIN = true

-- Server hop settings
local MIN_PLAYERS_IN_SERVER = 0  -- Don't join servers with less than this many players
local MAX_VISITED_SERVERS = 50   -- Remember this many visited servers

-- ========================================
-- INSERT YOUR BRAINROT NAMES LIST HERE
-- ========================================
local BRAINROT_NAMES = {
    "Noobini Pizzanini", "Lirili Larila", "Tim Cheese", "Fluriflura", "Talpa Di Fero", "Noobini Santanini", "Svinina Bombardino", "Raccooni Jandelini", "Pipi Kiwi", "Tartaragno", "Pipi Corni", "Trippi Troppi", "Tung Tung Tung Sahur", "Gangster Footera", "Bandito Bobritto", "Boneca Ambalabu", "Cacto Hipopotamo", "Ta Ta Ta Ta Sahur", "Tric Trac Baraboom", "Frogo Elgo", "Pipi Avocado", "Cupcake Koala", "Pinealotto Fruttarino", "Cappuccino Assassino", "Bandito Axolito", "Brr Brr Patapim", "Avocadini Antilopini", "Trulimero Trulicina", "Bambini Crostini", "Malame Amarele", "Bananita Dolphinita", "Perochello Lemonchello", "Brri Brri Bicus Dicus Bombicus", "Avocadini Guffo", "Ti Ti Ti Sahur", "Mangolini Parrocini", "Frogato Pirato", "Salamino Penguino", "Doi Doi Do", "Penguin Tree", "Wombo Rollo", "Penguino Cocosino", "Mummio Rappitto", "Burbaloni Loliloli", "Chimpanzini Bananini", "Tirilikalika Tirilikalako", "Ballerina Cappuccina", "Chef Crabracadabra", "Lionel Cactuseli", "Glorbo Fruttodrillo", "Quivioli Ameleonni", "Blueberrinni Octopusini", "Clickerino Crabo", "Caramello Filtrello", "Pipi Potato", "Strawberrelli Flamingelli", "Cocosini Mama", "Pandaccini Bananini", "Quackula", "Pi Pi Watermelon", "Signore Carapace", "Sigma Boy", "Sigma Girl", "Chocco Bunny", "Puffaball", "Sealo Regalo", "Buho de Fuego", "Frigo Camelo", "Orangutini Ananassini", "Rhino Toasterino", "Bombardiro Crocodilo", "Brutto Gialutto", "Spioniro Golubiro", "Bombombini Gusini", "Zibra Zubra Zibralini", "Tigrilini Watermelini", "Avocadorilla", "Cavallo Virtuoso", "Te Te Te Sahur", "Gorillo Subwoofero", "Gorillo Watermelondrillo", "Stoppo Luminino", "Tracoducotulu Delapeladustuz", "Tob Tobi Tobi", "Lerulerulerule", "Ganganzelli Trulala", "Magi Ribbitini", "Rhino Helicopterino", "Jingle Jingle Sahur", "Los Noobinis", "Cachorrito Melonito", "Carloooo", "Elefanto Frigo", "Carrotini Brainini", "Centrucci Nuclucci", "Toiletto Focaccino", "Jacko Spaventosa", "Bananito Bandito", "Tree Tree Tree Sahur", "Cocofanto Elefanto", "Antonio", "Girafa Celestre", "Gattatino Nyanino", "Gattatino Neonino", "Chihuanini Taconini", "Matteo", "Tralalero Tralala", "Los Crocodillitos", "Tigroligre Frutonni", "Odin Din Din Dun", "Orcalero Orcala", "Money Money Man", "Alessio", "Unclito Samito", "Statutino Libertino", "Tipi Topi Taco", "Tralalita Tralala", "Tukanno Banana", "Extinct Ballerina", "Vampira Cappucina", "Espresso Signora", "Trenozosturzzo Turbo 3000", "Bulbito Bandito Traktorito", "Urubini Flamenguini", "Jacko Jack Jack", "Trippi Troppi Troppa Trippa", "Capi Taco", "Los Chihuaninis", "Gattito Tacoto", "Las Capuchinas", "Ballerino Lololo", "Los Tungtungtungcitos", "Pakrahmatmamat", "Ballerina Peppermintina", "Piccione Macchina", "Pakrahmatmatina", "Los Bombinitos", "Tractoro Dinosauro", "Brr Es Teh Patipum", "Cacasito Satalito", "Orcalita Orcala", "Aquanaut", "Tartaruga Cisterna", "Snailenzo", "Corn Corn Corn Sahur", "Squalanana", "Mummy Ambalabu", "Los Orcalitos", "Dug Dug Dug", "Ginger Globo", "Yeti Claus", "Crabbo Limonetta", "Los Tipi Tacos", "Granchiello Spiritell", "Frio Ninja", "Piccionetta Macchina", "Mastodontico Telepiedone", "Los Gattitos", "Bambu Bambu Sahur", "Chrismasmamat", "Anpali Babel", "Cappuccino Clownino", "Bombardini Tortinii", "Brasilini Berimbini", "Belula Beluga", "Krupuk Pagi Pagi", "Skull Skull Skull", "Cocoa Assassino", "Tentacolo Tecnico", "Ginger Cisterna", "Pop Pop Sahur", "Noo La Polizia", "La Vacca Saturno Saturnita", "Pandanini Frostini", "Bisonte Giuppitere", "Blackhole Goat", "Jackorilla", "Agarrini La Palini", "Chachechi", "Karkerkar Kurkur", "Los Tortus", "Los Matteos", "Sammyni Spyderini", "Trenostruzzo Turbo 4000", "Chimpanzini Spiderini", "Boatito Auratito", "Fragola La La La", "Dul Dul Dul", "La Vacca Prese Presente", "Frankentteo", "Karker Sahur", "Torrtuginni Dragonfrutini", "Los Tralaleritos", "Zombie Tralala", "La Cucaracha", "Vulturino Skeletono", "Guerriro Digitale", "Extinct Tralalero", "Yess My Examine", "Extinct Matteo", "Las Tralaleritas", "Reindeer Tralala", "Las Vaquitas Saturnitas", "Pumpkin Spyderini", "Job Job Job Sahur", "Los Karkeritos", "Graipuss Medussi", "Santteo", "La Vacca Jacko Linterino", "Triplito Tralaleritos", "Trickolino", "Giftini Spyderini", "Los Spyderinis", "Perrito Burrito", "1x1x1x1", "Los Cucarachas", "Please My Present", "Cuadramat and Pakrahmatmamat", "Los Jobcitos", "Nooo My Hotspot", "Pot Hotspot", "Noo My Examine", "Telemorte", "La Sahur Combinasion", "List List List Sahur", "To To To Sahur", "Pirulitoita Bicicletaire", "25", "Santa Hotspot", "Horegini Boom", "Quesadilla Crocodila", "Pot Pumpkin", "Naughty Naughty", "Ho Ho Ho Sahur", "Chicleteira Bicicleteira", "Spaghetti Tualetti", "Esok Sekolah", "Quesadillo Vampiro", "Burrito Bandito", "Chicleteirina Bicicleteirina", "Los Quesadillas", "Noo My Candy", "Los Nooo My Hotspotsitos", "La Grande Combinasion", "Rang Ring Bus", "Guest 666", "Los Chicleteiras", "67", "Mariachi Corazoni", "Los Burritos", "Los 25", "Swag Soda", "Chimnino", "Los Combinasionas", "Chicleteira Noelteira", "Fishino Clownino", "Tacorita Bicicleta", "Nuclearo Dinosauro", "Las Sis", "La Karkerkar Combinasion", "Chillin Chili", "Chipso and Queso", "Money Money Puggy", "Celularcini Viciosini", "Los Planitos", "Los Mobilis", "Los 67", "Mieteteira Bicicleteira", "La Spooky Grande", "Los Spooky Combinasionas", "Los Candies", "Los Hotspositos", "Los Puggies", "W or L", "Tralalalaledon", "La Extinct Grande Combinasion", "Tralaledon", "La Jolly Grande", "Los Primos", "Eviledon", "Los Tacoritas", "Tang Tang Kelentang", "Ketupat Kepat", "Los Bros", "Tictac Sahur", "La Supreme Combinasion", "Gingerat Gerat", "Orcaledon", "Ketchuru and Masturu", "Garama and Madundung", "Festive 67", "La Ginger Sekolah", "Spooky and Pumpky", "Lavadorito Spinito", "Los Spaghettis", "La Casa Boo", "Fragrama and Chocrama", "La Secret Combinasion", "Reinito Sleighito", "Burguro and Fryuro", "Dragon Cannelloni", "Cooki and Milki", "Capitano Moby", "Headless Horseman", "Strawberry Elephant", "Meowl", "2", "6", "Admin Lucky Block", "Brainrot God", "Brainrot God Lucky Block", "Brainrot Trader", "Ice Dragon", "John Pork", "Christmas Brainrots", "Festive Lucky Block", "Arachnid Family", "Combinasions Family", "Karkerkur Family", "Limited Stock Brainrots"
}
-- ========================================

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

-- Services
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Request function
local requestFunc = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request


-- ========= UTILITY FUNCTIONS =========
local function formatValue(value)
    if value >= 1000000000 then return string.format("%.2fB", value / 1000000000)
    elseif value >= 1000000 then return string.format("%.2fM", value / 1000000)
    elseif value >= 1000 then return string.format("%.2fK", value / 1000)
    else return tostring(math.floor(value))
    end
end

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

local function getWorldPos(inst)
    if not inst then return nil end
    if inst:IsA("BasePart") then return inst.Position end
    if inst:IsA("Model") then
        if inst.PrimaryPart then return inst.PrimaryPart.Position end
        for _, d in ipairs(inst:GetDescendants()) do
            if d:IsA("BasePart") then return d.Position end
        end
    end
    for _, d in ipairs(inst:GetDescendants()) do
        if d:IsA("BasePart") then return d.Position end
    end
    return nil
end

-- CORRECTED /s parser - handles all formats: 100/s, 1k/s, 100k/s, 1m/s, etc.
local function parsePerSecondFromText(text)
    if typeof(text) ~= "string" then return nil end
    
    -- Remove all commas first, then clean whitespace
    local cleaned = text:gsub(",", ""):gsub("%s+", " ")
    local lower = cleaned:lower()
    
    if DEBUG_MODE then
        print("🔍 Parsing text:", text, "→ Cleaned:", cleaned)
    end
    
    -- Look for /s patterns (the actual income rate)
    local patterns = {
        -- Pattern 1: Number with suffix and /s (e.g., "1.5m/s", "100k/s")
        "([%d%.]+)%s*([kmb])%s*/%s*s",
        
        -- Pattern 2: Plain number with /s (e.g., "100/s", "1500/s")
        "([%d%.]+)%s*/%s*s",
    }
    
    for patternIndex, pattern in ipairs(patterns) do
        local num, suffix = lower:match(pattern)
        if num then
            local base = tonumber(num)
            if base and base > 0 then
                suffix = suffix or ""
                
                -- Apply suffix multiplier
                if suffix == "k" then 
                    base = base * 1000
                elseif suffix == "m" then 
                    base = base * 1000000
                elseif suffix == "b" then 
                    base = base * 1000000000
                end
                
                if DEBUG_MODE then
                    print(string.format("✅ Pattern %d matched: %s%s → %.0f /s", 
                        patternIndex, num, suffix, base))
                end
                
                return base
            end
        end
    end
    
    if DEBUG_MODE then
        print("❌ No valid /s pattern found in:", text)
    end
    
    return nil
end

-- ========= ENHANCED DEBRIS SCAN =========
local function scanDebrisEnhanced()
    local debrisFolder = Workspace:FindFirstChild("Debris")
    if not debrisFolder then 
        print("⚠️ No Debris folder found")
        return {} 
    end

    local dataByPosition = {}
    local totalFound = 0
    local skippedNoDollar = 0
    local skippedOfflineCash = 0
    local skippedNoSlash = 0

    print("🔍 Scanning Debris folder...")
    
    for _, obj in ipairs(debrisFolder:GetChildren()) do
        local perSecValue = nil
        local foundText = nil
        local objPos = getWorldPos(obj)

        for _, gui in ipairs(obj:GetDescendants()) do
            if gui:IsA("TextLabel") or gui:IsA("TextBox") then
                local text = gui.Text
                local lowerText = text:lower()
                
                -- Skip offline cash
                if lowerText:match("offline") or lowerText:match("cash") then
                    if DEBUG_MODE then
                        print(string.format("⏭️ Skipped (offline cash): '%s'", text))
                    end
                    skippedOfflineCash = skippedOfflineCash + 1
                    continue
                end
                
                local hasDollar = text:match("%$")
                local hasSlash = text:match("/s") or text:match("/S")
                
                -- Only parse if it has both $ and /s indicators
                if hasDollar and hasSlash then
                    local v = parsePerSecondFromText(text)
                    if v and v > 0 then
                        perSecValue = v
                        foundText = text
                        if DEBUG_MODE then
                            print(string.format("💰 Valid /s: %.0f from text: '%s'", v, text))
                        end
                        break
                    end
                else
                    if DEBUG_MODE then
                        if not hasDollar then
                            skippedNoDollar = skippedNoDollar + 1
                        elseif not hasSlash then
                            skippedNoSlash = skippedNoSlash + 1
                        end
                    end
                end
            end
        end

        if perSecValue and objPos then
            table.insert(dataByPosition, {
                value = perSecValue,
                pos = objPos,
                text = foundText,
                object = obj,
                matched = false
            })
            totalFound = totalFound + 1
            print(string.format("✅ Debris #%d: %.0f /s at position (%d, %d, %d) | Text: '%s'", 
                totalFound, perSecValue, 
                math.floor(objPos.X), math.floor(objPos.Y), math.floor(objPos.Z),
                foundText))
        end
    end

    print(string.format("📊 Total valid debris (with $ and /s): %d", totalFound))
    if DEBUG_MODE then
        print(string.format("⏭️ Skipped (no $): %d", skippedNoDollar))
        print(string.format("⏭️ Skipped (no /s): %d", skippedNoSlash))
        print(string.format("⏭️ Skipped (offline cash): %d", skippedOfflineCash))
    end
    return dataByPosition
end

-- ========= SCAN BRAINROTS =========
local function scanBrainrots()
    local brainrotList = {}
    local plots = Workspace:FindFirstChild("Plots")
    
    if not plots then
        warn("⚠️ No Plots folder found!")
        return brainrotList
    end
    
    print("🔍 Scanning for brainrots...")
    
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
                    local pos = getWorldPos(obj)
                    if pos then
                        table.insert(brainrotList, {
                            name = obj.Name,
                            position = pos,
                            object = obj,
                            value = 0
                        })
                        print(string.format("🎯 Found brainrot: %s at (%d, %d, %d)", 
                            obj.Name, 
                            math.floor(pos.X), math.floor(pos.Y), math.floor(pos.Z)))
                    end
                end
            end
        end
    end
    
    print(string.format("📊 Total brainrots found: %d", #brainrotList))
    return brainrotList
end

-- ========= IMPROVED MATCHING ALGORITHM =========
local function matchBrainrotsWithDebris(brainrotList, debrisData)
    print("\n🔗 Starting improved proximity matching...")
    print(string.format("   Brainrots to match: %d", #brainrotList))
    print(string.format("   Debris objects: %d", #debrisData))
    
    local pairs = {}
    
    for i, brainrot in ipairs(brainrotList) do
        if not brainrot.position then continue end
        
        for j, debris in ipairs(debrisData) do
            if not debris.matched then
                local dist = (debris.pos - brainrot.position).Magnitude
                local verticalDist = debris.pos.Y - brainrot.position.Y
                
                if verticalDist > 0 and verticalDist < 20 and dist < 30 then
                    table.insert(pairs, {
                        brainrotIndex = i,
                        debrisIndex = j,
                        distance = dist,
                        verticalDist = verticalDist,
                        brainrotName = brainrot.name,
                        debrisValue = debris.value,
                        debrisText = debris.text
                    })
                    
                    if DEBUG_MODE then
                        print(string.format("   📍 Potential pair: %s ← %.0f /s (dist: %.2f, above: %.2f studs)", 
                            brainrot.name, debris.value, dist, verticalDist))
                    end
                elseif verticalDist <= 0 and DEBUG_MODE then
                    print(string.format("   ⬇️ Rejected (below brainrot): debris at Y=%d vs brainrot %s at Y=%d", 
                        math.floor(debris.pos.Y), brainrot.name, math.floor(brainrot.position.Y)))
                end
            end
        end
    end
    
    print(string.format("   Found %d potential matches within range", #pairs))
    
    table.sort(pairs, function(a, b) 
        return a.distance < b.distance 
    end)
    
    local matchedBrainrots = {}
    local matchedDebris = {}
    local matchCount = 0
    
    for _, pair in ipairs(pairs) do
        local bIndex = pair.brainrotIndex
        local dIndex = pair.debrisIndex
        
        if not matchedBrainrots[bIndex] and not matchedDebris[dIndex] then
            brainrotList[bIndex].value = debrisData[dIndex].value
            debrisData[dIndex].matched = true
            matchedBrainrots[bIndex] = true
            matchedDebris[dIndex] = true
            matchCount = matchCount + 1
            
            print(string.format("✅ Match #%d: %s → %.0f /s (dist: %.2f studs, above: %.2f) | Text: '%s'", 
                matchCount,
                pair.brainrotName,
                pair.debrisValue,
                pair.distance,
                pair.verticalDist,
                pair.debrisText
            ))
        end
    end
    
    local unmatchedCount = 0
    for i, brainrot in ipairs(brainrotList) do
        if not matchedBrainrots[i] then
            unmatchedCount = unmatchedCount + 1
            if DEBUG_MODE then
                print(string.format("❌ No match: %s at (%d, %d, %d)", 
                    brainrot.name,
                    math.floor(brainrot.position.X),
                    math.floor(brainrot.position.Y),
                    math.floor(brainrot.position.Z)
                ))
            end
        end
    end
    
    print(string.format("\n📊 Matching Summary:"))
    print(string.format("   ✅ Matched: %d", matchCount))
    print(string.format("   ❌ Unmatched: %d", unmatchedCount))
    print(string.format("   📍 Unused debris: %d", #debrisData - matchCount))
    
    return brainrotList
end



-- ========= IMPROVED SERVER HOP WITH FILE PERSISTENCE =========
local function serverHop()
    print("🔄 Initiating server hop...")
    
    -- Load visited servers from file
    local AllIDs = {}
    local actualHour = os.date("!*t").hour
    
    local File = pcall(function()
        AllIDs = HttpService:JSONDecode(readfile("brainrot-servers.json"))
    end)
    
    if not File then
        table.insert(AllIDs, actualHour)
        pcall(function()
            writefile("brainrot-servers.json", HttpService:JSONEncode(AllIDs))
        end)
    end
    
    local success, err = pcall(function()
        local url = string.format(
            "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100",
            game.PlaceId
        )
        
        local response = game:HttpGet(url)
        local data = HttpService:JSONDecode(response)
        
        local num = 0
        for _, server in pairs(data.data) do
            local Possible = true
            local ID = tostring(server.id)
            
            -- Check if server meets requirements
            if server.playing >= MIN_PLAYERS_IN_SERVER and server.playing < server.maxPlayers then
                
                -- Check against visited servers
                for _, Existing in pairs(AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                            if DEBUG_MODE then
                                print(string.format("   ⏭️ Skipped (visited): %d/%d players", server.playing, server.maxPlayers))
                            end
                        end
                    else
                        -- Reset file if hour changed
                        if tonumber(actualHour) ~= tonumber(Existing) then
                            pcall(function()
                                delfile("brainrot-servers.json")
                                AllIDs = {}
                                table.insert(AllIDs, actualHour)
                            end)
                        end
                    end
                    num = num + 1
                end
                
                -- Teleport to valid server
                if Possible == true then
                    table.insert(AllIDs, ID)
                    pcall(function()
                        writefile("brainrot-servers.json", HttpService:JSONEncode(AllIDs))
                    end)
                    
                    print(string.format("🎯 Teleporting to server with %d/%d players...", 
                        server.playing, server.maxPlayers))
                    print(string.format("📊 Total visited servers: %d", #AllIDs - 1))
                    
                    local teleportSuccess = pcall(function()
                        TeleportService:TeleportToPlaceInstance(
                            game.PlaceId,
                            ID,
                            LocalPlayer
                        )
                    end)
                    
                    if not teleportSuccess then
                        warn("⚠️ Teleport failed (server full?), trying next server...")
                        continue  -- Try next server in the loop
                    else
                        return  -- Successfully teleported
                    end
                end
            elseif DEBUG_MODE then
                if server.playing < MIN_PLAYERS_IN_SERVER then
                    print(string.format("   ⏭️ Skipped (too few players): %d/%d", server.playing, server.maxPlayers))
                end
            end
        end
        
        warn("⚠️ No valid servers found, trying standard teleport...")
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end)
    
    if not success then
        warn("❌ Server hop failed:", err)
        warn("🔄 Retrying in 3 seconds...")
        wait(3)
        serverHop()  -- Retry
    end
end

-- ========= DUAL WEBHOOK SYSTEM =========
local function sendToWebhook(brainrotList)
    print("\n📤 Preparing webhooks...")
    
    local filteredBrainrots = {}
    local totalGeneration = 0
    
    for _, brainrot in pairs(brainrotList) do
        local value = brainrot.value or 0
        if value >= MIN_FILTER and value <= MAX_FILTER then
            brainrot.rarity = getRarityScore(brainrot.name)
            table.insert(filteredBrainrots, brainrot)
            totalGeneration = totalGeneration + value
        end
    end
    
    print(string.format("📊 Filtered: %d brainrots (%.0f total /s)", #filteredBrainrots, totalGeneration))
    print(string.format("   Filter: %.0f - %s /s", MIN_FILTER, MAX_FILTER == math.huge and "∞" or formatValue(MAX_FILTER)))
    
    if #filteredBrainrots == 0 then
        print("⏭️ No matches - skipping webhooks")
        return false
    end
    
    print("✅ MATCH FOUND! Sending webhooks...")
    
    table.sort(filteredBrainrots, function(a, b) return (a.value or 0) > (b.value or 0) end)
    
    local jobId = game.JobId
    
    -- ========= WEBHOOK 1: SIMPLE JOB ID TO REPLIT =========
    local replitPayload = {
        ["content"] = string.format("Job ID: `%s` Scanner: %s", jobId, LocalPlayer.Name)
    }
    
    if requestFunc then
        local success1 = pcall(function()
            requestFunc({
                Url = REPLIT_WEBHOOK_URL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode(replitPayload)
            })
        end)
        
        if success1 then
            print("✅ REPLIT WEBHOOK SENT (Job ID only)")
        else
            warn("❌ Replit webhook failed")
        end
    end
    
    -- ========= WEBHOOK 2: FULL DETAILS TO DISCORD =========
    local content = "@everyone\n🚨 **HIGH VALUE BRAINROTS DETECTED**\n\n"
    
    -- Top Generators
    if #filteredBrainrots >= 1 then
        content = content .. "🏆 **TOP GENERATORS**\n"
        for i = 1, math.min(2, #filteredBrainrots) do
            local brainrot = filteredBrainrots[i]
            local rarityDisplay = RARITY_DISPLAY[brainrot.rarity] or ""
            content = content .. string.format("#%d - **%s**\n%s\n💰 **%s/s**\n\n",
                i, brainrot.name, rarityDisplay, formatValue(brainrot.value))
        end
    end
    
    -- Other Brainrots
    if #filteredBrainrots > 2 then
        content = content .. "📋 **OTHER BRAINROTS**\n"
        for i = 3, math.min(6, #filteredBrainrots) do
            local brainrot = filteredBrainrots[i]
            local rarityDisplay = RARITY_DISPLAY[brainrot.rarity] or ""
            content = content .. string.format("`#%d` %s **%s** → `%s/s` ",
                i, rarityDisplay, brainrot.name, formatValue(brainrot.value))
        end
        content = content .. "\n\n"
    end
    
    -- Stats
    content = content .. string.format("💰 **Total Generation**\n```\n%s/s\n```\n\n", formatValue(totalGeneration))
    content = content .. string.format("🧠 **Total Brainrots**\n```\n%d\n```\n\n", #filteredBrainrots)
    content = content .. string.format("⚙️ **Filter Range**\n```\n%s - %s /s\n```\n\n",
        formatValue(MIN_FILTER),
        MAX_FILTER == math.huge and "∞" or formatValue(MAX_FILTER))
    
    -- Server Info
    content = content .. string.format("🎮 **Server Information**\nJob ID: `%s` Scanner: %s\n", jobId, LocalPlayer.Name)
    content = content .. "Brainrot Scanner v2.1"
    
    local discordPayload = {
        ["content"] = content
    }
    
    if requestFunc then
        local success2 = pcall(function()
            requestFunc({
                Url = DISCORD_WEBHOOK_URL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode(discordPayload)
            })
        end)
        
        if success2 then
            print("✅ DISCORD WEBHOOK SENT (Full details)")
        else
            warn("❌ Discord webhook failed")
        end
    else
        warn("❌ No HTTP request function available")
    end
    
    return true
end

-- ========= CLEAN BUTTON UI =========
local function createButtons()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BrainrotScannerButtons"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("CoreGui")
    
    -- Scan Server Button
    local scanButton = Instance.new("TextButton")
    scanButton.Size = UDim2.new(0, 180, 0, 50)
    scanButton.Position = UDim2.new(1, -200, 1, -120)
    scanButton.AnchorPoint = Vector2.new(0, 1)
    scanButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    scanButton.Text = "🔍 Scan Server"
    scanButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    scanButton.TextSize = 18
    scanButton.Font = Enum.Font.GothamBold
    scanButton.BorderSizePixel = 0
    scanButton.Parent = screenGui
    
    local scanCorner = Instance.new("UICorner")
    scanCorner.CornerRadius = UDim.new(0, 10)
    scanCorner.Parent = scanButton
    
    -- Server Hop Button
    local hopButton = Instance.new("TextButton")
    hopButton.Size = UDim2.new(0, 180, 0, 50)
    hopButton.Position = UDim2.new(1, -200, 1, -60)
    hopButton.AnchorPoint = Vector2.new(0, 1)
    hopButton.BackgroundColor3 = Color3.fromRGB(67, 181, 129)
    hopButton.Text = "🔄 Server Hop"
    hopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    hopButton.TextSize = 18
    hopButton.Font = Enum.Font.GothamBold
    hopButton.BorderSizePixel = 0
    hopButton.Parent = screenGui
    
    local hopCorner = Instance.new("UICorner")
    hopCorner.CornerRadius = UDim.new(0, 10)
    hopCorner.Parent = hopButton
    
    -- Hover effects
    scanButton.MouseEnter:Connect(function()
        scanButton.BackgroundColor3 = Color3.fromRGB(108, 121, 255)
    end)
    
    scanButton.MouseLeave:Connect(function()
        scanButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    end)
    
    hopButton.MouseEnter:Connect(function()
        hopButton.BackgroundColor3 = Color3.fromRGB(77, 201, 149)
    end)
    
    hopButton.MouseLeave:Connect(function()
        hopButton.BackgroundColor3 = Color3.fromRGB(67, 181, 129)
    end)
    
    return scanButton, hopButton
end

-- ========= SCAN FUNCTION =========
local function performScan()
    print("\n" .. string.rep("=", 60))
    print("🔍 SCANNING SERVER...")
    
    local debrisData = scanDebrisEnhanced()
    local brainrotList = scanBrainrots()
    brainrotList = matchBrainrotsWithDebris(brainrotList, debrisData)
    
    sendToWebhook(brainrotList)
    
    print(string.format("\n⏱️ Hopping to next server in %d seconds...", HOP_DELAY))
    wait(HOP_DELAY)
    serverHop()
end

-- ========= MAIN =========
print("🚀 Brainrot Scanner v2.1 Loading...")
print("⚙️ Filter: Min=" .. formatValue(MIN_FILTER) .. "/s | Max=" .. (MAX_FILTER == math.huge and "∞" or formatValue(MAX_FILTER)) .. "/s")
print("📤 Discord Webhook: " .. (DISCORD_WEBHOOK_URL ~= "YOUR_DISCORD_WEBHOOK_URL_HERE" and "✅ Configured" or "❌ NOT SET"))
print("📤 Replit Webhook: " .. REPLIT_WEBHOOK_URL)
print("👥 Min Players: " .. MIN_PLAYERS_IN_SERVER)
print("🔄 Server Memory: " .. MAX_VISITED_SERVERS)

local scanButton, hopButton = createButtons()

scanButton.MouseButton1Click:Connect(function()
    scanButton.Text = "⏳ Scanning..."
    performScan()
    wait(1)
    scanButton.Text = "🔍 Scan Server"
end)

hopButton.MouseButton1Click:Connect(function()
    hopButton.Text = "🔄 Hopping..."
    wait(0.5)
    serverHop()
end)

print("✅ Buttons loaded!")

if AUTO_SCAN_ON_JOIN then
    print("⏱️ Auto-scan starting in 5 seconds...")
    wait(5)
    performScan()
end
