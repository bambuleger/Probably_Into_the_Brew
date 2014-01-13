--[[
	=======================================================
	                     Into the Brew
	                         v1.6
	=======================================================
	            Brewmaster Monk Rotation for PE            
	 https://probablyengine.com/forum/viewtopic.php?id=189
	=======================================================
]]--


ProbablyEngine.rotation.register_custom(268, "|cFF32ff84Into the Brew|r", {

-----------------------------------------------------------------------------------------------------------------------------
-- Hotkeys ------------------------------------------------------------------------------------------------------------------ 
-----------------------------------------------------------------------------------------------------------------------------
	{ "pause", "modifier.lshift"},
 	{ "115180", "modifier.lalt", "ground" }, -- Dizzying Haze
 	{ "115315", "modifier.lcontrol", "ground" }, -- Black Ox Statue
-----------------------------------------------------------------------------------------------------------------------------
-- Buffs -------------------------------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
	{ "115921", -- Legacy of the Emperor
    	{
      	"!player.buff(117666)", -- Legacy of the Emperor Buff
      	"!player.buff(1126)", -- Mark of the Wild
      	"!player.buff(90363)", -- Embrace of the Shale Spider
      	"!player.buff(20217)" -- Blessing of Kings
    	}
 	},
-----------------------------------------------------------------------------------------------------------------------------
-- Queued Spells ------------------------------------------------------------------------------------------------------------ 
-----------------------------------------------------------------------------------------------------------------------------
	{ "!123402", "@intoBrew.checkQueue(123402)" },
	{ "!115203", "@intoBrew.checkQueue(115203)" },
	{ "!115176", "@intoBrew.checkQueue(115176)" },
	{ "!115213", "@intoBrew.checkQueue(115213)" },
	{ "!116844", "@intoBrew.checkQueue(116844)" },
	{ "!119392", "@intoBrew.checkQueue(119392)" },
	{ "!119381", "@intoBrew.checkQueue(119381)" },
	{ "!122280", "@intoBrew.checkQueue(122280)" },
	{ "!122278", "@intoBrew.checkQueue(122278)" },
	{ "!122783", "@intoBrew.checkQueue(122783)" },
	{ "!115078", "@intoBrew.checkQueue(115078)", "mouseover" },
	{ "!115315", "@intoBrew.checkQueue(115315)", "ground" },
-----------------------------------------------------------------------------------------------------------------------------
-- Interrupts --------------------------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
  -- Interrupts
  {{
    { "115078", { -- Paralysis when SHS, Ring of Peace, and Quaking Palm are all on CD
       "!target.debuff(Spear Hand Strike)",
       "player.spell(116705).cooldown > 0",
       "player.spell(116844).cooldown > 0",
       "player.spell(107079).cooldown > 0",
       "!modifier.last(116705)"
    }},
    { "116844", { -- Ring of Peace when SHS is on CD
       "!target.debuff(Spear Hand Strike)",
       "player.spell(116705).cooldown > 0",
       "!modifier.last(116705)"
    }},
    { "107079", { -- Quaking Palm when SHS and Ring of Peace are on CD
       "!target.debuff(Spear Hand Strike)",
       "player.spell(116705).cooldown > 0",
       "player.spell(116844).cooldown > 0",
       "!modifier.last(116705)"
    }},
    { "116705" }, -- Spear Hand Strike
  }, "target.interruptAt(50)" },


-----------------------------------------------------------------------------------------------------------------------------
-- Selfheal Talents T2 ------------------------------------------------------------------------------------------------------ 
-----------------------------------------------------------------------------------------------------------------------------
	{ "115098", "player.health < 85" }, -- Chi Wave
	{ "123986", "player.health < 85" }, -- Chi Burst
	{ "124081", { "player.buff(124081)" }, "focus"}, -- Zen Sphere on focus if already on player
	{ "124081", { "!player.buff(124081)" }, "player"}, -- Zen Sphere on player
	{ "#5512", "player.health < 40"}, --Healthstone when less than 40% health


-----------------------------------------------------------------------------------------------------------------------------
-- Stagger ------------------------------------------------------------------------------------------------------------------ 
-----------------------------------------------------------------------------------------------------------------------------
	{ "119582", "@intoBrew.DrinkStagger" }, 


-----------------------------------------------------------------------------------------------------------------------------
-- Defensives---------------------------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
	{ "115308", "player.buff(128939).count >= 10" }, -- Elusive Brew 10 Stacks
	{ "115203", {"player.health <= 35", "toggle.def" }, "player" }, -- Fortifying Brew
	{ "123402", {"player.health <= 50", "toggle.def" }, "player" }, -- Guard
	{ "115450", "player.dispellable(115450)", "player"}, -- Self Dispell
   { "122783", { -- Diffuse Magic at < 50% health and when FB buff is not up
     "player.health < 50",
     "!player.buff(115203)" --FB
   }},
   { "122278", { -- Dampen Harm at < 50% health and when FB buff is not up
     "player.health < 50",
     "!player.buff(115203)" --FB
   }},

   { "117368", "target.disarmable" }, -- Grapple Weapon
   -- Ring of Peace when Grapple Weapon debuff is not present, is on CD, and the target is in melee range
   { "116844", { "!player.buff(123232)", "player.spell(117368).cooldown > 0", "target.range <= 5" }},

   { "137562", "player.state.disorient" }, -- 137562 = Nimble Brew
   { "137562", "player.state.fear" },
   { "137562", "player.state.stun" },
   { "137562", "player.state.root" },
   { "137562", "player.state.horror" },
   { "137562", "player.state.snare" },

   { "116841", "player.state.disorient" }, -- 116841 = Tiger's Lust
   { "116841", "player.state.stun" },
   { "116841", "player.state.root" },
   { "116841", "player.state.snare" },

-----------------------------------------------------------------------------------------------------------------------------
-- Cooldowns ---------------------------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
   {{
      { "121279" }, -- Lifeblood
      { "26297" }, -- Berserking
      { "20572" }, -- Blood Fury
      { "33697" }, -- Blood Fury
      { "33702" }, -- Blood Fury
   	{ "123904" }, -- Xuen
   	{ "#gloves" },
   }, "modifier.cooldowns" },

-----------------------------------------------------------------------------------------------------------------------------
-- Main Rotation ------------------------------------------------------------------------------------------------------------ 
-----------------------------------------------------------------------------------------------------------------------------
	{ "115080", "@intoBrew.touchdeath" }, --Touch of Death
	{ "121253", "toggle.kegsmash" }, -- Keg Smash on CD
	-- Blackout Kick 
	{{
		{ "100784", "!player.buff(115307)"},
		{ "100784", "player.buff(115307).duration < 3"},
		{ "100784" }
	}, "player.chi >= 2"},
	{ "100787", "player.buff(125359).duration < 4" }, -- Tiger Palm
	{ "100787", "player.energy <= 39"},
	{ "115072", "player.health <= 85"}, -- Expel Harm if < 85
	-- Breath of Fire
	{ "115181", {
		"player.chi >= 2",
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
		"player.buff(115307).duration >= 3",		
	}}, 	
	{ "100780", "player.energy >= 40"},-- Jab


-----------------------------------------------------------------------------------------------------------------------------
-- SoO autotaunt Events --------------------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
	{ "115546", {"target.id(71543)", "!player.debuff(143436)", "focus.debuff(143436).count >= 1", "toggle.autotaunt"}}, 	-- Immerseus 1 Stack
	{ "115546", {"target.id(72276)", "!player.debuff(146124)", "focus.debuff(146124).count >= 4", "toggle.autotaunt"}}, 	-- Norushen 4 Stacks
	{ "115546", {"target.id(71734)", "!player.debuff(144358)", "focus.debuff(144358).count >= 1", "toggle.autotaunt"}}, 	-- Sha of Pride 1 Stack
	{ "115546", {"target.id(71466)", "!player.debuff(144467)", "focus.debuff(144467).count >= 3", "toggle.autotaunt"}}, 	-- Iron Juggernaut 3 Stacks
	{ "115546", {"target.id(71859)", "!player.debuff(144215)", "focus.debuff(144215).count >= 5", "toggle.autotaunt"}}, 	-- Dark Shamans 5 Stacks
	{ "115546", {"target.id(71515)", "!player.debuff(143494)", "focus.debuff(143494).count >= 3", "toggle.autotaunt"}}, 	-- Nazgrim 3 Stacks
	{ "115546", {"target.id(71454)", "!player.debuff(142990)", "focus.debuff(142990).count >= 13", "toggle.autotaunt"}}, 	-- Malkorok 13 Stacks
	{ "115546", {"target.id(71504)", "!player.debuff(143385)", "focus.debuff(143385).count >= 3", "toggle.autotaunt"}},		-- Blackfuse 3 Stacks !!!
	{ "115546", {"target.id(71529)", "!player.debuff(143426)", "focus.debuff(143426).count >= 3", "toggle.autotaunt"}}, 	-- Thok 3 Stacks Fearsome Roar
	{ "115546", {"target.id(71529)", "!player.debuff(143780)", "focus.debuff(143780).count >= 3", "toggle.autotaunt"}}, 	-- Thok 3 Stacks Acid Breath
	{ "115546", {"target.id(71529)", "!player.debuff(143773)", "focus.debuff(143773).count >= 3", "toggle.autotaunt"}}, 	-- Thok 3 Stacks Freezing Breath
	{ "115546", {"target.id(71865)", "!player.debuff(145183)", "focus.debuff(145183).count >= 3", "toggle.autotaunt"}}, 	-- Garrosh 3 Stacks Gripping Despair
	{ "115546", {"target.id(71865)", "!player.debuff(145195)", "focus.debuff(145195).count >= 3", "toggle.autotaunt"}}, 	-- Garrosh 3 Stacks Empowered Gripping Despair
},	

-----------------------------------------------------------------------------------------------------------------------------
-- OOC ---------------------------------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
{
	{ "115180", "modifier.lalt", "ground" }, -- Dizzying Haze
 	{ "115315", "modifier.lcontrol", "ground" }, -- Black Ox Statue
	{ "115921", -- Legacy of the Emperor
    	{
      	"!player.buff(117666)", -- Legacy of the Emperor Buff
      	"!player.buff(1126)", -- Mark of the Wild
      	"!player.buff(90363)", -- Embrace of the Shale Spider
      	"!player.buff(20217)" -- Blessing of Kings
    	}
 	},
},

----------------------------------------------------------------------------------------------------------------------
-- Custom Toggle ------------------------------------------------------------------------------------------------------------ 
-----------------------------------------------------------------------------------------------------------------------------
function()
ProbablyEngine.toggle.create(
    'def',
    'Interface\\Icons\\INV_SummerFest_Symbol_Medium.png‎',
    'Defensive CDs Toggle',
	'Enable or Disable usage of Guard / Fortifying Brew')
ProbablyEngine.toggle.create(
    'autotaunt',
    'Interface\\Icons\\Spell_Magic_PolymorphRabbit.png‎',
    'SoO Auto autotaunt Toggle',
	'Enable or Disable Auto autotaunt in SoO\nImmerseus 1 Stack\nNorushen 4 Stacks\nSha of Pride 1 Stack\nIron Juggernaut 3 Stacks\nDark Shamans 5 Stacks\nGeneral Nazgrim 3 Stacks\nMalkorok 13 Stacks\nBlackfuse 3 Stacks\nThok 3 Stacks\nGarrosh 3 Stacks\nSET 2ND TANK TO FOCUS')
ProbablyEngine.toggle.create(
    'kegsmash',
    'Interface\\Icons\\achievement_brewery_2.png‎',
    'Keg Smash Toggle',
	'Enable or Disable Keg Smash to avoid cleave')
end)
