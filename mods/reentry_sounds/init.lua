reentry_sounds = {}

function reentry_sounds.node_sound_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "", gain = 1.0}
	table.dug = table.dug or
			{name = "reentry_sounds_dug_node", gain = 0.25}
	table.place = table.place or
			{name = "reentry_sounds_place_node_hard", gain = 1.0}
	return table
end

function reentry_sounds.node_sound_ship_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "reentry_sounds_hard_footstep", gain = 0.2}
	table.dug = table.dug or
			{name = "reentry_sounds_hard_footstep", gain = 1.0}
	reentry_sounds.node_sound_defaults(table)
	return table
end

function reentry_sounds.node_sound_asteroid_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "reentry_sounds_asteroid_footstep", gain = 0.25}
	table.dig = table.dig or
			{name = "reentry_sounds_asteroid_dig", gain = 0.35}
	table.dug = table.dug or
			{name = "reentry_sounds_asteroid_dug", gain = 1.0}
	table.place = table.place or
			{name = "reentry_sounds_place_node", gain = 1.0}
	reentry_sounds.node_sound_defaults(table)
	return table
end

function reentry_sounds.node_sound_glass_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "reentry_sounds_glass_footstep", gain = 0.3}
	table.dig = table.dig or
			{name = "reentry_sounds_glass_footstep", gain = 0.5}
	table.dug = table.dug or
			{name = "reentry_sounds_break_glass", gain = 1.0}
	reentry_sounds.node_sound_defaults(table)
	return table
end

function reentry_sounds.node_sound_ice_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "reentry_sounds_ice_footstep", gain = 0.15}
	table.dig = table.dig or
			{name = "reentry_sounds_ice_dig", gain = 0.5}
	table.dug = table.dug or
			{name = "reentry_sounds_ice_dug", gain = 0.5}
	reentry_sounds.node_sound_defaults(table)
	return table
end

function reentry_sounds.node_sound_metal_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "reentry_sounds_metal_footstep", gain = 0.2}
	table.dig = table.dig or
			{name = "reentry_sounds_dig_metal", gain = 0.5}
	table.dug = table.dug or
			{name = "reentry_sounds_dug_metal", gain = 0.5}
	table.place = table.place or
			{name = "reentry_sounds_place_node_metal", gain = 0.5}
	reentry_sounds.node_sound_defaults(table)
	return table
end
