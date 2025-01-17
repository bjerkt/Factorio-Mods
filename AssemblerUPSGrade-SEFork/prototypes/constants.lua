DEBUG = false

--Number of beacons around a standard building.
beacon_count = 12

NEED_FLUID_RECIPES = { "bc-asif", "se-bc-asif", "spd-3-asif", "prod-3-asif", "pla-asif", "rf-asif", "sfpg-asif", "sflo-asif", "sfho-asif", "rcu-asif", "arty-shell-asif" }
MAX_FLUID_PER_INPUT_PER_SECOND = settings.startup["max-flow-rate"].value

TECH_DETAILS = {
	["arty-shell-asif"] = { cost = 750000, prereqs = {"gc-asif", "pla-asif"} },
	["gc-asif"] = { cost = 250000, prereqs = {"asif"} },
	["rc-asif"] = { cost = 500000, prereqs = {"gc-asif"} },
	["bc-asif"] = { cost = 1000000, prereqs = {"rc-asif"} },
	["se-bc-asif"] = { cost = 1000000, prereqs = {"bc-asif"} },
	--["beacon-asif"] = { cost = 1000000, prereqs = {"rc-asif"} },
	["lds-asif"] = { cost = 500000, prereqs = {"asif"} },
	["se-lds-asif"] = { cost = 500000, prereqs = {"lds-asif"} },
	["se-hs-asif"] = { cost = 500000, prereqs = {"asif"} },
	["se-hsi-asif"] = { cost = 500000, prereqs = {"se-hs-asif"} },
	["eng-asif"] = { cost = 500000, prereqs = {"asif"} },
	["pla-asif"] = { cost = 500000, prereqs = {"asif"} },
	--RF is handled on its own since it unlocks multiple recipes.
	--["rf-asif"] = { cost = 500000, prereqs = {"asif"} },
	["rcu-asif"] = { cost = 1000000, prereqs = {"bc-asif"} },
	--["spd-3-asif"] = { cost = 1000000, prereqs = {"bc-asif"} },
	--["prod-3-asif"] = { cost = 1000000, prereqs = {"bc-asif"} },
	--["eff-3-asif"] = { cost = 1000000, prereqs = {"bc-asif"} },
	--Oil is handled on its own since it unlocks multiple recipes.
	["oil-asif"] = { cost = 4000000, prereqs = {"asif"} },
}
-- Names of the desired recipes for each item. Important distinction, as there are multiple recipes for certain items
ITEM_LIST = {
	["arty-shell-asif"] = "artillery-shell",
	["gc-asif"] = "electronic-circuit-stone",
	["rc-asif"] = "advanced-circuit",
	["bc-asif"] = "processing-unit",
	["se-bc-asif"] = "se-processing-unit-holmium",
	["lds-asif"] = "low-density-structure",
	["se-lds-asif"] = "se-low-density-structure-beryllium",
	["se-hs-asif"] = "se-heat-shielding",
	["se-hsi-asif"] = "se-heat-shielding-iridium",
	["eng-asif"] = "engine-unit",
	["pla-asif"] = "plastic-bar",
	--["rf-asif"] = "rocket-fuel",
	--["sfpg-asif"] = "solid-fuel-from-petroleum-gas",
	--["sflo-asif"] = "solid-fuel-from-light-oil",
	--["sfho-asif"] = "solid-fuel-from-heavy-oil",
	["rcu-asif"] = "rocket-control-unit",
	--["spd-3-asif"] = "speed-module-3",
	--["prod-3-asif"] = "productivity-module-3",
	--["eff-3-asif"] = "effectivity-module-3",
	--["beacon-asif"] = "beacon",
}
RECIPE_MAP = {
	["hc-asif"] = "heavy-oil-cracking",
	["lc-asif"] = "light-oil-cracking",
}
-- Root ingredients; we don't need to recurse past these
base_recipes = 
{
	"copper-plate",
	"iron-plate",
	"steel-plate",
	"plastic-bar",
	"sulfuric-acid",
	"solid-fuel",
	"petroleum-gas",
	"heavy-oil",
	"light-oil",
	"sulfur",
	"coal",
	"water",
	"wood",
	"stone",
	"glass",
	"sand",
	"se-vitamelange-extract",
	"se-beryllium-ingot",
	"se-holmium-ingot",
	"se-iridium-ingot",
	"se-naquium-ingot",
	"se-cryonite-rod",
	"se-vulcanite-block"

}
plastic_base_recipes = {"coal", "sulfur", "petroleum-gas", "light-oil", "heavy-oil", "water" }
FLUID_NAMES = {"sulfuric-acid", "petroleum-gas", "light-oil", "heavy-oil", "water" }

--replicate changes here to control.lua!
ORDER_MAP = {
	["gc-asif"] = "a",
	["rc-asif"] = "b",
	["bc-asif"] = "c",
	["se-bc-asif"] = "c1",
	["lds-asif"] = "e",
	["se-lds-asif"] = "e1",
	["se-hs-asif"] = "h",
	["se-hsi-asif"] = "h1",
	["eng-asif"] = "d",
	["pla-asif"] = "f",
	--["rf-asif"] = "h",
	--["sfpg-asif"] = "g2",
	--["sflo-asif"] = "g1",
	--["sfho-asif"] = "g3",
	["rcu-asif"] = "i",
	["arty-shell-asif"] = "j",
	["oil-asif"] = "o1",
	["lc-asif"] = "o2",
	["hc-asif"] = "o3",
	["spd-3-asif"] = "z1",
	["prod-3-asif"] = "z2",
	["eff-3-asif"] = "z3",
	["beacon-asif"] = "z4",
}

--//modules (level 3)
local spd_module_speed_bonus = data.raw.module["speed-module-3"].effect.speed.bonus
local spd_module_pwr_penality = data.raw.module["speed-module-3"].effect.consumption.bonus
local prod_mod_speed_penalty = data.raw.module["productivity-module-3"].effect.speed.bonus
prod_mod_prod_bonus = data.raw.module["productivity-module-3"].effect.productivity.bonus
local prod_mod_pwr_penality = data.raw.module["productivity-module-3"].effect.consumption.bonus
prod_mod_pollution_penalty = data.raw.module["productivity-module-3"].effect.pollution.bonus

--//Beacon
tmp = string.gsub(data.raw["beacon"]["beacon"].energy_usage,"%kW","")
beacon_pwr_drain = tonumber(tmp)

beacon_pwr_penalty = spd_module_pwr_penality * beacon_count
total_beacon_speed_bonus = spd_module_speed_bonus * beacon_count

--//Assembler (refers to vanilla object)
base_ass_entity = data.raw["assembling-machine"]["assembling-machine-3"]
local tmp = string.gsub(base_ass_entity.energy_usage,"%kW","")
assembler_base_pwr_use = tonumber(tmp)
assembler_base_speed = base_ass_entity.crafting_speed
assembler_base_pollution = base_ass_entity.energy_source.emissions_per_minute
assembler_base_modules = base_ass_entity.module_specification.module_slots

local assembler_modules_speed_effect_prod = assembler_base_modules * prod_mod_speed_penalty
local assembler_modules_speed_effect_speed = assembler_base_modules * spd_module_speed_bonus
local assembler_modules_pwr_penalty_prod = assembler_base_modules * prod_mod_pwr_penality
local assembler_modules_pwr_penalty_speed = assembler_base_modules * spd_module_pwr_penality
assembler_productivity_factor = assembler_base_modules * prod_mod_prod_bonus

--Total bonus with prod modules in assemblers
assembler_total_speed_bonus_prod = assembler_base_speed * (assembler_modules_speed_effect_prod + total_beacon_speed_bonus + 1)
--Total bonus with speed modules in assemblers
assembler_total_speed_bonus_speed = assembler_base_speed * (assembler_modules_speed_effect_speed + total_beacon_speed_bonus + 1)
assembler_per_unit_pwr_drain_penalty_prod = (beacon_pwr_penalty + assembler_modules_pwr_penalty_prod + 1)
assembler_per_unit_pwr_drain_penalty_speed = (beacon_pwr_penalty + assembler_modules_pwr_penalty_speed + 1)
--Note: value DOES NOT include power drain from beacons (IE the 320Kw the beacon itself uses). This is to be done in the
-- entity function itself.
assembler_total_pwr_draw_prod = assembler_base_pwr_use * assembler_per_unit_pwr_drain_penalty_prod
assembler_total_pwr_draw_speed = assembler_base_pwr_use * assembler_per_unit_pwr_drain_penalty_speed


--//Chem plant (refers to vanilla object)
base_chem_entity = data.raw["assembling-machine"]["chemical-plant"]
local tmp = string.gsub(base_chem_entity.energy_usage,"%kW","")
chem_base_pwr_use = tonumber(tmp)
chem_base_speed = base_chem_entity.crafting_speed
chem_base_pollution = base_chem_entity.energy_source.emissions_per_minute
chem_base_modules = base_chem_entity.module_specification.module_slots

local chem_modules_speed_effect = chem_base_modules * prod_mod_speed_penalty
local chem_modules_pwr_penalty = chem_base_modules * prod_mod_pwr_penality
chem_productivity_factor = chem_base_modules * prod_mod_prod_bonus

chem_total_speed_bonus = chem_base_speed * (chem_modules_speed_effect + total_beacon_speed_bonus + 1)
chem_per_unit_pwr_drain_penalty = (beacon_pwr_penalty + chem_modules_pwr_penalty + 1)
chem_total_pwr_draw = chem_base_pwr_use * chem_per_unit_pwr_drain_penalty

--//Oil Refinery (refers to vanilla object)
base_oil_entity = data.raw["assembling-machine"]["oil-refinery"]
local tmp = string.gsub(base_oil_entity.energy_usage,"%kW","")
oil_base_pwr_use = tonumber(tmp)
oil_base_speed = base_oil_entity.crafting_speed
oil_base_pollution = base_oil_entity.energy_source.emissions_per_minute
oil_base_modules = base_oil_entity.module_specification.module_slots

local oil_modules_speed_effect = oil_base_modules * prod_mod_speed_penalty
local oil_modules_pwr_penalty = oil_base_modules * prod_mod_pwr_penality
oil_productivity_factor = oil_base_modules * prod_mod_prod_bonus

oil_total_speed_bonus = oil_base_speed * (oil_modules_speed_effect + (spd_module_speed_bonus * 16) + 1)
oil_per_unit_pwr_drain_penalty = (beacon_pwr_penalty + oil_modules_pwr_penalty + 1)
oil_total_pwr_draw = oil_base_pwr_use * oil_per_unit_pwr_drain_penalty

--///
--Reminder: Crafting speed formula is:
--final speed = Recipe time / (assembler speed * (beacon_effect + module_spd_effect + 1)
--final speed is the number of seconds it takes to craft one item, so to get items/second,
-- you need to divide 1 by it. IE: 1/final speed = items per second.
--Note: Productivity modules also cause additional items to be produced, so remember to
-- factor in that effect as well. IE: Items per second = ProdModBonus * 1/final_speed
--///

--///
--Color, tint, and graphics section
--///

GRAPHICS_MAP = {
	["gc-asif"] = {icon = "gc-asif.png", tint = {r= .2, g = .6, b = .01, a = 1}},
	["rc-asif"] = {icon = "rc-asif.png", tint = {r= .78, g = .01, b = .01, a = 1}},
	["bc-asif"] = {icon = "bc-asif.png", tint = {r= .2, g = .13, b = .72, a = 1}},
	["se-bc-asif"] = {icon = "bc-asif.png", tint = {r= .2, g = .13, b = .72, a = 1}},
	["lds-asif"] = {icon = "lds-asif.png", tint = {r= .88, g = .75, b = 0.5, a = 1}},
	["se-lds-asif"] = {icon = "lds-asif.png", tint = {r= .88, g = .75, b = 0.5, a = 1}},
	["se-hs-asif"] = {icon = "se-hs-asif.png", tint = {r= 64, g = 69, b = 74, a = 255}},
	["se-hsi-asif"] = {icon = "se-hs-asif.png", tint = {r= 64, g = 69, b = 74, a = 255}},
	["eng-asif"] = {icon = "eng-asif.png", tint = {r= .49, g = .35, b = .31, a = 1}},
	["pla-asif"] = {icon = "pla-asif.png", tint = data.raw.recipe["plastic-bar"].crafting_machine_tint.primary},
	["rf-asif"] = {icon = "rf-asif.png", tint = {r= .8, g = .65, b = .11, a = 1}},
	["sfpg-asif"] = {icon = "sfpg-asif.png", tint = data.raw.recipe["solid-fuel-from-petroleum-gas"].crafting_machine_tint.primary},
	["sflo-asif"] = {icon = "sflo-asif.png", tint = data.raw.recipe["solid-fuel-from-light-oil"].crafting_machine_tint.primary},
	["sfho-asif"] = {icon = "sfho-asif.png", tint = data.raw.recipe["solid-fuel-from-heavy-oil"].crafting_machine_tint.primary},
	["rcu-asif"] = {icon = "rcu-asif.png", tint = {181, 255, 181, 255}},
	["prod-3-asif"] = {icon = "prod-3-asif.png", tint = {r= 240, g = 66, b = 19, a = 255}},
	["spd-3-asif"] = {icon = "spd-3-asif.png", tint = {r= .25, g = .93, b = .92, a = 1}},
	["eff-3-asif"] = {icon = "eff-3-asif.png", tint = {r= 0, g = 1, b = 0, a = 1}},
	["oil-asif"] = {icon = "oil-asif.png", tint = {r= 0, g = 0, b = 0, a = 1}},
	["lc-asif"] = {icon = "lc-asif.png", tint = data.raw.recipe["heavy-oil-cracking"].crafting_machine_tint.primary},
	["hc-asif"] = {icon = "hc-asif.png", tint = data.raw.recipe["light-oil-cracking"].crafting_machine_tint.primary},
	["arty-shell-asif"] = {icon = "arty-shell-asif.png", tint = {r= 255, g = 149, b = 0, a = 255}},
	["beacon-asif"] = {icon = "beacon-asif.png", tint = {r= 156, g = 99, b = 66, a = 255}},
}

recipe_tint = {r= 1, g = .533, b = 0, a = 1}
