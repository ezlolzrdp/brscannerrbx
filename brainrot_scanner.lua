-- ====================================
-- BRAINROT SCANNER - DUAL WEBHOOK VERSION (NO SERVER HOP)
-- With Beautiful Discord Embeds
-- ====================================

-- Configuration
local DISCORD_WEBHOOK_URL = "https://discord.com/api/webhooks/1452120328364101693/XSaMuA_dNl_GShp3ONOOEmNnkakZeMctfvyKXVV-hJDxgK8H6ZTUoCApFxBw4Nzbo5_8"
local REPLIT_WEBHOOK_URL = "https://nodejs--bugpvpalt.replit.app/webhook"
local DEBUG_MODE = true

-- /s Filter Settings (EDIT THESE) - Note: these are in /s not m/s!
local MIN_FILTER = 1 -- Minimum /s value (e.g., 100 = 100/s)
local MAX_FILTER = math.huge  -- Maximum /s value
local AUTO_SCAN_ON_JOIN = true

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

-- Get brainrot image from wiki
local function getBrainrotImageUrl(displayName)
    if not displayName or displayName == "" then return nil end
    local page = displayName:gsub("%s+", "_"):gsub("^%s*(.-)%s*$", "%1")
    local url = "https://stealabrainrot.fandom.com/wiki/" .. page
    local ok, html = pcall(function() return game:HttpGet(url, true) end)
    if not ok or not html then return nil end
    local og = html:match('<meta%s+property="og:image"%s+content="([^"]+)')
    if og then return og:match("(https?://[^?\"'>]+)") end
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

-- ========= BEAUTIFUL DISCORD WEBHOOK (Like Script 2) =========
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
    local players = #Players:GetPlayers()
    local timeString = os.date("%H:%M:%S %d/%m/%Y")
    
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
    
    -- ========= WEBHOOK 2: BEAUTIFUL DISCORD EMBED (LIKE SCRIPT 2) =========
    local topBrainrot = filteredBrainrots[1]
    local image = getBrainrotImageUrl(topBrainrot.name)
    
    local joinLink = "https://www.roblox.com/games/start?placeId=" .. tostring(game.PlaceId) .. "&gameInstanceId=" .. tostring(jobId)
    local joinScript = "game:GetService(\"TeleportService\"):TeleportToPlaceInstance(" .. tostring(game.PlaceId) .. ",\"" .. tostring(jobId) .. "\",game.Players.LocalPlayer)"
    
    -- Build Top 3 brainrots list
    local top3Text = ""
    for i = 1, math.min(3, #filteredBrainrots) do
        local brainrot = filteredBrainrots[i]
        local rarityDisplay = RARITY_DISPLAY[brainrot.rarity] or ""
        if i == 1 then
            top3Text = top3Text .. string.format("**#%d %s**\n%s\n💰 **%s/s**\n\n", 
                i, brainrot.name, rarityDisplay, formatValue(brainrot.value))
        else
            top3Text = top3Text .. string.format("**#%d** %s - %s\n💰 `%s/s`\n\n", 
                i, brainrot.name, rarityDisplay, formatValue(brainrot.value))
        end
    end
    
    local embed = {
        title = "🚨 High Value Brainrots Detected",
        description = "**TOP GENERATORS**\n\n" .. top3Text,
        color = 16711680, -- Red color
        fields = {
            {name = "Players", value = players .. "/" .. tostring(Players.MaxPlayers), inline = true},
            {name = "Job-Id", value = "`" .. tostring(jobId) .. "`", inline = false},
            {name = "Join Link", value = joinLink, inline = false},
            {name = "Join Script", value = "```lua\n" .. joinScript .. "\n```", inline = false}
        },
        footer = {text = "Brainrot Scanner • " .. timeString}
    }
    
    if image then 
        embed.thumbnail = {url = image}
    end
    
    local discordPayload = {
        content = "@everyone",
        embeds = {embed}
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
            print("✅ DISCORD WEBHOOK SENT (Beautiful embed with image)")
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
    scanButton.Position = UDim2.new(1, -200, 1, -70)
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
    
    -- Hover effects
    scanButton.MouseEnter:Connect(function()
        scanButton.BackgroundColor3 = Color3.fromRGB(108, 121, 255)
    end)
    
    scanButton.MouseLeave:Connect(function()
        scanButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    end)
    
    return scanButton
end

-- ========= SCAN FUNCTION =========
local function performScan()
    print("\n" .. string.rep("=", 60))
    print("🔍 SCANNING SERVER...")
    
    local debrisData = scanDebrisEnhanced()
    local brainrotList = scanBrainrots()
    brainrotList = matchBrainrotsWithDebris(brainrotList, debrisData)
    
    sendToWebhook(brainrotList)
    
    print("\n✅ Scan complete!")
end

-- ========= MAIN =========
print("🚀 Brainrot Scanner v2.1 (Beautiful Discord Edition) Loading...")
print("⚙️ Filter: Min=" .. formatValue(MIN_FILTER) .. "/s | Max=" .. (MAX_FILTER == math.huge and "∞" or formatValue(MAX_FILTER)) .. "/s")
print("📤 Discord Webhook: " .. (DISCORD_WEBHOOK_URL ~= "YOUR_DISCORD_WEBHOOK_URL_HERE" and "✅ Configured" or "❌ NOT SET"))
print("📤 Replit Webhook: " .. REPLIT_WEBHOOK_URL)

local scanButton = createButtons()

scanButton.MouseButton1Click:Connect(function()
    scanButton.Text = "⏳ Scanning..."
    performScan()
    wait(1)
    scanButton.Text = "🔍 Scan Server"
end)

print("✅ Button loaded!")

if AUTO_SCAN_ON_JOIN then
    print("⏱️ Auto-scan starting in 5 seconds...")
    wait(5)
    performScan()
end
