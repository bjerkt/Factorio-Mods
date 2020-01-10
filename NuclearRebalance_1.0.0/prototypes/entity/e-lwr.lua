--////////////////////////////////////////
--LWR Entity
--////////////////////////////////////////
data:extend({
	{
		burner = {
			burnt_inventory_size = 1,
			--Setting effectivity here actually makes it less efficient.
			effectivity = 0.25,
			fuel_inventory_size = 1,
			fuel_category = "lwr-nuclear"
		},
		collision_box = {
			{
			  -19.9000000000001,
			  -39.9000000000001
			},
			{
			  19.90000000000001,
			  39.90000000000001
			}
		},
		corpse = "steam-engine-remnants",
		dying_explosion = "medium-explosion",
		--Setting effectivity here sets it for the tooltip but does nothing else
		effectivity = .25,
		energy_source = {
			type = "electric",
			emissions_per_minute = .01,
			usage_priority = "primary-output"
		},
		fast_replaceable_group = "lwr",
		flags = {
			"placeable-neutral",
			"player-creation"
		},
		fluid_box = nil,
		horizontal_animation = {
			layers = {
			{
				filename = "__NuclearRebalance__/graphics/entity/e-lwr-h.png",
				frame_count = 1,
				width = 771,
				height = 606,
				hr_version = nil,
				line_length = 1,
				shift = {
					0,
					-11.5
				},
				scale = 3.28
			},
			{
				draw_as_shadow = true,
				filename = "__NuclearRebalance__/graphics/entity/e-lwr-h-shadow.png",
				frame_count = 1,
				width = 1006,
				height = 522,
				hr_version = nil,
				line_length = 1,
				shift = {
					12.125,
					-7
				},
				scale = 3.28
			},
			}
		},
		icon = "__NuclearRebalance__/graphics/icons/lwr/i-lwr.png",
		icon_size = 128,
		max_health = 400000,
		max_power_output = "500MW",
		min_perceived_performance = 0.25,
		minable = {
			mining_time = 30,
			result = "lwr"
		},
		name = "lwr",
		performance_to_sound_speedup = 0.5,
		selection_box = {
		{
			-19.5,
			-39.5
		},
		{
			19.5,
			39.5
		}
		},
		smoke = {
			{
				--Horizontal orientation; top stack.
				east_position = {
					-28, -- 5 to 15 == more east
					-32 -- -30 to -40 == more north
				},
				frequency = 0.3125,
				name = "lwr-cooling-tower-smoke",
				--Vertical orientation; left stack
				north_position = {
					-8,
					6
				},
				slow_down_factor = 1,
				starting_frame_deviation = 60,
				starting_vertical_speed = 0.08
			},
			{
				--Horizontal orientation; bottom stack.
				east_position = {
					-28, -- 5 to 15 == more east
					-13 -- -30 to -40 == more north
				},
				frequency = 0.3125,
				name = "lwr-cooling-tower-smoke",
				--Vertical orientation; right stack
				north_position = {
					13,
					6
				},
				slow_down_factor = 1,
				starting_frame_deviation = 60,
				starting_vertical_speed = 0.08
			},
		},
		type = "generator",
		vehicle_impact_sound = {
			filename = "__base__/sound/car-stone-impact.ogg",
			volume = 0.65
		},
		vertical_animation = {
			layers = {
			{
				filename = "__NuclearRebalance__/graphics/entity/e-lwr-v.png",
				frame_count = 1,
				width = 383,
				height = 1005,
				hr_version = nil,
				line_length = 1,
				shift = {
					0,
					-11.5
				},
				scale = 3.26
			},
			{
				draw_as_shadow = true,
				filename = "__NuclearRebalance__/graphics/entity/e-lwr-v-shadow.png",
				frame_count = 1,
				width = 616,
				height = 780,
				hr_version = nil,
				line_length = 1,
				shift = {
					12,
					0
				},
				scale = 3.26
			},
			}
		}
	}
})