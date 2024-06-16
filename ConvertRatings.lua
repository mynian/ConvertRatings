--Set color variables default values to avoid first load errors 
cvred = 1
cvgreen = .996
cvblue = .545
cvalpha = 1
cvcolor = "Default"

--Hard coded color options table 
local colorTable = {
	["blue"] = {0, 0, 1},
	["green"] = {0, 1, 0},
	["red"] = {1, 0, 0},
	["black"] = {0, 0, 0},
	["white"] = {1, 1, 1},
	["light blue"] = {0, 1, 1},
	["light red"] = {1, .5, .5},
	["pink"] = {1, .5, 1},
	["purple"] = {.7, 0, 1},
	["orange"] = {1, .5, 0},
	["default"] = {1, .996, .545}
}

--Color Picker
local function ShowColorPicker(cvred, cvgreen, cvblue, cvalpha, changedCallback)
 ColorPickerFrame:SetColorRGB(cvred, cvgreen, cvblue);
 ColorPickerFrame.hasOpacity, ColorPickerFrame.opacity = (cvalpha ~= nil), cvalpha;
 ColorPickerFrame.previousValues = {cvred, cvgreen, cvblue, cvalpha};
 ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc =  changedCallback, changedCallback, changedCallback;
 ColorPickerFrame:Hide();
 ColorPickerFrame:Show(); 
 end

function myColorCallback(restore)
 local newR, newG, newB, newA;
 if restore then
  newR, newG, newB, newA = unpack(restore);  
 else
  newA, newR, newG, newB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB();  
 end 
  cvred, cvgreen, cvblue, cvalpha = newR, newG, newB, newA;
end

--Create a Frame to add to the default options panel
local cvrpanel = CreateFrame("Frame")
cvrpanel.name = "Convert Ratings"

--Options Panel Title
local cvropttitle = cvrpanel:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
cvropttitle:SetPoint("TOP")
cvropttitle:SetText("Convert Ratings")

--Add title text to the options menu for the dropdown menu
local cvrddtitle = cvrpanel:CreateFontString("ARTWORK", nil, "GameFontNormal")
cvrddtitle:SetPoint("TOPLEFT", cvrpanel, 0, - 80)
cvrddtitle:SetText("Pick a Color")

--Create the dropdown menu frame
local cvrdropdown = CreateFrame("Frame", "CVRDropDown", cvrpanel, "UIDropDownMenuTemplate")
cvrdropdown:SetPoint("TOPLEFT", cvrpanel, -20, -100)
UIDropDownMenu_SetWidth(cvrdropdown, 150)

--Function to set the color of the addon, update the text in the dropdown menu and update the savedvariable for the menu to display the chosen color between sessions
local function cvrdropdown_OnClick(self, arg1, arg2, checked)
	cvred, cvgreen, cvblue = unpack(colorTable[string.lower(arg1)])
	hexcolor = string.format("|cff%02x%02x%02x", cvred*255, cvgreen*255, cvblue*255)
	UIDropDownMenu_SetText(cvrdropdown, "Current Color: " .. hexcolor .. arg1)
	cvcolor = tostring(arg1)
end

--Code for the dropdown menu
function cvrdropdown_Menu(frame, level, menuList)
	--convert the current color variables to hex
	hexcolor = string.format("|cff%02x%02x%02x", cvred*255, cvgreen*255, cvblue*255)
	--Set the text of the dropdown when you click on it to the currently selected color
	UIDropDownMenu_SetText(cvrdropdown, "Current Color: " .. hexcolor .. cvcolor)
	--Create a dropdown menu item's info
	local info = UIDropDownMenu_CreateInfo()
	--tell it to do something when you click on this option
	info.func = cvrdropdown_OnClick
	--pull the color assignements for the variables from the color table and set them in the addon
	cvred, cvgreen, cvblue = unpack(colorTable[string.lower("default")])
	--convert the color variables to hex for display in the dropdown menu
	hexcolor = string.format("|cff%02x%02x%02x", cvred*255, cvgreen*255, cvblue*255)
	--Set the text of the dropdown item, and the value that it passes out of the dropdown when you click on it
	info.text, info.arg1 = hexcolor .. "Default", "Default"
	--Put the item into the dropdown menu
	UIDropDownMenu_AddButton(info)
	info.func = cvrdropdown_OnClick
	cvred, cvgreen, cvblue = unpack(colorTable[string.lower("black")])
	hexcolor = string.format("|cff%02x%02x%02x", cvred*255, cvgreen*255, cvblue*255)
	info.text, info.arg1 = hexcolor .. "Black", "Black"
	UIDropDownMenu_AddButton(info)
	info.func = cvrdropdown_OnClick
	cvred, cvgreen, cvblue = unpack(colorTable[string.lower("blue")])
	hexcolor = string.format("|cff%02x%02x%02x", cvred*255, cvgreen*255, cvblue*255)
	info.text, info.arg1 = hexcolor .. "Blue", "Blue"
	UIDropDownMenu_AddButton(info)
	info.func = cvrdropdown_OnClick
	cvred, cvgreen, cvblue = unpack(colorTable[string.lower("green")])
	hexcolor = string.format("|cff%02x%02x%02x", cvred*255, cvgreen*255, cvblue*255)
	info.text, info.arg1 = hexcolor .. "Green", "Green"
	UIDropDownMenu_AddButton(info)
	info.func = cvrdropdown_OnClick
	cvred, cvgreen, cvblue = unpack(colorTable[string.lower("light blue")])
	hexcolor = string.format("|cff%02x%02x%02x", cvred*255, cvgreen*255, cvblue*255)
	info.text, info.arg1 = hexcolor .. "Light Blue", "Light Blue"
	UIDropDownMenu_AddButton(info)
	info.func = cvrdropdown_OnClick
	cvred, cvgreen, cvblue = unpack(colorTable[string.lower("light red")])
	hexcolor = string.format("|cff%02x%02x%02x", cvred*255, cvgreen*255, cvblue*255)
	info.text, info.arg1 = hexcolor .. "Light Red", "Light Red"
	UIDropDownMenu_AddButton(info)
	info.func = cvrdropdown_OnClick
	cvred, cvgreen, cvblue = unpack(colorTable[string.lower("orange")])
	hexcolor = string.format("|cff%02x%02x%02x", cvred*255, cvgreen*255, cvblue*255)
	info.text, info.arg1 = hexcolor .. "Orange", "Orange"
	UIDropDownMenu_AddButton(info)
	info.func = cvrdropdown_OnClick
	cvred, cvgreen, cvblue = unpack(colorTable[string.lower("pink")])
	hexcolor = string.format("|cff%02x%02x%02x", cvred*255, cvgreen*255, cvblue*255)
	info.text, info.arg1 = hexcolor .. "Pink", "Pink"
	UIDropDownMenu_AddButton(info)
	info.func = cvrdropdown_OnClick
	cvred, cvgreen, cvblue = unpack(colorTable[string.lower("purple")])
	hexcolor = string.format("|cff%02x%02x%02x", cvred*255, cvgreen*255, cvblue*255)
	info.text, info.arg1 = hexcolor .. "Purple", "Purple"
	UIDropDownMenu_AddButton(info)
	info.func = cvrdropdown_OnClick
	cvred, cvgreen, cvblue = unpack(colorTable[string.lower("red")])
	hexcolor = string.format("|cff%02x%02x%02x", cvred*255, cvgreen*255, cvblue*255)
	info.text, info.arg1 = hexcolor .. "Red", "Red"
	UIDropDownMenu_AddButton(info)	
	info.func = cvrdropdown_OnClick
	cvred, cvgreen, cvblue = unpack(colorTable[string.lower("white")])
	hexcolor = string.format("|cff%02x%02x%02x", cvred*255, cvgreen*255, cvblue*255)
	info.text, info.arg1 = hexcolor .. "White", "White"
	UIDropDownMenu_AddButton(info)	
end

--Function to initialize the dropdown menu
UIDropDownMenu_Initialize(cvrdropdown, cvrdropdown_Menu)

--Add title text in the options menu for a button to open up the color picker for the user to choose a custom color
local cvrddtitle = cvrpanel:CreateFontString("ARTWORK", nil, "GameFontNormal")
cvrddtitle:SetPoint("TOPLEFT", cvrpanel, 0, -20)
cvrddtitle:SetText("Choose a Custom Color")

--Create the button for the color picker in the options menu
local cvrbutton = CreateFrame("Button", nil, cvrpanel, "UIPanelButtonTemplate")
cvrbutton:SetPoint("TOPLEFT", cvrpanel, 0, -40)
cvrbutton:SetText("Color Wheel")
cvrbutton:SetWidth(150)
cvrbutton:HookScript("OnClick", function() ShowColorPicker(cvred, cvgreen, cvblue, nil, myColorCallback); cvcolor = "Custom"; UIDropDownMenu_SetText(cvrdropdown, "Current Color: "  .. cvcolor)  end)
	
--Add our panel to the options frame	
InterfaceOptions_AddCategory(cvrpanel)

--Slash Command to change the color of the output 
SLASH_CONVERTRATINGS1, SLASH_CONVERTRATINGS2 = '/convertratings', '/cvr';
function SlashCmdList.CONVERTRATINGS(msg, editBox)
	--Grab the first input word as the command and the rest of the input as a user variable 
	local command, rest = msg:match("^(%S*)%s*(.-)$");
	--Hard coded color options parsing 	
	if (colorTable[string.lower(command)]) then
		cvred, cvgreen, cvblue = unpack(colorTable[string.lower(command)]);
		UIDropDownMenu_SetText(cvrdropdown, "Current Color: " .. command);
		print("Convert Ratings output color set to "..string.lower(command));
	elseif string.lower(command) == 'custom' and rest == "" then
		ShowColorPicker(cvred, cvgreen, cvblue, nil, myColorCallback);
	else
		--when no valid args entered, open the options panel
		InterfaceOptionsFrame_OpenToCategory(cvrpanel.name)
	end
end

--equipment slot table
local invtable = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 16, 17, 16, 15, 16, 0, 0, 5, 16, 17, 17, 0, 0, 16, 0, 0}

--rating tables to allow addon to work at all levels 
masterytab = { 
			2.755331157, 2.755331157, 2.755331157, 2.755331157, 2.755331157, --5
			2.755331157, 2.755331157, 2.755331157, 2.755331157, 2.755331157, --10
			2.755331157, 2.893097715, 3.030864272, 3.168630830, 3.306397388, --15
			3.444163946, 3.581930504, 3.719697062, 3.857463619, 3.995230177, --20
			4.157336642, 4.328411045, 4.509013995, 4.699745287, 4.901246867, --25
			5.114206043, 5.339358964, 5.577494374, 5.829457682, 6.096155371, --30
			6.378559769, 6.677714222, 6.994738704, 7.330835899, 7.687297795, --35
			8.065512846, 8.466973748, 8.893285876, 9.346176460, 9.827504547, --40
			10.33927185, 10.88363451, 11.46291596, 12.07962083, 12.73645022, --45
			13.43631816, 14.18236972, 14.97800066, 15.82687885, 16.73296767, --50
			17.79432523, 18.92300378, 20.12327343, 21.39967514, 22.75703790, --55
			24.20049699, 25.73551344, 27.36789465, 29.10381637, 35.00060877, --60
			40.11816240, 45.98397031, 52.70743720, 60.41396420, 69.24728776, --65
			79.37216048, 90.97742400, 104.2795311, 119.5265829, 179.9951510, --70
			}

crittab = { 
			2.755331157, 2.755331157, 2.755331157, 2.755331157, 2.755331157, --5
			2.755331157, 2.755331157, 2.755331157, 2.755331157, 2.755331157, --10
			2.755331157, 2.893097715, 3.030864272, 3.168630830, 3.306397388, --15
			3.444163946, 3.581930504, 3.719697062, 3.857463619, 3.995230177, --20
			4.157336642, 4.328411045, 4.509013995, 4.699745287, 4.901246867, --25
			5.114206043, 5.339358964, 5.577494374, 5.829457682, 6.096155371, --30
			6.378559769, 6.677714222, 6.994738704, 7.330835899, 7.687297795, --35
			8.065512846, 8.466973748, 8.893285876, 9.346176460, 9.827504547, --40
			10.33927185, 10.88363451, 11.46291596, 12.07962083, 12.73645022, --45
			13.43631816, 14.18236972, 14.97800066, 15.82687885, 16.73296767, --50
			17.79432523, 18.92300378, 20.12327343, 21.39967514, 22.75703790, --55
			24.20049699, 25.73551344, 27.36789465, 29.10381637, 35.00060877, --60
			40.11816240, 45.98397031, 52.70743720, 60.41396420, 69.24728776, --65
			79.37216048, 90.97742400, 104.2795311, 119.5265829, 179.9951510, --70
			}

hastetab = {
			2.602257204, 2.602257204, 2.602257204, 2.602257204, 2.602257204, --5
			2.602257204, 2.602257204, 2.602257204, 2.602257204, 2.602257204, --10
			2.602257204, 2.732370064, 2.862482924, 2.992595784, 3.122708644, --15
			3.252821504, 3.382934365, 3.513047225, 3.643160085, 3.773272945, --20
			3.926373495, 4.087943764, 4.258513218, 4.438648327, 4.628955374, --25
			4.830083485, 5.042727910, 5.267633575, 5.505598922, 5.757480073, --30
			6.024195337, 6.306730098, 6.606142110, 6.923567238, 7.260225695, --35
			7.617428799, 7.996586318, 8.399214439, 8.826944434, 9.281532073, --40
			9.764867855, 10.27898815, 10.82608729, 11.40853079, 12.02886965, --45
			12.68985604, 13.39446029, 14.14588952, 14.94760780, 15.80335835, --50
			16.80575161, 17.87172580, 19.00531380, 20.21080430, 21.49275802, --55
			22.85602494, 24.30576270, 25.84745605, 27.48693768, 33.05613050, --60
			37.88937560, 43.42930529, 49.77924624, 57.05763286, 65.40021622, --65
			74.96259601, 85.92312267, 98.48622383, 112.8862171, 169.9954204, --70
			}

verstab = {
			3.138016040, 3.138016040, 3.138016040, 3.138016040, 3.138016040, --5
			3.138016040, 3.138016040, 3.138016040, 3.138016040, 3.138016040, --10
			3.138016040, 3.294916842, 3.451817644, 3.608718446, 3.765619248, --15
			3.922520050, 4.079420852, 4.236321654, 4.393222455, 4.550123257, --20
			4.734744509, 4.929579245, 5.135265939, 5.352487688, 5.581975598, --25
			5.824512438, 6.080936598, 6.352146370, 6.639104582, 6.942843617, --30
			7.264470848, 7.605174530, 7.966230191, 8.349007552, 8.754978044, --35
			9.185722964, 9.642942324, 10.12846447, 10.64425652, 11.19243573, --40
			11.77528183, 12.39525041, 13.05498762, 13.75734595, 14.50540164, --45
			15.30247346, 16.15214330, 17.05827853, 18.02505647, 19.05699095, --50
			20.26575929, 21.55119875, 22.91817252, 24.37185225, 25.91773761, --55
			27.56167713, 29.30989031, 31.16899113, 33.14601309, 39.86180443, --60
			45.69012940, 52.37063285, 60.02791459, 68.80479256, 78.86496662, --65
			90.39607166, 103.6131773, 118.7627993, 136.1274971, 204.9944775, --70
			}

leechtab = {
			2.265494507, 2.265494507, 2.265494507, 2.265494507, 2.265494507, --5
			2.265494507, 2.265494507, 2.265494507, 2.265494507, 2.265494507, --10
			2.265494507, 2.378769232, 2.492043957, 2.605318683, 2.718593408, --15
			2.831868133, 2.945142859, 3.058417584, 3.171692309, 3.284967035, --20
			3.418254572, 3.558915748, 3.707411507, 3.864235014, 4.029914090, --25
			4.205013858, 4.390139593, 4.585939818, 4.793109650, 5.012394416, --30
			5.244593588, 5.490565027, 5.751229601, 6.027576184, 6.320667076, --35
			6.631643896, 6.961733971, 7.312257276, 7.684633978, 8.080392628, --40
			8.501179074, 8.948766152, 9.425064231, 9.932132686, 10.47219240, --45
			11.04763937, 11.66105955, 12.31524499, 13.01321150, 13.75821786, --50
			14.63088964, 15.55891422, 16.54580260, 17.59528845, 18.71134227, --55
			19.89818642, 21.16031105, 22.50249115, 23.92980457, 28.77827832, --60
			32.98604464, 37.80904225, 43.33722614, 49.67370390, 56.93665882, --65
			65.26155417, 74.80365974, 85.74094780, 98.27741257, 147.9960130, --70
			}

avoidtab = {
			1.102132463, 1.102132463, 1.102132463, 1.102132463, 1.102132463, --5
			1.102132463, 1.102132463, 1.102132463, 1.102132463, 1.102132463, --10
			1.102132463, 1.157239086, 1.212345709, 1.267452332, 1.322558955, --15
			1.377665578, 1.432772202, 1.487878825, 1.542985448, 1.598092071, --20
			1.662934657, 1.731364418, 1.803605598, 1.879898115, 1.960498747, --25
			2.045682417, 2.135743586, 2.230997750, 2.331783073, 2.438462148, --30
			2.551423907, 2.671085689, 2.797895482, 2.932334360, 3.074919118, --35
			3.226205139, 3.386789499, 3.557314351, 3.738470584, 3.931001819, --40
			4.135708739, 4.353453804, 4.585166382, 4.831848334, 5.094580087, --45
			5.374527263, 5.672947889, 5.991200266, 6.330751541, 6.693187066, --50
			7.117730093, 7.569201514, 8.049309374, 8.559870057, 9.102815160, --55
			9.680198798, 10.29420538, 10.94715786, 11.64152655, 14.00024351, --60
			16.04726496, 18.39358812, 21.08297488, 24.16558568, 27.69891510, --65
			31.74886419, 36.39096960, 41.71181244, 47.81063314, 71.99806040, --70
			}

speedtab = {
			0.765369766, 0.765369766, 0.765369766, 0.765369766, 0.765369766, --5
			0.765369766, 0.765369766, 0.765369766, 0.765369766, 0.765369766, --10
			0.765369766, 0.803638254, 0.841906742, 0.880175231, 0.918443719, --15
			0.956712207, 0.994980695, 1.033249184, 1.071517672, 1.109786160, --20
			1.154815734, 1.202336401, 1.252503888, 1.305484802, 1.361457463, --25
			1.420612790, 1.483155268, 1.549303993, 1.619293801, 1.693376492, --30
			1.771822158, 1.854920617, 1.942982973, 2.036343305, 2.135360499, --35
			2.240420235, 2.351937152, 2.470357188, 2.596160128, 2.729862374, --40
			2.872019957, 3.023231808, 3.184143321, 3.355450232, 3.537902838, --45
			3.732310599, 3.939547145, 4.160555740, 4.396355237, 4.648046574, --50
			4.942868120, 5.256389940, 5.589798176, 5.944354206, 6.321399417, --55
			6.722360276, 7.148753734, 7.602192957, 8.084393436, 9.722391324, --60
			11.14393400, 12.77332508, 14.64095478, 16.78165672, 19.23535771, --65
			22.04782236, 25.27150667, 28.96653642, 33.20182857, 49.99865305, --70
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

local masteryamt, critamt, hasteamt, versinamt, versoutamt, leechamt, avoidamt, speedamt, cvlevel, gem1, gem2, gem3;

--Here is the function where the stats are pulled from the item that is currently moused over
local function getItemIdFromTooltip(self)
	
	--Determine Mastery Coefficient
	masterycf = select(2,GetMasteryEffect())
		
	--Set Player level
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

	local itemGuid = self:GetTooltipData()["guid"]
	local itemLink = nil

	if itemGuid == nil then
		itemLink = self:GetTooltipData()["hyperlink"]
	else
		itemLink = C_Item.GetItemLinkByGUID(itemGuid)
	end
	
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
		if line == nil then
			return
		end
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
		if line == nil then
			return
		end
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
		if line == nil then
			return
		end
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
		if line == nil then
			return
		end
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
		if line == nil then
			return
		end
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
		if line == nil then
			return
		end
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
		if line == nil then
			return
		end
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

--Function for getting gem info
--This method successfully gets the itemid of the gems that are equipped, what to do from there ..... ??????
--[[local function getgeminfo(self)
	local itemGuid = self:GetTooltipData()["guid"]
	local itemLink = nil

	if itemGuid == nil then
		itemLink = self:GetTooltipData()["hyperlink"]
	else
		itemLink = C_Item.GetItemLinkByGUID(itemGuid)
	end
	
	if(itemLink == nil) then
     		return;
	end
	
	local _, itemID, enchantID, gem1, gem2, gem3, gem4 = strsplit(":", strmatch(itemLink, "|H(.-)|h"))
	
	--This gives me a table of the data used to genereate the tooltip for the gem
	local gem1info = C_Tooltipinfo.GetItemByID(gem1)
	
end
]]

local function OnPlayerEnteringWorld(self, event)
	--Hooks to make the addon function
	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, getItemIdFromTooltip)
	--TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, getgeminfo)
	--Set the info in the dropdown menu to the values from the saved variables so that it shows the currently selected color when logging in
	hexcolor = string.format("|cff%02x%02x%02x", cvred*255, cvgreen*255, cvblue*255)
	UIDropDownMenu_SetText(cvrdropdown, "Current Color: " .. hexcolor .. cvcolor)
	--TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, getgeminfo)
end

--Create a frame to register the PLAYER_ENTERING_WORLD event to securly hook the tooltip's after everything is loaded 
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", OnPlayerEnteringWorld)

--Old Hooks saved for reference
--[[GameTooltip:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
ItemRefTooltip:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
ShoppingTooltip1:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
ShoppingTooltip2:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
GameTooltip.ItemTooltip.Tooltip:HookScript("OnTooltipSetItem", getItemIdFromTooltip);
]]
