-- Define a table to list all the different spec mastery coefficents
local masterytab = {1.5,1.5,2.25,1,0.75,2,2,0.5,0.6,2.25,0.625,0.5,1.2,0.75,2.25,1,10,1.25,1.5,1,1.5,1.5,1.25,2.5,4,2.2,2.76,2.25,2,3,3.125,1.8,3,2,1.4,1.5}

-- Assign each class and spec combo the table index number from the mastery table
-- The class name is the english name from the UnitClass pull and the number is the spec id returned from the GetSpecializationInfo call on the player's current spec
local DEATHKNIGHT250 = 1
local DEATHKNIGHT251 = 2
local DEATHKNIGHT252 = 3
local DEMONHUNTER577 = 4
local DEMONHUNTER581 = 5
local DRUID102 = 6
local DRUID103 = 7
local DRUID104 = 8
local DRUID105 = 9
local HUNTER253 = 10
local HUNTER254 = 11
local HUNTER255 = 12
local MAGE62 = 13
local MAGE63 = 14
local MAGE64 = 15
local MONK268 = 16
local MONK269 = 17
local MONK270 = 18
local PALADIN65 = 19
local PALADIN66 = 20
local PALADIN70 = 21
local PRIEST256 = 22
local PRIEST257 = 23
local PRIEST258 = 24
local ROGUE259 = 25
local ROGUE260 = 26
local ROGUE261 = 27
local SHAMAN262 = 28
local SHAMAN263 = 29
local SHAMAN264 = 30
local WARLOCK265 = 31
local WARLOCK266 = 32
local WARLOCK267 = 33
local WARRIOR71 = 34
local WARRIOR72 = 35
local WARRIOR73 = 36

--These are the amounts of each rating for 1 percent for each rating
--The mastery amount is the base rating amount before the coefficent is applied
local critamt = 350
local hasteamt = 325
local versinamt = 400
local versoutamt = 800
local masteryamt = 350

--Get Current Player Spec
--These calls will have to be set to call upon login and when a spec change is detected
--This call pulls the spec number for that particular class will only return 1 2 3 or 4
local specn = GetSpecialization()

--This call pulls the specific info from the spec number that the player currently is using, item 1 from the call is the unique spec number
local specid = select(1,GetSpecializationInfo(specn))

--turn the integer that is returned from the last call to a string so that it can be properly concatenated with the class name
tostring(specn)

--Get Current Player Class
--This should only need to be run on login, item 2 from the call is the english name for the spec, this should be used to avoid having localization issues in non english clients
local classn = select(2,UnitClass("player"))

--Concatenate class and specid for mastery coefficent lookup
local masterycs = classn .. specid

--Pull the coeff from the mastery table using the class name and spec id
local masterycf = masterytab[masterycs]

--Attempt to pull itemid from mouseover
--Would need to be called when a tooltip is shown

-- No goddam idea on how to actually do this


--populate item stats table using item ID

-- Ideally the itemid would be stored in a variable that we can use in this next pull I set it to iid for now

local stats = GetItemStats(iid)

--pull individual stats from stats table

local rawmastery = stats["ITEM_MOD_MASTERY_RATING_SHORT"]
local rawcrit = stats["ITEM_MOD_CRIT_RATING_SHORT"]
local rawhaste = stats["ITEM_MOD_HASTE_RATING_SHORT"]
local rawvers = stats["ITEM_MOD_VERSATILITY"]
--I did not include leech, avoidance and speed, because they aren't that important

--convert raw stats into percentages so long as they exist else assign a zero
if rawcrit ~= 0
   then
       local pcrit = rawcrit / critamt
   else
       local pcrit = 0
   end

if rawhaste ~= 0
   then
       local phaste = rawhaste / hasteamt
   else
       local phaste = 0
   end

if rawvers ~= 0
   then
       local pversin = rawvers / versinamt
       local pversout = rawvers / versoutamt
   else
       local pversin = 0
       local pversout = 0
   end

if rawmastery ~= 0
   then
       local pmastery = (rawmastery / masteryamt) * masterycf
   else
       local pmastery = 0
   end

--As I have no idea on how to put the values into the tooltip, the lines below should output the converted stats to the chat frame, this obviously is not really how it should be handled
--Ideally they would be added to the existing tooltip, or maybe a little additional tooltip that is anchored to the main one
DEFAULT_CHAT_FRAME:AddMessage(pcrit .. "% Crit")
DEFAULT_CHAT_FRAME:AddMessage(phaste .. "% Haste")
DEFAULT_CHAT_FRAME:AddMessage(pversin .. "% Versatility Damage")
DEFAULT_CHAT_FRAME:AddMessage(pversout .. "% Versatility Reduction")
DEFAULT_CHAT_FRAME:AddMessage(pmastery .. "% Mastery")