local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")

local IS_SUPPORTED_PLACE = (game.PlaceId == 109983668079237) or (game.PlaceId == 96342491571673)
if not IS_SUPPORTED_PLACE then
    warn("Script not running - unsupported place ID")
    return
end

print("=== BRAINROT SCANNER STARTED ===")

local function dismissBlockingPrompts()
    pcall(function()
        if GuiService and GuiService.ClearError then
            GuiService:ClearError()
        end
    end)

    local function tryOverlay(overlay)
        if not overlay then return end
        for _, inst in ipairs(overlay:GetDescendants()) do
            if inst:IsA("TextButton") or inst:IsA("ImageButton") then
                local btnName = tostring(inst.Name or "")
                local btnText = ""
                pcall(function()
                    if inst:IsA("TextButton") then
                        btnText = tostring(inst.Text or "")
                    end
                end)

                local n = string.lower(btnName)
                local t = string.lower(btnText)
                local shouldClick = false
                if string.find(n, "ok", 1, true) or string.find(t, "ok", 1, true) then shouldClick = true end
                if string.find(n, "close", 1, true) or string.find(t, "close", 1, true) then shouldClick = true end
                if string.find(n, "leave", 1, true) or string.find(t, "leave", 1, true) then shouldClick = true end
                if string.find(n, "cancel", 1, true) or string.find(t, "cancel", 1, true) then shouldClick = true end
                if string.find(n, "retry", 1, true) or string.find(t, "retry", 1, true) then shouldClick = true end
                if string.find(n, "confirm", 1, true) or string.find(t, "confirm", 1, true) then shouldClick = true end

                if shouldClick then
                    pcall(function()
                        inst:Activate()
                    end)
                end
            end
        end
    end

    pcall(function()
        local promptGui = CoreGui:FindFirstChild("RobloxPromptGui")
        if not promptGui then
            promptGui = CoreGui:FindFirstChild("RobloxPromptGui", true)
        end

        if promptGui then
            local overlay = promptGui:FindFirstChild("PromptOverlay")
            if not overlay then
                overlay = promptGui:FindFirstChild("PromptOverlay", true)
            end
            tryOverlay(overlay)
        end
    end)
end

task.spawn(function()
    while true do
        task.wait(0.5)
        dismissBlockingPrompts()
    end
end)

local function queueThisOnTeleport()
    local q = queue_on_teleport or queueonteleport or (syn and syn.queue_on_teleport)
    if type(q) ~= "function" then return end

    local rf = readfile
    if type(rf) ~= "function" then return end

    local ok, src = pcall(rf, "WEBHOOK SAB.lua")
    if not ok or type(src) ~= "string" or src == "" then
        ok, src = pcall(rf, "autoexec/WEBHOOK SAB.lua")
    end
    if not ok or type(src) ~= "string" or src == "" then return end

    pcall(q, src)
end

pcall(queueThisOnTeleport)

local _request = request or http_request or (http and http.request) or (syn and syn.request)
if not _request then
    warn("ERROR: No HTTP request function available - webhooks will not work!")
    warn("Your executor needs to support: request, http_request, or syn.request")
end

local webhookFree = "https://discord.com/api/webhooks/1452120328364101693/XSaMuA_dNl_GShp3ONOOEmNnkakZeMctfvyKXVV-hJDxgK8H6ZTUoCApFxBw4Nzbo5_8"
local webhookLowTier = "https://discord.com/api/webhooks/1452120328364101693/XSaMuA_dNl_GShp3ONOOEmNnkakZeMctfvyKXVV-hJDxgK8H6ZTUoCApFxBw4Nzbo5_8"
local webhookHighTierFull = "https://discord.com/api/webhooks/1452120328364101693/XSaMuA_dNl_GShp3ONOOEmNnkakZeMctfvyKXVV-hJDxgK8H6ZTUoCApFxBw4Nzbo5_8"

local multipliers = { K = 1e3, M = 1e6, B = 1e9, T = 1e12 }

local SUPPORTED_PLACE_IDS = {
    [109983668079237] = true,
    [96342491571673] = true,
}
local PLACE_ID = game.PlaceId

local SERVERHOP_INTERVAL = 1.5

local SCAN_INTERVAL = 1
local plotsRef
local overheadSet = {}
local plotsConnections = {}

local WEBHOOK_ONCE_PER_EXECUTION = false
local webhookUsed = false
local pendingEventScan = false
local forceHopNow = false

-- Changed to false so it always notifies
local GLOBAL_WEBHOOK_ONCE = false
local GLOBAL_WEBHOOK_FLAG = "ECLIPSE_SAB_WEBHOOK_SENT"
if GLOBAL_WEBHOOK_ONCE and getgenv and getgenv()[GLOBAL_WEBHOOK_FLAG] == nil then
    getgenv()[GLOBAL_WEBHOOK_FLAG] = false
end

local GLOBAL_SEEN_BRAINROTS_KEY = "ECLIPSE_SAB_SEEN_BRAINROTS"
if getgenv and getgenv()[GLOBAL_SEEN_BRAINROTS_KEY] == nil then
    getgenv()[GLOBAL_SEEN_BRAINROTS_KEY] = {}
end

local GLOBAL_VISITED_KEY = "ECLIPSE_SAB_VISITED_SERVERS"
if getgenv and getgenv()[GLOBAL_VISITED_KEY] == nil then
    getgenv()[GLOBAL_VISITED_KEY] = {}
end

local GLOBAL_FAILED_SERVERS_KEY = "ECLIPSE_SAB_FAILED_SERVERS"
if getgenv and getgenv()[GLOBAL_FAILED_SERVERS_KEY] == nil then
    getgenv()[GLOBAL_FAILED_SERVERS_KEY] = {}
end

local function getVisitedServers()
    if getgenv then
        return getgenv()[GLOBAL_VISITED_KEY]
    end
    return nil
end

local function markVisited(serverId)
    local visited = getVisitedServers()
    if visited and serverId then
        visited[serverId] = true
    end
end

local function getSeenBrainrots()
    if getgenv then
        return getgenv()[GLOBAL_SEEN_BRAINROTS_KEY]
    end
    return {}
end

local function getFailedServers()
    if getgenv then
        return getgenv()[GLOBAL_FAILED_SERVERS_KEY]
    end
    return nil
end

local function markFailed(serverId)
    local failedServers = getFailedServers()
    if failedServers and serverId then
        failedServers[serverId] = os.clock()
    end
end

local function isFailedRecently(serverId)
    local failedServers = getFailedServers()
    if not failedServers then return false end
    local t = serverId and failedServers[serverId]
    return t and (os.clock() - t) < 60
end

local function getNextServerId()
    local visited = getVisitedServers() or {}
    local cursor = nil
    local candidates = {}

    local SERVER_LIST_PAGE_LIMIT = 100
    local SERVER_LIST_MAX_PAGES = 20

    for _ = 1, SERVER_LIST_MAX_PAGES do
        local url = "https://games.roblox.com/v1/games/" .. tostring(PLACE_ID) .. "/servers/Public?sortOrder=Asc&limit=" .. tostring(SERVER_LIST_PAGE_LIMIT)
        if cursor then
            url = url .. "&cursor=" .. HttpService:UrlEncode(cursor)
        end

        local ok, body = pcall(function()
            return game:HttpGet(url, true)
        end)
        if not ok or not body then break end

        local decodedOk, data = pcall(function()
            return HttpService:JSONDecode(body)
        end)
        if not decodedOk or not data or type(data) ~= "table" then break end

        if type(data.data) == "table" then
            for _, server in ipairs(data.data) do
                local id = server and server.id
                local playing = server and server.playing
                local maxPlayers = server and server.maxPlayers

                if id and id ~= game.JobId and not visited[id] and not isFailedRecently(id) then
                    if type(playing) == "number" and type(maxPlayers) == "number" and playing < maxPlayers then
                        candidates[#candidates + 1] = {id = id, playing = playing}
                    end
                end
            end
        end

        cursor = data.nextPageCursor
        if not cursor or cursor == "" then break end
    end

    if #candidates == 0 then return nil end

    local chosen = candidates[math.random(1, #candidates)]
    return chosen.id
end

local function clearPlotsConnections()
    for _, conn in pairs(plotsConnections) do
        pcall(function() conn:Disconnect() end)
    end
    table.clear(plotsConnections)
end

local function rebuildOverheadCache(plots)
    table.clear(overheadSet)
    local count = 0
    for _, inst in pairs(plots:GetDescendants()) do
        if inst.Name == "AnimalOverhead" then
            overheadSet[inst] = true
            count = count + 1
        end
    end
    print("Rebuilt overhead cache - found", count, "overheads")
end

local function ensurePlotsAndCache()
    if plotsRef and plotsRef.Parent then return true end

    local plots = Workspace:FindFirstChild("Plots")
    if not plots then 
        warn("ERROR: Could not find Plots in Workspace")
        return false 
    end

    plotsRef = plots
    clearPlotsConnections()
    rebuildOverheadCache(plotsRef)

    plotsConnections.added = plotsRef.DescendantAdded:Connect(function(inst)
        if inst.Name == "AnimalOverhead" then
            overheadSet[inst] = true
            scheduleScan()
        end
    end)

    plotsConnections.removing = plotsRef.DescendantRemoving:Connect(function(inst)
        if overheadSet[inst] then
            overheadSet[inst] = nil
        end
    end)

    print("Successfully connected to Plots")
    return true
end

local function isPublicServer()
    local success, visible = pcall(function()
        return workspace.Map.Codes.Main.SurfaceGui.MainFrame.PrivateServerMessage.Visible
    end)

    if not success then 
        print("Could not detect server type - assuming public")
        return true 
    end
    
    local isPublic = not visible
    print("Server type:", isPublic and "PUBLIC" or "PRIVATE")
    return isPublic
end

local function parseGenerationValue(text)
    if not text then return nil end
    local cleanText = text:gsub("[^%d%.KMBT]", "")
    local number = tonumber(cleanText:match("^%d*%.?%d+"))
    if not number then return nil end
    local suffix = cleanText:match("[KMBT]$") or ""
    return number * (multipliers[suffix] or 1)
end

local function getBrainrotImageUrl(displayName)
    if not displayName or displayName == "" then return nil end
    local page = displayName:gsub("%s+", "_"):gsub("^%s*(.-)%s*$", "%1")
    local url = "https://stealabrainrot.fandom.com/wiki/" .. page
    local ok, html = pcall(function() return game:HttpGet(url, true) end)
    if not ok or not html then return nil end
    local og = html:match('<meta%s+property="og:image"%s+content="([^"]+)')
    if og then return og:match("(https?://[^?\"'>]+)") end
end

local function sendToWebhook(url, embed)
    if not isPublicServer() then 
        warn("Skipping webhook - not in public server")
        return false
    end
    
    if not _request then 
        warn("Skipping webhook - no HTTP request function")
        return false
    end
    
    if GLOBAL_WEBHOOK_ONCE and getgenv and getgenv()[GLOBAL_WEBHOOK_FLAG] then 
        warn("Skipping webhook - global flag set")
        return false
    end
    
    if WEBHOOK_ONCE_PER_EXECUTION and webhookUsed then 
        warn("Skipping webhook - already sent this execution")
        return false
    end
    
    if WEBHOOK_ONCE_PER_EXECUTION then webhookUsed = true end
    if GLOBAL_WEBHOOK_ONCE and getgenv then getgenv()[GLOBAL_WEBHOOK_FLAG] = true end
    
    print("Sending webhook notification...")
    local ok = pcall(_request, {
        Url = url,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode({embeds = {embed}})
    })
    
    if ok then
        print("✓ Webhook sent successfully!")
    else
        warn("✗ Webhook failed to send")
    end
    
    return ok
end

local scheduleScan
local scanAndNotify

scheduleScan = function()
    if WEBHOOK_ONCE_PER_EXECUTION and webhookUsed then return end
    if pendingEventScan then return end
    pendingEventScan = true
    task.defer(function()
        pendingEventScan = false
        pcall(scanAndNotify)
    end)
end

scanAndNotify = function()
    print("\n=== SCAN STARTED ===")
    
    if not ensurePlotsAndCache() then 
        warn("ERROR: Could not find Plots")
        return 
    end

    local overheadCount = 0
    for _ in pairs(overheadSet) do
        overheadCount = overheadCount + 1
    end
    print("Checking", overheadCount, "overheads...")

    local seen = getSeenBrainrots()
    if not seen then 
        warn("ERROR: Could not get seen brainrots")
        return 
    end

    local bestByKey = {}
    local totalChecked = 0
    local validBrainrots = 0

    for overhead in pairs(overheadSet) do
        if not overhead.Parent or not overhead:IsDescendantOf(plotsRef) then
            overheadSet[overhead] = nil
        else
            totalChecked = totalChecked + 1
            local name = overhead:FindFirstChild("DisplayName")
            local gen = overhead:FindFirstChild("Generation")
            local rarity = overhead:FindFirstChild("Rarity")
            
            if name and gen and rarity then
                local displayName = tostring(name.Text or "")
                local genText = tostring(gen.Text or "")
                local key = displayName:lower():gsub("%s+", " "):gsub("^%s*(.-)%s*$", "%1")
                
                local val = parseGenerationValue(genText)
                
                if val then
                    print(string.format("Found: %s - %s (%.0f)", displayName, genText, val))
                    
                    if key ~= "" and val >= 0 then
                        validBrainrots = validBrainrots + 1
                        
                        if seen[key] then
                            print("  -> Already notified for this brainrot")
                        else
                            local prev = bestByKey[key]
                            if not prev or val > prev.genValue then
                                bestByKey[key] = {
                                    key = key,
                                    displayName = displayName,
                                    rarity = tostring(rarity.Text or ""),
                                    generation = genText,
                                    genValue = val,
                                }
                                print("  -> NEW TARGET! Will notify!")
                            end
                        end
                    end
                end
            end
        end
    end

    print(string.format("\nSummary: Checked %d overheads, found %d valid brainrots", totalChecked, validBrainrots))

    local jobId = game.JobId
    local players = #Players:GetPlayers()
    local timeString = os.date("%H:%M:%S %d/%m/%Y")

    local sentAny = false

    for _, best in pairs(bestByKey) do
        local title
        local color
        local webhookUrl

        if best.genValue >= 5000000 then
            title = "Brainrot Found (5M+)"
            color = 16711680
            webhookUrl = webhookHighTierFull
        elseif best.genValue >= 1000000 then
            title = "Brainrot Found (1M–5M)"
            color = 16763904
            webhookUrl = webhookLowTier
        else
            title = "Brainrot Found (500K–1M)"
            color = 8421504
            webhookUrl = webhookFree
        end

        local joinLink = "https://www.roblox.com/games/start?placeId=" .. tostring(PLACE_ID) .. "&gameInstanceId=" .. tostring(jobId)
        local joinScript = "game:GetService(\"TeleportService\"):TeleportToPlaceInstance(" .. tostring(PLACE_ID) .. ",\"" .. tostring(jobId) .. "\",game.Players.LocalPlayer)"

        title = "Brainrot Found (" .. tostring(best.generation) .. ")"

        local embed = {
            title = title,
            color = color,
            fields = {
                {name = "Brainrot Name", value = tostring(best.displayName), inline = true},
                {name = "Players", value = players .. "/" .. tostring(Players.MaxPlayers), inline = true},
                {name = "Job-Id", value = "`" .. tostring(jobId) .. "`", inline = false},
                {name = "Join Link", value = joinLink, inline = false},
                {name = "Join Script", value = "```lua\n" .. joinScript .. "\n```", inline = false}
            },
            footer = {text = "Eclipse SAB Notifier • " .. timeString}
        }

        local image = getBrainrotImageUrl(best.displayName)
        if image then embed.thumbnail = {url = image} end

        if webhookUrl == webhookFree then
            task.wait(3)
        end

        print("\n🔔 Attempting to send notification for:", best.displayName)
        local didSend = sendToWebhook(webhookUrl, embed)
        if didSend then
            seen[best.key] = true
            sentAny = true
            print("✓ Successfully notified!")
        else
            warn("✗ Failed to send notification")
        end
    end

    if sentAny then
        print("\n⚠ Triggering server hop...")
        task.spawn(function()
            pcall(function()
                task.defer(function()
                    forceHopNow = true
                end)
            end)
        end)
    end
    
    print("=== SCAN COMPLETE ===\n")
end

task.spawn(function()
    print("Starting initial scan...")
    pcall(scanAndNotify)
    while true do
        task.wait(SCAN_INTERVAL)
        pcall(scanAndNotify)
    end
end)

task.spawn(function()
    math.randomseed(os.clock() * 1000000)
    markVisited(game.JobId)

    local localPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

    local TELEPORT_INIT_TIMEOUT = 4
    local SERVER_FETCH_RETRY_DELAY = 0.5

    local pendingTeleportServerId = nil

    local teleportFailed = false
    TeleportService.TeleportInitFailed:Connect(function(player)
        if player == localPlayer then
            teleportFailed = true
            if pendingTeleportServerId then
                markFailed(pendingTeleportServerId)
            end
            forceHopNow = true
        end
    end)

    while true do
        if forceHopNow then
            forceHopNow = false
        else
            task.wait(SERVERHOP_INTERVAL)
        end

        local nextServerId
        repeat
            nextServerId = getNextServerId()
            if not nextServerId then
                task.wait(SERVER_FETCH_RETRY_DELAY)
            end
        until nextServerId

        teleportFailed = false
        pendingTeleportServerId = nextServerId
        markVisited(nextServerId)
        print("Attempting to teleport to server:", nextServerId)
        pcall(function()
            TeleportService:TeleportToPlaceInstance(PLACE_ID, nextServerId, localPlayer)
        end)

        task.wait(TELEPORT_INIT_TIMEOUT)
        if teleportFailed then
            markFailed(nextServerId)
            warn("Teleport failed, marking server as failed")
        end
        pendingTeleportServerId = nil
    end
end)
