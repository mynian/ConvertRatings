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
	["lightblue"] = {0, 1, 1},
	["lightred"] = {1, .5, .5},
	["pink"] = {1, .5, 1},
	["purple"] = {.7, 0, 1},
	["orange"] = {1, .5, 0},
	["default"] = {1, .996, .545}
}

--[[Color Picker
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
--]]

--[[Create a Frame to add to the default options panel
local cvrpanel = CreateFrame("Frame")
cvrpanel.name = "Convert Ratings"
--]]

--[[Options Panel Title
local cvropttitle = cvrpanel:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
cvropttitle:SetPoint("TOP")
cvropttitle:SetText("Convert Ratings")
--]]

--[[Add title text to the options menu for the dropdown menu
local cvrddtitle = cvrpanel:CreateFontString("ARTWORK", nil, "GameFontNormal")
cvrddtitle:SetPoint("TOPLEFT", cvrpanel, 0, - 80)
cvrddtitle:SetText("Pick a Color")
--]]

--[[Create the dropdown menu frame
local cvrdropdown = CreateFrame("Frame", "CVRDropDown", cvrpanel, "UIDropDownMenuTemplate")
cvrdropdown:SetPoint("TOPLEFT", cvrpanel, -20, -100)
UIDropDownMenu_SetWidth(cvrdropdown, 150)
--]]

--[[Function to set the color of the addon, update the text in the dropdown menu and update the savedvariable for the menu to display the chosen color between sessions
local function cvrdropdown_OnClick(self, arg1, arg2, checked)
	cvred, cvgreen, cvblue = unpack(colorTable[string.lower(arg1)])
	hexcolor = string.format("|cff%02x%02x%02x", cvred*255, cvgreen*255, cvblue*255)
	UIDropDownMenu_SetText(cvrdropdown, "Current Color: " .. hexcolor .. arg1)
	cvcolor = tostring(arg1)
end
--]]

--[[Code for the dropdown menu
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
--]]

--[[Function to initialize the dropdown menu
UIDropDownMenu_Initialize(cvrdropdown, cvrdropdown_Menu)
--]]

--[[Add title text in the options menu for a button to open up the color picker for the user to choose a custom color
local cvrddtitle = cvrpanel:CreateFontString("ARTWORK", nil, "GameFontNormal")
cvrddtitle:SetPoint("TOPLEFT", cvrpanel, 0, -20)
cvrddtitle:SetText("Choose a Custom Color")
--]]

--[[Create the button for the color picker in the options menu
local cvrbutton = CreateFrame("Button", nil, cvrpanel, "UIPanelButtonTemplate")
cvrbutton:SetPoint("TOPLEFT", cvrpanel, 0, -40)
cvrbutton:SetText("Color Wheel")
cvrbutton:SetWidth(150)
cvrbutton:HookScript("OnClick", function() ShowColorPicker(cvred, cvgreen, cvblue, nil, myColorCallback); cvcolor = "Custom"; UIDropDownMenu_SetText(cvrdropdown, "Current Color: "  .. cvcolor)  end)
--]]

--Add our panel to the options frame	
--InterfaceOptions_AddCategory(cvrpanel)

--Slash Command to change the color of the output 
SLASH_CONVERTRATINGS1, SLASH_CONVERTRATINGS2 = '/convertratings', '/cvr';
function SlashCmdList.CONVERTRATINGS(msg, editBox)
	--Grab the first input word as the command and the rest of the input as a user variable 
	local command, rest = msg:match("^(%S*)%s*(.-)$");
	--Hard coded color options parsing 	
	if (colorTable[string.lower(command)]) then
		cvred, cvgreen, cvblue = unpack(colorTable[string.lower(command)]);
		--UIDropDownMenu_SetText(cvrdropdown, "Current Color: " .. command);
		print("Convert Ratings output color set to "..string.lower(command));
	--elseif string.lower(command) == 'custom' and rest == "" then
		--ShowColorPicker(cvred, cvgreen, cvblue, nil, myColorCallback);
	else
		--when no valid args entered, open the options panel
		--InterfaceOptionsFrame_OpenToCategory(cvrpanel.name)
		print("Options Table temporarily disabled due to 11.0 updates")
		print("You can set the color via slash command to one of the hard coded colors red, blue, green, black, white, light blue, light red, pink, orange, default or custom to use the color picker frame")
	end
end

--equipment slot table
local invtable = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 16, 17, 16, 15, 16, 0, 0, 5, 16, 17, 17, 0, 0, 16, 0, 0}

--rating tables to allow addon to work at all levels 
masterytab = { 
			3.126767800, 3.126767800, 3.126767800, 3.126767800, 3.126767800, --5
			3.126767800, 3.126767800, 3.126767800, 3.126767800, 3.126767800, --10
			3.126767800, 3.283106190, 3.439444580, 3.595782970, 3.752121360, --15
			3.908459750, 4.064798140, 4.221136529, 4.377474919, 4.533813309, --20
			4.723916102, 4.931107062, 5.156902454, 5.402989839, 5.671248285, --25
			5.963771271, 6.282892672, 6.631216242, 7.011649117, 7.427439910, --30
			7.882222056, 8.380063201, 8.925521515, 9.523709967, 10.18036977, --35
			10.90195438, 11.69572568, 12.56986421, 13.53359570, 14.59733632, --40
			15.77285982, 17.07348984, 18.51432165, 20.11247789, 21.88740407, --45
			23.86121016, 26.05906623, 28.50966082, 31.24573297, 34.30469023, --50
			37.72932745, 41.56866382, 45.87891857, 50.72464994, 56.18008605, --55
			62.33068187, 69.27494313, 77.12656519, 86.01694436, 96.09813024, --60
			101.5028672, 107.2115765, 113.2413543, 119.6102579, 126.3373604, --65
			133.4428077, 140.9478785, 148.8750484, 157.2480570, 185.2999937, --70
			207.0033105, 231.2486346, 258.3336995, 288.5911108, 322.3924302, --75
			360.1527393, 402.3357357, 449.4594281, 502.1024970, 700.0000000, --80
			}

crittab = { 
			3.126767800, 3.126767800, 3.126767800, 3.126767800, 3.126767800, --5
			3.126767800, 3.126767800, 3.126767800, 3.126767800, 3.126767800, --10
			3.126767800, 3.283106190, 3.439444580, 3.595782970, 3.752121360, --15
			3.908459750, 4.064798140, 4.221136529, 4.377474919,	4.533813309, --20
			4.723916102, 4.931107062, 5.156902454, 5.402989839, 5.671248285, --25
			5.963771271, 6.282892672, 6.631216242, 7.011649117, 7.427439910, --30
			7.882222056, 8.380063201, 8.925521515, 9.523709967, 10.18036977, --35
			10.90195438, 11.69572568, 12.56986421, 13.53359570, 14.59733632, --40
			15.77285982, 17.07348984, 18.51432165, 20.11247789, 21.88740407, --45
			23.86121016, 26.05906623, 28.50966082, 31.24573297, 34.30469023, --50
			37.72932745, 41.56866382, 45.87891857, 50.72464994, 56.18008605, --55
			62.33068187, 69.27494313, 77.12656519, 86.01694436, 96.09813024, --60
			101.5028672, 107.2115765, 113.2413543, 119.6102579, 126.3373604, --65
			133.4428077, 140.9478785, 148.8750484, 157.2480570, 185.2999937, --70
			207.0033105, 231.2486346, 258.3336995, 288.5911108, 322.3924302, --75
			360.1527393, 402.3357357, 449.4594281, 502.1024970, 700.0000000, --80
			}

hastetab = {
			2.948095354, 2.948095354, 2.948095354, 2.948095354, 2.948095354, --5
			2.948095354, 2.948095354, 2.948095354, 2.948095354, 2.948095354, --10
			2.948095354, 3.095500122, 3.242904889, 3.390309657, 3.537714425, --15
			3.685119192, 3.832523960, 3.979928728, 4.127333496, 4.274738263, --20
			4.453978039, 4.649329515, 4.862222314, 5.094247563, 5.347176954, --25
			5.622984341, 5.923870234, 6.252289599, 6.610983454, 7.003014772, --30
			7.431809367, 7.901202447, 8.415491714, 8.979497968, 9.598634353, --35
			10.27898556, 11.02739849, 11.85158626, 12.76024738, 13.76320282, --40
			14.87155354, 16.09786185, 17.45636041, 18.96319344, 20.63669526, --45
			22.49771244, 24.56997673, 26.88053735, 29.46026251, 32.34442221, --50
			35.57336588, 39.19331160, 43.25726608, 47.82609852, 52.96979542, --55
			58.76892862, 65.31637495, 72.71933289, 81.10169039, 90.60680851, --60
			95.70270333, 101.0852007, 106.7704197, 112.7753860, 119.1180827, --65
			125.8175044, 132.8937140, 140.3679028, 148.2624537, 174.7114226, --70
			195.1745499, 218.0344269, 243.5717739, 272.1001901, 303.9700056, --75
			339.5725827, 379.3451222, 423.7760322, 473.4109257, 660.0000000, --80
			}

verstab = {
			 3.484112691, 3.484112691, 3.484112691, 3.484112691, 3.484112691, --5
			 3.484112691, 3.484112691, 3.484112691, 3.484112691, 3.484112691, --10
			 3.484112691, 3.658318326, 3.832523960, 4.006729595, 4.180935229, --15
			 4.355140864, 4.529346498, 4.703552133, 4.877757767, 5.051963402, --20
			 5.263792227, 5.494662155, 5.746262735, 6.020474392, 6.319390946, --25
			 6.645345131, 7.000937549, 7.389069526, 7.812980445, 8.276290186, --30
			 8.783047434, 9.337784710, 9.945581116, 10.61213396, 11.34384060, --35
			 12.14789202, 13.03238004, 14.00642012, 15.08029235, 16.26560333, --40
			 17.57547237, 19.02474582, 20.63024412, 22.41104679, 24.38882167, --45
			 26.58820561, 29.03724523, 31.76790777, 34.81667388, 38.22522625, --50
			 42.04125059, 46.31936825, 51.12222354, 56.52175280, 62.60066731, --55
			 69.45418837, 77.19207949, 85.94102978, 95.84745228, 107.0807737, --60
			 113.1031948, 119.4643281, 126.1832233, 133.2800016, 140.7759159, --65
			 148.6934143, 157.0562075, 165.8893396, 175.2192635, 206.4771359, --70
			 230.6608317, 257.6770500, 287.8575509, 321.5729520, 359.2372794, --75
			 401.3130523, 448.3169626, 500.8262199, 559.4856395, 780.0000000, --80
			}

leechtab = {
			4.556125589, 4.556125589, 4.556125589, 4.556125589, 4.556125589, --5
			4.556125589, 4.556125589, 4.556125589, 4.556125589, 4.556125589, --10
			4.556125589, 4.783931869, 5.011738148, 5.239544428, 5.467350707, --15
			5.695156987, 5.922963266, 6.150769545, 6.378575825, 6.606382104, --20
			6.883387706, 7.185293091, 7.514307661, 7.872890423, 8.263779433, --25
			8.690025176, 9.155028423, 9.662583199, 10.21692560, 10.82278928, --30
			11.48546867, 12.21089087, 13.00569776, 13.87733962, 14.83418219, --35
			15.88562903, 17.04226168, 18.31600031, 19.72028806, 21.27030270, --40
			22.98320017, 24.87839486, 26.97788260, 29.30661343, 31.89292206, --45
			34.76902578, 37.97160074, 41.54245007, 45.52927901, 49.98659542, --50
			54.97675724, 60.57119206, 66.85181896, 73.91270808, 81.86201984, --55
			90.82427377, 100.9430061, 112.3838864, 125.3383770, 140.0280348, --60
			147.9034710, 156.2218363, 165.0080418, 174.2883999, 184.0907025, --65
			194.4443047, 205.3802128, 216.9311765, 229.1317879, 270.0072718, --70
			301.6319536, 336.9606856, 376.4273059, 420.5164658, 469.7695816, --75
			524.7914833, 586.2578415, 654.9234651, 731.6315702, 1019.995125, --80
			}

avoidtab = {
			2.429933648, 2.429933648, 2.429933648, 2.429933648, 2.429933648, --5
			2.429933648, 2.429933648, 2.429933648, 2.429933648, 2.429933648, --10
			2.429933648, 2.551430330, 2.672927012, 2.794423695, 2.915920377, --15
			3.037417060, 3.158913742, 3.280410424, 3.401907107, 3.523403789, --20
			3.671140110, 3.832156315, 4.007630753, 4.198874892, 4.407349031, --25
			4.634680094, 4.882681826, 5.153377706, 5.449026985, 5.772154285, --30
			6.125583292, 6.512475133, 6.936372139, 7.401247800, 7.911563836, --35
			8.472335480, 9.089206227, 9.768533500, 10.51748696, 11.34416144, --40
			12.25770676, 13.26847726, 14.38820405, 15.63019383, 17.00955843, --45
			18.54348041, 20.25152039, 22.15597337, 24.28228214, 26.65951756, --50
			29.32093720, 32.30463577, 35.65430345, 39.42011098, 43.65974391, --55
			48.43961268, 53.83626993, 59.93807276, 66.84713441, 74.68161856, --60
			78.88185118, 83.31831267, 88.00428898, 92.95381328, 98.18170799, --65
			103.7036292, 109.5361135, 115.6966275, 122.2036202, 144.0038783, --70
			160.8703752, 179.7123657, 200.7612298, 224.2754484, 250.5437769, --75
			279.8887911, 312.6708488, 349.2925147, 390.2035041, 543.9974000, --80
			}

speedtab = {
			 0.759354265, 0.759354265, 0.759354265, 0.759354265, 0.759354265, --5
			 0.759354265, 0.759354265, 0.759354265, 0.759354265, 0.759354265, --10
			 0.759354265, 0.797321978, 0.835289691, 0.873257405, 0.911225118, --15
			 0.949192831, 0.987160544, 1.025128258, 1.063095971, 1.101063684, --20
			 1.147231284, 1.197548848, 1.252384610, 1.312148404, 1.377296572, --25
			 1.448337529, 1.525838070, 1.610430533, 1.702820933, 1.803798214, --30
			 1.914244779, 2.035148479, 2.167616293, 2.312889937, 2.472363699, --35
			 2.647604838, 2.840376946, 3.052666719, 3.286714676, 3.545050450, --40
			 3.830533362, 4.146399143, 4.496313767, 4.884435572, 5.315487011, --45
			 5.794837629, 6.328600123, 6.923741679, 7.588213168, 8.331099237, --50
			 9.162792874, 10.09519868, 11.14196983, 12.31878468, 13.64366997, --55
			 15.13737896, 16.82383435, 18.73064774, 20.88972950, 23.33800580, --60
			 24.65057849, 26.03697271, 27.50134031, 29.04806665, 30.68178375, --65
			 32.40738412, 34.23003546, 36.15519609, 38.18863132, 45.00121196, --70
			 50.27199227, 56.16011427, 62.73788432, 70.08607764, 78.29493027, --75
			 87.46524721, 97.70964024, 109.1539108, 121.9385950, 169.9991875, --80
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
	--hexcolor = string.format("|cff%02x%02x%02x", cvred*255, cvgreen*255, cvblue*255)
	--UIDropDownMenu_SetText(cvrdropdown, "Current Color: " .. hexcolor .. cvcolor)
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
