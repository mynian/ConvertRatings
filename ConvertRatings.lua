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
local eqslottable = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 16, 17, 16, 15, 16, 0, 0, 5, 16, 17, 17, 0, 0, 16, 0, 0}

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
	versinamt = verstab[cvlevel]
	versoutamt = verstab[cvlevel] * 2
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
	local name, itemLink = self:GetItem();		
	
	--Check to make sure an itemLink is actually returned
	if(itemLink == nil) then
     		return;
	end

	--Declare variables for future use
	local rawcrit, rawhaste, rawmastery, rawvers, stats, rawleech, rawavoid, rawspeed, hexcolor, oldmastery, newsomastery, newstmastery, oldcrit, newsocrit, newstcrit, oldhaste, newsohaste, newsthaste, oldvers, newsovers, newstvers, oldavoid, newsoavoid, newstavoid, oldspeed, newsospeed, newstspeed oldleech, newsoleech, newstleech;
	local eqitemslot, eqitemslotname, eqitemtype, eqsoitemlink, eqstitemlink, eqsostats, eqststats eqsomastery, eqstmastery, eqsocrit, eqstcrit eqsohaste, eqsthaste eqsovers, eqstvers, eqsoleech, eqstleech, eqsoavoid, eqstavoid, eqsospeed, eqstspeed, stitemtype, stitemslot, stitemlink;
	
	
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
			newstvers = oldvers - eqstvers
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
			
	
		if newstcrit ~= nil then
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
		else
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
	
		if newsthaste ~= nil then
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
		else
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

	--Round The outputs 
	prcrit = mathround(pcrit, 2)
	prhaste = mathround(phaste, 2)
	prversin = mathround(pversin, 2)
	prversout = mathround(pversout, 2)
	prmastery = mathround(pmastery, 2)
	prspeed = mathround(pspeed, 2)
	prleech = mathround(pleech, 2)
	pravoid = mathround(pavoid, 2)


	--Convert percentages to strings 
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
    
	--Set output values in the same line as the rating in tooltip 
	for i=1, self:NumLines() do		
		local line = _G[self:GetName().."TextLeft"..i]
		local text = line:GetText()
		if text then
		--If line contains "Critical Strike", then sets show a 'fontString' and set its text 
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

--Hooks to make the addon function
GameTooltip:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
ItemRefTooltip:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
ShoppingTooltip1:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
ShoppingTooltip2:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
GameTooltip.ItemTooltip.Tooltip:HookScript("OnTooltipSetItem", getItemIdFromTooltip);