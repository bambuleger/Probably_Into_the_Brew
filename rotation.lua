--[[
	=======================================================
	                     Into the Brew
	                         v1.3
	=======================================================
	            Brewmaster Monk Rotation for PE            
	https://probablyengine.com/forum/viewtopic.php?id=189
	=======================================================
]]--


ProbablyEngine.rotation.register_custom(268, "Into the Brew", {

-- Hotkeys
	{ "pause", "modifier.lshift"},
 	{ "115180", "modifier.lalt", "ground" }, -- Dizzying Haze
 	{ "115315", "modifier.rcontrol", "ground" }, -- Black Ox Statue


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
	--Healthstone
	--{ "#5512", "player.health < 40" },
	{ "!/run UseItemByName(5512)", "@intoBrew.Healthstone"},

-- Stagger
	--{ "119582", (function() return intoBrew.DrinkStagger() end) }, 
	{ "119582", "@intoBrew.DrinkStagger" }, 

-- Defensives
	-- Elusive Brew 10 Stacks
	{ "115308", "player.buff(128939).count >= 10" },
	-- Fortifying Brew
	{ "115203", "player.health <= 35" },
	-- Guard
	{ "123402", "player.health <= 35", "player"},
	-- Self Dispell
	{ "115450", "player.dispellable(115450)", "player"},

-- Cooldowns
	-- Xuen
	{ "123904", {"player.spell(123904).exists", "modifier.cooldowns"}},

-- Rotation
	--Touch of Death
	--{ "115080", (function() return intoBrew.touchdeath() end) },
	{ "115080", "@intoBrew.touchdeath" },
	-- Keg Smash on CD
	{ "121253" },
	-- Blackout Kick 
	--{ "100784", { "!player.buff(115307)", "player.chi >= 2"} },
	{{
		{ "100784", "!player.buff(115307)"},
		{ "100784", "player.buff(115307).duration < 3"},
		{ "100784" }
	}, "player.chi >= 2"},
	-- Tiger Palm
	{ "100787", "player.buff(125359).duration < 4" },
	{ "100787", "player.energy <= 39"},
	-- Expel Harm if < 85
	{ "115072", "player.health <= 85"},
	-- Breath of Fire
	{ "115181", {
		"player.chi >= 2",
		--"player.buff(115307).duration >= 3",
		"modifier.multitarget"
	}}, 
	--Spinning Crane Kick
	{ "101546", {
		"modifier.multitarget",
		"!player.spell(116847).exists",
		"player.buff(115307).duration >= 3",	
	}}, 
	--Rushing Jade Wind
	{ "116847", {
		"modifier.multitarget" ,
		"!player.buff(116847)",
		"player.spell(116847).exists",
		"player.buff(115307).duration >= 3",		
	}}, 	
	-- Jab 
	{ "100780", "player.energy >= 40"},

},	{
	-- OOC Hotkeys
	{ "115180", "modifier.lalt", "ground" }, -- Dizzying Haze
 	{ "115315", "modifier.rcontrol", "ground" }, -- Black Ox Statue

})