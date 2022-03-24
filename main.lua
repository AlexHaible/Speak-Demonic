local raceName, raceId = UnitRace("player");
local f = CreateFrame("Frame",nil,UIParent);
local prevMapID = 0;
f:RegisterEvent("ZONE_CHANGED_NEW_AREA");
f:SetScript("OnEvent",
	function(self, event, ...)
		local mapID = C_Map.GetBestMapForUnit("player");
		if mapID == 720 and prevMapID ~= 720 then
			DEFAULT_CHAT_FRAME.editBox.languageID = 8;
			print("You're now speaking Demonic");
			prevMapID = 720;
		end
		if mapID ~= 720 and prevMapID == 720 then
			if raceId == "NightElf" then
				DEFAULT_CHAT_FRAME.editBox.languageID = 7;
				print("You're now speaking Common");
				prevMapID = mapID;
			end
			if raceId == "BloodElf" then
				DEFAULT_CHAT_FRAME.editBox.languageID = 1;
				print("You're now speaking Orcish");
				prevMapID = mapID;
			end
		end
	end
);