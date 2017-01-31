--Set color variables default values to avoid first load errors :M
cvred = .3
cvgreen = 1
cvblue = 0
cvalpha = 1

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
--Color Picker
function ShowColorPicker(cvred, cvgreen, cvblue, cvalpha, changedCallback)
 ColorPickerFrame:SetColorRGB(cvred, cvgreen, cvblue);
 ColorPickerFrame.hasOpacity, ColorPickerFrame.opacity = (cvalpha ~= nil), cvalpha;
 ColorPickerFrame.previousValues = {cvred, cvgreen, cvbue, cvalpha};
 ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc =  changedCallback, changedCallback, changedCallback;
 ColorPickerFrame:Hide();
 ColorPickerFrame:Show();
 end

local function myColorCallback(restore)
 local newR, newG, newB, newA;
 if restore then
  newR, newG, newB, newA = unpack(restore);  
 else
  newA, newR, newG, newB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB();
 end 
  cvred, cvgreen, cvblue, cvalpha = newR, newG, newB, newA;  
end

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
	elseif string.lower(command) == 'custom' and rest == "" then
		ShowColorPicker(r, g, b, a, myColorCallback);
	else
		--when no valid args entered, output this stuff :M
		print("Convert Ratings: Valid color options are red, green, blue, black, white, lightblue, lightred, pink, purple, orange or custom")
		print("Convert Ratings: The custom option will bring up the Color Picker for you to choose a color.")
		print("Convert Ratings: To reset to the default color, use /convertratings default")
	end
end

-- Define a table to list all the different spec mastery coefficents :M
masteryctab = {}

-- Populate the table with mastery coefficents :M
masteryctab.DEATHKNIGHT250 = 1.5
masteryctab.DEATHKNIGHT251 = 1.5
masteryctab.DEATHKNIGHT252 = 2.25
masteryctab.DEMONHUNTER577 = 1
masteryctab.DEMONHUNTER581 = 0.75
masteryctab.DRUID102 = 2
masteryctab.DRUID103 = 2
masteryctab.DRUID104 = 0.5
masteryctab.DRUID105 = 0.6
masteryctab.HUNTER253 = 2.25
masteryctab.HUNTER254 = 0.625
masteryctab.HUNTER255 = 0.5
masteryctab.MAGE62 = 1.2
masteryctab.MAGE63 = 0.75
masteryctab.MAGE64 = 2.25
masteryctab.MONK268 = 1
masteryctab.MONK269 = 10
masteryctab.MONK270 = 1.25
masteryctab.PALADIN65 = 1.5
masteryctab.PALADIN66 = 1
masteryctab.PALADIN70 = 1.5
masteryctab.PRIEST256 = 1.5
masteryctab.PRIEST257 = 1.25
masteryctab.PRIEST258 = 2.5
masteryctab.ROGUE259 = 4
masteryctab.ROGUE260 = 2.2
masteryctab.ROGUE261 = 2.76
masteryctab.SHAMAN262 = 2.25
masteryctab.SHAMAN263 = 2
masteryctab.SHAMAN264 = 3
masteryctab.WARLOCK265 = 3.125
masteryctab.WARLOCK266 = 1.8
masteryctab.WARLOCK267 = 3
masteryctab.WARRIOR71 = 2
masteryctab.WARRIOR72 = 1.4
masteryctab.WARRIOR73 = 1.5

--rating tables to allow addon to work at all levels :M

masterytab = {0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.807692, 1.076923, 1.346154, 1.615385, 1.884615, 2.153846, 2.423077, 2.692308, 2.961538, 3.230769, 3.5, 3.769231, 4.038462, 4.307692, 4.576923, 4.846154, 5.115385, 5.384615, 5.653846, 5.923077, 6.192307, 6.461538, 6.730769, 7, 7.269231, 7.538462, 7.807693, 8.076923, 8.346154, 8.615384, 8.884615, 9.153846, 9.423077, 9.692307, 9.961538, 10.23077, 10.5, 10.769232, 11.038462, 11.307693, 11.576923, 11.846155, 12.115385, 12.384617, 12.653847, 12.923079, 13.192308, 13.461539, 13.73077, 14, 14.18609987, 14.37219973, 14.5582996, 14.74439946, 14.93049933, 15.11659919, 15.30269906, 15.48879892, 15.67489879, 15.86099865, 16.04709852, 16.23319838, 16.41929825, 16.60539811, 16.79149798, 16.97759784, 17.16369771, 17.34979757, 17.53589744, 17.7219973, 18.44534413, 19.16869096, 19.53036437, 19.53036437, 19.89203779, 20.61538462, 21.33873144, 22.06207827, 22.7854251, 23, 27, 32, 38, 44, 51, 60, 70, 82, 95, 110, 125, 142.5, 162, 184.5, 210, 238.5, 271.5, 309, 351.5, 400}
crittab = {0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.807692, 1.076923, 1.346154, 1.615385, 1.884615, 2.153846, 2.423077, 2.692308, 2.961538, 3.230769, 3.5, 3.769231, 4.038462, 4.307692, 4.576923, 4.846154, 5.115385, 5.384615, 5.653846, 5.923077, 6.192307, 6.461538, 6.730769, 7, 7.269231, 7.538462, 7.807693, 8.076923, 8.346154, 8.615384, 8.884615, 9.153846, 9.423077, 9.692307, 9.961538, 10.23077, 10.5, 10.769232, 11.038462, 11.307693, 11.576923, 11.846155, 12.115385, 12.384617, 12.653847, 12.923079, 13.192308, 13.461539, 13.73077, 14, 14.18609987, 14.37219973, 14.5582996, 14.74439946, 14.93049933, 15.11659919, 15.30269906, 15.48879892, 15.67489879, 15.86099865, 16.04709852, 16.23319838, 16.41929825, 16.60539811, 16.79149798, 16.97759784, 17.16369771, 17.34979757, 17.53589744, 17.7219973, 18.44534413, 19.16869096, 19.53036437, 19.53036437, 19.89203779, 20.61538462, 21.33873144, 22.06207827, 22.7854251, 23, 27, 32, 38, 44, 51, 60, 70, 82, 95, 110, 125, 142.5, 162, 184.5, 210, 238.5, 271.5, 309, 351.5, 400}
hastetab = {0.48076875, 0.48076875, 0.48076875, 0.48076875, 0.48076875, 0.48076875, 0.48076875, 0.48076875, 0.48076875, 0.48076875, 0.72115375, 0.96153875, 1.2019225, 1.4423075, 1.6826925, 1.9230775, 2.16346125, 2.40384625, 2.64423125, 2.884615, 3.125, 3.365385, 3.60576875, 3.84615375, 4.08653875, 4.3269225, 4.5673075, 4.8076925, 5.0480775, 5.28846125, 5.52884625, 5.76923125, 6.00961625, 6.25, 6.490385, 6.73076875, 6.97115375, 7.21153875, 7.4519225, 7.6923075, 7.9326925, 8.1730775, 8.41346125, 8.65384625, 8.89423125, 9.13461625, 9.375, 9.61538375, 9.85576875, 10.09615375, 10.33653875, 10.5769225, 10.8173075, 11.0576925, 11.2980775, 11.53846125, 11.77884625, 12.01923125, 12.25961625, 12.5, 12.56060925, 12.72538518, 12.8901611, 13.05493703, 13.21971295, 13.38448886, 13.54926479, 13.71404071, 13.87881664, 14.04359255, 14.20836848, 14.3731444, 14.53792033, 14.70269625, 14.86747216, 15.03224809, 15.19702401, 15.36179994, 15.52657585, 15.69135178, 16.33181511, 16.97227845, 17.29251013, 17.29251013, 17.61274179, 18.25320513, 18.89366846, 19.5341318, 20.17459514, 20, 25, 29, 35, 40, 46, 55, 64, 75, 86, 100, 114, 130, 148.5, 170, 193.5, 221, 252, 288, 328.5, 375}
verstab = {0.636364182, 0.636364182, 0.636364182, 0.636364182, 0.636364182, 0.636364182, 0.636364182, 0.636364182, 0.636364182, 0.636364182, 0.954545091, 1.272727182, 1.590909273, 1.909091364, 2.227272273, 2.545454364, 2.863636455, 3.181818545, 3.499999455, 3.818181545, 4.136363636, 4.454545727, 4.772727818, 5.090908727, 5.409090818, 5.727272909, 6.045455, 6.363635909, 6.681818, 7.000000091, 7.318181, 7.636363091, 7.954545182, 8.272727273, 8.590909364, 8.909091455, 9.227273545, 9.545454455, 9.863636545, 10.18181745, 10.49999955, 10.81818164, 11.13636373, 11.45454464, 11.77272673, 12.09091, 12.40909091, 12.72727418, 13.04545509, 13.36363718, 13.68181809, 14.00000136, 14.31818227, 14.63636555, 14.95454645, 15.27272973, 15.59090945, 15.90909155, 16.22727364, 16.54545455, 16.76539076, 16.98532695, 17.20526316, 17.42519936, 17.64513557, 17.86507177, 18.08500798, 18.30494418, 18.52488039, 18.74481659, 18.9647528, 19.18468899, 19.4046252, 19.6245614, 19.84449761, 20.06443381, 20.28437002, 20.50430622, 20.72424243, 20.94417863, 21.79904306, 22.6539075, 23.08133971, 23.08133971, 23.50877193, 24.36363637, 25.21850079, 26.07336523, 26.92822966, 27, 32, 38, 45, 52, 60, 71, 83, 97, 112, 130, 148, 168.5, 192, 218.5, 248.5, 283, 322, 366.5, 417, 475}


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
    
    -- set cutoff :M
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


local masteryamt, critamt, hasteamt, versinamt, versoutamt;


--Here is the function where the stats are pulled from the item that is currently moused over :M&L
local function getItemIdFromTooltip(self)

--Moved the mastery determination function inside the mouseover call to allow it to show the correct mastery coef after a spec change without having to reload ui :M
local specn, specid, classn, masterycs;    	
    
        --Get Current Player Spec :M
        specn = GetSpecialization()

        --Pull specifc spec id :M
        specid = select(1,GetSpecializationInfo(specn))

        --turn the integer that is returned from the last call to a string so that it can be properly concatenated with the class name :M
        tostring(specid)

        --Get Current Player Class :M
        classn = select(2,UnitClass("player"))

        --Concatenate class and specid for mastery coefficent lookup :M
        masterycs = classn .. specid

        --Pull the coeff from the mastery table using the class name and spec id :M
        masterycf = masteryctab[masterycs]
		
	--Set Player level :M
	cvlevel = UnitLevel("player")
		
	--Select the level based rating amounts :M
	masteryamt = masterytab[cvlevel]
	hasteamt = hastetab[cvlevel]
	critamt = crittab[cvlevel]
	versinamt = verstab[cvlevel]
	versoutamt = verstab[cvlevel] * 2

   	--Get itemLink of mouseover :L
    	local name, itemLink = self:GetItem();

	--Declare variables for future use :M
	local rawcrit, rawhaste, rawmastery, rawvers, stats;
	
	--Check to see if trainer window is open to prevent errors :M
		local numServices = GetNumTrainerServices()
		if numServices ~= 0 then
			return;
		else
	
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
