minetest.register_node("reentry_nodes:solid_floor", {
	description = "Spaceship Floor",
	tiles = {"reentry_nodes_solid_floor.png"},
    groups = {mapnode = 1},
    paramtype = "light",
})

minetest.register_node("reentry_nodes:solid_wall", {
	description = "Spaceship Wall",
	tiles = {"reentry_nodes_solid_wall.png"},
    groups = {mapnode = 1},
    paramtype = "light",
})

minetest.register_node("reentry_nodes:solid_ceiling", {
	description = "Spaceship Ceiling",
	tiles = {"reentry_nodes_solid_ceiling.png"},
    groups = {mapnode = 1},
    paramtype = "light",
})

minetest.register_node("reentry_nodes:solid_floor_light", {
	description = "Spaceship Floor Light",
	tiles = {"reentry_nodes_solid_floor_light.png"},
    groups = {mapnode = 1},
    light_source = 14,
    paramtype = "light",
})

minetest.register_node("reentry_nodes:solid_wall_light", {
	description = "Spaceship Wall Light",
	tiles = {"reentry_nodes_solid_wall_light.png"},
    groups = {mapnode = 1},
    light_source = 14,
    paramtype = "light",
})

minetest.register_node("reentry_nodes:solid_ceiling_light", {
	description = "Spaceship Ceiling Light",
	tiles = {"reentry_nodes_solid_ceiling_light.png"},
    groups = {mapnode = 1},
    light_source = 14,
    paramtype = "light",
})

minetest.register_chatcommand("setblock", {
	description = "Set block at ~ ~ ~ to reentry_nodes:solid_floor",
    privs={interact=true, server=true},
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if player then
			minetest.set_node(player:get_pos(), {name = "reentry_nodes:solid_floor"})
		else
			return false, S("You must be a player to run this command")
		end
	end
})

minetest.override_item("", {
	wield_scale = {x=1,y=1,z=2.5},
	tool_capabilities = {
		full_punch_interval = 0.9,
		groupcaps = {
			diggable = {times={[1]=4.00, [2]=1.80, [3]=0.60}, uses=0, maxlevel=3},
		},
		damage_groups = {damageable=1},
	}
})