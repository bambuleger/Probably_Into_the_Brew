--[[
	=======================================================
	                     Into the Brew
	                         v 1.2
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

ProbablyEngine.rotation.register_custom(268, "Into the Brew", {

-- Hotkeys
	{ "pause", "modifier.lshift"},
 	{ "115180", "modifier.lalt", "ground" }, -- Dizzying Haze
 	{ "115315", "modifier.rcontrol", "ground" }, -- Black Ox Statue
 	{ "122057", "modifier.lcontrol", "target"}, -- Clash

--Buff
	{ "115921", -- Legacy of the Emperor
    {
      "!player.buff(117666).any", -- Legacy of the Emperor Buff
      "!player.buff(1126).any", -- Mark of the Wild
      "!player.buff(90363).any", -- Embrace of the Shale Spider
      "!player.buff(20217).any" -- Blessing of Kings
    }
  },

-- Interrupts
	{ "117368", "modifier.interrupts" }, --Grapple Weapon (Disarm)
	{ "116705", "modifier.interrupts" }, --Spear Hand Strike

-- Selfheal Talents T2 
	-- Chi Wave
	{ "115098", { "player.spell(115098).exists", "player.health < 85" }},
	-- Chi Burst
	{ "123986", { "player.spell(123986).exists", "player.health < 85" }},
	-- Zen Sphere on player
	{ "124081", { "player.spell(124081).exists", "!player.buff(124081)" }},

-- Stagger
	{ "119582", (function() return intoBrew.DrinkStagger() end) }, 

-- Defensives
	-- Elusive Brew 10 Stacks
	{ "115308", "player.buff(128939).count >= 10" },
	-- Fortifying Brew
	{ "115203", "player.health <= 35" },
	-- Guard
	{ "123402", "player.health <= 35", "player"},

-- Cooldowns
	-- Xuen
	{ "123904", "modifier.cooldowns"},

-- Rotation
	--Touch of Death
	{ "115080", (function() return intoBrew.touchdeath() end) },
	-- Keg Smash on CD
	{ "121253" },
	-- Blackout Kick 
	{ "100784", { "!player.buff(115307)", "player.chi >= 2"} },
	{{
		{ "100784", "!player.buff(115307)"},
		{ "100784", "player.buff(115307).duration < 3"},
		{ "100784" }
	}, "player.chi >= 3"},
	-- Tiger Palm
	{ "100787", "player.buff(125359).duration < 4" },
	{ "100787", "player.energy <= 39"},
	-- Expel Harm if < 85
	{ "115072", "player.health <= 85"},
	-- Breath of Fire
	{ "115181", {
		"player.chi >= 4",
		"modifier.multitarget"
	}}, 
	--Spinning Crane Kick
	{ "101546", {
		"modifier.multitarget",
		"!player.spell(116847).exists"		
	}}, 
	--Rushing Jade Wind
	{ "116847", {
		"modifier.multitarget" ,
		"!player.buff(116847)",
		"player.spell(116847).exists"		
	}}, 	
	-- Jab 
	{ "100780", "player.energy >= 40"},

})