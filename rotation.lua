--[[
	=======================================================
	                     Into the Brew
	                         v 1.0
	=======================================================
	            Brewmaster Monk Rotation for PE            
	https://probablyengine.com/forum/viewtopic.php?pid=550
	=======================================================
]]--

intoBrew = { }

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

function intoBrew.ElusiveBr ()
 local eluid = select(11, UnitAura("player","Elusive Brew")) 
 if eluid == 128939
  then 
   local ElusiveBrCount = select(4,UnitAura("player","Elusive Brew"))
   if ElusiveBrCount ~= nil 
    and ElusiveBrCount >= 10 
    then return true 
   end 
  end 
end

function intoBrew.StaggerValue ()    
    local staggerLight, _, iconLight, _, _, remainingLight, _, _, _, _, _, _, _, _, valueStaggerLight, _, _ = UnitAura("player", "Light Stagger", "", "HARMFUL")
  	local staggerModerate, _, iconModerate, _, _, remainingModerate, _, _, _, _, _, _, _, _, valueStaggerModerate, _, _ = UnitAura("player", "Moderate Stagger", "", "HARMFUL")
    local staggerHeavy, _, iconHeavy, _, _, remainingHeavy, _, _, _, _, _, _, _, _, valueStaggerHeavy, _, _ = UnitAura("player", "Heavy Stagger", "", "HARMFUL")
    local staggerTotal= (remainingLight or remainingModerate or remainingHeavy or 0) * (valueStaggerLight or valueStaggerModerate or valueStaggerHeavy or 0)
    local percentOfHealth=(100/UnitHealthMax("player")*staggerTotal)
    local ticksTotal=(valueStaggerLight or valueStaggerLight or valueStaggerLight or 0)
    return percentOfHealth;
end

function intoBrew.DrinkStagger()
	local heavystag = select(11,UnitDebuff("player","Heavy Stagger"))
	local moderatestag = select(11,UnitDebuff("player","Moderate Stagger"))
	local lightstag = select(11,UnitDebuff("player","Light Stagger"))
	local puriProc = select(11,UnitBuff("player", "Purifier"))
	if (UnitPower("player", 12) >= 1 or puriProc == 138237) then 
		if heavystag == 124273
			then return true
		end
		if moderatestag == 124274
			and intoBrew.StaggerValue() > 25
			then return true
		end
		--[[if lightstag == 124275
			and intoBrew.StaggerValue() > 
			then return true
		end]]--
	end
	return false
end


ProbablyEngine.rotation.register_custom(268, "Into the Brew", {

-- Hotkeys
	--{ "pause", "modifier.lshift"} NOT IMPLEMENTED IN PE
 	{ "Dizzying Haze", "modifier.lalt", "ground" }, -- Dizzying Haze
 	{ "Summon Black Ox Statue", "modifier.rcontrol", "ground" }, -- Black Ox Statue
 	{ "Clash", "modifier.lcontrol", "target"},
 	{ "Ring of Peace", "modifier.rshift"},
 	{ "Charging Ox Wave", "modifier.rshift"},
 	{ "Leg Sweep", "modifier.rshift"},

--Buff
	{ "Legacy of the Emperor", {
		"!player.buff(Legacy of the Emperor)",
		"!player.buff(Blessing of Kings)",
  		"!player.buff(Mark of the Wild)",
  		"!player.buff(Embrace of the Shale Spider)",
	}},

-- Interrupts
	{ "Spear Hand Strike", "modifier.interrupts" }, --Spear Hand Strike

-- Selfheal Talents T2 
	-- Chi Wave
	{ "Chi Wave", "player.health < 85" },
	-- Chi Burst
	{ "Chi Burst", "player.health < 85" },
	-- Zen Sphere on player
	{ "Zen Sphere", "!player.buff(Zen Sphere)" },

-- Stagger
	{ "Purifying Brew", (function() return intoBrew.DrinkStagger() end) }, 

-- Defensives
	-- Elusive Brew 10 Stacks
	{ "Elusive Brew", (function() return intoBrew.ElusiveBr() end) },
	-- Fortifying Brew
	{ "Fortifying Brew", "player.health <= 35" },
	-- Guard
	{ "Guard", "player.health <= 35" },

-- Cooldowns
	-- Xuen
	{ "Invoke Xuen, the White Tiger", "modifier.cooldowns"},

-- Rotation
	--Touch of Death
	{ "Touch of Death", (function() return intoBrew.touchdeath() end) },
	-- Keg Smash on CD
	{ "Keg Smash" },
	-- Blackout Kick 
	--[[	{ "Blackout Kick" },]]--
	{ "Blackout Kick", { "!player.buff(Shuffle)", "player.chi >= 2"} },
	{{
		{ "Blackout Kick", "!player.buff(Shuffle)"},
		{ "Blackout Kick", "player.buff(Shuffle).duration < 3"},
		{ "Blackout Kick" }
	}, "player.chi >= 3"},
	-- Tiger Palm
	{ "Tiger Palm", "player.buff(Tiger Power).duration < 4" },
	{ "Tiger Palm", "player.energy <= 39"},
	-- Expel Harm if < 85
	{ "Expel Harm", "player.health <= 85"},
	-- Breath of Fire
	{ "Breath of Fire", {
		"player.chi >= 4",
		"modifier.multitarget"
	}}, 
	--Rushing Jade Wind
	{ "Rushing Jade Wind", {
		"modifier.multitarget" ,
		"!player.buff(Rushing Jade Wind)"		
	}}, 
	--Spinning Crane Kick
	{ "Spinning Crane Kick", {
		"modifier.multitarget",
		"!player.spell.usable(Rushing Jade Wind)"		
	}}, 	
	-- Jab 
	{ "Jab", "player.energy >= 40"},
	
	



-- Spell IDs
--Blackout Kick 			100784
--Breath of Fire 			115181
--Dizzying Haze 			115180
--Expel Harm 				115072
--Jab 						100780
--Keg Smash					121253
--Spinning Crane Kick 		101546
--Rushing Jade Wind 		116847
--Tiger Palm 				100787
--Touch of Death 			115080
--Xuen						123904

--Clash 					122057
--Detox 					115450
--Healing Sphere 			115460
--Legacy of the Emperor 	117666 (spell) 117666 (buff)
--Paralysis 				115078
--Provoke 					115546
--Roll 						109132
--Spear Hand Strike 		116705
--Summon Black Ox Statue 	115315
--Transcendence 			101643
--Transcendence: Transfer 	119996
--Shuffle					115307

--Avert harm 				115213
--Elusive Brew 				115308
--Fortifying Brew 			115203
--Grapple Weapon 			117368
--Guard 					123402
--Nimble Brew 				137562
--Purifying Brew 			119582
--Zen Meditation 			115176
--Chi Wave					115098
--Chi Burst					123986
--Zen Sphere				124081

})