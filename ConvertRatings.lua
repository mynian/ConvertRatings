--Set color variables default values to avoid first load errors :M
cvred = .3
cvgreen = 1
cvblue = 0

--Hard coded color options table :L
local colorTable = {
	["blue"] = {0, 0, 1},
	["green"] = {0, 1, 0},
	["red"] = {1, 0, 0},
	["black"] = {0, 0, 0},
	["white"] = {1, 1, 1},
	["lightblue"] = {0, 1, 1},
	["lightred"] = {1, .5, .5},
	["pink"] = {1, .5, 1},
	["purple"] = {.7, 0, 1},
	["orange"] = {1, 0.5, 1},
	["default"] = {.3, 1, 0}
}

--Slash Command to change the color of the output :M
SLASH_CONVERTRATINGS1, SLASH_CONVERTRATINGS2 = '/convertratings', '/cvr';
function SlashCmdList.CONVERTRATINGS(msg, editBox)
	--Grab the first input word as the command and the rest of the input as a user variable :M
	local command, rest = msg:match("^(%S*)%s*(.-)$");
	--Hard coded color options parsing :M&L
	if string.lower(command) == 'blue' and rest == "" then
		cvred, cvgreen, cvblue = unpack(colorTable["blue"])
		print("Convert Ratings output color set to blue")
	elseif string.lower(command) == 'green' and rest == "" then
		cvred, cvgreen, cvblue = unpack(colorTable["green"])
		print("Convert Ratings output color set to green")
	elseif string.lower(command) == 'red' and rest == "" then
		cvred, cvgreen, cvblue = unpack(colorTable["red"])
		print("Convert Ratings output color set to red")
	elseif string.lower(command) == 'black' and rest == "" then
		cvred, cvgreen, cvblue = unpack(colorTable["black"])
		print("Convert Ratings output color set to black")
	elseif string.lower(command) == 'white' and rest == "" then
		cvred, cvgreen, cvblue = unpack(colorTable["white"])
		print("Convert Ratings output color set to white")
	elseif string.lower(command) == 'lightblue' and rest == "" then
		cvred, cvgreen, cvblue = unpack(colorTable["lightblue"])
		print("Convert Ratings output color set to light blue")
	elseif string.lower(command) == 'lightred' and rest == "" then
		cvred, cvgreen, cvblue = unpack(colorTable["lightred"])
		print("Convert Ratings output color set to light red")
	elseif string.lower(command) == 'pink' and rest == "" then
		cvred, cvgreen, cvblue = unpack(colorTable["pink"])
		print("Convert Ratings output color set to pink")
	elseif string.lower(command) == 'purple' and rest == "" then
		cvred, cvgreen, cvblue = unpack(colorTable["purple"])
		print("Convert Ratings output color set to purple")
	elseif string.lower(command) == 'orange' and rest == "" then
		cvred, cvgreen, cvblue = unpack(colorTable["orange"])
		print("Convert Ratings output color set to orange")
	elseif string.lower(command) == 'default' and rest == "" then
		cvred, cvgreen, cvblue = unpack(colorTable["default"])
		print("Convert Ratings output color reset to default")
	--Custom RGB value parsing :M	
	elseif string.lower(command) == "redv" and rest ~= "" then
		if string.match(rest, "%p") == "." and string.match(rest, "%d%p%d") ~= nil then
		cvred = string.match(rest, "%d%p%d")
		print("Convert Ratings output Red value set to" .. " " .. string.match(rest, "%d%p%d"))
		else print("Convert Ratings: To set custom RGB values use syntax /convertratings (redv|bluev|greenv) and a value between 0.0 and 1.0 in the format of X.X")
		end
	elseif string.lower(command) == "greenv" and rest ~= "" then
		if string.match(rest, "%p") == "." and string.match(rest, "%d%p%d") ~= nil then
		cvgreen = string.match(rest, "%d%p%d")
		print("Convert Ratings output Green value set to" .. " " .. string.match(rest, "%d%p%d"))
		else print("Convert Ratings: To set custom RGB values use syntax /convertratings (redv|bluev|greenv) and a value between 0.0 and 1.0 in the format of X.X")
		end
	elseif string.lower(command) == "bluev" and rest ~= "" then
		if string.match(rest, "%p") == "." and string.match(rest, "%d%p%d") ~= nil then
		cvblue = string.match(rest, "%d%p%d")
		print("Convert Ratings output Blue value set to" .. " " .. string.match(rest, "%d%p%d"))
		else print("Convert Ratings: To set custom RGB values use syntax /convertratings (redv|bluev|greenv) and a value between 0.0 and 1.0 in the format of X.X")
		end
	else
		--when no valid args entered, output this stuff :M
		print("Convert Ratings: Valid color options are red, green, blue, black, white, lightblue, lightred, pink, purple, orange default or set custom RGB values")
		print("Convert Ratings: To set custom RGB values use syntax /convertratings (redv|bluev|greenv) and a value between 0.0 and 1.0 in the format of X.X")
	end
end

-- Define a table to list all the different spec mastery coefficents :M
masterytab = {}

-- Populate the table with mastery coefficents :M
masterytab.DEATHKNIGHT250 = 1.5
masterytab.DEATHKNIGHT251 = 1.5
masterytab.DEATHKNIGHT252 = 2.25
masterytab.DEMONHUNTER577 = 1
masterytab.DEMONHUNTER581 = 0.75
masterytab.DRUID102 = 2
masterytab.DRUID103 = 2
masterytab.DRUID104 = 0.5
masterytab.DRUID105 = 0.6
masterytab.HUNTER253 = 2.25
masterytab.HUNTER254 = 0.625
masterytab.HUNTER255 = 0.5
masterytab.MAGE62 = 1.2
masterytab.MAGE63 = 0.75
masterytab.MAGE64 = 2.25
masterytab.MONK268 = 1
masterytab.MONK269 = 10
masterytab.MONK270 = 1.25
masterytab.PALADIN65 = 1.5
masterytab.PALADIN66 = 1
masterytab.PALADIN70 = 1.5
masterytab.PRIEST256 = 1.5
masterytab.PRIEST257 = 1.25
masterytab.PRIEST258 = 2.5
masterytab.ROGUE259 = 4
masterytab.ROGUE260 = 2.2
masterytab.ROGUE261 = 2.76
masterytab.SHAMAN262 = 2.25
masterytab.SHAMAN263 = 2
masterytab.SHAMAN264 = 3
masterytab.WARLOCK265 = 3.125
masterytab.WARLOCK266 = 1.8
masterytab.WARLOCK267 = 3
masterytab.WARRIOR71 = 2
masterytab.WARRIOR72 = 1.4
masterytab.WARRIOR73 = 1.5

--These are the amounts of each rating for 1 percent for each rating :M
--The mastery amount is the base rating amount before the coefficent is applied :M
critamt = 400
hasteamt = 375
versinamt = 475
versoutamt = 950
masteryamt = 400


--Create Function to round the decimals :M
math.round = function(number, precision)
  precision = precision or 0

  local decimal = string.find(tostring(number), ".", nil, true);
  
  if ( decimal ) then  
    local power = 10 ^ precision;
    
    if ( number >= 0 ) then 
      number = math.floor(number * power + 0.5) / power;
    else 
      number = math.ceil(number * power - 0.5) / power;    
    end
    
    -- convert number to string for formatting :M
    number = tostring(number);      
    
    -- set cutoff :G
    local cutoff = number:sub(decimal + 1 + precision);
      
    -- delete everything after the cutoff :M
    number = number:gsub(cutoff, "");
  else
    -- number is an integer :M
    if ( precision > 0 ) then
      number = tostring(number);
      
      number = number .. ".";
      
      for i = 1,precision
      do
        number = number .. "0";
      end
    end
  end    
  return number;
end




--Create a start-up function :L
local AddOn = CreateFrame("FRAME", "ConvertRatings");
AddOn:SetScript("OnEvent", function(self, event, ...)

    --Getting Player Information :L	
    if(event == "PLAYER_ENTERING_WORLD") then

    
        --Get Current Player Spec :M
        local specn = GetSpecialization()

        --Pull specifc spec id :M
        local specid = select(1,GetSpecializationInfo(specn))

        --turn the integer that is returned from the last call to a string so that it can be properly concatenated with the class name :M
        tostring(specid)

        --Get Current Player Class :M
        local classn = select(2,UnitClass("player"))

        --Concatenate class and specid for mastery coefficent lookup :M
        local masterycs = classn .. specid

        --Pull the coeff from the mastery table using the class name and spec id :M
        masterycf = masterytab[masterycs]
    end

end);

AddOn:RegisterEvent("PLAYER_ENTERING_WORLD");


--Here is the function where the stats are pulled from the item that is currently moused over :M&L
local function getItemIdFromTooltip(self)
    local name, itemLink = self:GetItem();

	--Declare variables for future use :M
	local rawcrit, rawhaste, rawmastery, rawvers, stats;
	
	--Get Item rarity :M
	local irare = select(3,GetItemInfo(itemLink))
	--Artifact specific processing :L
	if irare == 6 then
		for i=1, self:NumLines() do
			--Checks if the line contains a statname in its text - then gets the number of that text :L
			if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_CRIT_RATING_SHORT"])) then
				rawcrit = string.match(_G[self:GetName().."TextLeft"..i]:GetText(), "%d+");
			elseif(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_HASTE_RATING_SHORT"])) then
				rawhaste = string.match(_G[self:GetName().."TextLeft"..i]:GetText(), "%d+");
			elseif(string.find(_G[self:GetName() .. "TextLeft"..i]:GetText(), _G["ITEM_MOD_MASTERY_RATING_SHORT"])) then
				rawmastery = string.match(_G[self:GetName().."TextLeft"..i]:GetText(), "%d+");
			elseif(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_VERSATILITY"])) then
				rawvers = string.match(_G[self:GetName().."TextLeft"..i]:GetText(), "%d+");
			end		
		end
	else 
	
		--Gets stats from non Artifact items :M
		stats = GetItemStats(itemLink);
		
		--If not an item with stats, don't do anything :L
		if(stats == nil) then
			return;
		end

		--Pull individual stats from stats table :M
		rawmastery = stats["ITEM_MOD_MASTERY_RATING_SHORT"]
		rawcrit = stats["ITEM_MOD_CRIT_RATING_SHORT"]
		rawhaste = stats["ITEM_MOD_HASTE_RATING_SHORT"]
		rawvers = stats["ITEM_MOD_VERSATILITY"]
		
	end 
	
    --Localing the variables here - we'll use them after... :L
    local pcrit, phaste, pversin, pversout, pmastery, prcrit, prhaste, prversin, prversout, prmastery;
    
    --convert raw stats into percentages so long as they are not nil :M
    if rawcrit ~= nil then
        pcrit = rawcrit / critamt
    end

    if rawhaste ~= nil then
        phaste = rawhaste / hasteamt
    end

    if rawvers ~= nil then
        pversin = rawvers / versinamt
        pversout = rawvers / versoutamt
    end

    if rawmastery ~= nil then
        pmastery = (rawmastery / masteryamt) * masterycf
    end

    --Round The outputs :M
    prcrit = math.round(pcrit, 2)
    prhaste = math.round(phaste, 2)
    prversin = math.round(pversin, 2)
    prversout = math.round(pversout, 2)
    prmastery = math.round(pmastery, 2)


    --Convert percentages to strings :M
    tostring(prcrit)
    tostring(prhaste)
    tostring(prversin)
    tostring(prversout)
    tostring(prmastery)

    
	--Set output values in the same line as the rating in tooltip :L
	for i=1, self:NumLines() do
	
		--If line contains "Critical Strike", then sets show a 'fontString' and set its text :L
		if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_CRIT_RATING_SHORT"])) and rawcrit ~= nil then
			_G[self:GetName().."TextRight"..i]:SetText("(" .. prcrit .. "%)");
			_G[self:GetName().."TextRight"..i]:SetTextColor(cvred,cvgreen,cvblue);
			_G[self:GetName().."TextRight"..i]:Show();
			break
		end		
	
	end
	
	for i=1, self:NumLines() do
	
			if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_HASTE_RATING_SHORT"])) and rawhaste ~= nil then
			_G[self:GetName().."TextRight"..i]:SetText("(" .. prhaste .. "%)");
			_G[self:GetName().."TextRight"..i]:SetTextColor(cvred,cvgreen,cvblue);
			_G[self:GetName().."TextRight"..i]:Show();
			break
		end		
	
	end
	
	for i=1, self:NumLines() do
	
			if(string.find(_G[self:GetName() .. "TextLeft"..i]:GetText(), _G["ITEM_MOD_MASTERY_RATING_SHORT"])) and rawmastery ~= nil then
			_G[self:GetName().."TextRight"..i]:SetText("(" .. prmastery .. "%)");
			_G[self:GetName().."TextRight"..i]:SetTextColor(cvred,cvgreen,cvblue);
			_G[self:GetName().."TextRight"..i]:Show();
			break
		end		
	
	end
	
	for i=1, self:NumLines() do
	
			if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_VERSATILITY"])) and rawvers ~= nil then
			_G[self:GetName().."TextRight"..i]:SetText("(" .. prversin .. "%/" .. prversout .. "%)");
			_G[self:GetName().."TextRight"..i]:SetTextColor(cvred,cvgreen,cvblue);
			_G[self:GetName().."TextRight"..i]:Show();
			break
		end		
	
	end
end

--Hooks to make the addon function :L
GameTooltip:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
ItemRefTooltip:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
ShoppingTooltip1:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
ShoppingTooltip2:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
