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

masterytab = {
				2.704760381,	2.704760381,	2.704760381,	2.704760381,	2.704760381, --5
				2.704760381,	2.704760381,	2.704760381,	2.704760381,	2.704760381, --10
				2.704760381,	2.8399984,	    2.975236419,	3.110474438,	3.245712457, --15
				3.380950476,	3.516188495,	3.651426514,	3.786664533,	3.921902552, --20
				4.057140571,	4.19237859,	    4.327616609,	4.462854628,	4.598092647, --25
				4.737322892,	4.88209548,	    5.032659304,	5.189275662,	5.352218918, --30
				5.521777213,	5.698253213,	5.881964896,	6.073246395,	6.272448877, --35
				6.479941485,	6.696112333,	6.921369552,	7.156142407,	7.400882478, --40
				7.676707786,	7.962812896,	8.259580927,	8.567409279,	8.886710161, --45
				9.217911147,	9.561455743,	9.917803988,	10.28743306,	10.67083793, --50
				11.78114906,	13.00698914,	14.36037908,	15.85459057,	17.50427622, --55
				19.32561328,	21.33646224,	23.55654201,	26.00762324,	35.00000009, --60
			}
crittab = { 
			2.704760381,	2.704760381,	2.704760381,	2.704760381,	2.704760381, --5
			2.704760381,	2.704760381,	2.704760381,	2.704760381,	2.704760381, --10
			2.704760381,	2.8399984,	    2.975236419,	3.110474438,	3.245712457, --15
			3.380950476,	3.516188495,	3.651426514,	3.786664533,	3.921902552, --20
			4.057140571,	4.19237859,	    4.327616609,	4.462854628,	4.598092647, --25
			4.737322892,	4.88209548,	    5.032659304,	5.189275662,	5.352218918, --30
			5.521777213,	5.698253213,	5.881964896,	6.073246395,	6.272448877, --35
			6.479941485,	6.696112333,	6.921369552,	7.156142407,	7.400882478, --40
			7.676707786,	7.962812896,	8.259580927,	8.567409279,	8.886710161, --45
			9.217911147,	9.561455743,	9.917803988,	10.28743306,	10.67083793, --50
			11.78114906,	13.00698914,	14.36037908,	15.85459057,	17.50427622, --55
			19.32561328,	21.33646224,	23.55654201,	26.00762324,	35.00000009, --60			
			}
hastetab = {
			2.550202644,	2.550202644,	2.550202644,	2.550202644,	2.550202644, --5
			2.550202644,	2.550202644,	2.550202644,	2.550202644,	2.550202644, --10
			2.550202644,	2.677712777,	2.805222909,	2.932733041,	3.060243173, --15
			3.187753306,	3.315263438,	3.44277357,	    3.570283702,	3.697793835, --20
			3.825303967,	3.952814099,	4.080324231,	4.207834363,	4.335344496, --25
			4.466618727,	4.603118595,	4.745078773,	4.892745624,	5.046377837, --30
			5.206247087,	5.372638744,	5.545852617,	5.726203744,	5.914023226, --35
			6.109659115,	6.313477343,	6.525862721,	6.747219984,	6.977974908, --40
			7.23803877,	    7.507795016,	7.787604874,	8.077843034,	8.378898152, --45
			8.691173367,	9.015086844,	9.351072331,	9.699579745,	10.06107577, --50
			11.10794054,	12.26373262,	13.53978599,	14.94861396,	16.50403187, --55
			18.22129252,	20.11723583,	22.21045389,	24.52147334,	33.00000009, --60
			}
verstab = {
			3.091154721,	3.091154721,	3.091154721,	3.091154721,	3.091154721, --5
			3.091154721,	3.091154721,	3.091154721,	3.091154721,	3.091154721, --10
			3.091154721,	3.245712457,	3.400270193,	3.554827929,	3.709385665, --15
			3.863943401,	4.018501137,	4.173058873,	4.327616609,	4.482174345, --20
			4.636732081,	4.791289817,	4.945847553,	5.100405289,	5.254963025, --25
			5.414083305,	5.579537691,	5.751610634,	5.930600757,	6.11682162,	 --30
			6.310602529,	6.512289386,	6.722245596,	6.940853023,	7.168513002, --35
			7.405647412,	7.65269981,	    7.910136631,	8.178448466,	8.458151403, --40
			8.773380327,	9.100357595,	9.439521059,	9.79132489,	    10.15624018, --45
			10.5347556, 	10.92737799,	11.33463313,	11.75706636,	12.19524335, --50
			13.46417035,	14.86513044,	16.4118618,	    18.11953208,	20.00488711, --55
			22.08641518,	24.38452828,	26.92176229,	29.72299799,	40.0000001,	 --60
			}
leechtab = {
			1.622856228,	1.622856228,	1.622856228,	1.622856228,	1.622856228, --5
			1.622856228,	1.622856228,	1.622856228,	1.622856228,	1.622856228, --10
			1.622856228,	1.70399904, 	1.785141851,	1.866284663,	1.947427474, --15
			2.028570285,	2.109713097,	2.190855908,	2.27199872, 	2.353141531, --20
			2.434284342,	2.515427154,	2.596569965,	2.677712777,	2.758855588, --25
			2.842393735,	2.929257288,	3.019595583,	3.113565397,	3.211331351, --30
			3.313066328,	3.418951928,	3.529178938,	3.643947837,	3.763469326, --35
			3.887964891,	4.0176674,	    4.152821731,	4.293685444,	4.440529487, --40
			4.606024672,	4.777687737,	4.955748556,	5.140445567,	5.332026097, --45
			5.530746688,	5.736873446,	5.950682393,	6.172459837,	6.40250276,	 --50
			7.068689434,	7.804193483,	8.616227447,	9.51275434,	    10.50256573, --55
			11.59536797,	12.80187735,	14.1339252,	    15.60457394,	21.00000006, --60
			}
avoidtab = {
			1.081904152,	1.081904152,	1.081904152,	1.081904152,	1.081904152, --5
			1.081904152,	1.081904152,	1.081904152,	1.081904152,	1.081904152, --10
			1.081904152,	1.13599936,	    1.190094567,	1.244189775,	1.298284983, --15
			1.35238019,	    1.406475398,	1.460570605,	1.514665813,	1.568761021, --20
			1.622856228,	1.676951436,	1.731046644,	1.785141851,	1.839237059, --25
			1.894929157,	1.952838192,	2.013063722,	2.075710265,	2.140887567, --30
			2.208710885,	2.279301285,	2.352785959,	2.429298558,	2.508979551, --35
			2.591976594,	2.678444933,	2.768547821,	2.862456963,	2.960352991, --40
			3.070683114,	3.185125158,	3.303832371,	3.426963712,	3.554684064, --45
			3.687164459,	3.824582297,	3.967121595,	4.114973225,	4.268335174, --50
			4.712459623,	5.202795655,	5.744151632,	6.341836227,	7.001710488, --55
			7.730245312,	8.534584897,	9.422616802,	10.4030493,	    14.00000004, --60
			}
speedtab = {
			0.77278868,  	0.77278868,  	0.77278868,	    0.77278868, 	0.77278868,  --5
			0.77278868, 	0.77278868, 	0.77278868, 	0.77278868, 	0.77278868,	 --10
			0.77278868, 	0.811428114,	0.850067548,	0.888706982,	0.927346416, --15
			0.96598585,	    1.004625284,	1.043264718,	1.081904152,	1.120543586, --20
			1.15918302,  	1.197822454,	1.236461888,	1.275101322,	1.313740756, --25
			1.353520826,	1.394884423,	1.437902658,	1.482650189,	1.529205405, --30
			1.577650632,	1.628072347,	1.680561399,	1.735213256,	1.79212825,	 --35
			1.851411853,	1.913174952,	1.977534158,	2.044612116,	2.114537851, --40
			2.193345082,	2.275089399,	2.359880265,	2.447831223,	2.539060046, --45
			2.633688899,	2.731844498,	2.833658282,	2.939266589,	3.048810838, --50
			3.366042588,	3.716282611,	4.102965451,	4.529883019,	5.001221777, --55
			5.521603794,	6.096132069,	6.730440573,	7.430749497,	10.00000003, --60
			}

--Create Function to round the decimals :M
local function mathround(number, precision)
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
	
	--Check to make sure an itemLink is actually returned
	if(itemLink == nil) then
     		return;
	end

	--Declare variables for future use :M
	local rawcrit, rawhaste, rawmastery, rawvers, stats, rawleech, rawavoid, rawspeed, hexcolor;
	
	--Check to see if trainer window is open to prevent errors :M
		local numServices = GetNumTrainerServices()
		if numServices ~= 0 then
			return;
		else
	
	--Get Gem Info
	--local gem1name, gem1Link = GetItemGem(itemLink, 1)
	--local gem1stats = GetItemStats(gem1Link)		  
	--local gem2name, gem2Link = GetItemGem(itemLink, 2)
	--local gem3name, gem3Link = GetItemGem(itemLink, 3)
	
	
	
	--Get Item rarity :M
	local irare = select(3,GetItemInfo(itemLink))
	--Artifact specific processing :L

	
		--Gets stats from non Artifact items :M
		stats = GetItemStats(itemLink);
		
		--If not an item with stats, don't do anything :L
		if(stats == nil) then
			return;
		end

		--Pull individual stats from stats table :M
		rawmastery = stats["ITEM_MOD_MASTERY_RATING_SHORT"]
			print(rawmastery)
		rawcrit = stats["ITEM_MOD_CRIT_RATING_SHORT"]
		rawhaste = stats["ITEM_MOD_HASTE_RATING_SHORT"]
		rawvers = stats["ITEM_MOD_VERSATILITY"]
		rawavoid = stats["ITEM_MOD_CR_AVOIDANCE_SHORT"]
		rawspeed = stats["ITEM_MOD_CR_SPEED_SHORT"]
		rawleech = stats["ITEM_MOD_CR_LIFESTEAL_SHORT"]
		
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
    prcrit = mathround(pcrit, 2)
    prhaste = mathround(phaste, 2)
    prversin = mathround(pversin, 2)
    prversout = mathround(pversout, 2)
    prmastery = mathround(pmastery, 2)
	prspeed = mathround(pspeed, 2)
	prleech = mathround(pleech, 2)
	pravoid = mathround(pavoid, 2)


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
		local line = _G[self:GetName().."TextLeft"..i]
		local text = line:GetText()
		if text then
		--If line contains "Critical Strike", then sets show a 'fontString' and set its text :L
			if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_CRIT_RATING_SHORT"])) and rawcrit ~= nil then
				_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawcrit .. " " .. _G["ITEM_MOD_CRIT_RATING_SHORT"] .. hexcolor .. " (" .. prcrit .. "%)");
				break
			end
		end	
	end
	
	for i=1, self:NumLines() do
		local line = _G[self:GetName().."TextLeft"..i]
		local text = line:GetText()
		if text then	
			if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_HASTE_RATING_SHORT"])) and rawhaste ~= nil then
			_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawhaste .. " " .. _G["ITEM_MOD_HASTE_RATING_SHORT"] .. hexcolor .. " (" .. prhaste .. "%)");
			break
			end
		end	
	end
	
	for i=1, self:NumLines() do
		local line = _G[self:GetName().."TextLeft"..i]
		local text = line:GetText()
		if text then	
			if(string.find(_G[self:GetName() .. "TextLeft"..i]:GetText(), _G["ITEM_MOD_MASTERY_RATING_SHORT"])) and rawmastery ~= nil then
			_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawmastery .. " " .. _G["ITEM_MOD_MASTERY_RATING_SHORT"] .. hexcolor .. " (" .. prmastery .. "%)");
			break
			end
		end	
	end
	
	for i=1, self:NumLines() do
		local line = _G[self:GetName().."TextLeft"..i]
		local text = line:GetText()
		if text then
			if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_VERSATILITY"])) and rawvers ~= nil then
			_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawvers .. " " .. _G["ITEM_MOD_VERSATILITY"] .. hexcolor .. " (" .. prversin .. "%/" .. prversout .. "%)");
			break
			end
		end		
	end
	
	for i=1, self:NumLines() do
		local line = _G[self:GetName().."TextLeft"..i]
		local text = line:GetText()
		if text then
			if(string.find(_G[self:GetName() .. "TextLeft"..i]:GetText(), _G["ITEM_MOD_CR_SPEED_SHORT"])) and rawspeed ~= nil then
			_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawspeed .. " " .. _G["ITEM_MOD_CR_SPEED_SHORT"] .. hexcolor .. " (" .. prspeed .. "%)");
			break
			end
		end		
	end
	
	for i=1, self:NumLines() do
		local line = _G[self:GetName().."TextLeft"..i]
		local text = line:GetText()
		if text then
			if(string.find(_G[self:GetName() .. "TextLeft"..i]:GetText(), _G["ITEM_MOD_CR_LIFESTEAL_SHORT"])) and rawleech ~= nil then
			_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawleech .. " " .. _G["ITEM_MOD_CR_LIFESTEAL_SHORT"] .. hexcolor .. " (" .. prleech .. "%)");
			break
			end
		end		
	end
	
	for i=1, self:NumLines() do
		local line = _G[self:GetName().."TextLeft"..i]
		local text = line:GetText()
		if text then
			if(string.find(_G[self:GetName() .. "TextLeft"..i]:GetText(), _G["ITEM_MOD_CR_AVOIDANCE_SHORT"])) and rawavoid ~= nil then
			_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawavoid .. " " .. _G["ITEM_MOD_CR_AVOIDANCE_SHORT"] .. hexcolor .. " (" .. pravoid .. "%)");
			break
			end
		end	
	end	
end

--Hooks to make the addon function :L
GameTooltip:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
ItemRefTooltip:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
ShoppingTooltip1:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
ShoppingTooltip2:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
GameTooltip.ItemTooltip.Tooltip:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
