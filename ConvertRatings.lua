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

masterytab = {2.974847787, 2.974847787,	2.974847787, 2.974847787, 2.974847787, 2.974847787, 2.974847787, 2.974847787, 2.974847787, 2.974847787, 2.974847787, 2.974847787, 2.974847787, 2.974847787, 2.974847787, 2.974847787, 3.093841699, 3.21283561, 3.331829522, 3.450823433, 3.569817345, 3.688811256, 3.807805168,	3.926799079, 4.045792991, 4.164786902, 4.283780814, 4.402774725, 4.521768637, 4.640762548, 4.75975646, 4.878750371, 4.997744282, 5.116738194, 5.235732105, 5.354726017,	5.473719928, 5.59271384, 5.711707751, 5.830701663, 5.949695574,	6.068689486, 6.187683397, 6.306677309, 6.42567122, 6.546535779,	6.669673757, 6.795127915, 6.922941822, 7.053159861,7.185827255, 7.320990075, 7.458695259, 7.598990627, 7.741924901, 7.887547717, 8.035909646, 8.187062209, 8.341057897,	8.497950189, 8.609541531, 8.723231866, 8.839060675, 8.957068182, 9.077295368, 9.199783984, 9.324576567,	9.451716453, 9.581247795, 9.713215574, 9.84766562, 9.984644623,	10.12420015, 10.26638067, 10.41123555, 10.5588151, 10.70917057,	10.86235417, 11.0184191, 11.17741955, 11.33941075, 11.50444894,	11.67259144, 11.84389663, 12.01842402, 12.19623421, 12.37738894, 12.56195113, 12.74998486, 12.94155544, 13.1367294, 13.3355745,	13.53815981, 13.74455568, 13.95483378, 14.16906714, 14.38733014, 14.6096986, 14.83624973, 15.0670622, 15.30221617, 15.5417933, 15.78587679, 16.0345514,	16.2879035, 16.54602105, 16.80899371, 17.07691278, 17.34987131,	17.62282985, 20.20451199, 23.16440142, 26.55790416, 30.44854303, 34.90914671, 40.02321302, 45.88647194,	52.60867751, 60.31566238, 72}
crittab = { 2.974847787, 2.974847787, 2.974847787 ,2.974847787 ,2.974847787, 2.974847787, 2.974847787, 2.974847787, 2.974847787, 2.974847787, 2.974847787, 2.974847787,	2.974847787, 2.974847787, 2.974847787, 2.974847787, 3.093841699, 3.21283561, 3.331829522, 3.450823433, 3.569817345, 3.688811256, 3.807805168, 3.926799079, 4.045792991, 4.164786902, 4.283780814, 4.402774725, 4.521768637, 4.640762548, 4.75975646, 4.878750371, 4.997744282, 5.116738194, 5.235732105, 5.354726017, 5.473719928, 5.59271384, 5.711707751, 5.830701663, 5.949695574, 6.068689486, 6.187683397,	6.306677309, 6.42567122, 6.546535779, 6.669673757, 6.795127915,	6.922941822, 7.053159861, 7.185827255, 7.320990075, 7.458695259, 7.598990627, 7.741924901, 7.887547717,	8.035909646, 8.187062209, 8.341057897, 8.497950189, 8.609541531, 8.723231866, 8.839060675, 8.957068182,	9.077295368, 9.199783984, 9.324576567, 9.451716453, 9.581247795, 9.713215574, 9.84766562, 9.984644623, 10.12420015, 10.26638067, 10.41123555, 10.5588151, 10.70917057, 10.86235417, 11.0184191,	11.17741955, 11.33941075, 11.50444894, 11.67259144, 11.84389663, 12.01842402, 12.19623421, 12.37738894,	12.56195113, 12.74998486, 12.94155544, 13.1367294, 13.3355745, 13.53815981, 13.74455568, 13.95483378, 14.16906714, 14.38733014,	14.6096986, 14.83624973, 15.0670622, 15.30221617, 15.5417933, 15.78587679, 16.0345514, 16.2879035, 16.54602105,	16.80899371, 17.07691278, 17.34987131, 17.62282985, 20.20451199, 23.16440142, 26.55790416, 30.44854303,	34.90914671, 40.02321302, 45.88647194, 52.60867751, 60.31566238, 72}
hastetab = {2.809578466, 2.809578466, 2.809578466, 2.809578466,	2.809578466, 2.809578466, 2.809578466, 2.809578466, 2.809578466, 2.809578466, 2.809578466, 2.809578466,	2.809578466, 2.809578466, 2.809578466, 2.809578466, 2.921961604, 3.034344743, 3.146727882, 3.25911102, 3.371494159, 3.483877297, 3.596260436, 3.708643575, 3.821026713, 3.933409852, 4.045792991, 4.158176129, 4.270559268, 4.382942406, 4.495325545, 4.607708684, 4.720091822,	4.832474961, 4.9448581, 5.057241238, 5.169624377, 5.282007515, 5.394390654, 5.506773793, 5.619156931, 5.73154007, 5.843923209, 5.956306347, 6.068689486, 6.182839347, 6.299136326, 6.417620809,	6.538333943, 6.661317647, 6.78661463, 6.914268404, 7.0443233, 7.176824481, 7.311817962, 7.449350622, 7.589470221, 7.73222542, 7.877665792, 8.025841845, 8.131233668, 8.238607873, 8.348001749, 8.459453283, 8.573001181, 8.688684874, 8.806544536, 8.926621095,	9.048956251, 9.173592487, 9.300573086, 9.429942144, 9.561744587, 9.696026187, 9.832833576, 9.972214262,	10.11421665, 10.25889005, 10.4062847, 10.5564518, 10.70944348, 10.86531288, 11.02411413, 11.18590238, 11.3507338, 11.51866564, 11.68975622, 11.86406495, 12.04165237, 12.22258014, 12.4069111, 12.59470925, 12.78603982, 12.98096926, 13.17956524, 13.38189674,	13.58803402, 13.79804868, 14.01201363, 14.23000319, 14.45209305, 14.67836034, 14.90888363, 15.14374299,	15.38301997, 15.62679766, 15.87516072, 16.1281954, 16.38598958, 16.64378375, 19.0820391, 21.87749023, 25.08246504, 28.7569573, 32.96974967, 37.79970119, 43.33722349, 49.6859732, 56.96479225, 68}
verstab = {3.511973082,	3.511973082, 3.511973082, 3.511973082, 3.511973082, 3.511973082, 3.511973082, 3.511973082, 3.511973082,	3.511973082, 3.511973082, 3.511973082, 3.511973082, 3.511973082, 3.511973082, 3.511973082, 3.652452005,	3.792930929, 3.933409852, 4.073888775, 4.214367699, 4.354846622, 4.495325545, 4.635804468, 4.776283392, 4.916762315, 5.057241238, 5.197720162, 5.338199085, 5.478678008, 5.619156931, 5.759635855, 5.900114778,	6.040593701, 6.181072625, 6.321551548, 6.462030471, 6.602509394, 6.742988318, 6.883467241, 7.023946164,	7.164425088, 7.304904011, 7.445382934, 7.585861857, 7.728549184, 7.873920407, 8.022026011, 8.172917428, 8.326647058, 8.483268287, 8.642835505, 8.805404125, 8.971030602, 9.139772453, 9.311688277, 9.486837776,	9.665281774, 9.84708224, 10.03230231, 10.16404209, 10.29825984,	10.43500219, 10.5743166, 10.71625148,10.86085609, 11.00818067, 11.15827637, 11.31119531, 11.46699061, 11.62571636, 11.78742768,	11.95218073, 12.12003273, 12.29104197, 12.46526783, 12.64277081, 12.82361256, 13.00785588, 13.19556475, 13.38680435, 13.5816411, 13.78014267, 13.98237797, 14.18841725, 14.39833205, 14.61219528, 14.83008119, 15.05206546, 15.27822517, 15.50863887, 15.74338657, 15.98254978,	16.22621157, 16.47445655, 16.72737092, 16.98504253, 17.24756085, 17.51501704, 17.78750398, 18.06511631,	18.34795042, 18.63610454, 18.92967874, 19.22877496, 19.53349708, 19.8439509, 20.16024425, 20.48248697, 20.80472968, 23.85254888, 27.34686278, 31.35308129, 35.94619663,	41.21218708, 47.24962648, 54.17152937, 62.1074665, 71.20599031,	85}
leechtab = {1.652693215, 1.652693215, 1.652693215, 1.652693215,	1.652693215, 1.652693215, 1.652693215, 1.652693215, 1.652693215, 1.652693215, 1.652693215, 1.652693215,	1.652693215, 1.652693215, 1.652693215, 1.652693215, 1.718800944, 1.784908672, 1.851016401, 1.91712413, 1.983231858, 2.049339587, 2.115447315, 2.181555044, 2.247662773, 2.313770501, 2.37987823, 2.445985958, 2.512093687, 2.578201416, 2.644309144, 2.710416873, 2.776524601, 2.84263233, 2.908740059, 2.974847787, 3.040955516, 3.107063244, 3.173170973, 3.239278702, 3.30538643, 3.371494159, 3.437601887, 3.503709616, 3.569817345, 3.636964322, 3.705374309, 3.775071064, 3.84607879, 3.918422145, 3.992126253, 4.067216708, 4.143719588,	4.22166146, 4.30106939, 4.381970954, 4.464394248, 4.548367894, 4.633921054, 4.721083438, 4.783078628, 4.846239926, 4.910589264,	4.97614899, 5.042941871, 5.110991102, 5.180320315, 5.250953585,	5.322915442, 5.396230875, 5.470925345, 5.547024791, 5.62455564,	5.703544816, 5.78401975, 5.866008389, 5.949539205, 6.034641205,	6.121343943, 6.209677528, 6.299672636, 6.39136052, 6.48477302, 6.579942575, 6.676902235, 6.775685671, 6.876327189, 6.978861737,	7.083324922, 7.189753023, 7.298182998, 7.408652502, 7.521199897, 7.635864268, 7.752685434, 7.871703965,	7.992961191, 8.116499222, 8.242360958, 8.370590109, 8.501231204, 8.63432961, 8.76993155, 8.908084113, 9.048835276, 9.192233918,	9.338329836, 9.487173767, 9.638817397, 9.790461028, 11.22472888, 12.8691119, 14.7543912, 16.91585724, 19.39397039, 22.23511835,	25.49248441, 29.22704306, 33.50870132, 40}
avoidtab = {1.156885251, 1.156885251, 1.156885251, 1.156885251,	1.156885251, 1.156885251, 1.156885251, 1.156885251, 1.156885251, 1.156885251, 1.156885251, 1.156885251,	1.156885251, 1.156885251, 1.156885251, 1.156885251, 1.203160661, 1.249436071, 1.295711481, 1.341986891, 1.388262301, 1.434537711, 1.480813121, 1.527088531, 1.573363941, 1.619639351, 1.665914761, 1.712190171,	1.758465581, 1.804740991, 1.851016401, 1.897291811, 1.943567221, 1.989842631, 2.036118041, 2.082393451,	2.128668861, 2.174944271, 2.221219681, 2.267495091, 2.313770501, 2.360045911, 2.406321321, 2.452596731,	2.498872141, 2.545875025, 2.593762017, 2.642549745, 2.692255153, 2.742895502, 2.794488377, 2.847051696,	2.900603712, 2.955163022, 3.010748573, 3.067379668, 3.125075973, 3.183857526, 3.243744738, 3.304758407, 3.34815504, 3.392367948, 3.437412485, 3.483304293, 3.53005931, 3.577693772, 3.626224221, 3.67566751, 3.726040809, 3.777361612, 3.829647741, 3.882917353, 3.937188948, 3.992481371, 4.048813825, 4.106205872, 4.164677443, 4.224248843, 4.28494076, 4.34677427, 4.409770845, 4.473952364, 4.539341114, 4.605959802, 4.673831565, 4.74297997, 4.813429032, 4.885203216, 4.958327446, 5.032827116, 5.108728099, 5.186056751, 5.264839928, 5.345104987, 5.426879804, 5.510192775, 5.595072834, 5.681549455, 5.769652671, 5.859413076, 5.950861843, 6.044030727, 6.138952085, 6.235658879, 6.334184693, 6.434563743,	6.536830886, 6.641021637, 6.747172178, 6.85332272, 7.857310218, 9.008378328, 10.32807384, 11.84110007, 13.57577927, 15.56458284, 17.84473909, 20.45893014, 23.45609093, 28}
speedtab = {0.826346608, 0.826346608, 0.826346608, 0.826346608, 0.826346608, 0.826346608, 0.826346608, 0.826346608, 0.826346608, 0.826346608, 0.826346608, 0.826346608,	0.826346608, 0.826346608, 0.826346608, 0.826346608, 0.859400472, 0.892454336, 0.9255082, 0.958562065, 0.991615929, 1.024669793,	1.057723658, 1.090777522, 1.123831386, 1.156885251, 1.189939115, 1.222992979, 1.256046843, 1.289100708, 1.322154572, 1.355208436, 1.388262301, 1.421316165, 1.454370029, 1.487423894, 1.520477758, 1.553531622,	1.586585487, 1.619639351, 1.652693215, 1.685747079, 1.718800944, 1.751854808, 1.784908672, 1.818482161,	1.852687155, 1.887535532, 1.923039395, 1.959211073, 1.996063126, 2.033608354, 2.071859794, 2.11083073, 2.150534695, 2.190985477, 2.232197124, 2.274183947, 2.316960527,	2.360541719, 2.391539314, 2.423119963, 2.455294632, 2.488074495, 2.521470936, 2.555495551, 2.590160158,	2.625476793, 2.661457721, 2.698115437, 2.735462672, 2.773512395, 2.81227782, 2.851772408, 2.892009875, 2.933004195, 2.974769602, 3.017320602, 3.060671971, 3.104838764, 3.149836318, 3.19568026, 3.24238651, 3.289971287, 3.338451118, 3.387842836, 3.438163594, 3.489430868, 3.541662461, 3.594876512, 3.649091499, 3.704326251, 3.760599948, 3.817932134, 3.876342717, 3.935851982, 3.996480595, 4.058249611,	4.121180479, 4.185295055, 4.250615602, 4.317164805, 4.384965775, 4.454042057, 4.524417638, 4.596116959,	4.669164918, 4.743586883, 4.819408699, 4.895230514, 5.612364441, 6.434555949, 7.377195599, 8.457928618,	9.696985196, 11.11755917, 12.7462422, 14.61352153, 16.75435066,	20}

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
	
	--Get Item rarity :M
	local irare = select(3,GetItemInfo(itemLink))
	--Artifact specific processing :L
	if irare == 6 then
		for i=1, self:NumLines() do
			--Checks if the line contains a statname in its text - then gets the number of that text :L
			if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_CRIT_RATING_SHORT"])) then
				rawcrit = string.match(_G[self:GetName().."TextLeft"..i]:GetText(), "%d+%,?%.?%s?%d*");
				if rawcrit == nil then
					break;
				else
					rawcrit = rawcrit:gsub("%p", '')
				end
			elseif(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_HASTE_RATING_SHORT"])) then
				rawhaste = string.match(_G[self:GetName().."TextLeft"..i]:GetText(), "%d+%,?%.?%s?%d*");
				if rawhaste == nil then
					break;
				else
					rawhaste = rawhaste:gsub("%p", '')
				end
			elseif(string.find(_G[self:GetName() .. "TextLeft"..i]:GetText(), _G["ITEM_MOD_MASTERY_RATING_SHORT"])) then
				rawmastery = string.match(_G[self:GetName().."TextLeft"..i]:GetText(), "%d+%,?%.?%s?%d*");
				if rawmastery == nil then
					break;
				else
					rawmastery = rawmastery:gsub("%p", '')
				end
			elseif(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_VERSATILITY"])) then
				rawvers = string.match(_G[self:GetName().."TextLeft"..i]:GetText(), "%d+%,?%.?%s?%d*");
				if rawvers == nil then
					break;
				else
					rawvers = rawvers:gsub("%p", '')
				end
			elseif(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_CR_LIFESTEAL_SHORT"])) then
				rawleech = string.match(_G[self:GetName().."TextLeft"..i]:GetText(), "%d+%,?%.?%s?%d*");
				if rawleech == nil then
					break;
				else
					rawleech = rawleech:gsub("%p", '')
				end
			elseif(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_CR_AVOIDANCE_SHORT"])) then
				rawavoid = string.match(_G[self:GetName().."TextLeft"..i]:GetText(), "%d+%,?%.?%s?%d*");
				if rawavoid == nil then
					break;
				else
					rawavoid = rawavoid:gsub("%p", '')
				end
			elseif(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ITEM_MOD_CR_SPEED_SHORT"])) then
				rawspeed = string.match(_G[self:GetName().."TextLeft"..i]:GetText(), "%d+%,?%.?%s?%d*");
				if rawspeed == nil then
					break;
				else
					rawspeed = rawspeed:gsub("%p", '')
				end
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
