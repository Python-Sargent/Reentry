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

minetest.register_node("reentry_nodes:window", {
	description = "Window",
	drawtype = "glasslike_framed",
	tiles = {"reentry_nodes_window.png"},
	use_texture_alpha = "blend",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {mapnode = 1},
})

minetest.register_node("reentry_nodes:door_bottom", {
	description = "Door",
	drawtype = "mesh",
	mesh = "door.obj",
	tiles = {
		"reentry_nodes_door.png",
		"reentry_nodes_door_side.png"
	},
	selection_box = {
		type = "fixed",
		fixed = {1.5/32, 1.5, 0.5, -1.5/32, -0.5, -0.5},
	},
	collision_box = {
		type = "fixed",
		fixed = {1.5/32, 1.5, 0.5, -1.5/32, -0.5, -0.5},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "4dir",
	sunlight_propagates = true,
	groups = {mapnode = 1},
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		minetest.rotate_node(itemstack, placer, pointed_thing)
		if minetest.get_node(vector.offset(pos, 0, 1, 0)).name ~= "air" then
			return false
		end
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		minetest.swap_node(pos, {name="reentry_nodes:door_bottom_open"})
		minetest.swap_node(vector.offset(pos, 0, 1, 0), {name = "reentry_nodes:door_top_open"})
	end,
	on_construct = function(pos)
		minetest.set_node(vector.offset(pos, 0, 1, 0), {name = "reentry_nodes:door_top"})
	end,
	on_destruct = function(pos)
		minetest.set_node(vector.offset(pos, 0, 1, 0), {name = "air"})
	end,
})

minetest.register_node("reentry_nodes:door_top", {
	description = "Door (top)",
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = false,
	diggable = false,
	buildable_to = false,
	floodable = false,
	drop = "",
	collision_box = {
		type = "fixed",
		fixed = {1.5/32, 1.5, 0.5, -1.5/32, -0.5, -0.5},
	},
	groups = {mapnode = 1, not_in_creative_inventory = 1},
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		minetest.rotate_node(itemstack, placer, pointed_thing)
	end,
})

minetest.register_node("reentry_nodes:door_bottom_open", {
	description = "Door (open)",
	drawtype = "mesh",
	mesh = "door_open.obj",
	tiles = {
		"reentry_nodes_door.png",
		"reentry_nodes_door_side.png"
	},
	selection_box = {
		type = "fixed",
		fixed = {1.5/32, 1.5, 0.5, -1.5/32, -0.5, -0.5},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "4dir",
	sunlight_propagates = true,
	diggable = false,
	walkable = false,
	groups = {mapnode = 1, not_in_creative_inventory=1},
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		minetest.rotate_node(itemstack, placer, pointed_thing)
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		minetest.swap_node(pos, {name="reentry_nodes:door_bottom"})
		minetest.swap_node(vector.offset(pos, 0, 1, 0), {name = "reentry_nodes:door_top"})
	end,
})

minetest.register_node("reentry_nodes:door_top_open", {
	description = "Door (top, open)",
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = false,
	floodable = false,
	drop = "",
	groups = {mapnode = 1, not_in_creative_inventory = 1},
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		minetest.rotate_node(itemstack, placer, pointed_thing)
	end,
})

minetest.register_node("reentry_nodes:relay_disc", {
	description = "Relay Disc Piece",
	tiles = {"reentry_nodes_relay_disc.png"},
    groups = {mapnode = 1},
})


reentry_nodes.vector3_to_meta = function(vec3, meta, suffix)
	meta:set_float("x" .. suffix, vec3.x)
	meta:set_float("y" .. suffix, vec3.y)
	meta:set_float("z" .. suffix, vec3.z)
end

reentry_nodes.meta_to_strpos = function(meta, suffix)
	local x = meta:get_float("x" .. suffix)
	local y = meta:get_int("y" .. suffix)
	local z = meta:get_int("z" .. suffix)
	return x .. ", " .. y .. ", " .. z
end

reentry_nodes.meta_to_vector3 = function(meta, suffix)
	local x = meta:get_float("x" .. suffix)
	local y = meta:get_float("y" .. suffix)
	local z = meta:get_float("z" .. suffix)
	return vector.new(x, y, z)
end

reentry_nodes.into_to_boolstr = function(intbool)
	if intbool == 1 then
		return "true"
	else
		return "false" -- defaults false
	end
end

local function checkmark( checked )
	if checked == 1 then
		return "checkmark_checked.png"
	else
		return "checkmark_unchecked.png"
	end
end

reentry_nodes.triggers = {}

reentry_nodes.register_trigger = function(name, trigger)
	reentry_nodes.triggers[name] = trigger
end

reentry_nodes.register_trigger("lights_off", {
	key = "lights_off",
	func = reentry_systems.lights_off,
})

reentry_nodes.register_trigger("lights_on", {
	key = "lights_on",
	func = reentry_systems.lights_on,
})

reentry_nodes.register_trigger("suffocation_on", {
	key = "suffocation_on",
	func = reentry_systems.suffocate,
})

reentry_nodes.register_trigger("suffocation_off", {
	key = "suffocation_off",
	func = reentry_systems.suffocate_end,
})

reentry_nodes.register_trigger("storyline", {
	key = "storyline",
	func = reentry_story.story,
})

reentry_nodes.populate_params = function(name, params, trigger)
	local param1 = params.param1
	local param2 = params.param2
	local p1
	local p2
	if param1 == "player" then
		p1 = params.player
	elseif param1 == "pos1" then
		p1 = params.pos
	elseif param1 == "pos1_64" then
		p1 = vector.offset(params.pos, 64, 64, 64)
	else
		p1 = param1
	end
	if param2 == "key" then
		p2 = params.key
	elseif param2 == "pos2" then
		p2 = params.pos
	elseif param2 == "pos2_64" then
		p2 = vector.offset(params.pos, -64, -64, -64)
	else
		p2 = param2
	end
	return p1, p2
end

reentry_nodes.trigger_run = function(name, params)
	if name == "none" then minetest.log("Trigger not defined in trigger node at " .. minetest.pos_to_string(params.pos, 0)) end
	local trigger = reentry_nodes.triggers[name]
	if trigger ~= nil then
		trigger.func(reentry_nodes.populate_params(name, params, trigger))
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
	local formspec = "formspec_version[6]" ..
		"size[6.5,5]" ..
		"field[0.2,0.4;3,0.5;posmin;Position Min;" .. reentry_nodes.meta_to_strpos(meta, "min") .. "]" ..
		"field[3.3,0.4;3,0.5;posmax;Position Max;" .. reentry_nodes.meta_to_strpos(meta, "max") .. "]" ..
		"image_button[0.2,0.9;1,1;" .. checkmark(meta:get_int("active")) .. ";active;Active;false;true]" ..
		"button[3.3,1;3,0.8;submit;Update]" ..
		"field[1.4,1.3;1.8,0.5;delay;Timer Delay;0.5]" ..
		"field[0.3,3.3;3,0.5;trigger;Trigger Name;" .. meta:get_string("trigger") .. "]" ..
		"field[0.3,4.3;3,0.5;param1;Param 1;" .. meta:get_string("parameter1") .. "]" ..
		"field[3.4,4.3;3,0.5;param2;Param 2;" .. meta:get_string("parameter2") .. "]" ..
		"button[3.4,3;3,0.8;submit2;Update]" ..
		"field[0.3,2.3;0.9,0.5;keep_active;Keep Active;" .. reentry_nodes.into_to_boolstr(meta:get_int("keep_active")) .. "]" ..
		"field[3.4,2.4;3,0.4;reset_delay;Reset Delay;" .. meta:get_int("reset_delay") .. "]"
		--"size[6.5,5]" ..
		--"field[0.2,0.5;3,0.5;posmin;Position Min;" .. reentry_nodes.meta_to_strpos(meta, "min") .. "]" ..
		--"field[3.3,0.5;3,0.5;posmax;Position Max;" .. reentry_nodes.meta_to_strpos(meta, "max") .. "]" ..
		--"image_button[0.2,1;1,1;" .. checkmark(meta:get_int("active")) .. ";active;Active;false;true]" ..
		--"button[3.3,1.1;3,0.8;submit;Update]" ..
		--"field[1.4,1.4;1.8,0.5;delay;Timer Delay;0.5]" ..
		--"field[0.3,2.6;3,0.8;trigger;Trigger Name;" .. meta:get_string("trigger") .. "]" ..
		--"field[0.3,4;3,0.8;param1;Param 1;" .. meta:get_string("parameter1") .. "]" ..
		--"field[3.4,4;3,0.8;param2;Param 2;" .. meta:get_string("parameter2") .. "]" ..
		--"button[3.4,2.6;3,0.8;submit2;Update]"
		--"size[6.5,5]" ..
		--"field[0.5,0.5;3,1;posmin;Position Min;" .. reentry_nodes.meta_to_strpos(meta, "min") .. "]" ..
		--"field[3.5,0.5;3,1;posmax;Position Max;" .. reentry_nodes.meta_to_strpos(meta, "max") .. "]" ..
		--"image_button[0.5,1;1,1;" .. checkmark(meta:get_int("active")) .. ";active;Is Active]" ..
		--"button[2.25,1;2,1;submit;Update]" ..
		--"field[5,1.5;1,1;delay;Delay;0.5]" ..
		--"label[0.5,2;Trigger Actions]" ..
		--"field[0.5,2.5;3,1;trigger;Trigger;" .. meta:get_string("trigger") .. "]" ..
		--"field[0.5,3.5;3,1;param1;Param 1;" .. meta:get_string("parameter1") .. "]" ..
		--"field[3.5,3.5;3,1;param2;Param 2;" .. meta:get_string("parameter2") .. "]" ..
		--"button[3.5,2;3,1;submit2;Update]"
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
		meta:set_float("timer_delay", 0.5)
		meta:set_float("reset_delay", 5)
		meta:set_int("active", 0) -- used as boolean just like C
		meta:set_int("keep_active", 0) -- ditto
		meta:set_string("trigger", "none")
		meta:set_string("parameter1", "")
		meta:set_string("parameter2", "")
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
		if activated ~= nil and meta:get_string("trigger") ~= "none" and activated:is_player() then
			if meta:get_int("active") == 1 then reentry_nodes.trigger_run(meta:get_string("trigger"), {pos = pos, player = activated, meta = meta, param1 = meta:get_string("parameter1"), param2 = meta:get_string("parameter2")}) end
			if meta:get_int("keep_active") == 0 then meta:set_int("active", 0) end -- if keep_active disabled, deactivate trigger
		end
		return true
	end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	local form = formname:split("_") -- split the trigger, ex. "trigger_(0,0,0)" to "trigger", "(0,0,0)"
	if form[1] ~= "trigger" then
		return
	end
	
	local pos = vector.new(minetest.string_to_pos(form[2])) -- compile positional data passed through formname back into pos
	local meta = minetest.get_meta(pos)
	if fields.active then
		local active = meta:get_int("active")
		local timer = minetest.get_node_timer(pos)
		if active == 1 then
			meta:set_int("active", 0)
			timer:stop()
		else
			meta:set_int("active", 1)
			timer:start(meta:get_int("timer_delay"))
		end
	end
	if fields.submit2 then
		if reentry_nodes.triggers[fields.trigger] then
			meta:set_string("trigger", fields.trigger)
		else
			minetest.log(fields.trigger or type(fields.trigger))
		end
		meta:set_string("parameter1", fields.param1)
		meta:set_string("parameter2", fields.param2)
		meta:set_float("reset_delay", fields.reset_delay)
		if fields.keep_active then
			if fields.keep_active == "true" then
				meta:set_int("keep_active", 1)
			elseif fields.keep_active == "false" then
				meta:set_int("keep_active", 0)
			end
		end
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
			return false, "You must be a player to run this command"
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
			return false, "You must be a player to run this command"
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