--Set color variables default values to avoid first load errors :M
cvred = 1
cvgreen = .996
cvblue = .545
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
	["default"] = {1, .996, .545}
}
--Color Picker
function ShowColorPicker(cvred, cvgreen, cvblue, cvalpha, changedCallback)
 ColorPickerFrame:SetColorRGB(cvred, cvgreen, cvblue);
 ColorPickerFrame.hasOpacity, ColorPickerFrame.opacity = (cvalpha ~= nil), cvalpha;
 ColorPickerFrame.previousValues = {cvred, cvgreen, cvblue, cvalpha};
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
	
	if (colorTable[string.lower(command)]) then
		cvred, cvgreen, cvblue = unpack(colorTable[string.lower(command)]);
		print("Convert Ratings output color set to "..string.lower(command));
	elseif string.lower(command) == 'custom' and rest == "" then
		ShowColorPicker(cvred, cvgreen, cvblue, nil, myColorCallback);
	else
		--when no valid args entered, output this stuff :M
		print("Convert Ratings: Valid color options are red, green, blue, black, white, lightblue, lightred, pink, purple, orange or custom")
		print("Convert Ratings: The custom option will bring up the Color Picker for you to choose a color.")
		print("Convert Ratings: To reset to the default color, use /convertratings default")
	end
end


--rating tables to allow addon to work at all levels :M

masterytab = {0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.807692, 1.076923, 1.346154, 1.615385, 1.884615, 2.153846, 2.423077, 2.692308, 2.961538, 3.230769, 3.5, 3.769231, 4.038462, 4.307692, 4.576923, 4.846154, 5.115385, 5.384615, 5.653846, 5.923077, 6.192307, 6.461538, 6.730769, 7, 7.269231, 7.538462, 7.807693, 8.076923, 8.346154, 8.615384, 8.884615, 9.153846, 9.423077, 9.692307, 9.961538, 10.23077, 10.5, 10.769232, 11.038462, 11.307693, 11.576923, 11.846155, 12.115385, 12.384617, 12.653847, 12.923079, 13.192308, 13.461539, 13.73077, 14, 14.18609987, 14.37219973, 14.5582996, 14.74439946, 14.93049933, 15.11659919, 15.30269906, 15.48879892, 15.67489879, 15.86099865, 16.04709852, 16.23319838, 16.41929825, 16.60539811, 16.79149798, 16.97759784, 17.16369771, 17.34979757, 17.53589744, 17.7219973, 18.44534413, 19.16869096, 19.53036437, 19.53036437, 19.89203779, 20.61538462, 21.33873144, 22.06207827, 22.7854251, 23, 27, 32, 38, 44, 51, 60, 70, 82, 95, 110, 125, 142.5, 162, 184.5, 210, 238.5, 271.5, 309, 351.5, 400}
crittab = {0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.538462, 0.807692, 1.076923, 1.346154, 1.615385, 1.884615, 2.153846, 2.423077, 2.692308, 2.961538, 3.230769, 3.5, 3.769231, 4.038462, 4.307692, 4.576923, 4.846154, 5.115385, 5.384615, 5.653846, 5.923077, 6.192307, 6.461538, 6.730769, 7, 7.269231, 7.538462, 7.807693, 8.076923, 8.346154, 8.615384, 8.884615, 9.153846, 9.423077, 9.692307, 9.961538, 10.23077, 10.5, 10.769232, 11.038462, 11.307693, 11.576923, 11.846155, 12.115385, 12.384617, 12.653847, 12.923079, 13.192308, 13.461539, 13.73077, 14, 14.18609987, 14.37219973, 14.5582996, 14.74439946, 14.93049933, 15.11659919, 15.30269906, 15.48879892, 15.67489879, 15.86099865, 16.04709852, 16.23319838, 16.41929825, 16.60539811, 16.79149798, 16.97759784, 17.16369771, 17.34979757, 17.53589744, 17.7219973, 18.44534413, 19.16869096, 19.53036437, 19.53036437, 19.89203779, 20.61538462, 21.33873144, 22.06207827, 22.7854251, 23, 27, 32, 38, 44, 51, 60, 70, 82, 95, 110, 125, 142.5, 162, 184.5, 210, 238.5, 271.5, 309, 351.5, 400}
hastetab = {0.48076875, 0.48076875, 0.48076875, 0.48076875, 0.48076875, 0.48076875, 0.48076875, 0.48076875, 0.48076875, 0.48076875, 0.72115375, 0.96153875, 1.2019225, 1.4423075, 1.6826925, 1.9230775, 2.16346125, 2.40384625, 2.64423125, 2.884615, 3.125, 3.365385, 3.60576875, 3.84615375, 4.08653875, 4.3269225, 4.5673075, 4.8076925, 5.0480775, 5.28846125, 5.52884625, 5.76923125, 6.00961625, 6.25, 6.490385, 6.73076875, 6.97115375, 7.21153875, 7.4519225, 7.6923075, 7.9326925, 8.1730775, 8.41346125, 8.65384625, 8.89423125, 9.13461625, 9.375, 9.61538375, 9.85576875, 10.09615375, 10.33653875, 10.5769225, 10.8173075, 11.0576925, 11.2980775, 11.53846125, 11.77884625, 12.01923125, 12.25961625, 12.5, 12.56060925, 12.72538518, 12.8901611, 13.05493703, 13.21971295, 13.38448886, 13.54926479, 13.71404071, 13.87881664, 14.04359255, 14.20836848, 14.3731444, 14.53792033, 14.70269625, 14.86747216, 15.03224809, 15.19702401, 15.36179994, 15.52657585, 15.69135178, 16.33181511, 16.97227845, 17.29251013, 17.29251013, 17.61274179, 18.25320513, 18.89366846, 19.5341318, 20.17459514, 20, 25, 29, 35, 40, 46, 55, 64, 75, 86, 100, 114, 130, 148.5, 170, 193.5, 221, 252, 288, 328.5, 375}
verstab = {0.636364182, 0.636364182, 0.636364182, 0.636364182, 0.636364182, 0.636364182, 0.636364182, 0.636364182, 0.636364182, 0.636364182, 0.954545091, 1.272727182, 1.590909273, 1.909091364, 2.227272273, 2.545454364, 2.863636455, 3.181818545, 3.499999455, 3.818181545, 4.136363636, 4.454545727, 4.772727818, 5.090908727, 5.409090818, 5.727272909, 6.045455, 6.363635909, 6.681818, 7.000000091, 7.318181, 7.636363091, 7.954545182, 8.272727273, 8.590909364, 8.909091455, 9.227273545, 9.545454455, 9.863636545, 10.18181745, 10.49999955, 10.81818164, 11.13636373, 11.45454464, 11.77272673, 12.09091, 12.40909091, 12.72727418, 13.04545509, 13.36363718, 13.68181809, 14.00000136, 14.31818227, 14.63636555, 14.95454645, 15.27272973, 15.59090945, 15.90909155, 16.22727364, 16.54545455, 16.76539076, 16.98532695, 17.20526316, 17.42519936, 17.64513557, 17.86507177, 18.08500798, 18.30494418, 18.52488039, 18.74481659, 18.9647528, 19.18468899, 19.4046252, 19.6245614, 19.84449761, 20.06443381, 20.28437002, 20.50430622, 20.72424243, 20.94417863, 21.79904306, 22.6539075, 23.08133971, 23.08133971, 23.50877193, 24.36363637, 25.21850079, 26.07336523, 26.92822966, 27, 32, 38, 45, 52, 60, 71, 83, 97, 112, 130, 148, 168.5, 192, 218.5, 248.5, 283, 322, 366.5, 417, 475}
leechtab = {0.342657636, 0.342657636, 0.342657636, 0.342657636, 0.342657636, 0.342657636, 0.342657636, 0.342657636, 0.342657636, 0.342657636, 0.513985818, 0.685314636, 0.856643455, 1.027972273, 1.199300455, 1.370629273, 1.541958091, 1.713286909, 1.884615091, 2.055943909, 2.227272727, 2.398601545, 2.569930364, 2.741258545, 2.912587364, 3.083916182, 3.255245, 3.426573182, 3.597902, 3.769230818, 3.940559, 4.111887818, 4.283216636, 4.454545455, 4.625874273, 4.797203091, 4.968531909, 5.139860091, 5.311188909, 5.482517091, 5.653845909, 5.825174727, 5.996503545, 6.167831727, 6.339160545, 6.51049, 6.681818182, 6.853147636, 7.024475818, 7.195804636, 7.367132818, 7.538462273, 7.709790455, 7.881119909, 8.052448091, 8.223777545, 8.395105091, 8.566433909, 8.737762727, 8.909090909, 9.0275181, 9.145945284, 9.264372473, 9.382799656, 9.501226848, 9.619654031, 9.73808122, 9.856508404, 9.974935595, 10.09336278, 10.21178997, 10.33021715, 10.44864434, 10.56707153, 10.68549871, 10.8039259, 10.92235309, 11.04078027, 11.15920746, 11.27763465, 11.73794627, 12.19825788, 12.42841369, 12.42841369, 12.6585695, 13.11888112, 13.57919273, 14.03950435, 14.49981597, 14.50909091, 17.30909091, 20.36363636, 24.18181818, 28, 32.58181818, 38.18181818, 44.54545455, 52.18181818, 60.58181818, 70, 80, 91, 104, 118, 134, 150, 168, 187, 207, 230}
avoidtab = {0.122377727, 0.122377727, 0.122377727, 0.122377727, 0.122377727, 0.122377727, 0.122377727, 0.122377727, 0.122377727, 0.122377727, 0.183566364, 0.244755227, 0.305944091, 0.367132955, 0.428321591, 0.489510455, 0.550699318, 0.611888182, 0.673076818, 0.734265682, 0.795454545, 0.856643409, 0.917832273, 0.979020909, 1.040209773, 1.101398636, 1.1625875, 1.223776136, 1.284965, 1.346153864, 1.4073425, 1.468531364, 1.529720227, 1.590909091, 1.652097955, 1.713286818, 1.774475682, 1.835664318, 1.896853182, 1.958041818, 2.019230682, 2.080419545, 2.141608409, 2.202797045, 2.263985909, 2.325175, 2.386363636, 2.447552727, 2.508741364, 2.569930227, 2.631118864, 2.692307955, 2.753496591, 2.814685682, 2.875874318, 2.937063409, 2.998251818, 3.059440682, 3.120629545, 3.181818182, 3.224113607, 3.26640903, 3.308704455, 3.350999877, 3.393295302, 3.435590725, 3.47788615, 3.520181573, 3.562476998, 3.60477242, 3.647067845, 3.689363268, 3.731658693, 3.773954116, 3.816249541, 3.858544964, 3.900840389, 3.943135811, 3.985431236, 4.027726659, 4.192123666, 4.356520673, 4.438719175, 4.438719175, 4.52091768, 4.685314686, 4.849711691, 5.014108698, 5.178505705, 5.227272727, 6.136363636, 7.272727273, 8.636363636, 10, 11.59090909, 13.63636364, 15.90909091, 18.63636364, 21.59090909, 25, 28, 31, 35, 40, 45, 50.5, 57, 64, 71, 80}
speedtab = {0.122377727, 0.122377727, 0.122377727, 0.122377727, 0.122377727, 0.122377727, 0.122377727, 0.122377727, 0.122377727, 0.122377727, 0.183566364, 0.244755227, 0.305944091, 0.367132955, 0.428321591, 0.489510455, 0.550699318, 0.611888182, 0.673076818, 0.734265682, 0.795454545, 0.856643409, 0.917832273, 0.979020909, 1.040209773, 1.101398636, 1.1625875, 1.223776136, 1.284965, 1.346153864, 1.4073425, 1.468531364, 1.529720227, 1.590909091, 1.652097955, 1.713286818, 1.774475682, 1.835664318, 1.896853182, 1.958041818, 2.019230682, 2.080419545, 2.141608409, 2.202797045, 2.263985909, 2.325175, 2.386363636, 2.447552727, 2.508741364, 2.569930227, 2.631118864, 2.692307955, 2.753496591, 2.814685682, 2.875874318, 2.937063409, 2.998251818, 3.059440682, 3.120629545, 3.181818182, 3.224113607, 3.26640903, 3.308704455, 3.350999877, 3.393295302, 3.435590725, 3.47788615, 3.520181573, 3.562476998, 3.60477242, 3.647067845, 3.689363268, 3.731658693, 3.773954116, 3.816249541, 3.858544964, 3.900840389, 3.943135811, 3.985431236, 4.027726659, 4.192123666, 4.356520673, 4.438719175, 4.438719175, 4.52091768, 4.685314686, 4.849711691, 5.014108698, 5.178505705, 5.227272727, 6.136363636, 7.272727273, 8.636363636, 10, 11.59090909, 13.63636364, 15.90909091, 18.63636364, 21.59090909, 25, 28, 31, 35, 40, 45, 50.5, 57, 64, 71, 80}

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


local masteryamt, critamt, hasteamt, versinamt, versoutamt, leechamt, avoidamt, speedamt;


--Here is the function where the stats are pulled from the item that is currently moused over :M&L
local function getItemIdFromTooltip(self)
	
	--Determine Mastery Coefficient
    	masterycf = select(2,GetMasteryEffect())
		
	--Set Player level :M
	cvlevel = UnitLevel("player")
		
	--Select the level based rating amounts :M
	masteryamt = masterytab[cvlevel]
	hasteamt = hastetab[cvlevel]
	critamt = crittab[cvlevel]
	versinamt = verstab[cvlevel]
	versoutamt = verstab[cvlevel] * 2
	leechamt = leechtab[cvlevel]
	avoidamt = avoidtab[cvlevel]
	speedamt = speedtab[cvlevel]

   	--Get itemLink of mouseover :L
    	local name, itemLink = self:GetItem();

	--Declare variables for future use :M
	local rawcrit, rawhaste, rawmastery, rawvers, stats, rawleech, rawavoid, rawspeed, hexcolor;
	
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
			elseif(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_CR_LIFESTEAL_SHORT"])) then
				rawleech = string.match(_G[self:GetName().."TextLeft"..i]:GetText(), "%d+");
			elseif(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_CR_AVOIDANCE_SHORT"])) then
				rawavoid = string.match(_G[self:GetName().."TextLeft"..i]:GetText(), "%d+");
			elseif(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_CR_SPEED_SHORT"])) then
				rawspeed = string.match(_G[self:GetName().."TextLeft"..i]:GetText(), "%d+");
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
		rawavoid = stats["ITEM_MOD_CR_AVOIDANCE_SHORT"]
		rawspeed = stats["ITEM_MOD_CR_SPEED_SHORT"]
		rawleech = stats["ITEM_MOD_CR_LIFESTEAL_SHORT"]
		
	end
		end
	
    --Localing the variables here - we'll use them after... :L
    local pcrit, phaste, pversin, pversout, pmastery, prcrit, prhaste, prversin, prversout, prmastery, pleech, pavoid, pspeed, prleech, pravoid, prspeed;
    
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
	
	if rawavoid ~= nil then
		pavoid = rawavoid / avoidamt
	end
	
	if rawspeed ~= nil then
		pspeed = rawspeed / speedamt
	end
	
	if rawleech ~= nil then
		pleech = rawleech / leechamt
	end

    --Round The outputs :M
    prcrit = math.round(pcrit, 2)
    prhaste = math.round(phaste, 2)
    prversin = math.round(pversin, 2)
    prversout = math.round(pversout, 2)
    prmastery = math.round(pmastery, 2)
	prspeed = math.round(pspeed, 2)
	prleech = math.round(pleech, 2)
	pravoid = math.round(pavoid, 2)


    --Convert percentages to strings :M
    tostring(prcrit)
    tostring(prhaste)
    tostring(prversin)
    tostring(prversout)
    tostring(prmastery)
	tostring(prleech)
	tostring(pravoid)
	tostring(prspeed)
	
	--Convert text color from decimal to hex
	hexcolor = string.format("|cff%02x%02x%02x", cvred*255, cvgreen*255, cvblue*255)

    
	--Set output values in the same line as the rating in tooltip :L
	for i=1, self:NumLines() do
	
		--If line contains "Critical Strike", then sets show a 'fontString' and set its text :L
		if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_CRIT_RATING_SHORT"])) and rawcrit ~= nil then
			_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawcrit .. " " .. _G["ITEM_MOD_CRIT_RATING_SHORT"] .. hexcolor .. " (" .. prcrit .. "%)");
			break
		end		
	
	end
	
	for i=1, self:NumLines() do
	
			if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_HASTE_RATING_SHORT"])) and rawhaste ~= nil then
			_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawhaste .. " " .. _G["ITEM_MOD_HASTE_RATING_SHORT"] .. hexcolor .. " (" .. prhaste .. "%)");
			break
		end		
	
	end
	
	for i=1, self:NumLines() do
	
			if(string.find(_G[self:GetName() .. "TextLeft"..i]:GetText(), _G["ITEM_MOD_MASTERY_RATING_SHORT"])) and rawmastery ~= nil then
			_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawmastery .. " " .. _G["ITEM_MOD_MASTERY_RATING_SHORT"] .. hexcolor .. " (" .. prmastery .. "%)");
			break
		end		
	
	end
	
	for i=1, self:NumLines() do
	
			if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_VERSATILITY"])) and rawvers ~= nil then
			_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawvers .. " " .. _G["ITEM_MOD_VERSATILITY"] .. hexcolor .. " (" .. prversin .. "%/" .. prversout .. "%)");
			break
		end		
	
	end
	
	for i=1, self:NumLines() do
	
			if(string.find(_G[self:GetName() .. "TextLeft"..i]:GetText(), _G["ITEM_MOD_CR_SPEED_SHORT"])) and rawspeed ~= nil then
			_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawspeed .. " " .. _G["ITEM_MOD_CR_SPEED_SHORT"] .. hexcolor .. " (" .. prspeed .. "%)");
			break
		end		
	
	end
	
	for i=1, self:NumLines() do
	
			if(string.find(_G[self:GetName() .. "TextLeft"..i]:GetText(), _G["ITEM_MOD_CR_LIFESTEAL_SHORT"])) and rawleech ~= nil then
			_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawleech .. " " .. _G["ITEM_MOD_CR_LIFESTEAL_SHORT"] .. hexcolor .. " (" .. prleech .. "%)");
			break
		end		
	
	end
	
	for i=1, self:NumLines() do
	
			if(string.find(_G[self:GetName() .. "TextLeft"..i]:GetText(), _G["ITEM_MOD_CR_AVOIDANCE_SHORT"])) and rawavoid ~= nil then
			_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawavoid .. " " .. _G["ITEM_MOD_CR_AVOIDANCE_SHORT"] .. hexcolor .. " (" .. pravoid .. "%)");
			break
		end		
	
	end
	
	
end

--Hooks to make the addon function :L
GameTooltip:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
ItemRefTooltip:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
ShoppingTooltip1:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
ShoppingTooltip2:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
