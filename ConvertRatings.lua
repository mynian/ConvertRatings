-- Define a table to list all the different spec mastery coefficents
masterytab = {}

-- Populate the table with mastery coefficents
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

--These are the amounts of each rating for 1 percent for each rating
--The mastery amount is the base rating amount before the coefficent is applied
critamt = 350
hasteamt = 325
versinamt = 400
versoutamt = 800
masteryamt = 350

--CHANGES:Lanrutcon:Create a start-up function - This is needed because some WoW API is only available after some events.
--Gnor: I moved this up in the addon, because i need this data stored to run before the calculations
local AddOn = CreateFrame("FRAME", "ConvertRatings");
AddOn:SetScript("OnEvent", function(self, event, ...)
    
    if(event == "PLAYER_ENTERING_WORLD") then
        --Getting Player Information
    
        --Get Current Player Spec
        local specn = GetSpecialization()

        --This call pulls the specific info from the spec number that the player currently is using, item 1 from the call is the unique spec number
        local specid = select(1,GetSpecializationInfo(specn))

        --turn the integer that is returned from the last call to a string so that it can be properly concatenated with the class name
        tostring(specid)

        --Get Current Player Class
        local classn = select(2,UnitClass("player"))

        --Concatenate class and specid for mastery coefficent lookup
        local masterycs = classn .. specid

        --Pull the coeff from the mastery table using the class name and spec id
        masterycf = masterytab[masterycs]
    end

end);

AddOn:RegisterEvent("PLAYER_ENTERING_WORLD");


--CHANGES:Lanrutcon:New function for GameTooltip's "OnTooltipSetItem"
local function getItemIdFromTooltip(self)
    local name, itemLink = self:GetItem();
    
    --Gets stats from item using itemLink - it's a table
    stats = GetItemStats(itemLink);

    --Gnor: pull individual stats from stats table since the way that it was being accomplished wouldn't allow for calculations to be done
    local rawmastery = stats["ITEM_MOD_MASTERY_RATING_SHORT"]
    local rawcrit = stats["ITEM_MOD_CRIT_RATING_SHORT"]
    local rawhaste = stats["ITEM_MOD_HASTE_RATING_SHORT"]
    local rawvers = stats["ITEM_MOD_VERSATILITY"]

    --convert raw stats into percentages so long as they are not nil
    --This seems to work, as I am not getting any error output
if rawcrit ~= nil
   then
       local pcrit = rawcrit / critamt
   else
   end

if rawhaste ~= nil
   then
       local phaste = rawhaste / hasteamt
   else
   end

if rawvers ~= nil
   then
       local pversin = rawvers / versinamt
       local pversout = rawvers / versoutamt
   else
   end

if rawmastery ~= nil
   then
       local pmastery = (rawmastery / masteryamt) * masterycf
   else
   end

--Convert percentages to strings
tostring(pcrit)
tostring(phaste)
tostring(pversin)
tostring(pversout)
tostring(pmastery)

--Send the converted stats to the tooltip if they are not nil
--This does not work atm
--temp see if they output to chat ... nope must be missing something

if pcrit ~= nil
   then
      GameTooltip:AddLine(pcrit .. "% Crit")
   else
   end

 if phaste ~= nil
   then
       GameTooltip:AddLine(phaste .. "% Haste")
   else
   end

 if pmastery ~= nil
   then
       GameTooltip:AddLine(pmastery .. "% Mastery")
   else
   end

if pversin ~= nil
   then
      GameTooltip:AddLine(pversin .. "%/" .. pversout .. "% Versatility")
   else
   end
end
GameTooltip:HookScript("OnTooltipSetItem", getItemIdFromTooltip);