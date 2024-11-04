reentry_nodes = {}

minetest.register_node("reentry_nodes:solid_floor", {
	description = "Spaceship Floor",
	tiles = {"reentry_nodes_solid_floor.png"},
    groups = {mapnode = 1},
})

minetest.register_node("reentry_nodes:solid_wall", {
	description = "Spaceship Wall",
	tiles = {"reentry_nodes_solid_wall.png"},
    groups = {mapnode = 1},
})

minetest.register_node("reentry_nodes:solid_ceiling", {
	description = "Spaceship Ceiling",
	tiles = {"reentry_nodes_solid_ceiling.png"},
    groups = {mapnode = 1},
})

minetest.register_node("reentry_nodes:solid_floor_light", {
	description = "Spaceship Floor Light",
	tiles = {"reentry_nodes_solid_floor_light.png"},
    groups = {mapnode = 1},
    light_source = 14,
})

minetest.register_node("reentry_nodes:solid_wall_light", {
	description = "Spaceship Wall Light",
	tiles = {"reentry_nodes_solid_wall_light.png"},
    groups = {mapnode = 1},
    light_source = 14,
})

minetest.register_node("reentry_nodes:solid_ceiling_light", {
	description = "Spaceship Ceiling Light",
	tiles = {"reentry_nodes_solid_ceiling_light.png"},
    groups = {mapnode = 1},
    light_source = 14,
})

minetest.register_node("reentry_nodes:solid_floor_light_off", {
	description = "Spaceship Floor Light (off)",
	tiles = {"reentry_nodes_solid_floor_light.png"},
    groups = {mapnode = 1, not_in_creative_inventory=1},
    drop = "reentry_nodes:solid_floor_light",
})

minetest.register_node("reentry_nodes:solid_wall_light_off", {
	description = "Spaceship Wall Light (off)",
	tiles = {"reentry_nodes_solid_wall_light.png"},
    groups = {mapnode = 1, not_in_creative_inventory=1},
    drop = "reentry_nodes:solid_wall_light",
})

minetest.register_node("reentry_nodes:solid_ceiling_light_off", {
	description = "Spaceship Ceiling Light (off)",
	tiles = {"reentry_nodes_solid_ceiling_light.png"},
    groups = {mapnode = 1, not_in_creative_inventory=1},
    drop = "reentry_nodes:solid_ceiling_light",
})

reentry_nodes.vector3_to_meta = function(vec3, meta, suffix)
	meta:set_int("x" .. suffix, vec3.x)
	meta:set_int("y" .. suffix, vec3.y)
	meta:set_int("z" .. suffix, vec3.z)
end

reentry_nodes.meta_to_strpos = function(meta, suffix)
	local x = meta:get_int("x" .. suffix)
	local y = meta:get_int("y" .. suffix)
	local z = meta:get_int("z" .. suffix)
	return x .. ", " .. y .. ", " .. z
end

reentry_nodes.meta_to_vector3 = function(meta, suffix)
	local x = meta:get_int("x" .. suffix)
	local y = meta:get_int("y" .. suffix)
	local z = meta:get_int("z" .. suffix)
	return vector.new(x, y, z)
end

local function checkmark( checked )
	if checked == 1 then
		return "checkmark_checked.png"
	else
		return "checkmark_unchecked.png"
	end
end

reentry_nodes.trigger_run = function(name, pos)
	if name == "lights_off" then
		reentry_systems.lights_off(vector.new(64, 64, 64), vector.new(-64, -64, -64))
	end
end

reentry_nodes.trigger_check = function(pos1, pos2, objtype)
    local objects = core.get_objects_in_area(pos1, pos2)
    for i, obj in pairs(objects) do
        if objtype == "player" then
            if obj:get_player_name() then -- check for a player
                return obj
            end
        elseif objtype == "object" then -- obj is a wide scope for any object
            return obj
        end
    end
end

reentry_nodes.create_trigger_formspec = function(pos)
	local meta = minetest.get_meta(pos)
	local formspec = "size[6.5,4]" ..
		"field[0.5,0.5;3,1;posmin;Position Min;" .. reentry_nodes.meta_to_strpos(meta, "min") .. "]" ..
		"field[3.5,0.5;3,1;posmax;Position Max;" .. reentry_nodes.meta_to_strpos(meta, "max") .. "]" ..
		"image_button[0.5,1;1,1;" .. checkmark(meta:get_int("active")) .. ";active;Is Active]" ..
		"button[2.25,1;2,1;submit;Update]" ..
		"label[0.5,2;Trigger Actions:]" ..
		"button[0.5,3;2,1;lights_off;Lights Off]"
	return formspec
end

minetest.register_node("reentry_nodes:solid_floor_trigger", {
	description = "Spaceship Floor Trigger",
	tiles = {"reentry_nodes_solid_floor_trigger.png"},
    groups = {mapnode = 1, trigger=1},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		reentry_nodes.vector3_to_meta(vector.new(0, 0, 0), meta, "min")
		reentry_nodes.vector3_to_meta(vector.new(0, 0, 0), meta, "max")
		meta:set_int("active", 0)
		meta:set_string("trigger", "none")
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local privs = minetest.get_player_privs(clicker:get_player_name())
		if privs.server then minetest.show_formspec(clicker:get_player_name(), "trigger_" .. minetest.pos_to_string(pos, 0), reentry_nodes.create_trigger_formspec(pos)) end
	end,
	on_timer = function(pos, elapsed)
		local meta = minetest.get_meta(pos)
		local posmin = vector.add(pos, reentry_nodes.meta_to_vector3(meta, "min"))
		local posmax = vector.add(pos, reentry_nodes.meta_to_vector3(meta, "max"))
		local activated = reentry_nodes.trigger_check(posmin, posmax, "player")
		if activated ~= nil and meta:get_string("trigger") ~= "none" then
			reentry_nodes.trigger_run(meta:get_string("trigger"), pos)
			return true
		end
		return true
	end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	local form = formname:split("_")
	if form[1] ~= "trigger" then
		return
	end
	
	local pos = vector.new(minetest.string_to_pos(form[2]))
	local meta = minetest.get_meta(pos)
	if fields.active then
		local active = meta:get_int("active")
		local timer = minetest.get_node_timer(pos)
		if active == 1 then
			meta:set_int("active", 0)
			timer:stop()
		else
			meta:set_int("active", 1)
			timer:start(0.5)
		end
	end

	if fields.lights_off then
		meta:set_string("trigger", "lights_off")
	end

	if fields.submit then
		local posmn = fields.posmin:split(", ")
		local posmin = vector.new(posmn[1], posmn[2], posmn[3])
		reentry_nodes.vector3_to_meta(posmin, meta, "min")

		local posmx = fields.posmax:split(", ")
		local posmax = vector.new(posmx[1], posmx[2], posmx[3])
		reentry_nodes.vector3_to_meta(posmax, meta, "max")
	end

	if not fields.quit then
		minetest.show_formspec(player:get_player_name(), "trigger_" .. minetest.pos_to_string(pos, 0), reentry_nodes.create_trigger_formspec(pos))
	end
end)

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

minetest.register_chatcommand("pts", {
	description = "PosToString",
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if player then
			minetest.chat_send_player(name, minetest.pos_to_string(player:get_pos()), 0)
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