--[[
    =======================================================
                         Into the Brew
                             v1.5
    =======================================================
                Brewmaster Monk Rotation for PE            
    https://probablyengine.com/forum/viewtopic.php?id=189
    =======================================================
]]--

-----------------------------------------------------------------------------------------------------------------------------
-- Initialize Tables -------------------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
local intoBrew = {} 

intoBrew.queueSpell = nil
intoBrew.queueTime = 0
-----------------------------------------------------------------------------------------------------------------------------
-- Notify Frame -- (c)xrn overlay for pqr -----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
    local function onUpdate(self,elapsed) 
      if self.time < GetTime() - 2.5 then
        if self:GetAlpha() == 0 then self:Hide() else self:SetAlpha(self:GetAlpha() - .05) end
      end
    end
    itb = CreateFrame("Frame",nil,ChatFrame1) 
    itb:SetSize(ChatFrame1:GetWidth(),30)
    itb:Hide()
    itb:SetScript("OnUpdate",onUpdate)
    itb:SetPoint("TOPLEFT",0,150)
    itb.text = itb:CreateFontString(nil,"OVERLAY","MovieSubtitleFont")
    itb.text:SetAllPoints()
    itb.texture = itb:CreateTexture()
    itb.texture:SetAllPoints()
    itb.texture:SetTexture(0,0,0,.50) 
    itb.time = 0
    function itb:message(message) 
      self.text:SetText(message)
      self:SetAlpha(1)
      self.time = GetTime() 
      self:Show() 
    end
    
    local function onUpdate(self,elapsed) 
      if self.time < GetTime() - 2.8 then
        if self:GetAlpha() == 0 then self:Hide() else self:SetAlpha(self:GetAlpha() - .05) end
      end
    end
    itb = CreateFrame("Frame",nil,ChatFrame1) 
    itb:SetSize(ChatFrame1:GetWidth(),30)
    itb:Hide()
    itb:SetScript("OnUpdate",onUpdate)
    itb:SetPoint("TOP",0,0)
    itb.text = itb:CreateFontString(nil,"OVERLAY","MovieSubtitleFont")
    itb.text:SetAllPoints()
    itb.texture = itb:CreateTexture()
    itb.texture:SetAllPoints()
    itb.texture:SetTexture(0,0,0,.50) 
    itb.time = 0
    function itb:message(message) 
      self.text:SetText(message)
      self:SetAlpha(1)
      self.time = GetTime() 
      self:Show() 
    end
-----------------------------------------------------------------------------------------------------------------------------
-- Macros ------------------------------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
ProbablyEngine.command.register('into', function(msg, box)
  local command, text = msg:match("^(%S*)%s*(.-)$")
-- Toggle -------------------------------------------------------------------------------------------------------------------
  if command == 'toggle' then
    if ProbablyEngine.toggle.states.MasterToggle then
        --ProbablyEngine.buttons.toggle('MasterToggle')
        ProbablyEngine.buttons.buttons['MasterToggle']:Click()
        itb:message("|cFFB30000Into the Brew off")
    else
        --ProbablyEngine.buttons.toggle('MasterToggle')
        ProbablyEngine.buttons.buttons['MasterToggle']:Click()
        itb:message("|cFF00B34AInto the Brew on")
    end
  end
  if command == 'kick' then
    if ProbablyEngine.toggle.states.interrupt then
      --ProbablyEngine.buttons.toggle('interrupt')
      ProbablyEngine.buttons.buttons['interrupt']:Click()
      itb:message("|cFFB30000Interrupts off")
    else
      --ProbablyEngine.buttons.toggle('interrupt')
      ProbablyEngine.buttons.buttons['interrupt']:Click()
      itb:message("|cFF00B34AInterrupts on")
    end
  end

  if command == 'xuen' then
    if ProbablyEngine.toggle.states.cooldowns then
      --ProbablyEngine.buttons.toggle('cooldowns')
      ProbablyEngine.buttons.buttons['cooldowns']:Click()
      itb:message("|cFFB30000Xuen off")
    else
      --ProbablyEngine.buttons.toggle('cooldowns')
      ProbablyEngine.buttons.buttons['cooldowns']:Click()
      itb:message("|cFF00B34AXuen on")
    end
  end

  if command == 'aoe' then
    if ProbablyEngine.toggle.states.multitarget then
      --ProbablyEngine.buttons.toggle('multitarget')
      ProbablyEngine.buttons.buttons['multitarget']:Click()
      itb:message("|cFFB30000AoE off")
    else
      --ProbablyEngine.buttons.toggle('multitarget')
      ProbablyEngine.buttons.buttons['multitarget']:Click()
      itb:message("|cFF00B34AAoE on")
    end
  end
  
  if command == 'taunt' then
    if ProbablyEngine.toggle.states.taunt then
      --ProbablyEngine.buttons.toggle('taunt')
      ProbablyEngine.buttons.buttons['taunt']:Click()
      itb:message("|cFFB30000SoO Auto Taunt off")
    else
      --ProbablyEngine.buttons.toggle('taunt')
      ProbablyEngine.buttons.buttons['taunt']:Click()
      itb:message("|cFF00B34ASoO Auto Taunt on")
    end
  end

  if command == 'def' then
    if ProbablyEngine.toggle.states.def then
      --ProbablyEngine.buttons.toggle('def')
      ProbablyEngine.buttons.buttons['def']:Click()
      itb:message("|cFFB30000Defensive Cooldowns off")
    else
      --ProbablyEngine.buttons.toggle('def')
      ProbablyEngine.buttons.buttons['def']:Click()
      itb:message("|cFF00B34ADefensive Cooldowns on")
    end
  end

  if command == 'ksmash' then
    if ProbablyEngine.toggle.states.kegsmash then
      --ProbablyEngine.buttons.toggle('kegsmash')
      ProbablyEngine.buttons.buttons['kegsmash']:Click()
      itb:message("|cFFB30000Keg Smash off")
    else
      --ProbablyEngine.buttons.toggle('kegsmash')
      ProbablyEngine.buttons.buttons['kegsmash']:Click()
      itb:message("|cFF00B34AKeg Smash on")
    end
  end

  if command == 'macros' then
    intoBrew.createAllMacros()
  end
-- Spell Queue -- thank you merq for basic code -----------------------------------------------------------------------------
  if command == "qGuard" or command == 123402 then
    intoBrew.queueSpell = 123402
    itb:message("Guard queued")
  elseif command == "qBrew" or command == 115203 then
    intoBrew.queueSpell = 115203
    itb:message("Fortifying Brew queued")
  elseif command == "qZen" or command == 115176 then
    intoBrew.queueSpell = 115176
    itb:message("Zen Meditation queued")
  elseif command == "qAvert" or command == 115213 then
    intoBrew.queueSpell = 115213
    itb:message("Avert Harm queued")
  elseif command == "qTfour" then
    if select(2,GetTalentRowSelectionInfo(4)) == 10 then
        intoBrew.queueSpell = 116844
        itb:message("Ring of Peace queued") 
    elseif select(2,GetTalentRowSelectionInfo(4)) == 11 then
        intoBrew.queueSpell = 119392
        itb:message("Charging Ox Wave queued") 
    elseif select(2,GetTalentRowSelectionInfo(4)) == 12 then
        intoBrew.queueSpell = 119381
        itb:message("Leg Sweep queued") 
    end
  elseif command == "qTfive" then
    if select(2,GetTalentRowSelectionInfo(5)) == 14 then
        intoBrew.queueSpell = 122278
        itb:message("Dampen Harm queued") 
    elseif select(2,GetTalentRowSelectionInfo(5)) == 15 then
        intoBrew.queueSpell = 122783
        itb:message("Diffuse Magic queued") 
    end
  else
    intoBrew.queueSpell = nil
  end
  if intoBrew.queueSpell ~= nil then intoBrew.queueTime = GetTime() end
end)
-----------------------------------------------------------------------------------------------------------------------------
-- Spell Queue Check -- thank you merq for basic code ----------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
intoBrew.checkQueue = function (spellId)
    if (GetTime() - intoBrew.queueTime) > 4 then
        intoBrew.queueTime = 0
        intoBrew.queueSpell = nil
    return false
    else
    if intoBrew.queueSpell then
        if intoBrew.queueSpell == spellId then
            if ProbablyEngine.parser.lastCast == GetSpellName(spellId) then
                intoBrew.queueSpell = nil
                intoBrew.queueTime = 0
            end
        return true
        end
    end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------
-- Create Macros ----------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
function intoBrew.createAllMacros( ... )
  local usedslots = select(2,GetNumMacros())
  if usedslots <= 5 then
    CreateMacro("toggle", "PANDARENRACIAL_INNERPEACE", "/into toggle", 1, 1)
    CreateMacro("kick", "INV_MISC_QUESTIONMARK", "#showtooltip Spear Hand Strike\n/into kick", 1, 1)
    CreateMacro("xuen", "INV_MISC_QUESTIONMARK", "#showtooltip Invoke Xuen, the White Tiger\n/into xuen", 1, 1)
    CreateMacro("aoe", "Ability_warlock_jinx", "/into aoe", 1, 1)
    CreateMacro("ksmash", "ACHIEVEMENT_BREWERY_2", "#showtooltip Keg Smash\n/into ksmash", 1, 1)
    CreateMacro("taunt", "Spell_Magic_PolymorphRabbit", "/into taunt", 1, 1)
    CreateMacro("def", "INV_SummerFest_Symbol_Medium", "/into def", 1, 1)
    CreateMacro("qGuard", "INV_MISC_QUESTIONMARK", "#showtooltip Guard\n/into qGuard", 1, 1)
    CreateMacro("qBrew", "INV_MISC_QUESTIONMARK", "#showtooltip Fortifying Brew\n/into qBrew", 1, 1)
    CreateMacro("qZen", "INV_MISC_QUESTIONMARK", "#showtooltip Zen Meditation\n/into qZen", 1, 1)
    CreateMacro("qAvert", "INV_MISC_QUESTIONMARK", "#showtooltip Avert Harm\n/into qAvert", 1, 1)
    CreateMacro("qTfour", "ability_parry", "/into qTfour", 1, 1)
    CreateMacro("qTfive", "ability_parry", "/into qTfive", 1, 1)
  else
    print("You don't have enough free Macroslots")
  end
end  
-----------------------------------------------------------------------------------------------------------------------------
-- Touch of Death ----------------------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
function intoBrew.touchdeath ()
    local GlyphSockets = NUM_GLYPH_SLOTS
    if IsSpellKnown(115080)
        and UnitHealth("target") <= UnitHealth("player") 
        and not UnitIsPlayer("target")
        then
            for i=1, GlyphSockets do
                if select(4, GetGlyphSocketInfo(i)) == 123391
                    then return true
                end
            end
        if UnitPower("player",12) >= 3
            then return true
        end
     end    
end
-----------------------------------------------------------------------------------------------------------------------------
-- Stagger ------------------------------------------------------------------------------------------------------------------ 
-----------------------------------------------------------------------------------------------------------------------------
function intoBrew.StaggerValue ()    
    local staggerLight, _, iconLight, _, _, remainingLight, _, _, _, _, _, _, _, _, valueStaggerLight, _, _ = UnitAura("player", GetSpellInfo(124275), "", "HARMFUL")
    local staggerModerate, _, iconModerate, _, _, remainingModerate, _, _, _, _, _, _, _, _, valueStaggerModerate, _, _ = UnitAura("player", GetSpellInfo(124274), "", "HARMFUL")
    local staggerHeavy, _, iconHeavy, _, _, remainingHeavy, _, _, _, _, _, _, _, _, valueStaggerHeavy, _, _ = UnitAura("player", GetSpellInfo(124273), "", "HARMFUL")
    local staggerTotal= (remainingLight or remainingModerate or remainingHeavy or 0) * (valueStaggerLight or valueStaggerModerate or valueStaggerHeavy or 0)
    local percentOfHealth=(100/UnitHealthMax("player")*staggerTotal)
    local ticksTotal=(valueStaggerLight or valueStaggerLight or valueStaggerLight or 0)
    return percentOfHealth;
end

function intoBrew.DrinkStagger()
    if (UnitPower("player", 12) >= 1 or UnitBuff("player", GetSpellInfo(138237))) then 
        if UnitDebuff("player", GetSpellInfo(124273))
            then return true
        end
        if UnitDebuff("player", GetSpellInfo(124274))
            and intoBrew.StaggerValue() > 25
            then return true
        end
        --[[if UnitDebuff("player", GetSpellInfo(124275))
            and intoBrew.StaggerValue() > 3
            then return true
        end]]--
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------
-- Healthstone -------------------------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
local PlayerHP = 100 * UnitHealth("player") / UnitHealthMax("player")

function intoBrew.Healthstone(...)
    if PlayerHP < 40
    and GetItemCount(5512,false,false) > 0 
    and ( select(2, GetItemCooldown(5512)) == 0 ) then
        return true
    end
end 
-----------------------------------------------------------------------------------------------------------------------------
-- Register Library --------------------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
ProbablyEngine.library.register("intoBrew", intoBrew)