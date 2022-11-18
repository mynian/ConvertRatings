--Set color variables default values to avoid first load errors 
cvred = 1
cvgreen = .996
cvblue = .545
cvalpha = 1

--Hard coded color options table 
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

--equipment slot table
local invtable = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 16, 17, 16, 15, 16, 0, 0, 5, 16, 17, 17, 0, 0, 16, 0, 0}

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

--Slash Command to change the color of the output 
SLASH_CONVERTRATINGS1, SLASH_CONVERTRATINGS2 = '/convertratings', '/cvr';
function SlashCmdList.CONVERTRATINGS(msg, editBox)
	--Grab the first input word as the command and the rest of the input as a user variable 
	local command, rest = msg:match("^(%S*)%s*(.-)$");
	--Hard coded color options parsing 
	
	if (colorTable[string.lower(command)]) then
		cvred, cvgreen, cvblue = unpack(colorTable[string.lower(command)]);
		print("Convert Ratings output color set to "..string.lower(command));
	elseif string.lower(command) == 'custom' and rest == "" then
		ShowColorPicker(cvred, cvgreen, cvblue, nil, myColorCallback);
	else
		--when no valid args entered, output this stuff 
		print("Convert Ratings: Valid color options are red, green, blue, black, white, lightblue, lightred, pink, purple, orange or custom")
		print("Convert Ratings: The custom option will bring up the Color Picker for you to choose a color.")
		print("Convert Ratings: To reset to the default color, use /convertratings default")
	end
end

--rating tables to allow addon to work at all levels 
masterytab = { 
			2.704760381, 2.704760381, 2.704760381, 2.704760381, 2.704760381, --5
			2.704760381, 2.704760381, 2.704760381, 2.704760381, 2.704760381, --10
			2.704760381, 2.839998400, 2.975236419, 3.110474438, 3.245712457, --15
			3.380950476, 3.516188495, 3.651426514, 3.786664533, 3.921902552, --20
			4.057140571, 4.192378590, 4.327616609, 4.462854628, 4.598092647, --25
			4.737322892, 4.882095480, 5.032659304, 5.189275662, 5.352218918, --30
			5.521777213, 5.698253213, 5.881964896, 6.073246395, 6.272448877, --35
			6.479941485, 6.696112333, 6.921369552, 7.156142407, 7.400882478, --40
			7.676707786, 7.962812896, 8.259580927, 8.567409279, 8.886710161, --45
			9.217911147, 9.561455743, 9.917803988, 10.28743306, 10.67083793, --50
			11.78114906, 13.00698914, 14.36037908, 15.85459057, 17.50427622, --55
			19.32561328, 21.33646224, 23.55654201, 26.00762324, 35.00000009, --60
			40.79412275, 47.54744134, 55.41874725, 64.59311921, 75.28627506, --65
			87.74964396, 102.2762782, 119.2077439, 138.9421522, 219.9999998, --70
			}

crittab = { 
			2.704760381, 2.704760381, 2.704760381, 2.704760381, 2.704760381, --5
			2.704760381, 2.704760381, 2.704760381, 2.704760381, 2.704760381, --10
			2.704760381, 2.839998400, 2.975236419, 3.110474438, 3.245712457, --15
			3.380950476, 3.516188495, 3.651426514, 3.786664533, 3.921902552, --20
			4.057140571, 4.192378590, 4.327616609, 4.462854628, 4.598092647, --25
			4.737322892, 4.882095480, 5.032659304, 5.189275662, 5.352218918, --30
			5.521777213, 5.698253213, 5.881964896, 6.073246395, 6.272448877, --35
			6.479941485, 6.696112333, 6.921369552, 7.156142407, 7.400882478, --40
			7.676707786, 7.962812896, 8.259580927, 8.567409279, 8.886710161, --45
			9.217911147, 9.561455743, 9.917803988, 10.28743306, 10.67083793, --50
			11.78114906, 13.00698914, 14.36037908, 15.85459057, 17.50427622, --55
			19.32561328, 21.33646224, 23.55654201, 26.00762324, 35.00000009, --60
			40.79412275, 47.54744134, 55.41874725, 64.59311921, 75.28627506, --65
			87.74964396, 102.2762782, 119.2077439, 138.9421522, 219.9999998, --70
			}

hastetab = {
			2.550202644, 2.550202644, 2.550202644, 2.550202644, 2.550202644, --5
			2.550202644, 2.550202644, 2.550202644, 2.550202644, 2.550202644, --10
			2.550202644, 2.677712777, 2.805222909, 2.932733041, 3.060243173, --15
			3.187753306, 3.315263438, 3.442773570, 3.570283702, 3.697793835, --20
			3.825303967, 3.952814099, 4.080324231, 4.207834363, 4.335344496, --25
			4.466618727, 4.603118595, 4.745078773, 4.892745624, 5.046377837, --30
			5.206247087, 5.372638744, 5.545852617, 5.726203744, 5.914023226, --35
			6.109659115, 6.313477343, 6.525862721, 6.747219984, 6.977974908, --40
			7.238038770, 7.507795016, 7.787604874, 8.077843034, 8.378898152, --45
			8.691173367, 9.015086844, 9.351072331, 9.699579745, 10.06107577, --50
			11.10794054, 12.26373262, 13.53978599, 14.94861396, 16.50403187, --55
			18.22129252, 20.11723583, 22.21045389, 24.52147334, 33.00000009, --60
			38.93984445, 45.38619401, 52.89971328, 61.65706833, 71.86417165, --65
			83.76102378, 97.62735649, 113.7892101, 132.6265998, 209.9999998, --70
			}

verstab = {
			3.091154721, 3.091154721, 3.091154721, 3.091154721, 3.091154721, --5
			3.091154721, 3.091154721, 3.091154721, 3.091154721, 3.091154721, --10
			3.091154721, 3.245712457, 3.400270193, 3.554827929, 3.709385665, --15
			3.863943401, 4.018501137, 4.173058873, 4.327616609, 4.482174345, --20
			4.636732081, 4.791289817, 4.945847553, 5.100405289, 5.254963025, --25
			5.414083305, 5.579537691, 5.751610634, 5.930600757, 6.116821620, --30
			6.310602529, 6.512289386, 6.722245596, 6.940853023, 7.168513002, --35
			7.405647412, 7.652699810, 7.910136631, 8.178448466, 8.458151403, --40
			8.773380327, 9.100357595, 9.439521059, 9.791324890, 10.15624018, --45
			10.53475560, 10.92737799, 11.33463313, 11.75706636, 12.19524335, --50
			13.46417035, 14.86513044, 16.41186180, 18.11953208, 20.00488711, --55
			22.08641518, 24.38452828, 26.92176229, 29.72299799, 40.00000010, --60
			46.35695768, 54.03118334, 62.97584915, 73.40127183, 85.5525853,  --65
			99.7155045, 116.2230434, 135.4633454, 157.8888093, 249.9999998,  --70
			}

leechtab = {
			1.622856228, 1.622856228, 1.622856228, 1.622856228, 1.622856228, --5
			1.622856228, 1.622856228, 1.622856228, 1.622856228, 1.622856228, --10
			1.622856228, 1.703999040, 1.785141851, 1.866284663, 1.947427474, --15
			2.028570285, 2.109713097, 2.190855908, 2.271998720, 2.353141531, --20
			2.434284342, 2.515427154, 2.596569965, 2.677712777, 2.758855588, --25
			2.842393735, 2.929257288, 3.019595583, 3.113565397, 3.211331351, --30
			3.313066328, 3.418951928, 3.529178938, 3.643947837, 3.763469326, --35
			3.887964891, 4.017667400, 4.152821731, 4.293685444, 4.440529487, --40
			4.606024672, 4.777687737, 4.955748556, 5.140445567, 5.332026097, --45
			5.530746688, 5.736873446, 5.950682393, 6.172459837, 6.402502760, --50
			7.068689434, 7.804193483, 8.616227447, 9.512754340, 10.50256573, --55
			11.59536797, 12.80187735, 14.13392520, 15.60457394, 21.00000006, --60
			24.47647365, 28.52846481, 33.25124835, 38.75587152, 45.17176504, --65
			52.64978637, 61.36576694, 71.52464636, 83.36529132, 131.9999999, --70
			}

avoidtab = {
			1.081904152, 1.081904152, 1.081904152, 1.081904152, 1.081904152, --5
			1.081904152, 1.081904152, 1.081904152, 1.081904152, 1.081904152, --10
			1.081904152, 1.135999360, 1.190094567, 1.244189775, 1.298284983, --15
			1.352380190, 1.406475398, 1.460570605, 1.514665813, 1.568761021, --20
			1.622856228, 1.676951436, 1.731046644, 1.785141851, 1.839237059, --25
			1.894929157, 1.952838192, 2.013063722, 2.075710265, 2.140887567, --30
			2.208710885, 2.279301285, 2.352785959, 2.429298558, 2.508979551, --35
			2.591976594, 2.678444933, 2.768547821, 2.862456963, 2.960352991, --40
			3.070683114, 3.185125158, 3.303832371, 3.426963712, 3.554684064, --45
			3.687164459, 3.824582297, 3.967121595, 4.114973225, 4.268335174, --50
			4.712459623, 5.202795655, 5.744151632, 6.341836227, 7.001710488, --55
			7.730245312, 8.534584897, 9.422616802, 10.40304930, 14.00000004, --60
			16.3176491, 19.01897654, 22.1674989, 25.83724768, 30.11451002,   --65
			35.09985758, 40.91051129, 47.68309758, 55.57686088, 87.99999994, --70
			}

speedtab = {
			0.772788680, 0.772788680, 0.772788680, 0.772788680, 0.772788680, --5
			0.772788680, 0.772788680, 0.772788680, 0.772788680, 0.772788680, --10
			0.772788680, 0.811428114, 0.850067548, 0.888706982, 0.927346416, --15
			0.965985850, 1.004625284, 1.043264718, 1.081904152, 1.120543586, --20
			1.159183020, 1.197822454, 1.236461888, 1.275101322, 1.313740756, --25
			1.353520826, 1.394884423, 1.437902658, 1.482650189, 1.529205405, --30
			1.577650632, 1.628072347, 1.680561399, 1.735213256, 1.792128250, --35
			1.851411853, 1.913174952, 1.977534158, 2.044612116, 2.114537851, --40
			2.193345082, 2.275089399, 2.359880265, 2.447831223, 2.539060046, --45
			2.633688899, 2.731844498, 2.833658282, 2.939266589, 3.048810838, --50
			3.366042588, 3.716282611, 4.102965451, 4.529883019, 5.001221777, --55
			5.521603794, 6.096132069, 6.730440573, 7.430749497, 10.00000003, --60
			11.4965255, 13.39973347, 15.61801059, 18.20351541, 21.21704115,  --65
			24.72944512, 28.82331477, 33.59490966, 39.15642471, 61.99999996, --70
			}
--Fuck you Prickle for making me make those look pretty.

--Create Function to round the decimals 
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
    
    -- convert number to string for formatting 
    number = tostring(number);      
    
    -- set cutoff :M
    local cutoff = number:sub(decimal + 1 + precision);
      
    -- delete everything after the cutoff 
    number = number:gsub(cutoff, "");
  else
    -- number is an integer 
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

local masteryamt, critamt, hasteamt, versinamt, versoutamt, leechamt, avoidamt, speedamt, cvlevel;

--Here is the function where the stats are pulled from the item that is currently moused over
local function getItemIdFromTooltip(self)
	
	--Determine Mastery Coefficient
	masterycf = select(2,GetMasteryEffect())
		
	--Set Player level :M
	cvlevel = UnitLevel("player")
		
	--Select the level based rating amounts 
	masteryamt = masterytab[cvlevel]
	hasteamt = hastetab[cvlevel]
	critamt = crittab[cvlevel]
	versamt = verstab[cvlevel]	
	leechamt = leechtab[cvlevel]
	avoidamt = avoidtab[cvlevel]
	speedamt = speedtab[cvlevel]

	--Calculate the DR breakpoints
	masterytenperc = masteryamt * 30
	masterytwentyperc = masterytenperc + ((masteryamt * 9) * 1.1)
	masterythirtyperc = masterytwentyperc + ((masteryamt * 8) * 1.2)
	masteryfourtyperc = masterythirtyperc + ((masteryamt * 7) * 1.3)
	masteryfiftyperc = masteryfourtyperc + ((masteryamt * 12) * 1.4)
	masterycap = masteryfiftyperc + ((masteryamt * 60) * 1.5)

	crittenperc = critamt * 30
	crittwentyperc = crittenperc + ((critamt * 9) * 1.1)
	critthirtyperc = crittwentyperc + ((critamt * 8) * 1.2)
	critfourtyperc = critthirtyperc + ((critamt * 7) * 1.3)
	critfiftyperc = critfourtyperc + ((critamt * 12) * 1.4)
	critcap = critfiftyperc + ((critamt * 60) * 1.5)

	hastetenperc = hasteamt * 30
	hastetwentyperc = hastetenperc + ((hasteamt * 9) * 1.1)
	hastethirtyperc = hastetwentyperc + ((hasteamt * 8) * 1.2)
	hastefourtyperc = hastethirtyperc + ((hasteamt * 7) * 1.3)
	hastefiftyperc = hastefourtyperc + ((hasteamt * 12) * 1.4)
	hastecap = hastefiftyperc + ((hasteamt * 60) * 1.5)

	verstenperc = versamt * 30
	verstwentyperc = verstenperc + ((versamt * 9) * 1.1)
	versthirtyperc = verstwentyperc + ((versamt * 8) * 1.2)
	versfourtyperc = versthirtyperc + ((versamt * 7) * 1.3)
	versfiftyperc = versfourtyperc + ((versamt * 12) * 1.4)
	verscap = versfiftyperc + ((versamt * 60) * 1.5)

	leechtenperc = leechamt * 30
	leechtwentyperc = leechtenperc + ((leechamt * 9) * 1.1)
	leechthirtyperc = leechtwentyperc + ((leechamt* 8) * 1.2)
	leechfourtyperc = leechthirtyperc + ((leechamt * 7) * 1.3)
	leechfiftyperc = leechfourtyperc + ((leechamt * 12) * 1.4)
	leechcap = leechfiftyperc + ((leechamt * 60) * 1.5)

	avoidtenperc = avoidamt * 30
	avoidtwentyperc = avoidtenperc + ((avoidamt * 9) * 1.1)
	avoidthirtyperc = avoidtwentyperc + ((avoidamt * 8) * 1.2)
	avoidfourtyperc = avoidthirtyperc + ((avoidamt	 * 7) * 1.3)
	avoidfiftyperc = avoidfourtyperc + ((avoidamt * 12) * 1.4)
	avoidcap = avoidfiftyperc + ((avoidamt * 60) * 1.5)

	speedtenperc = speedamt * 30
	speedtwentyperc = speedtenperc + ((speedamt * 9) * 1.1)
	speedthirtyperc = speedtwentyperc + ((speedamt * 8) * 1.2)
	speedfourtyperc = speedthirtyperc + ((speedamt * 7) * 1.3)
	speedfiftyperc = speedfourtyperc + ((speedamt * 12) * 1.4)
	speedcap = speedfiftyperc + ((speedamt * 60) * 1.5)

   	--Get itemLink of mouseover 
	local itemLink = C_Item.GetItemLinkByGUID(self:GetTooltipData()["guid"])	
	
	--Check to make sure an itemLink is actually returned
	if(itemLink == nil) then
     		return;
	end

	--Declare variables for future use
	local rawcrit, rawhaste, rawmastery, rawvers, stats, rawleech, rawavoid, rawspeed, hexcolor, oldmastery, newsomastery, newstmastery, oldcrit, newsocrit, newstcrit, oldhaste, newsohaste, newsthaste, oldvers, newsovers, newstvers, oldavoid, newsoavoid, newstavoid, oldspeed, newsospeed, newstspeed, oldleech, newsoleech, newstleech;
	local eqitemslot, eqitemslotname, eqitemtype, eqsoitemlink, eqstitemlink, eqsostats, eqststats, eqsomastery, eqstmastery, eqsocrit, eqstcrit, eqsohaste, eqsthaste, eqsovers, eqstvers, eqsoleech, eqstleech, eqsoavoid, eqstavoid, eqsospeed, eqstspeed, stitemtype, stitemslot, stitemlink;
	
	
	--Check to see if trainer window is open to prevent errors 
	local numServices = GetNumTrainerServices()
	if numServices ~= 0 then
		return;
	else
	
		--Gets stats items
		stats = GetItemStats(itemLink);
		
		--If not an item with stats, don't do anything
		if(stats == nil) then
			return;
		end

		--Pull individual stats from stats table
		rawmastery = stats["ITEM_MOD_MASTERY_RATING_SHORT"]			
		rawcrit = stats["ITEM_MOD_CRIT_RATING_SHORT"]
		rawhaste = stats["ITEM_MOD_HASTE_RATING_SHORT"]
		rawvers = stats["ITEM_MOD_VERSATILITY"]
		rawavoid = stats["ITEM_MOD_CR_AVOIDANCE_SHORT"]
		rawspeed = stats["ITEM_MOD_CR_SPEED_SHORT"]
		rawleech = stats["ITEM_MOD_CR_LIFESTEAL_SHORT"]
	
		--Get the item's equip slot
		eqitemtype = C_Item.GetItemInventoryTypeByID(itemLink)
		eqitemslot = invtable[eqitemtype]	
		
		--Get the itemlinks for the slots that the new item can be equipped into		
		if eqitemslot == 11 then
			eqsoitemlink = GetInventoryItemLink("player", 11)
			eqstitemlink = GetInventoryItemLink("player", 12)
		elseif eqitemslot == 13 then
			eqsoitemlink = GetInventoryItemLink("player", 13)
			eqstitemlink = GetInventoryItemLink("player", 14)
		elseif eqitemslot == 16 then
			stitemlink = GetInventoryItemLink("player", 17)
			if stitemlink ~= nil then
				stitemtype = C_Item.GetItemInventoryTypeByID(stitemlink)
				if (stitemtype == 14) or (stitemtype == 22) or (stitemtype == 23) then
					eqsoitemlink = GetInventoryItemLink("player", 16)
				else
					eqsoitemlink = GetInventoryItemLink("player", 16)
					eqstitemlink = GetInventoryItemLink("player", 17)
				end
			else
				eqsoitemlink = GetInventoryItemLink("player", 16)
			end					
		else
			eqsoitemlink = GetInventoryItemLink("player", eqitemslot)
		end		
	
		--Slot one stats table
		if eqsoitemlink ~= nil then
			eqsostats = GetItemStats(eqsoitemlink)
		end

		--Slot two stats table
		if eqstitemlink ~= nil then
			eqststats = GetItemStats(eqstitemlink)			
		end
	
		--Slot one individual stat pulls
		if eqsostats ~= nil then
			eqsomastery = eqsostats["ITEM_MOD_MASTERY_RATING_SHORT"]			
			eqsocrit = eqsostats["ITEM_MOD_CRIT_RATING_SHORT"]	
			eqsohaste = eqsostats["ITEM_MOD_HASTE_RATING_SHORT"]
			eqsovers = eqsostats["ITEM_MOD_VERSATILITY"]
			eqsoavoid = eqsostats["ITEM_MOD_CR_AVOIDANCE_SHORT"]
			eqsospeed = eqsostats["ITEM_MOD_CR_SPEED_SHORT"]
			eqsoleech = eqsostats["ITEM_MOD_CR_LIFESTEAL_SHORT"]					
		end

		--Slot two individual stat pulls
		if eqststats ~= nil then
			eqstmastery = eqststats["ITEM_MOD_MASTERY_RATING_SHORT"]			
			eqstcrit = eqststats["ITEM_MOD_CRIT_RATING_SHORT"]	
			eqsthaste = eqststats["ITEM_MOD_HASTE_RATING_SHORT"]
			eqstvers = eqststats["ITEM_MOD_VERSATILITY"]
			eqstavoid = eqststats["ITEM_MOD_CR_AVOIDANCE_SHORT"]
			eqstspeed = eqststats["ITEM_MOD_CR_SPEED_SHORT"]
			eqstleech = eqststats["ITEM_MOD_CR_LIFESTEAL_SHORT"]					
		end
	end
	
	--Pulling Current Combat Rating Bonuses for a baseline	
	oldmastery = GetCombatRating(26)
	oldcrit = GetCombatRating(9)
	oldhaste = GetCombatRating(18)
	oldvers = GetCombatRating(29)
	oldavoid = GetCombatRating(21)
	oldspeed = GetCombatRating(14)
	oldleech = GetCombatRating(17)

	--Remove the rating amount from the baseline if the slot has an item already equipped to avoid double dipping the stats possibly causing an erroneous DR tier reach
	if eqsostats ~= nil then
		if eqsomastery ~= nil then
			newsomastery = oldmastery - eqsomastery
		end
		if eqsocrit ~= nil then
			newsocrit = oldcrit - eqsocrit
		end
		if eqsohaste ~= nil then
			newsohaste = oldhaste - eqsohaste
		end
		if eqsovers ~= nil then
			newsovers = oldvers - eqsovers
		end
		if eqsoavoid ~= nil then
			newsoavoid = oldavoid - eqsoavoid
		end
		if eqsospeed ~= nil then
			newsospeed = oldspeed - eqsospeed
		end
		if eqsoleech ~= nil then
			newsoleech = oldleech - eqsoleech
		end
	end

	if eqststats ~= nil then
		if eqstmastery ~= nil then
			newstmastery = oldmastery - eqstmastery
		end
		if eqstcrit ~= nil then
			newstcrit = oldcrit - eqstcrit
		end
		if eqsthaste ~= nil then
			newsthaste = oldhaste - eqsthaste
		end
		if eqstvers ~= nil then
			newstvers = oldvers - eqstvers
		end
		if eqstavoid ~= nil then
			newstavoid = oldavoid - eqstavoid
		end
		if eqstspeed ~= nil then
			newstspeed = oldspeed - eqstspeed
		end
		if eqstleech ~= nil then
			newstleech = oldleech - eqstleech
		end
	end
	
    --Localing the variables here   
	local psocrit, pstcrit, psohaste, psthaste, psoversin, psoversout, pstversin, pstversout, psomastery, pstmastery, psoavoid, pstavoid, psospeed, pstspeed, psoleech, pstleech;
	local prsocrit, prstcrit, prsohaste, prsthaste, prsoversin, prstversin, prsoversout, prstversout, prsomastery, prstmastery, prsoavoid, prstavoid, prsospeed, prstspeed, prsoleech, prstleech;
	local socritdiff, socritremain, stcritdiff, stcritremain, somasterydiff, somasteryremain, stmasterydiff, stmasteryremain, sohastediff, sohasteremain,sthastediff, sthasteremain, soversdiff, soversremain, stversdiff, stversremain, soavoiddiff, soavoidremain, stavoiddiff, stavoidremain, sospeeddiff, sospeedremain, stspeeddiff, stspeedremain, soleechdiff, soleechremain, stleechdiff, stleechremain;
    
    --convert raw stats into percentages so long as they are not nil
	if rawcrit ~= nil then
		if newsocrit ~= nil then
			if newsocrit >= critcap then
				psocrit = 0
			elseif newsocrit < critcap and newsocrit >= critfiftyperc then
				if (newsocrit + rawcrit) <= critcap then
					psocrit = rawcrit / (critamt * 1.5)
				else 
					socritdiff = critcap - newsocrit				
					psocrit = socritdiff / (critamt * 1.5)
				end
			elseif newsocrit < critfiftyperc and newsocrit >= critfourtyperc then
				if (newsocrit + rawcrit) <= critfiftyperc then
					psocrit = rawcrit / (critamt * 1.4)
				else 
					socritdiff = critfiftyperc - newsocrit
					socritremain = rawcrit - socritdiff
					psocrit = (socritdiff / (critamt * 1.4)) + (socritremain / (critamt * 1.5))
				end
			elseif newsocrit < critfourtyperc and newsocrit >= critthirtyperc then
				if (newsocrit + rawcrit) <= critfourtyperc then
					psocrit = rawcrit / (critamt * 1.3)
				else
					socritdiff = critfourtyperc - newsocrit
					socritremain = rawcrit - socritdiff
					psocrit = (socritdiff / (critamt * 1.3)) + (socritremain / (critamt * 1.4))
				end
			elseif newsocrit < critthirtyperc and newsocrit >= crittwentyperc then
				if (newsocrit + rawcrit) <= critthirtyperc then
					psocrit = rawcrit / (critamt * 1.2)
				else
					socritdiff = critthirtyperc - newsocrit
					socritremain = rawcrit - socritdiff
					psocrit = (socritdiff / (critamt * 1.2)) + (socritremain / (critamt * 1.3))
				end
			elseif newsocrit < crittwentyperc and newsocrit >= crittenperc then
				if (newsocrit + rawcrit) <= crittwentyperc then
					psocrit = rawcrit / (critamt * 1.1)
				else
					socritdiff = crittwentyperc - newsocrit
					socritremain = rawcrit - socritdiff
					psocrit = (socritdiff / (critamt * 1.1)) + (socritremain / (critamt * 1.2))
				end
			else
				if (newsocrit + rawcrit) < crittenperc then
					psocrit = rawcrit / critamt
				else
					socritdiff = crittenperc - newsocrit
					socritremain = rawcrit - socritdiff
					psocrit = (socritdiff / critamt) + (socritremain / (critamt * 1.1))
				end
			end
		else
			if oldcrit >= critcap then
				psocrit = 0
			elseif oldcrit < critcap and oldcrit >= critfiftyperc then
				if (oldcrit + rawcrit) <= critcap then
					psocrit = rawcrit / (critamt * 1.5)
				else 
					socritdiff = critcap - oldcrit				
					psocrit = socritdiff / (critamt * 1.5)
				end
			elseif oldcrit < critfiftyperc and oldcrit >= critfourtyperc then
				if (oldcrit + rawcrit) <= critfiftyperc then
					psocrit = rawcrit / (critamt * 1.4)
				else 
					socritdiff = critfiftyperc - oldcrit
					socritremain = rawcrit - socritdiff
					psocrit = (socritdiff / (critamt * 1.4)) + (socritremain / (critamt * 1.5))
				end
			elseif oldcrit < critfourtyperc and oldcrit >= critthirtyperc then
				if (oldcrit + rawcrit) <= critfourtyperc then
					psocrit = rawcrit / (critamt * 1.3)
				else
					socritdiff = critfourtyperc - oldcrit
					socritremain = rawcrit - socritdiff
					psocrit = (socritdiff / (critamt * 1.3)) + (socritremain / (critamt * 1.4))
				end
			elseif oldcrit < critthirtyperc and oldcrit >= crittwentyperc then
				if (oldcrit + rawcrit) <= critthirtyperc then
					psocrit = rawcrit / (critamt * 1.2)
				else
					socritdiff = critthirtyperc - oldcrit
					socritremain = rawcrit - socritdiff
					psocrit = (socritdiff / (critamt * 1.2)) + (socritremain / (critamt * 1.3))
				end
			elseif oldcrit < crittwentyperc and oldcrit >= crittenperc then
				if (oldcrit + rawcrit) <= crittwentyperc then
					psocrit = rawcrit / (critamt * 1.1)
				else
					socritdiff = crittwentyperc - oldcrit
					socritremain = rawcrit - socritdiff
					psocrit = (socritdiff / (critamt * 1.1)) + (socritremain / (critamt * 1.2))
				end
			else
				if (oldcrit + rawcrit) < crittenperc then
					psocrit = rawcrit / critamt
				else
					socritdiff = crittenperc - oldcrit
					socritremain = rawcrit - socritdiff
					psocrit = (socritdiff / critamt) + (socritremain / (critamt * 1.1))
				end
			end
		end
			
	
		if eqststats ~= nil and newstcrit ~= nil then
			if newstcrit >= critcap then
				pstcrit = 0
			elseif newstcrit < critcap and newstcrit >= critfiftyperc then
				if (newstcrit + rawcrit) <= critcap then
					pstcrit = rawcrit / (critamt * 1.5)
				else 
					stcritdiff = critcap - newstcrit				
					pstcrit = stcritdiff / (critamt * 1.5)
				end
			elseif newstcrit < critfiftyperc and newstcrit >= critfourtyperc then
				if (newstcrit + rawcrit) <= critfiftyperc then
					pstcrit = rawcrit / (critamt * 1.4)
				else 
					stcritdiff = critfiftyperc - newstcrit
					stcritremain = rawcrit - stcritdiff
					pstcrit = (stcritdiff / (critamt * 1.4)) + (stcritremain / (critamt * 1.5))
				end
			elseif newstcrit < critfourtyperc and newstcrit >= critthirtyperc then
				if (newstcrit + rawcrit) <= critfourtyperc then
					pstcrit = rawcrit / (critamt * 1.3)
				else
					stcritdiff = critfourtyperc - newstcrit
					stcritremain = rawcrit - stcritdiff
					pstcrit = (stcritdiff / (critamt * 1.3)) + (stcritremain / (critamt * 1.4))
				end
			elseif newstcrit < critthirtyperc and newstcrit >= crittwentyperc then
				if (newstcrit + rawcrit) <= critthirtyperc then
					pstcrit = rawcrit / (critamt * 1.2)
				else
					stcritdiff = critthirtyperc - newstcrit
					stcritremain = rawcrit - stcritdiff
					pstcrit = (stcritdiff / (critamt * 1.2)) + (stcritremain / (critamt * 1.3))
				end
			elseif newstcrit < crittwentyperc and newstcrit >= crittenperc then
				if (newstcrit + rawcrit) <= crittwentyperc then
					pstcrit = rawcrit / (critamt * 1.1)
				else
					stcritdiff = crittwentyperc - newstcrit
					stcritremain = rawcrit - stcritdiff
					pstcrit = (stcritdiff / (critamt * 1.1)) + (stcritremain / (critamt * 1.2))
				end
			else
				if (newstcrit + rawcrit) < crittenperc then
					pstcrit = rawcrit / critamt
				else
					stcritdiff = crittenperc - newstcrit
					stcritremain = rawcrit - stcritdiff
					pstcrit = (stcritdiff / critamt) + (stcritremain / (critamt * 1.1))
				end
			end
		elseif eqststats ~= nil then
			if oldcrit >= critcap then
				pstcrit = 0
			elseif oldcrit < critcap and oldcrit >= critfiftyperc then
				if (oldcrit + rawcrit) <= critcap then
					pstcrit = rawcrit / (critamt * 1.5)
				else 
					stcritdiff = critcap - oldcrit				
					pstcrit = stcritdiff / (critamt * 1.5)
				end
			elseif oldcrit < critfiftyperc and oldcrit >= critfourtyperc then
				if (oldcrit + rawcrit) <= critfiftyperc then
					pstcrit = rawcrit / (critamt * 1.4)
				else 
					stcritdiff = critfiftyperc - oldcrit
					stcritremain = rawcrit - stcritdiff
					pstcrit = (stcritdiff / (critamt * 1.4)) + (stcritremain / (critamt * 1.5))
				end
			elseif oldcrit < critfourtyperc and oldcrit >= critthirtyperc then
				if (oldcrit + rawcrit) <= critfourtyperc then
					pstcrit = rawcrit / (critamt * 1.3)
				else
					stcritdiff = critfourtyperc - oldcrit
					stcritremain = rawcrit - stcritdiff
					pstcrit = (stcritdiff / (critamt * 1.3)) + (stcritremain / (critamt * 1.4))
				end
			elseif oldcrit < critthirtyperc and oldcrit >= crittwentyperc then
				if (oldcrit + rawcrit) <= critthirtyperc then
					pstcrit = rawcrit / (critamt * 1.2)
				else
					stcritdiff = critthirtyperc - oldcrit
					stcritremain = rawcrit - stcritdiff
					pstcrit = (stcritdiff / (critamt * 1.2)) + (stcritremain / (critamt * 1.3))
				end
			elseif oldcrit < crittwentyperc and oldcrit >= crittenperc then
				if (oldcrit + rawcrit) <= crittwentyperc then
					pstcrit = rawcrit / (critamt * 1.1)
				else
					stcritdiff = crittwentyperc - oldcrit
					stcritremain = rawcrit - stcritdiff
					pstcrit = (stcritdiff / (critamt * 1.1)) + (stcritremain / (critamt * 1.2))
				end
			else
				if (oldcrit + rawcrit) < crittenperc then
					pstcrit = rawcrit / critamt
				else
					stcritdiff = crittenperc - oldcrit
					stcritremain = rawcrit - stcritdiff
					pstcrit = (stcritdiff / critamt) + (stcritremain / (critamt * 1.1))
				end
			end
		end
	end	

	if rawhaste ~= nil then
		if newsohaste ~= nil then
			if newsohaste >= hastecap then
				psohaste = 0
			elseif newsohaste < hastecap and newsohaste >= hastefiftyperc then
				if (newsohaste + rawhaste) <= hastecap then
					psohaste = rawhaste / (hasteamt * 1.5)
				else 
					sohastediff = hastecap - newsohaste				
					psohaste = sohastediff / (hasteamt * 1.5)
				end
			elseif newsohaste < hastefiftyperc and newsohaste >= hastefourtyperc then
				if (newsohaste + rawhaste) <= hastefiftyperc then
					psohaste = rawhaste / (hasteamt * 1.4)
				else 
					sohastediff = hastefiftyperc - newsohaste
					sohasteremain = rawhaste - sohastediff
					psohaste = (sohastediff / (hasteamt * 1.4)) + (sohasteremain / (hasteamt * 1.5))
				end
			elseif newsohaste < hastefourtyperc and newsohaste >= hastethirtyperc then
				if (newsohaste + rawhaste) <= hastefourtyperc then
					psohaste = rawhaste / (hasteamt * 1.3)
				else
					sohastediff = hastefourtyperc - newsohaste
					sohasteremain = rawhaste - sohastediff
					psohaste = (sohastediff / (hasteamt * 1.3)) + (sohasteremain / (hasteamt * 1.4))
				end
			elseif newsohaste < hastethirtyperc and newsohaste >= hastetwentyperc then
				if (newsohaste + rawhaste) <= hastethirtyperc then
					psohaste = rawhaste / (hasteamt * 1.2)
				else
					sohastediff = hastethirtyperc - newsohaste
					sohasteremain = rawhaste - sohastediff
					psohaste = (sohastediff / (hasteamt * 1.2)) + (sohasteremain / (hasteamt * 1.3))
				end
			elseif newsohaste < hastetwentyperc and newsohaste >= hastetenperc then
				if (newsohaste + rawhaste) <= hastetwentyperc then
					psohaste = rawhaste / (hasteamt * 1.1)
				else
					sohastediff = hastetwentyperc - newsohaste
					sohasteremain = rawhaste - sohastediff
					psohaste = (sohastediff / (hasteamt * 1.1)) + (sohasteremain / (hasteamt * 1.2))
				end
			else
				if (newsohaste + rawhaste) < hastetenperc then
					psohaste = rawhaste / hasteamt
				else
					sohastediff = hastetenperc - newsohaste
					sohasteremain = rawhaste - sohastediff
					psohaste = (sohastediff / hasteamt) + (sohasteremain / (hasteamt * 1.1))
				end
			end
		else
			if oldhaste >= hastecap then
				psohaste = 0
			elseif oldhaste < hastecap and oldhaste >= hastefiftyperc then
				if (oldhaste + rawhaste) <= hastecap then
					psohaste = rawhaste / (hasteamt * 1.5)
				else 
					sohastediff = hastecap - oldhaste				
					psohaste = sohastediff / (hasteamt * 1.5)
				end
			elseif oldhaste < hastefiftyperc and oldhaste >= hastefourtyperc then
				if (oldhaste + rawhaste) <= hastefiftyperc then
					psohaste = rawhaste / (hasteamt * 1.4)
				else 
					sohastediff = hastefiftyperc - oldhaste
					sohasteremain = rawhaste - sohastediff
					psohaste = (sohastediff / (hasteamt * 1.4)) + (sohasteremain / (hasteamt * 1.5))
				end
			elseif oldhaste < hastefourtyperc and oldhaste >= hastethirtyperc then
				if (oldhaste + rawhaste) <= hastefourtyperc then
					psohaste = rawhaste / (hasteamt * 1.3)
				else
					sohastediff = hastefourtyperc - oldhaste
					sohasteremain = rawhaste - sohastediff
					psohaste = (sohastediff / (hasteamt * 1.3)) + (sohasteremain / (hasteamt * 1.4))
				end
			elseif oldhaste < hastethirtyperc and oldhaste >= hastetwentyperc then
				if (oldhaste + rawhaste) <= hastethirtyperc then
					psohaste = rawhaste / (hasteamt * 1.2)
				else
					sohastediff = hastethirtyperc - oldhaste
					sohasteremain = rawhaste - sohastediff
					psohaste = (sohastediff / (hasteamt * 1.2)) + (sohasteremain / (hasteamt * 1.3))
				end
			elseif oldhaste < hastetwentyperc and oldhaste >= hastetenperc then
				if (oldhaste + rawhaste) <= hastetwentyperc then
					psohaste = rawhaste / (hasteamt * 1.1)
				else
					sohastediff = hastetwentyperc - oldhaste
					sohasteremain = rawhaste - sohastediff
					psohaste = (sohastediff / (hasteamt * 1.1)) + (sohasteremain / (hasteamt * 1.2))
				end
			else
				if (oldhaste + rawhaste) < hastetenperc then
					psohaste = rawhaste / hasteamt
				else
					sohastediff = hastetenperc - oldhaste
					sohasteremain = rawhaste - sohastediff
					psohaste = (sohastediff / hasteamt) + (sohasteremain / (hasteamt * 1.1))
				end
			end
		end
	
		if eqststats ~= nil and newsthaste ~= nil then
			if newsthaste >= hastecap then
				psthaste = 0
			elseif newsthaste < hastecap and newsthaste >= hastefiftyperc then
				if (newsthaste + rawhaste) <= hastecap then
					psthaste = rawhaste / (hasteamt * 1.5)
				else 
					sthastediff = hastecap - newsthaste				
					psthaste = sthastediff / (hasteamt * 1.5)
				end
			elseif newsthaste < hastefiftyperc and newsthaste >= hastefourtyperc then
				if (newsthaste + rawhaste) <= hastefiftyperc then
					psthaste = rawhaste / (hasteamt * 1.4)
				else 
					sthastediff = hastefiftyperc - newsthaste
					sthasteremain = rawhaste - sthastediff
					psthaste = (sthastediff / (hasteamt * 1.4)) + (sthasteremain / (hasteamt * 1.5))
				end
			elseif newsthaste < hastefourtyperc and newsthaste >= hastethirtyperc then
				if (newsthaste + rawhaste) <= hastefourtyperc then
					psthaste = rawhaste / (hasteamt * 1.3)
				else
					sthastediff = hastefourtyperc - newsthaste
					sthasteremain = rawhaste - sthastediff
					psthaste = (sthastediff / (hasteamt * 1.3)) + (sthasteremain / (hasteamt * 1.4))
				end
			elseif newsthaste < hastethirtyperc and newsthaste >= hastetwentyperc then
				if (newsthaste + rawhaste) <= hastethirtyperc then
					psthaste = rawhaste / (hasteamt * 1.2)
				else
					sthastediff = hastethirtyperc - newsthaste
					sthasteremain = rawhaste - sthastediff
					psthaste = (sthastediff / (hasteamt * 1.2)) + (sthasteremain / (hasteamt * 1.3))
				end
			elseif newsthaste < hastetwentyperc and newsthaste >= hastetenperc then
				if (newsthaste + rawhaste) <= hastetwentyperc then
					psthaste = rawhaste / (hasteamt * 1.1)
				else
					sthastediff = hastetwentyperc - newsthaste
					sthasteremain = rawhaste - sthastediff
					psthaste = (sthastediff / (hasteamt * 1.1)) + (sthasteremain / (hasteamt * 1.2))
				end
			else
				if (newsthaste + rawhaste) < hastetenperc then
					psthaste = rawhaste / hasteamt
				else
					sthastediff = hastetenperc - newsthaste
					sthasteremain = rawhaste - sthastediff
					psthaste = (sthastediff / hasteamt) + (sthasteremain / (hasteamt * 1.1))
				end
			end
		elseif eqststats ~=nil then
			if oldhaste >= hastecap then
				psthaste = 0
			elseif oldhaste < hastecap and oldhaste >= hastefiftyperc then
				if (oldhaste + rawhaste) <= hastecap then
					psthaste = rawhaste / (hasteamt * 1.5)
				else 
					sthastediff = hastecap - oldhaste				
					psthaste = sthastediff / (hasteamt * 1.5)
				end
			elseif oldhaste < hastefiftyperc and oldhaste >= hastefourtyperc then
				if (oldhaste + rawhaste) <= hastefiftyperc then
					psthaste = rawhaste / (hasteamt * 1.4)
				else 
					sthastediff = hastefiftyperc - oldhaste
					sthasteremain = rawhaste - sthastediff
					psthaste = (sthastediff / (hasteamt * 1.4)) + (sthasteremain / (hasteamt * 1.5))
				end
			elseif oldhaste < hastefourtyperc and oldhaste >= hastethirtyperc then
				if (oldhaste + rawhaste) <= hastefourtyperc then
					psthaste = rawhaste / (hasteamt * 1.3)
				else
					sthastediff = hastefourtyperc - oldhaste
					sthasteremain = rawhaste - sthastediff
					psthaste = (sthastediff / (hasteamt * 1.3)) + (sthasteremain / (hasteamt * 1.4))
				end
			elseif oldhaste < hastethirtyperc and oldhaste >= hastetwentyperc then
				if (oldhaste + rawhaste) <= hastethirtyperc then
					psthaste = rawhaste / (hasteamt * 1.2)
				else
					sthastediff = hastethirtyperc - oldhaste
					sthasteremain = rawhaste - sthastediff
					psthaste = (sthastediff / (hasteamt * 1.2)) + (sthasteremain / (hasteamt * 1.3))
				end
			elseif oldhaste < hastetwentyperc and oldhaste >= hastetenperc then
				if (oldhaste + rawhaste) <= hastetwentyperc then
					psthaste = rawhaste / (hasteamt * 1.1)
				else
					sthastediff = hastetwentyperc - oldhaste
					sthasteremain = rawhaste - sthastediff
					psthaste = (sthastediff / (hasteamt * 1.1)) + (sthasteremain / (hasteamt * 1.2))
				end
			else
				if (oldhaste + rawhaste) < hastetenperc then
					psthaste = rawhaste / hasteamt
				else
					sthastediff = hastetenperc - oldhaste
					sthasteremain = rawhaste - sthastediff
					psthaste = (sthastediff / hasteamt) + (sthasteremain / (hasteamt * 1.1))
				end
			end
		end
	end  

    if rawvers ~= nil then		
		if newsovers ~= nil then
			if newsovers >= verscap then
				psoversin = 0
				psoversout = 0
			elseif newsovers < verscap and newsovers >= versfiftyperc then
				if (newsovers + rawvers) <= verscap then
					psoversin = rawvers / (versamt * 1.5)
					psoversout = psoversin / 2
				else 
					soversdiff = verscap - newsovers				
					psoversin = soversdiff / (versamt * 1.5)
					psoversout = psoversin / 2
				end
			elseif newsovers < versfiftyperc and newsovers >= versfourtyperc then
				if (newsovers + rawvers) <= versfiftyperc then
					psoversin = rawvers / (versamt * 1.4)
					psoversout = psoversin / 2
				else 
					soversdiff = versfiftyperc - newsovers
					soversremain = rawvers - soversdiff
					psoversin = (soversdiff / (versamt * 1.4)) + (soversremain / (versamt * 1.5))
					psoversout = psoversin / 2
				end
			elseif newsovers < versfourtyperc and newsovers >= versthirtyperc then
				if (newsovers + rawvers) <= versfourtyperc then
					psoversin = rawvers / (versamt * 1.3)
					psoversout = psoversin / 2
				else
					soversdiff = versfourtyperc - newsovers
					soversremain = rawvers - soversdiff
					psoversin = (soversdiff / (versamt * 1.3)) + (soversremain / (versamt * 1.4))
					psoversout = psoversin / 2
				end
			elseif newsovers < versthirtyperc and newsovers >= verstwentyperc then
				if (newsovers + rawvers) <= versthirtyperc then
					psoversin = rawvers / (versamt * 1.2)
					psoversout = psoversin / 2
				else
					soversdiff = versthirtyperc - newsovers
					soversremain = rawvers - soversdiff
					psoversin = (soversdiff / (versamt * 1.2)) + (soversremain / (versamt * 1.3))
					psoversout = psoversin / 2
				end
			elseif newsovers < verstwentyperc and newsovers >= verstenperc then
				if (newsovers + rawvers) <= verstwentyperc then
					psoversin = rawvers / (versamt * 1.1)
					psoversout = psoversin / 2
				else
					soversdiff = verstwentyperc - newsovers
					soversremain = rawvers - soversdiff
					psoversin = (soversdiff / (versamt * 1.1)) + (soversremain / (versamt * 1.2))
					psoversout = psoversin / 2
				end
			else
				if (newsovers + rawvers) < verstenperc then
					psoversin = rawvers / versamt
					psoversout = psoversin / 2
				else
					soversdiff = verstenperc - newsovers
					soversremain = rawvers - soversdiff
					psoversin = (soversdiff / versamt) + (soversremain / (versamt * 1.1))
					psoversout = psoversin / 2
				end
			end
		else
			if oldvers >= verscap then
				psoversin = 0
				psoversout = 0
			elseif oldvers < verscap and oldvers >= versfiftyperc then
				if (oldvers + rawvers) <= verscap then
					psoversin = rawvers / (versamt * 1.5)
					psoversout = psoversin / 2
				else 
					soversdiff = verscap - oldvers				
					psoversin = soversdiff / (versamt * 1.5)
					psoversout = psoversin / 2
				end
			elseif oldvers < versfiftyperc and oldvers >= versfourtyperc then
				if (oldvers + rawvers) <= versfiftyperc then
					psoversin = rawvers / (versamt * 1.4)
					psoversout = psoversin / 2
				else 
					soversdiff = versfiftyperc - oldvers
					soversremain = rawvers - soversdiff
					psoversin = (soversdiff / (versamt * 1.4)) + (soversremain / (versamt * 1.5))
					psoversout = psoversin / 2
				end
			elseif oldvers < versfourtyperc and oldvers >= versthirtyperc then
				if (oldvers + rawvers) <= versfourtyperc then
					psoversin = rawvers / (versamt * 1.3)
					psoversout = psoversin / 2
				else
					soversdiff = versfourtyperc - oldvers
					soversremain = rawvers - soversdiff
					psoversin = (soversdiff / (versamt * 1.3)) + (soversremain / (versamt * 1.4))
					psoversout = psoversin / 2
				end
			elseif oldvers < versthirtyperc and oldvers >= verstwentyperc then
				if (oldvers + rawvers) <= versthirtyperc then
					psoversin = rawvers / (versamt * 1.2)
					psoversout = psoversin / 2
				else
					soversdiff = versthirtyperc - oldvers
					soversremain = rawvers - soversdiff
					psoversin = (soversdiff / (versamt * 1.2)) + (soversremain / (versamt * 1.3))
					psoversout = psoversin / 2
				end
			elseif oldvers < verstwentyperc and oldvers >= verstenperc then
				if (oldvers + rawvers) <= verstwentyperc then
					psoversin = rawvers / (versamt * 1.1)
					psoversout = psoversin / 2
				else
					soversdiff = verstwentyperc - oldvers
					soversremain = rawvers - soversdiff
					psoversin = (soversdiff / (versamt * 1.1)) + (soversremain / (versamt * 1.2))
					psoversout = psoversin / 2
				end
			else
				if (oldvers + rawvers) < verstenperc then
					psoversin = rawvers / versamt
					psoversout = psoversin / 2
				else
					soversdiff = verstenperc - oldvers
					soversremain = rawvers - soversdiff
					psoversin = (soversdiff / versamt) + (soversremain / (versamt * 1.1))
					psoversout = psoversin / 2
				end
			end
		end
	
		if eqststats ~= nil and newstvers ~= nil then
			if newstvers >= verscap then
				pstversin = 0
				pstversout = 0
			elseif newstvers < verscap and newstvers >= versfiftyperc then
				if (newstvers + rawvers) <= verscap then
					pstversin = rawvers / (versamt * 1.5)
					pstversout = pstversin / 2
				else 
					stversdiff = verscap - newstvers				
					pstversin = stversdiff / (versamt * 1.5)
					pstversout = pstversin / 2
				end
			elseif newstvers < versfiftyperc and newstvers >= versfourtyperc then
				if (newstvers + rawvers) <= versfiftyperc then
					pstversin = rawvers / (versamt * 1.4)
					pstversout = pstversin / 2
				else 
					stversdiff = versfiftyperc - newstvers
					stversremain = rawvers - stversdiff
					pstversin = (stversdiff / (versamt * 1.4)) + (stversremain / (versamt * 1.5))
					pstversout = pstversin / 2
				end
			elseif newstvers < versfourtyperc and newstvers >= versthirtyperc then
				if (newstvers + rawvers) <= versfourtyperc then
					pstversin = rawvers / (versamt * 1.3)
					pstversout = pstversin / 2
				else
					stversdiff = versfourtyperc - newstvers
					stversremain = rawvers - stversdiff
					pstversin = (stversdiff / (versamt * 1.3)) + (stversremain / (versamt * 1.4))
					pstversout = pstversin / 2
				end
			elseif newstvers < versthirtyperc and newstvers >= verstwentyperc then
				if (newstvers + rawvers) <= versthirtyperc then
					pstversin = rawvers / (versamt * 1.2)
					pstversout = pstversin / 2
				else
					stversdiff = versthirtyperc - newstvers
					stversremain = rawvers - stversdiff
					pstversin = (stversdiff / (versamt * 1.2)) + (stversremain / (versamt * 1.3))
					pstversout = pstversin / 2
				end
			elseif newstvers < verstwentyperc and newstvers >= verstenperc then
				if (newstvers + rawvers) <= verstwentyperc then
					pstversin = rawvers / (versamt * 1.1)
					pstversout = pstversin / 2
				else
					stversdiff = verstwentyperc - newstvers
					stversremain = rawvers - stversdiff
					pstversin = (stversdiff / (versamt * 1.1)) + (stversremain / (versamt * 1.2))
					pstversout = pstversin / 2
				end
			else
				if (newstvers + rawvers) < verstenperc then
					pstversin = rawvers / versamt
					pstversout = pstversin / 2
				else
					stversdiff = verstenperc - newstvers
					stversremain = rawvers - stversdiff
					pstversin = (stversdiff / versamt) + (stversremain / (versamt * 1.1))
					pstversout = pstversin / 2
				end
			end
		elseif eqststats ~=nil then
			if oldvers >= verscap then
				pstversin = 0
				pstversout = 0
			elseif oldvers < verscap and oldvers >= versfiftyperc then
				if (oldvers + rawvers) <= verscap then
					pstversin = rawvers / (versamt * 1.5)
					pstversout = pstversin / 2
				else 
					stversdiff = verscap - oldvers				
					pstversin = stversdiff / (versamt * 1.5)
					pstversout = pstversin / 2
				end
			elseif oldvers < versfiftyperc and oldvers >= versfourtyperc then
				if (oldvers + rawvers) <= versfiftyperc then
					pstversin = rawvers / (versamt * 1.4)
					pstversout = pstversin / 2
				else 
					stversdiff = versfiftyperc - oldvers
					stversremain = rawvers - stversdiff
					pstversin = (stversdiff / (versamt * 1.4)) + (stversremain / (versamt * 1.5))
					pstversout = pstversin / 2
				end
			elseif oldvers < versfourtyperc and oldvers >= versthirtyperc then
				if (oldvers + rawvers) <= versfourtyperc then
					pstversin = rawvers / (versamt * 1.3)
					pstversout = pstversin / 2
				else
					stversdiff = versfourtyperc - oldvers
					stversremain = rawvers - stversdiff
					pstversin = (stversdiff / (versamt * 1.3)) + (stversremain / (versamt * 1.4))
					pstversout = pstversin / 2
				end
			elseif oldvers < versthirtyperc and oldvers >= verstwentyperc then
				if (oldvers + rawvers) <= versthirtyperc then
					pstversin = rawvers / (versamt * 1.2)
					pstversout = pstversin / 2
				else
					stversdiff = versthirtyperc - oldvers
					stversremain = rawvers - stversdiff
					pstversin = (stversdiff / (versamt * 1.2)) + (stversremain / (versamt * 1.3))
					pstversout = pstversin / 2
				end
			elseif oldvers < verstwentyperc and oldvers >= verstenperc then
				if (oldvers + rawvers) <= verstwentyperc then
					pstversin = rawvers / (versamt * 1.1)
					pstversout = pstversin / 2
				else
					stversdiff = verstwentyperc - oldvers
					stversremain = rawvers - stversdiff
					pstversin = (stversdiff / (versamt * 1.1)) + (stversremain / (versamt * 1.2))
					pstversout = pstversin / 2
				end
			else
				if (oldvers + rawvers) < verstenperc then
					pstversin = rawvers / versamt
					pstversout = pstversin / 2
				else
					stversdiff = verstenperc - oldvers
					stversremain = rawvers - stversdiff
					pstversin = (stversdiff / versamt) + (stversremain / (versamt * 1.1))
					pstversout = pstversin / 2
				end
			end
		end
    end

    if rawmastery ~= nil then        
		if newsomastery ~= nil then
			if newsomastery >= masterycap then
				psomastery = 0
			elseif newsomastery < masterycap and newsomastery >= masteryfiftyperc then
				if (newsomastery + rawmastery) <= masterycap then
					psomastery = (rawmastery / (masteryamt * 1.5)) * masterycf
				else 
					somasterydiff = masterycap - newsomastery				
					psomastery = (somasterydiff / (masteryamt * 1.5)) * masterycf
				end
			elseif newsomastery < masteryfiftyperc and newsomastery >= masteryfourtyperc then
				if (newsomastery + rawmastery) <= masteryfiftyperc then
					psomastery = (rawmastery / (masteryamt * 1.4)) * masterycf
				else 
					somasterydiff = masteryfiftyperc - newsomastery
					somasteryremain = rawmastery - somasterydiff
					psomastery = ((somasterydiff / (masteryamt * 1.4)) + (somasteryremain / (masteryamt * 1.5))) * masterycf
				end
			elseif newsomastery < masteryfourtyperc and newsomastery >= masterythirtyperc then
				if (newsomastery + rawmastery) <= masteryfourtyperc then
					psomastery = (rawmastery / (masteryamt * 1.3)) * masterycf
				else
					somasterydiff = masteryfourtyperc - newsomastery
					somasteryremain = rawmastery - somasterydiff
					psomastery = ((somasterydiff / (masteryamt * 1.3)) + (somasteryremain / (masteryamt * 1.4))) * masterycf
				end
			elseif newsomastery < masterythirtyperc and newsomastery >= masterytwentyperc then
				if (newsomastery + rawmastery) <= masterythirtyperc then
					psomastery = (rawmastery / (masteryamt * 1.2)) * masterycf
				else
					somasterydiff = masterythirtyperc - newsomastery
					somasteryremain = rawmastery - somasterydiff
					psomastery = ((somasterydiff / (masteryamt * 1.2)) + (somasteryremain / (masteryamt * 1.3))) * masterycf
				end
			elseif newsomastery < masterytwentyperc and newsomastery >= masterytenperc then
				if (newsomastery + rawmastery) <= masterytwentyperc then
					psomastery = (rawmastery / (masteryamt * 1.1)) * masterycf
				else
					somasterydiff = masterytwentyperc - newsomastery
					somasteryremain = rawmastery - somasterydiff
					psomastery = ((somasterydiff / (masteryamt * 1.1)) + (somasteryremain / (masteryamt * 1.2))) * masterycf
				end
			else
				if (newsomastery + rawmastery) < masterytenperc then
					psomastery = (rawmastery / masteryamt) * masterycf
				else
					somasterydiff = masterytenperc - newsomastery
					somasteryremain = rawmastery - somasterydiff
					psomastery = ((somasterydiff / masteryamt) + (somasteryremain / (masteryamt * 1.1))) * masterycf
				end
			end
		else
			if oldmastery >= masterycap then
				psomastery = 0
			elseif oldmastery < masterycap and oldmastery >= masteryfiftyperc then
				if (oldmastery + rawmastery) <= masterycap then
					psomastery = (rawmastery / (masteryamt * 1.5)) * masterycf
				else 
					somasterydiff = masterycap - oldmastery				
					psomastery = (somasterydiff / (masteryamt * 1.5)) * masterycf
				end
			elseif oldmastery < masteryfiftyperc and oldmastery >= masteryfourtyperc then
				if (oldmastery + rawmastery) <= masteryfiftyperc then
					psomastery = (rawmastery / (masteryamt * 1.4)) * masterycf
				else 
					somasterydiff = masteryfiftyperc - oldmastery
					somasteryremain = rawmastery - somasterydiff
					psomastery = ((somasterydiff / (masteryamt * 1.4)) + (somasteryremain / (masteryamt * 1.5))) * masterycf
				end
			elseif oldmastery < masteryfourtyperc and oldmastery >= masterythirtyperc then
				if (oldmastery + rawmastery) <= masteryfourtyperc then
					psomastery = (rawmastery / (masteryamt * 1.3)) * masterycf
				else
					somasterydiff = masteryfourtyperc - oldmastery
					somasteryremain = rawmastery - somasterydiff
					psomastery = ((somasterydiff / (masteryamt * 1.3)) + (somasteryremain / (masteryamt * 1.4))) * masterycf
				end
			elseif oldmastery < masterythirtyperc and oldmastery >= masterytwentyperc then
				if (oldmastery + rawmastery) <= masterythirtyperc then
					psomastery = (rawmastery / (masteryamt * 1.2)) * masterycf
				else
					somasterydiff = masterythirtyperc - oldmastery
					somasteryremain = rawmastery - somasterydiff
					psomastery = ((somasterydiff / (masteryamt * 1.2)) + (somasteryremain / (masteryamt * 1.3))) * masterycf
				end
			elseif oldmastery < masterytwentyperc and oldmastery >= masterytenperc then
				if (oldmastery + rawmastery) <= masterytwentyperc then
					psomastery = (rawmastery / (masteryamt * 1.1)) * masterycf
				else
					somasterydiff = masterytwentyperc - oldmastery
					somasteryremain = rawmastery - somasterydiff
					psomastery = ((somasterydiff / (masteryamt * 1.1)) + (somasteryremain / (masteryamt * 1.2))) * masterycf
				end
			else
				if (oldmastery + rawmastery) < masterytenperc then
					psomastery = (rawmastery / masteryamt) * masterycf
				else
					somasterydiff = masterytenperc - oldmastery
					somasteryremain = rawmastery - somasterydiff
					psomastery = ((somasterydiff / masteryamt) + (somasteryremain / (masteryamt * 1.1))) * masterycf
				end
			end
		end
	
		if eqststats ~= nil and newstmastery ~= nil then
			if newstmastery >= masterycap then
				pstmastery = 0
			elseif newstmastery < masterycap and newstmastery >= masteryfiftyperc then
				if (newstmastery + rawmastery) <= masterycap then
					pstmastery = (rawmastery / (masteryamt * 1.5)) * masterycf
				else 
					stmasterydiff = masterycap - newstmastery				
					pstmastery = (stmasterydiff / (masteryamt * 1.5)) * masterycf
				end
			elseif newstmastery < masteryfiftyperc and newstmastery >= masteryfourtyperc then
				if (newstmastery + rawmastery) <= masteryfiftyperc then
					pstmastery = (rawmastery / (masteryamt * 1.4)) * masterycf
				else 
					stmasterydiff = masteryfiftyperc - newstmastery
					stmasteryremain = rawmastery - stmasterydiff
					pstmastery = ((stmasterydiff / (masteryamt * 1.4)) + (stmasteryremain / (masteryamt * 1.5))) * masterycf
				end
			elseif newstmastery < masteryfourtyperc and newstmastery >= masterythirtyperc then
				if (newstmastery + rawmastery) <= masteryfourtyperc then
					pstmastery = (rawmastery / (masteryamt * 1.3)) * masterycf
				else
					stmasterydiff = masteryfourtyperc - newstmastery
					stmasteryremain = rawmastery - stmasterydiff
					pstmastery = ((stmasterydiff / (masteryamt * 1.3)) + (stmasteryremain / (masteryamt * 1.4))) * masterycf
				end
			elseif newstmastery < masterythirtyperc and newstmastery >= masterytwentyperc then
				if (newstmastery + rawmastery) <= masterythirtyperc then
					pstmastery = (rawmastery / (masteryamt * 1.2)) * masterycf
				else
					stmasterydiff = masterythirtyperc - newstmastery
					stmasteryremain = rawmastery - stmasterydiff
					pstmastery = ((stmasterydiff / (masteryamt * 1.2)) + (stmasteryremain / (masteryamt * 1.3))) * masterycf
				end
			elseif newstmastery < masterytwentyperc and newstmastery >= masterytenperc then
				if (newstmastery + rawmastery) <= masterytwentyperc then
					pstmastery = (rawmastery / (masteryamt * 1.1)) * masterycf
				else
					stmasterydiff = masterytwentyperc - newstmastery
					stmasteryremain = rawmastery - stmasterydiff
					pstmastery = ((stmasterydiff / (masteryamt * 1.1)) + (stmasteryremain / (masteryamt * 1.2))) * masterycf
				end
			else
				if (newstmastery + rawmastery) < masterytenperc then
					pstmastery = (rawmastery / masteryamt) * masterycf
				else
					stmasterydiff = masterytenperc - newstmastery
					stmasteryremain = rawmastery - stmasterydiff
					pstmastery = ((stmasterydiff / masteryamt) + (stmasteryremain / (masteryamt * 1.1))) * masterycf
				end
			end
		elseif eqststats ~=nil then
			if oldmastery >= masterycap then
				pstmastery = 0
			elseif oldmastery < masterycap and oldmastery >= masteryfiftyperc then
				if (oldmastery + rawmastery) <= masterycap then
					pstmastery = (rawmastery / (masteryamt * 1.5)) * masterycf
				else 
					stmasterydiff = masterycap - oldmastery				
					pstmastery = (stmasterydiff / (masteryamt * 1.5)) * masterycf
				end
			elseif oldmastery < masteryfiftyperc and oldmastery >= masteryfourtyperc then
				if (oldmastery + rawmastery) <= masteryfiftyperc then
					pstmastery = (rawmastery / (masteryamt * 1.4)) * masterycf
				else 
					stmasterydiff = masteryfiftyperc - oldmastery
					stmasteryremain = rawmastery - stmasterydiff
					pstmastery = ((stmasterydiff / (masteryamt * 1.4)) + (stmasteryremain / (masteryamt * 1.5))) * masterycf
				end
			elseif oldmastery < masteryfourtyperc and oldmastery >= masterythirtyperc then
				if (oldmastery + rawmastery) <= masteryfourtyperc then
					pstmastery = (rawmastery / (masteryamt * 1.3)) * masterycf
				else
					stmasterydiff = masteryfourtyperc - oldmastery
					stmasteryremain = rawmastery - stmasterydiff
					pstmastery = ((stmasterydiff / (masteryamt * 1.3)) + (stmasteryremain / (masteryamt * 1.4))) * masterycf
				end
			elseif oldmastery < masterythirtyperc and oldmastery >= masterytwentyperc then
				if (oldmastery + rawmastery) <= masterythirtyperc then
					pstmastery = (rawmastery / (masteryamt * 1.2)) * masterycf
				else
					stmasterydiff = masterythirtyperc - oldmastery
					stmasteryremain = rawmastery - stmasterydiff
					pstmastery = ((stmasterydiff / (masteryamt * 1.2)) + (stmasteryremain / (masteryamt * 1.3))) * masterycf
				end
			elseif oldmastery < masterytwentyperc and oldmastery >= masterytenperc then
				if (oldmastery + rawmastery) <= masterytwentyperc then
					pstmastery = (rawmastery / (masteryamt * 1.1)) * masterycf
				else
					stmasterydiff = masterytwentyperc - oldmastery
					stmasteryremain = rawmastery - stmasterydiff
					pstmastery = ((stmasterydiff / (masteryamt * 1.1)) + (stmasteryremain / (masteryamt * 1.2))) * masterycf
				end
			else
				if (oldmastery + rawmastery) < masterytenperc then
					pstmastery = (rawmastery / masteryamt) * masterycf
				else
					stmasterydiff = masterytenperc - oldmastery
					stmasteryremain = rawmastery - stmasterydiff
					pstmastery = ((stmasterydiff / masteryamt) + (stmasteryremain / (masteryamt * 1.1))) * masterycf
				end
			end
		end
    end
	
	if rawavoid ~= nil then		
		if newsoavoid ~= nil then
			if newsoavoid >= avoidcap then
				psoavoid = 0
			elseif newsoavoid < avoidcap and newsoavoid >= avoidfiftyperc then
				if (newsoavoid + rawavoid) <= avoidcap then
					psoavoid = rawavoid / (avoidamt * 1.5)
				else 
					soavoiddiff = avoidcap - newsoavoid				
					psoavoid = soavoiddiff / (avoidamt * 1.5)
				end
			elseif newsoavoid < avoidfiftyperc and newsoavoid >= avoidfourtyperc then
				if (newsoavoid + rawavoid) <= avoidfiftyperc then
					psoavoid = rawavoid / (avoidamt * 1.4)
				else 
					soavoiddiff = avoidfiftyperc - newsoavoid
					soavoidremain = rawavoid - soavoiddiff
					psoavoid = (soavoiddiff / (avoidamt * 1.4)) + (soavoidremain / (avoidamt * 1.5))
				end
			elseif newsoavoid < avoidfourtyperc and newsoavoid >= avoidthirtyperc then
				if (newsoavoid + rawavoid) <= avoidfourtyperc then
					psoavoid = rawavoid / (avoidamt * 1.3)
				else
					soavoiddiff = avoidfourtyperc - newsoavoid
					soavoidremain = rawavoid - soavoiddiff
					psoavoid = (soavoiddiff / (avoidamt * 1.3)) + (soavoidremain / (avoidamt * 1.4))
				end
			elseif newsoavoid < avoidthirtyperc and newsoavoid >= avoidtwentyperc then
				if (newsoavoid + rawavoid) <= avoidthirtyperc then
					psoavoid = rawavoid / (avoidamt * 1.2)
				else
					soavoiddiff = avoidthirtyperc - newsoavoid
					soavoidremain = rawavoid - soavoiddiff
					psoavoid = (soavoiddiff / (avoidamt * 1.2)) + (soavoidremain / (avoidamt * 1.3))
				end
			elseif newsoavoid < avoidtwentyperc and newsoavoid >= avoidtenperc then
				if (newsoavoid + rawavoid) <= avoidtwentyperc then
					psoavoid = rawavoid / (avoidamt * 1.1)
				else
					soavoiddiff = avoidtwentyperc - newsoavoid
					soavoidremain = rawavoid - soavoiddiff
					psoavoid = (soavoiddiff / (avoidamt * 1.1)) + (soavoidremain / (avoidamt * 1.2))
				end
			else
				if (newsoavoid + rawavoid) < avoidtenperc then
					psoavoid = rawavoid / avoidamt
				else
					soavoiddiff = avoidtenperc - newsoavoid
					soavoidremain = rawavoid - soavoiddiff
					psoavoid = (soavoiddiff / avoidamt) + (soavoidremain / (avoidamt * 1.1))
				end
			end
		else
			if oldavoid >= avoidcap then
				psoavoid = 0
			elseif oldavoid < avoidcap and oldavoid >= avoidfiftyperc then
				if (oldavoid + rawavoid) <= avoidcap then
					psoavoid = rawavoid / (avoidamt * 1.5)
				else 
					soavoiddiff = avoidcap - oldavoid				
					psoavoid = soavoiddiff / (avoidamt * 1.5)
				end
			elseif oldavoid < avoidfiftyperc and oldavoid >= avoidfourtyperc then
				if (oldavoid + rawavoid) <= avoidfiftyperc then
					psoavoid = rawavoid / (avoidamt * 1.4)
				else 
					soavoiddiff = avoidfiftyperc - oldavoid
					soavoidremain = rawavoid - soavoiddiff
					psoavoid = (soavoiddiff / (avoidamt * 1.4)) + (soavoidremain / (avoidamt * 1.5))
				end
			elseif oldavoid < avoidfourtyperc and oldavoid >= avoidthirtyperc then
				if (oldavoid + rawavoid) <= avoidfourtyperc then
					psoavoid = rawavoid / (avoidamt * 1.3)
				else
					soavoiddiff = avoidfourtyperc - oldavoid
					soavoidremain = rawavoid - soavoiddiff
					psoavoid = (soavoiddiff / (avoidamt * 1.3)) + (soavoidremain / (avoidamt * 1.4))
				end
			elseif oldavoid < avoidthirtyperc and oldavoid >= avoidtwentyperc then
				if (oldavoid + rawavoid) <= avoidthirtyperc then
					psoavoid = rawavoid / (avoidamt * 1.2)
				else
					soavoiddiff = avoidthirtyperc - oldavoid
					soavoidremain = rawavoid - soavoiddiff
					psoavoid = (soavoiddiff / (avoidamt * 1.2)) + (soavoidremain / (avoidamt * 1.3))
				end
			elseif oldavoid < avoidtwentyperc and oldavoid >= avoidtenperc then
				if (oldavoid + rawavoid) <= avoidtwentyperc then
					psoavoid = rawavoid / (avoidamt * 1.1)
				else
					soavoiddiff = avoidtwentyperc - oldavoid
					soavoidremain = rawavoid - soavoiddiff
					psoavoid = (soavoiddiff / (avoidamt * 1.1)) + (soavoidremain / (avoidamt * 1.2))
				end
			else
				if (oldavoid + rawavoid) < avoidtenperc then
					psoavoid = rawavoid / avoidamt
				else
					soavoiddiff = avoidtenperc - oldavoid
					soavoidremain = rawavoid - soavoiddiff
					psoavoid = (soavoiddiff / avoidamt) + (soavoidremain / (avoidamt * 1.1))
				end
			end
		end
	
		if eqststats ~= nil and newstavoid ~= nil then
			if newstavoid >= avoidcap then
				pstavoid = 0
			elseif newstavoid < avoidcap and newstavoid >= avoidfiftyperc then
				if (newstavoid + rawavoid) <= avoidcap then
					pstavoid = rawavoid / (avoidamt * 1.5)
				else 
					stavoiddiff = avoidcap - newstavoid				
					pstavoid = stavoiddiff / (avoidamt * 1.5)
				end
			elseif newstavoid < avoidfiftyperc and newstavoid >= avoidfourtyperc then
				if (newstavoid + rawavoid) <= avoidfiftyperc then
					pstavoid = rawavoid / (avoidamt * 1.4)
				else 
					stavoiddiff = avoidfiftyperc - newstavoid
					stavoidremain = rawavoid - stavoiddiff
					pstavoid = (stavoiddiff / (avoidamt * 1.4)) + (stavoidremain / (avoidamt * 1.5))
				end
			elseif newstavoid < avoidfourtyperc and newstavoid >= avoidthirtyperc then
				if (newstavoid + rawavoid) <= avoidfourtyperc then
					pstavoid = rawavoid / (avoidamt * 1.3)
				else
					stavoiddiff = avoidfourtyperc - newstavoid
					stavoidremain = rawavoid - stavoiddiff
					pstavoid = (stavoiddiff / (avoidamt * 1.3)) + (stavoidremain / (avoidamt * 1.4))
				end
			elseif newstavoid < avoidthirtyperc and newstavoid >= avoidtwentyperc then
				if (newstavoid + rawavoid) <= avoidthirtyperc then
					pstavoid = rawavoid / (avoidamt * 1.2)
				else
					stavoiddiff = avoidthirtyperc - newstavoid
					stavoidremain = rawavoid - stavoiddiff
					pstavoid = (stavoiddiff / (avoidamt * 1.2)) + (stavoidremain / (avoidamt * 1.3))
				end
			elseif newstavoid < avoidtwentyperc and newstavoid >= avoidtenperc then
				if (newstavoid + rawavoid) <= avoidtwentyperc then
					pstavoid = rawavoid / (avoidamt * 1.1)
				else
					stavoiddiff = avoidtwentyperc - newstavoid
					stavoidremain = rawavoid - stavoiddiff
					pstavoid = (stavoiddiff / (avoidamt * 1.1)) + (stavoidremain / (avoidamt * 1.2))
				end
			else
				if (newstavoid + rawavoid) < avoidtenperc then
					pstavoid = rawavoid / avoidamt
				else
					stavoiddiff = avoidtenperc - newstavoid
					stavoidremain = rawavoid - stavoiddiff
					pstavoid = (stavoiddiff / avoidamt) + (stavoidremain / (avoidamt * 1.1))
				end
			end
		elseif eqststats ~=nil then
			if oldavoid >= avoidcap then
				pstavoid = 0
			elseif oldavoid < avoidcap and oldavoid >= avoidfiftyperc then
				if (oldavoid + rawavoid) <= avoidcap then
					pstavoid = rawavoid / (avoidamt * 1.5)
				else 
					stavoiddiff = avoidcap - oldavoid				
					pstavoid = stavoiddiff / (avoidamt * 1.5)
				end
			elseif oldavoid < avoidfiftyperc and oldavoid >= avoidfourtyperc then
				if (oldavoid + rawavoid) <= avoidfiftyperc then
					pstavoid = rawavoid / (avoidamt * 1.4)
				else 
					stavoiddiff = avoidfiftyperc - oldavoid
					stavoidremain = rawavoid - stavoiddiff
					pstavoid = (stavoiddiff / (avoidamt * 1.4)) + (stavoidremain / (avoidamt * 1.5))
				end
			elseif oldavoid < avoidfourtyperc and oldavoid >= avoidthirtyperc then
				if (oldavoid + rawavoid) <= avoidfourtyperc then
					pstavoid = rawavoid / (avoidamt * 1.3)
				else
					stavoiddiff = avoidfourtyperc - oldavoid
					stavoidremain = rawavoid - stavoiddiff
					pstavoid = (stavoiddiff / (avoidamt * 1.3)) + (stavoidremain / (avoidamt * 1.4))
				end
			elseif oldavoid < avoidthirtyperc and oldavoid >= avoidtwentyperc then
				if (oldavoid + rawavoid) <= avoidthirtyperc then
					pstavoid = rawavoid / (avoidamt * 1.2)
				else
					stavoiddiff = avoidthirtyperc - oldavoid
					stavoidremain = rawavoid - stavoiddiff
					pstavoid = (stavoiddiff / (avoidamt * 1.2)) + (stavoidremain / (avoidamt * 1.3))
				end
			elseif oldavoid < avoidtwentyperc and oldavoid >= avoidtenperc then
				if (oldavoid + rawavoid) <= avoidtwentyperc then
					pstavoid = rawavoid / (avoidamt * 1.1)
				else
					stavoiddiff = avoidtwentyperc - oldavoid
					stavoidremain = rawavoid - stavoiddiff
					pstavoid = (stavoiddiff / (avoidamt * 1.1)) + (stavoidremain / (avoidamt * 1.2))
				end
			else
				if (oldavoid + rawavoid) < avoidtenperc then
					pstavoid = rawavoid / avoidamt
				else
					stavoiddiff = avoidtenperc - oldavoid
					stavoidremain = rawavoid - stavoiddiff
					pstavoid = (stavoiddiff / avoidamt) + (stavoidremain / (avoidamt * 1.1))
				end
			end
		end
	end
	
	if rawspeed ~= nil then		
		if newsospeed ~= nil then
			if newsospeed >= speedcap then
				psospeed = 0
			elseif newsospeed < speedcap and newsospeed >= speedfiftyperc then
				if (newsospeed + rawspeed) <= speedcap then
					psospeed = rawspeed / (speedamt * 1.5)
				else 
					sospeeddiff = speedcap - newsospeed				
					psospeed = sospeeddiff / (speedamt * 1.5)
				end
			elseif newsospeed < speedfiftyperc and newsospeed >= speedfourtyperc then
				if (newsospeed + rawspeed) <= speedfiftyperc then
					psospeed = rawspeed / (speedamt * 1.4)
				else 
					sospeeddiff = speedfiftyperc - newsospeed
					sospeedremain = rawspeed - sospeeddiff
					psospeed = (sospeeddiff / (speedamt * 1.4)) + (sospeedremain / (speedamt * 1.5))
				end
			elseif newsospeed < speedfourtyperc and newsospeed >= speedthirtyperc then
				if (newsospeed + rawspeed) <= speedfourtyperc then
					psospeed = rawspeed / (speedamt * 1.3)
				else
					sospeeddiff = speedfourtyperc - newsospeed
					sospeedremain = rawspeed - sospeeddiff
					psospeed = (sospeeddiff / (speedamt * 1.3)) + (sospeedremain / (speedamt * 1.4))
				end
			elseif newsospeed < speedthirtyperc and newsospeed >= speedtwentyperc then
				if (newsospeed + rawspeed) <= speedthirtyperc then
					psospeed = rawspeed / (speedamt * 1.2)
				else
					sospeeddiff = speedthirtyperc - newsospeed
					sospeedremain = rawspeed - sospeeddiff
					psospeed = (sospeeddiff / (speedamt * 1.2)) + (sospeedremain / (speedamt * 1.3))
				end
			elseif newsospeed < speedtwentyperc and newsospeed >= speedtenperc then
				if (newsospeed + rawspeed) <= speedtwentyperc then
					psospeed = rawspeed / (speedamt * 1.1)
				else
					sospeeddiff = speedtwentyperc - newsospeed
					sospeedremain = rawspeed - sospeeddiff
					psospeed = (sospeeddiff / (speedamt * 1.1)) + (sospeedremain / (speedamt * 1.2))
				end
			else
				if (newsospeed + rawspeed) < speedtenperc then
					psospeed = rawspeed / speedamt
				else
					sospeeddiff = speedtenperc - newsospeed
					sospeedremain = rawspeed - sospeeddiff
					psospeed = (sospeeddiff / speedamt) + (sospeedremain / (speedamt * 1.1))
				end
			end
		else
			if oldspeed >= speedcap then
				psospeed = 0
			elseif oldspeed < speedcap and oldspeed >= speedfiftyperc then
				if (oldspeed + rawspeed) <= speedcap then
					psospeed = rawspeed / (speedamt * 1.5)
				else 
					sospeeddiff = speedcap - oldspeed				
					psospeed = sospeeddiff / (speedamt * 1.5)
				end
			elseif oldspeed < speedfiftyperc and oldspeed >= speedfourtyperc then
				if (oldspeed + rawspeed) <= speedfiftyperc then
					psospeed = rawspeed / (speedamt * 1.4)
				else 
					sospeeddiff = speedfiftyperc - oldspeed
					sospeedremain = rawspeed - sospeeddiff
					psospeed = (sospeeddiff / (speedamt * 1.4)) + (sospeedremain / (speedamt * 1.5))
				end
			elseif oldspeed < speedfourtyperc and oldspeed >= speedthirtyperc then
				if (oldspeed + rawspeed) <= speedfourtyperc then
					psospeed = rawspeed / (speedamt * 1.3)
				else
					sospeeddiff = speedfourtyperc - oldspeed
					sospeedremain = rawspeed - sospeeddiff
					psospeed = (sospeeddiff / (speedamt * 1.3)) + (sospeedremain / (speedamt * 1.4))
				end
			elseif oldspeed < speedthirtyperc and oldspeed >= speedtwentyperc then
				if (oldspeed + rawspeed) <= speedthirtyperc then
					psospeed = rawspeed / (speedamt * 1.2)
				else
					sospeeddiff = speedthirtyperc - oldspeed
					sospeedremain = rawspeed - sospeeddiff
					psospeed = (sospeeddiff / (speedamt * 1.2)) + (sospeedremain / (speedamt * 1.3))
				end
			elseif oldspeed < speedtwentyperc and oldspeed >= speedtenperc then
				if (oldspeed + rawspeed) <= speedtwentyperc then
					psospeed = rawspeed / (speedamt * 1.1)
				else
					sospeeddiff = speedtwentyperc - oldspeed
					sospeedremain = rawspeed - sospeeddiff
					psospeed = (sospeeddiff / (speedamt * 1.1)) + (sospeedremain / (speedamt * 1.2))
				end
			else
				if (oldspeed + rawspeed) < speedtenperc then
					psospeed = rawspeed / speedamt
				else
					sospeeddiff = speedtenperc - oldspeed
					sospeedremain = rawspeed - sospeeddiff
					psospeed = (sospeeddiff / speedamt) + (sospeedremain / (speedamt * 1.1))
				end
			end
		end
	
		if eqststats ~= nil and newstspeed ~= nil then
			if newstspeed >= speedcap then
				pstspeed = 0
			elseif newstspeed < speedcap and newstspeed >= speedfiftyperc then
				if (newstspeed + rawspeed) <= speedcap then
					pstspeed = rawspeed / (speedamt * 1.5)
				else 
					stspeeddiff = speedcap - newstspeed				
					pstspeed = stspeeddiff / (speedamt * 1.5)
				end
			elseif newstspeed < speedfiftyperc and newstspeed >= speedfourtyperc then
				if (newstspeed + rawspeed) <= speedfiftyperc then
					pstspeed = rawspeed / (speedamt * 1.4)
				else 
					stspeeddiff = speedfiftyperc - newstspeed
					stspeedremain = rawspeed - stspeeddiff
					pstspeed = (stspeeddiff / (speedamt * 1.4)) + (stspeedremain / (speedamt * 1.5))
				end
			elseif newstspeed < speedfourtyperc and newstspeed >= speedthirtyperc then
				if (newstspeed + rawspeed) <= speedfourtyperc then
					pstspeed = rawspeed / (speedamt * 1.3)
				else
					stspeeddiff = speedfourtyperc - newstspeed
					stspeedremain = rawspeed - stspeeddiff
					pstspeed = (stspeeddiff / (speedamt * 1.3)) + (stspeedremain / (speedamt * 1.4))
				end
			elseif newstspeed < speedthirtyperc and newstspeed >= speedtwentyperc then
				if (newstspeed + rawspeed) <= speedthirtyperc then
					pstspeed = rawspeed / (speedamt * 1.2)
				else
					stspeeddiff = speedthirtyperc - newstspeed
					stspeedremain = rawspeed - stspeeddiff
					pstspeed = (stspeeddiff / (speedamt * 1.2)) + (stspeedremain / (speedamt * 1.3))
				end
			elseif newstspeed < speedtwentyperc and newstspeed >= speedtenperc then
				if (newstspeed + rawspeed) <= speedtwentyperc then
					pstspeed = rawspeed / (speedamt * 1.1)
				else
					stspeeddiff = speedtwentyperc - newstspeed
					stspeedremain = rawspeed - stspeeddiff
					pstspeed = (stspeeddiff / (speedamt * 1.1)) + (stspeedremain / (speedamt * 1.2))
				end
			else
				if (newstspeed + rawspeed) < speedtenperc then
					pstspeed = rawspeed / speedamt
				else
					stspeeddiff = speedtenperc - newstspeed
					stspeedremain = rawspeed - stspeeddiff
					pstspeed = (stspeeddiff / speedamt) + (stspeedremain / (speedamt * 1.1))
				end
			end
		elseif eqststats ~=nil then
			if oldspeed >= speedcap then
				pstspeed = 0
			elseif oldspeed < speedcap and oldspeed >= speedfiftyperc then
				if (oldspeed + rawspeed) <= speedcap then
					pstspeed = rawspeed / (speedamt * 1.5)
				else 
					stspeeddiff = speedcap - oldspeed				
					pstspeed = stspeeddiff / (speedamt * 1.5)
				end
			elseif oldspeed < speedfiftyperc and oldspeed >= speedfourtyperc then
				if (oldspeed + rawspeed) <= speedfiftyperc then
					pstspeed = rawspeed / (speedamt * 1.4)
				else 
					stspeeddiff = speedfiftyperc - oldspeed
					stspeedremain = rawspeed - stspeeddiff
					pstspeed = (stspeeddiff / (speedamt * 1.4)) + (stspeedremain / (speedamt * 1.5))
				end
			elseif oldspeed < speedfourtyperc and oldspeed >= speedthirtyperc then
				if (oldspeed + rawspeed) <= speedfourtyperc then
					pstspeed = rawspeed / (speedamt * 1.3)
				else
					stspeeddiff = speedfourtyperc - oldspeed
					stspeedremain = rawspeed - stspeeddiff
					pstspeed = (stspeeddiff / (speedamt * 1.3)) + (stspeedremain / (speedamt * 1.4))
				end
			elseif oldspeed < speedthirtyperc and oldspeed >= speedtwentyperc then
				if (oldspeed + rawspeed) <= speedthirtyperc then
					pstspeed = rawspeed / (speedamt * 1.2)
				else
					stspeeddiff = speedthirtyperc - oldspeed
					stspeedremain = rawspeed - stspeeddiff
					pstspeed = (stspeeddiff / (speedamt * 1.2)) + (stspeedremain / (speedamt * 1.3))
				end
			elseif oldspeed < speedtwentyperc and oldspeed >= speedtenperc then
				if (oldspeed + rawspeed) <= speedtwentyperc then
					pstspeed = rawspeed / (speedamt * 1.1)
				else
					stspeeddiff = speedtwentyperc - oldspeed
					stspeedremain = rawspeed - stspeeddiff
					pstspeed = (stspeeddiff / (speedamt * 1.1)) + (stspeedremain / (speedamt * 1.2))
				end
			else
				if (oldspeed + rawspeed) < speedtenperc then
					pstspeed = rawspeed / speedamt
				else
					stspeeddiff = speedtenperc - oldspeed
					stspeedremain = rawspeed - stspeeddiff
					pstspeed = (stspeeddiff / speedamt) + (stspeedremain / (speedamt * 1.1))
				end
			end
		end
	end
	
	if rawleech ~= nil then		
		if newsoleech ~= nil then
			if newsoleech >= leechcap then
				psoleech = 0
			elseif newsoleech < leechcap and newsoleech >= leechfiftyperc then
				if (newsoleech + rawleech) <= leechcap then
					psoleech = rawleech / (leechamt * 1.5)
				else 
					soleechdiff = leechcap - newsoleech				
					psoleech = soleechdiff / (leechamt * 1.5)
				end
			elseif newsoleech < leechfiftyperc and newsoleech >= leechfourtyperc then
				if (newsoleech + rawleech) <= leechfiftyperc then
					psoleech = rawleech / (leechamt * 1.4)
				else 
					soleechdiff = leechfiftyperc - newsoleech
					soleechremain = rawleech - soleechdiff
					psoleech = (soleechdiff / (leechamt * 1.4)) + (soleechremain / (leechamt * 1.5))
				end
			elseif newsoleech < leechfourtyperc and newsoleech >= leechthirtyperc then
				if (newsoleech + rawleech) <= leechfourtyperc then
					psoleech = rawleech / (leechamt * 1.3)
				else
					soleechdiff = leechfourtyperc - newsoleech
					soleechremain = rawleech - soleechdiff
					psoleech = (soleechdiff / (leechamt * 1.3)) + (soleechremain / (leechamt * 1.4))
				end
			elseif newsoleech < leechthirtyperc and newsoleech >= leechtwentyperc then
				if (newsoleech + rawleech) <= leechthirtyperc then
					psoleech = rawleech / (leechamt * 1.2)
				else
					soleechdiff = leechthirtyperc - newsoleech
					soleechremain = rawleech - soleechdiff
					psoleech = (soleechdiff / (leechamt * 1.2)) + (soleechremain / (leechamt * 1.3))
				end
			elseif newsoleech < leechtwentyperc and newsoleech >= leechtenperc then
				if (newsoleech + rawleech) <= leechtwentyperc then
					psoleech = rawleech / (leechamt * 1.1)
				else
					soleechdiff = leechtwentyperc - newsoleech
					soleechremain = rawleech - soleechdiff
					psoleech = (soleechdiff / (leechamt * 1.1)) + (soleechremain / (leechamt * 1.2))
				end
			else
				if (newsoleech + rawleech) < leechtenperc then
					psoleech = rawleech / leechamt
				else
					soleechdiff = leechtenperc - newsoleech
					soleechremain = rawleech - soleechdiff
					psoleech = (soleechdiff / leechamt) + (soleechremain / (leechamt * 1.1))
				end
			end
		else
			if oldleech >= leechcap then
				psoleech = 0
			elseif oldleech < leechcap and oldleech >= leechfiftyperc then
				if (oldleech + rawleech) <= leechcap then
					psoleech = rawleech / (leechamt * 1.5)
				else 
					soleechdiff = leechcap - oldleech				
					psoleech = soleechdiff / (leechamt * 1.5)
				end
			elseif oldleech < leechfiftyperc and oldleech >= leechfourtyperc then
				if (oldleech + rawleech) <= leechfiftyperc then
					psoleech = rawleech / (leechamt * 1.4)
				else 
					soleechdiff = leechfiftyperc - oldleech
					soleechremain = rawleech - soleechdiff
					psoleech = (soleechdiff / (leechamt * 1.4)) + (soleechremain / (leechamt * 1.5))
				end
			elseif oldleech < leechfourtyperc and oldleech >= leechthirtyperc then
				if (oldleech + rawleech) <= leechfourtyperc then
					psoleech = rawleech / (leechamt * 1.3)
				else
					soleechdiff = leechfourtyperc - oldleech
					soleechremain = rawleech - soleechdiff
					psoleech = (soleechdiff / (leechamt * 1.3)) + (soleechremain / (leechamt * 1.4))
				end
			elseif oldleech < leechthirtyperc and oldleech >= leechtwentyperc then
				if (oldleech + rawleech) <= leechthirtyperc then
					psoleech = rawleech / (leechamt * 1.2)
				else
					soleechdiff = leechthirtyperc - oldleech
					soleechremain = rawleech - soleechdiff
					psoleech = (soleechdiff / (leechamt * 1.2)) + (soleechremain / (leechamt * 1.3))
				end
			elseif oldleech < leechtwentyperc and oldleech >= leechtenperc then
				if (oldleech + rawleech) <= leechtwentyperc then
					psoleech = rawleech / (leechamt * 1.1)
				else
					soleechdiff = leechtwentyperc - oldleech
					soleechremain = rawleech - soleechdiff
					psoleech = (soleechdiff / (leechamt * 1.1)) + (soleechremain / (leechamt * 1.2))
				end
			else
				if (oldleech + rawleech) < leechtenperc then
					psoleech = rawleech / leechamt
				else
					soleechdiff = leechtenperc - oldleech
					soleechremain = rawleech - soleechdiff
					psoleech = (soleechdiff / leechamt) + (soleechremain / (leechamt * 1.1))
				end
			end
		end
	
		if eqststats ~= nil and newstleech ~= nil then
			if newstleech >= leechcap then
				pstleech = 0
			elseif newstleech < leechcap and newstleech >= leechfiftyperc then
				if (newstleech + rawleech) <= leechcap then
					pstleech = rawleech / (leechamt * 1.5)
				else 
					stleechdiff = leechcap - newstleech				
					pstleech = stleechdiff / (leechamt * 1.5)
				end
			elseif newstleech < leechfiftyperc and newstleech >= leechfourtyperc then
				if (newstleech + rawleech) <= leechfiftyperc then
					pstleech = rawleech / (leechamt * 1.4)
				else 
					stleechdiff = leechfiftyperc - newstleech
					stleechremain = rawleech - stleechdiff
					pstleech = (stleechdiff / (leechamt * 1.4)) + (stleechremain / (leechamt * 1.5))
				end
			elseif newstleech < leechfourtyperc and newstleech >= leechthirtyperc then
				if (newstleech + rawleech) <= leechfourtyperc then
					pstleech = rawleech / (leechamt * 1.3)
				else
					stleechdiff = leechfourtyperc - newstleech
					stleechremain = rawleech - stleechdiff
					pstleech = (stleechdiff / (leechamt * 1.3)) + (stleechremain / (leechamt * 1.4))
				end
			elseif newstleech < leechthirtyperc and newstleech >= leechtwentyperc then
				if (newstleech + rawleech) <= leechthirtyperc then
					pstleech = rawleech / (leechamt * 1.2)
				else
					stleechdiff = leechthirtyperc - newstleech
					stleechremain = rawleech - stleechdiff
					pstleech = (stleechdiff / (leechamt * 1.2)) + (stleechremain / (leechamt * 1.3))
				end
			elseif newstleech < leechtwentyperc and newstleech >= leechtenperc then
				if (newstleech + rawleech) <= leechtwentyperc then
					pstleech = rawleech / (leechamt * 1.1)
				else
					stleechdiff = leechtwentyperc - newstleech
					stleechremain = rawleech - stleechdiff
					pstleech = (stleechdiff / (leechamt * 1.1)) + (stleechremain / (leechamt * 1.2))
				end
			else
				if (newstleech + rawleech) < leechtenperc then
					pstleech = rawleech / leechamt
				else
					stleechdiff = leechtenperc - newstleech
					stleechremain = rawleech - stleechdiff
					pstleech = (stleechdiff / leechamt) + (stleechremain / (leechamt * 1.1))
				end
			end
		elseif eqststats ~=nil then
			if oldleech >= leechcap then
				pstleech = 0
			elseif oldleech < leechcap and oldleech >= leechfiftyperc then
				if (oldleech + rawleech) <= leechcap then
					pstleech = rawleech / (leechamt * 1.5)
				else 
					stleechdiff = leechcap - oldleech				
					pstleech = stleechdiff / (leechamt * 1.5)
				end
			elseif oldleech < leechfiftyperc and oldleech >= leechfourtyperc then
				if (oldleech + rawleech) <= leechfiftyperc then
					pstleech = rawleech / (leechamt * 1.4)
				else 
					stleechdiff = leechfiftyperc - oldleech
					stleechremain = rawleech - stleechdiff
					pstleech = (stleechdiff / (leechamt * 1.4)) + (stleechremain / (leechamt * 1.5))
				end
			elseif oldleech < leechfourtyperc and oldleech >= leechthirtyperc then
				if (oldleech + rawleech) <= leechfourtyperc then
					pstleech = rawleech / (leechamt * 1.3)
				else
					stleechdiff = leechfourtyperc - oldleech
					stleechremain = rawleech - stleechdiff
					pstleech = (stleechdiff / (leechamt * 1.3)) + (stleechremain / (leechamt * 1.4))
				end
			elseif oldleech < leechthirtyperc and oldleech >= leechtwentyperc then
				if (oldleech + rawleech) <= leechthirtyperc then
					pstleech = rawleech / (leechamt * 1.2)
				else
					stleechdiff = leechthirtyperc - oldleech
					stleechremain = rawleech - stleechdiff
					pstleech = (stleechdiff / (leechamt * 1.2)) + (stleechremain / (leechamt * 1.3))
				end
			elseif oldleech < leechtwentyperc and oldleech >= leechtenperc then
				if (oldleech + rawleech) <= leechtwentyperc then
					pstleech = rawleech / (leechamt * 1.1)
				else
					stleechdiff = leechtwentyperc - oldleech
					stleechremain = rawleech - stleechdiff
					pstleech = (stleechdiff / (leechamt * 1.1)) + (stleechremain / (leechamt * 1.2))
				end
			else
				if (oldleech + rawleech) < leechtenperc then
					pstleech = rawleech / leechamt
				else
					stleechdiff = leechtenperc - oldleech
					stleechremain = rawleech - stleechdiff
					pstleech = (stleechdiff / leechamt) + (stleechremain / (leechamt * 1.1))
				end
			end
		end
	end

	--Round The outputs 
	prsocrit = mathround(psocrit, 2)
	prstcrit = mathround(pstcrit, 2)
	prsohaste = mathround(psohaste, 2)
	prsthaste = mathround(psthaste, 2)
	prsoversin = mathround(psoversin, 2)
	prstversin = mathround(pstversin, 2)
	prsoversout = mathround(psoversout, 2)
	prstversout = mathround(pstversout, 2)
	prsomastery = mathround(psomastery, 2)
	prstmastery = mathround(pstmastery, 2)
	prsospeed = mathround(psospeed, 2)
	prstspeed = mathround(pstspeed, 2)
	prsoleech = mathround(psoleech, 2)
	prstleech = mathround(pstleech, 2)
	prsoavoid = mathround(psoavoid, 2)
	prstavoid = mathround(pstavoid, 2)

	--Convert percentages to strings 
	tostring(prsocrit)
	tostring(prstcrit)
	tostring(prsohaste)
	tostring(prsthaste)
	tostring(prsoversin)
	tostring(prstversin)
	tostring(prsoversout)
	tostring(prstversout)
	tostring(prsomastery)
	tostring(prstmastery)
	tostring(prsoleech)
	tostring(prstleech)
	tostring(prsoavoid)
	tostring(prstavoid)
	tostring(prsospeed)
	tostring(prstspeed)
	
	--Convert text color from decimal to hex
	hexcolor = string.format("|cff%02x%02x%02x", cvred*255, cvgreen*255, cvblue*255)
    
	--Set output values in the same line as the rating in tooltip 
	for i=1, self:NumLines() do		
		local line = _G[self:GetName().."TextLeft"..i]
		local text = line:GetText()
		if text then		
			if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_CRIT_RATING_SHORT"])) and rawcrit ~= nil then
				if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_SPELL_TRIGGER_ONEQUIP"])) then
					break
				elseif i <= 2 then				
				else
					if eqststats ~= nil then
						_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawcrit .. " " .. _G["ITEM_MOD_CRIT_RATING_SHORT"] .. hexcolor .. " (" .. prsocrit .. "%) (" .. prstcrit .. "%)");
						break
					else
						_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawcrit .. " " .. _G["ITEM_MOD_CRIT_RATING_SHORT"] .. hexcolor .. " (" .. prsocrit .. "%)");
						break
					end
				end
			end
		end	
	end
	
	for i=1, self:NumLines() do
		local line = _G[self:GetName().."TextLeft"..i]
		local text = line:GetText()
		if text then			
			if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_HASTE_RATING_SHORT"])) and rawhaste ~= nil then
				if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_SPELL_TRIGGER_ONEQUIP"])) then
					break
				elseif i <= 2 then				
				else
					if eqststats ~= nil then
						_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawhaste .. " " .. _G["ITEM_MOD_HASTE_RATING_SHORT"] .. hexcolor .. " (" .. prsohaste .. "%) (" .. prsthaste .. "%)");
						break
					else
						_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawhaste .. " " .. _G["ITEM_MOD_HASTE_RATING_SHORT"] .. hexcolor .. " (" .. prsohaste .. "%)");
						break
					end
				end
			end
		end	
	end
	
	for i=1, self:NumLines() do
		local line = _G[self:GetName().."TextLeft"..i]
		local text = line:GetText()
		if text then	
			if(string.find(_G[self:GetName() .. "TextLeft"..i]:GetText(), _G["ITEM_MOD_MASTERY_RATING_SHORT"])) and rawmastery ~= nil then
				if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_SPELL_TRIGGER_ONEQUIP"])) then
					break
				elseif i <= 2 then				
				else
					if eqststats ~= nil then
						_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawmastery .. " " .. _G["ITEM_MOD_MASTERY_RATING_SHORT"] .. hexcolor .. " (" .. prsomastery .. "%) (" .. prstmastery .. "%)");
						break
					else
						_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawmastery .. " " .. _G["ITEM_MOD_MASTERY_RATING_SHORT"] .. hexcolor .. " (" .. prsomastery .. "%)");
						break
					end
				end
			end
		end	
	end
	
	for i=1, self:NumLines() do
		local line = _G[self:GetName().."TextLeft"..i]
		local text = line:GetText()
		if text then
			if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_VERSATILITY"])) and rawvers ~= nil then
				if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_SPELL_TRIGGER_ONEQUIP"])) then
					break
				elseif i <= 2 then				
				else
					if eqststats ~= nil then
						_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawvers .. " " .. _G["ITEM_MOD_VERSATILITY"] .. hexcolor .. " (" .. prsoversin .. "%/" .. prsoversout .. "%) (" .. prstversin .. "%/" .. prstversout .. "%)");
						break
					else
						_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawvers .. " " .. _G["ITEM_MOD_VERSATILITY"] .. hexcolor .. " (" .. prsoversin .. "%/" .. prsoversout .. "%)");
						break
					end
				end
			end
		end		
	end
	
	for i=1, self:NumLines() do
		local line = _G[self:GetName().."TextLeft"..i]
		local text = line:GetText()
		if text then
			if(string.find(_G[self:GetName() .. "TextLeft"..i]:GetText(), _G["ITEM_MOD_CR_SPEED_SHORT"])) and rawspeed ~= nil then
				if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_SPELL_TRIGGER_ONEQUIP"])) then
					break
				elseif i <= 2 then				
				else
					if eqststats ~= nil then
						_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawspeed .. " " .. _G["ITEM_MOD_CR_SPEED_SHORT"] .. hexcolor .. " (" .. prsospeed .. "%) (" .. prstspeed .. "%)");
						break
					else
						_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawspeed .. " " .. _G["ITEM_MOD_CR_SPEED_SHORT"] .. hexcolor .. " (" .. prsospeed .. "%)");
						break
					end
				end
			end
		end		
	end
	
	for i=1, self:NumLines() do
		local line = _G[self:GetName().."TextLeft"..i]
		local text = line:GetText()
		if text then
			if(string.find(_G[self:GetName() .. "TextLeft"..i]:GetText(), _G["ITEM_MOD_CR_LIFESTEAL_SHORT"])) and rawleech ~= nil then
				if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_SPELL_TRIGGER_ONEQUIP"])) then
					break
				elseif i <= 2 then				
				else
					if eqststats ~= nil then
						_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawleech .. " " .. _G["ITEM_MOD_CR_LIFESTEAL_SHORT"] .. hexcolor .. " (" .. prsoleech .. "%) (" .. prstleech .. "%)");
						break
					else
						_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawleech .. " " .. _G["ITEM_MOD_CR_LIFESTEAL_SHORT"] .. hexcolor .. " (" .. prsoleech .. "%)");
						break
					end
				end
			end
		end		
	end
	
	for i=1, self:NumLines() do
		local line = _G[self:GetName().."TextLeft"..i]
		local text = line:GetText()
		if text then
			if(string.find(_G[self:GetName() .. "TextLeft"..i]:GetText(), _G["ITEM_MOD_CR_AVOIDANCE_SHORT"])) and rawavoid ~= nil then
				if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_SPELL_TRIGGER_ONEQUIP"])) then
					break
				elseif i <= 2 then				
				else
					if eqststats ~= nil then
						_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawavoid .. " " .. _G["ITEM_MOD_CR_AVOIDANCE_SHORT"] .. hexcolor .. " (" .. prsoavoid .. "%) (" .. prstavoid .. "%)");
						break
					else
						_G[self:GetName().."TextLeft"..i]:SetText("+" .. rawavoid .. " " .. _G["ITEM_MOD_CR_AVOIDANCE_SHORT"] .. hexcolor .. " (" .. prsoavoid .. "%)");
						break
					end
				end
			end
		end	
	end	
end

--Hooks to make the addon function
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, getItemIdFromTooltip)

--Old Hooks saved for reference
--[[GameTooltip:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
ItemRefTooltip:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
ShoppingTooltip1:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
ShoppingTooltip2:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
GameTooltip.ItemTooltip.Tooltip:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
]]
