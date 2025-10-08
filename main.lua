local _, playerRace = UnitRace("player")

local LANGUAGE_IDS = {
    Demonic = 8,
    Common  = 7,
    Orcish  = 1,
}

local DEFAULT_LANG_BY_RACE = {
    NightElf = "Common",
    BloodElf = "Orcish",
}

local DEMONIC_ZONE_ID = 720  -- The map ID for the demonic-speaking zone

local prevMapID = 0
local frame = CreateFrame("Frame")

local function setLanguage(languageName)
    local id = LANGUAGE_IDS[languageName]
    if id and DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.editBox then
        DEFAULT_CHAT_FRAME.editBox.languageID = id
        print(("You're now speaking %s"):format(languageName))
    end
end

frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:SetScript("OnEvent", function()
    local mapID = C_Map.GetBestMapForUnit("player")
    if not mapID then return end

    -- Entered demonic zone
    if mapID == DEMONIC_ZONE_ID and prevMapID ~= DEMONIC_ZONE_ID then
        setLanguage("Demonic")
        prevMapID = DEMONIC_ZONE_ID
        return
    end

    -- Left demonic zone
    if prevMapID == DEMONIC_ZONE_ID and mapID ~= DEMONIC_ZONE_ID then
        local defaultLang = DEFAULT_LANG_BY_RACE[playerRace]
        if defaultLang then
            setLanguage(defaultLang)
        end
        prevMapID = mapID
    end
end)
