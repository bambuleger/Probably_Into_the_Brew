--[[
    =======================================================
                         Into the Brew
                             v1.3
    =======================================================
                Brewmaster Monk Rotation for PE            
    https://probablyengine.com/forum/viewtopic.php?id=189
    =======================================================
]]--

-- Initialize tables
if not intoBrew then intoBrew = {} end


--[[local playerName = UnitName("player")

StaticPopupDialogs["welcome"] = {
        maxLetters = 1200,
        editBoxWidth = 2150,
        OnShow = function(self)
    end,
    text = " Welcome back " .. playerName .. "\nInto the Brew v1.3 loaded\nPlease comment / report bugs at\nhttp://tinyurl.com/intobrew",
    button1 = "Have fun!",
    OnAccept = function()
    end,
    timeout = 20,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,  
}
StaticPopup_Show ("welcome")]]--

-- Thank you Mavmins for the code
--[[ProbablyEngine.listener.register("intoBrew", "MODIFIER_STATE_CHANGED", function(...)
        local key                        = select(1, ...)
        local isDown                = select(2, ...)
        USE_AOE = ProbablyEngine.config.data.button_states.multitarget
        USE_INTRPT = ProbablyEngine.config.data.button_states.interrupt
               
       if  (key == "RSHIFT" and isDown == 1) then --cooldowns toggle
                if USE_CDS then 
                        USE_CDS = false 
                        print("Cooldowns: |cFFFF0000Disabled")        
                        ProbablyEngine.buttons.toggle('cooldowns')
                else 
                        USE_CDS = true 
                        print("Cooldowns: |cFF00FF00Enabled")
                        ProbablyEngine.buttons.toggle('cooldowns')
                end
        end    

        if  (key == "LCTRL" and isDown == 1) then  --aoe toggle
                if USE_AOE then
                        USE_AOE = false
                        print("AoE: |cFFFF0000Disabled")
                        ProbablyEngine.buttons.toggle('multitarget')                        
                else
                        USE_AOE = true
                        print("AoE: |cFF00FF00Enabled")        
                        ProbablyEngine.buttons.toggle('multitarget')
                end
        end 

        if  (key == "RSHIFT" and isDown == 1) then  --interrupt toggle
                if USE_INTRPT then
                        USE_INTRPT = false
                        print("Interrupts: |cFFFF0000Disabled")
                        ProbablyEngine.buttons.toggle('interrupt')                        
                else
                        USE_INTRPT = true
                        print("Interrupts: |cFF00FF00Enabled")        
                        ProbablyEngine.buttons.toggle('interrupt')
                end
        end       
end)]]--
 
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

local PlayerHP = 100 * UnitHealth("player") / UnitHealthMax("player")

function intoBrew.Healthstone(...)
    if PlayerHP < 40
    and GetItemCount(5512,false,false) > 0 
    and ( select(2, GetItemCooldown(5512)) == 0 ) then
        return true
    end
end
 
-- Register library
ProbablyEngine.library.register("intoBrew", intoBrew)