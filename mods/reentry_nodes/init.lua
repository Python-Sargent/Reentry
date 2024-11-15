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

minetest.register_node("reentry_nodes:solid_interior", {
	description = "Spaceship Interior",
	tiles = {"reentry_nodes_solid_interior.png"},
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

minetest.register_node("reentry_nodes:ladder", {
	description = "Ladder",
	drawtype = "mesh",
	mesh = "ladder.obj",
	tiles = {"reentry_nodes_ladder.png"},
	paramtype = "light",
	paramtype2 = "4dir",
	climbable = true,
	selection_box = {
		type = "fixed",
		fixed = {-12/32, 0.5, 0.5, -16/32, -0.5, -0.5},
	},
	collision_box = {
		type = "fixed",
		fixed = {-12/32, 0.5, 0.5, -16/32, -0.5, -0.5},
	},
	sunlight_propagates = true,
	groups = {mapnode = 1},
})

minetest.register_node("reentry_nodes:power_panel", {
	description = "Power Panel",
	drawtype = "mesh",
	mesh = "power_panel.obj",
	tiles = {
		"reentry_nodes_power_panel_box.png",
		"reentry_nodes_power_panel.png",
		"reentry_nodes_power_panel_light.png",
	},
	paramtype = "light",
	paramtype2 = "4dir",
	selection_box = {
		type = "fixed",
		fixed = {0.3, 0.35, 0.5, -0.3, -0.35, 0.4},
	},
	collision_box = {
		type = "fixed",
		fixed = {0.3, 0.35, 0.5, -0.3, -0.35, 0.4},
	},
	sunlight_propagates = true,
	groups = {mapnode = 1},
	light_source = 8,
})

minetest.register_node("reentry_nodes:microscope", {
	description = "Microscope",
	drawtype = "mesh",
	mesh = "microscope.obj",
	tiles = {
		"reentry_nodes_microscope_frame.png",
		"reentry_nodes_microscope_base.png",
		"reentry_nodes_microscope_arm.png",
		"reentry_nodes_microscope_screen.png^[brighten",
	},
	selection_box = {
		type = "fixed",
		fixed = {0.25, 0.25, 0.25, -0.25, -0.5, -0.25},
	},
	collision_box = {
		type = "fixed",
		fixed = {0.25, 0.25, 0.25, -0.25, -0.5, -0.25},
	},
	paramtype = "light",
	paramtype2 = "4dir",
	sunlight_propagates = true,
	groups = {mapnode = 1},
})

minetest.register_node("reentry_nodes:table", {
	description = "Table",
	drawtype = "mesh",
	mesh = "table.obj",
	tiles = {
		"reentry_nodes_table.png",
		"reentry_nodes_table_bottom.png"
	},
	paramtype = "light",
	sunlight_propagates = true,
	groups = {mapnode = 1},
})

minetest.register_node("reentry_nodes:table_top", {
	description = "Table Top",
	drawtype = "mesh",
	mesh = "table_top.obj",
	tiles = {"reentry_nodes_table.png"},
	paramtype = "light",
	sunlight_propagates = true,
	groups = {mapnode = 1},
})

minetest.register_node("reentry_nodes:paper_pad", {
	description = "Pad of Paper",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {0.5, -0.475, 0.5, -0.5, -0.5, -0.5}
	},
	tiles = {"reentry_nodes_paper_pad.png"},
    groups = {mapnode = 1},
})

minetest.register_node("reentry_nodes:monitor_desk", {
	description = "Desk Monitor",
	drawtype = "mesh",
	mesh = "monitor_desk.obj",
	tiles = {
		"reentry_nodes_monitor_frame.png",
		"reentry_nodes_monitor_screen.png"
	},
	selection_box = {
		type = "fixed",
		fixed = {0.35, 0.125, 0.35, -0.35, -0.5, -0.35},
	},
	collision_box = {
		type = "fixed",
		fixed = {0.35, 0.125, 0.35, -0.35, -0.5, -0.35},
	},
	paramtype = "light",
	paramtype2 = "4dir",
	sunlight_propagates = true,
	groups = {mapnode = 1},
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		if reentry_systems.get_power() == "on" then
			minetest.set_node(pos, {name="reentry_nodes:monitor_desk_starting"})
		else
			minetest.chat_send_player(clicker:get_player_name(), "The battery seems to have died")
		end
	end,
})

minetest.register_node("reentry_nodes:monitor_desk_starting", {
	description = "Desk Monitor (Starting))",
	drawtype = "mesh",
	mesh = "monitor_desk.obj",
	tiles = {
		"reentry_nodes_monitor_frame.png",
		"reentry_nodes_monitor_screen_2.png"
	},
	selection_box = {
		type = "fixed",
		fixed = {0.35, 0.125, 0.35, -0.35, -0.5, -0.35},
	},
	collision_box = {
		type = "fixed",
		fixed = {0.35, 0.125, 0.35, -0.35, -0.5, -0.35},
	},
	paramtype = "light",
	paramtype2 = "4dir",
	sunlight_propagates = true,
	diggable = false,
	groups = {mapnode = 1},
	on_construct = function(pos)
		local timer = minetest.get_node_timer(pos)
		timer:start(3)
	end,
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name="reentry_nodes:monitor_desk_on"})
	end,
})

reentry_nodes.create_monitor_formspec = function()
	local formspec = "formspec_version[6]" ..
	"size[10.5,11]" ..
	"bgcolor[#111111]" ..
	"label[0.1,0.3;Locked Session]" ..
	"textlist[0,0.6;10.5,10.4;terminal;" .. minetest.formspec_escape("[") .. "shipmonitor@IOSRL" .. minetest.formspec_escape("]") .. "$ ./monitor.sh," .. minetest.formspec_escape("[") .. "STATUS" .. minetest.formspec_escape("]") .. " Monitor Running," .. minetest.formspec_escape("[") .. "WARN" .. minetest.formspec_escape("]") .. " Oxygen 15%: Auxilary Oxygen Required," .. minetest.formspec_escape("[") .. "WARN" .. minetest.formspec_escape("]") .. " Electricity Capacity 18% charge: Emergency Backups in use," .. minetest.formspec_escape("[") .. "ERR" .. minetest.formspec_escape("]") .. " No Radio Contact," .. minetest.formspec_escape("[") .. "ERR" .. minetest.formspec_escape("]") .. " Temperature Control: Not Running," .. minetest.formspec_escape("[") .. "ERR" .. minetest.formspec_escape("]") .. " Critical Infrastructure Disability Detetcted;1;true]" ..
	"image_button_exit[0.3,9.7;1,1;off.png;power_off;;false;false]"
	return formspec
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	local form = formname:split("_")
	if form[1] ~= "monitor" then
		return
	end
	
	local pos = vector.new(minetest.string_to_pos(form[2])) -- compile positional data passed through formname back into pos
	
	if fields.power_off then
		minetest.set_node(pos, {name="reentry_nodes:monitor_desk"})
	end

	if not fields.quit then
		minetest.show_formspec(player:get_player_name(), "monitor_" .. minetest.pos_to_string(pos, 0), reentry_nodes.create_monitor_formspec())
	end
end)

minetest.register_node("reentry_nodes:monitor_desk_on", {
	description = "Desk Monitor (on)",
	drawtype = "mesh",
	mesh = "monitor_desk.obj",
	tiles = {
		"reentry_nodes_monitor_frame.png",
		"reentry_nodes_monitor_screen_on.png"
	},
	selection_box = {
		type = "fixed",
		fixed = {0.35, 0.125, 0.35, -0.35, -0.5, -0.35},
	},
	collision_box = {
		type = "fixed",
		fixed = {0.35, 0.125, 0.35, -0.35, -0.5, -0.35},
	},
	paramtype = "light",
	paramtype2 = "4dir",
	sunlight_propagates = true,
	groups = {mapnode = 1},
	drop = "reentry_nodes:monitor_desk",
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		--minetest.set_node(pos, {name="reentry_nodes:monitor_desk"})
		minetest.show_formspec(clicker:get_player_name(), "monitor_" .. minetest.pos_to_string(pos, 0), reentry_nodes.create_monitor_formspec())
	end,
})

minetest.register_node("reentry_nodes:suitlocker", {
	description = "Spacesuit Locker",
	drawtype = "mesh",
	mesh = "suitlocker.obj",
	tiles = {
		"reentry_nodes_character.png",
		"reentry_nodes_suitlocker.png",
		"",
	},
	selection_box = {
		type = "fixed",
		fixed = {0.5, 1.5, 0.5, -0.5, -0.5, -0.5},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "4dir",
	sunlight_propagates = true,
	groups = {mapnode = 1},
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		if minetest.get_node(vector.offset(pos, 0, 1, 0)).name ~= "air" then
			return false
		end
	end,
	on_construct = function(pos)
		minetest.set_node(vector.offset(pos, 0, 1, 0), {name = "reentry_nodes:suitlocker_top"})
	end,
	on_destruct = function(pos)
		minetest.set_node(vector.offset(pos, 0, 1, 0), {name = "air"})
	end,
})

minetest.register_node("reentry_nodes:suitlocker_top", {
	description = "Suitlocker (top)",
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
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


minetest.register_node("reentry_nodes:window", {
	description = "Window",
	drawtype = "glasslike_framed",
	tiles = {"reentry_nodes_window.png"},
	use_texture_alpha = "blend",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {mapnode = 1},
	
})

minetest.register_node("reentry_nodes:plasma", {
	description = "Plasma",
	drawtype = "glasslike",
	inventory_image = "reentry_nodes_plasma_inv.png",
	tiles = {"reentry_nodes_plasma.png"}, --^[brighten
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	sunlight_propagates = true,
	groups = {mapnode = 1},
	light_source = 14,
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
		if reentry_systems.get_power() == "on" then
			minetest.swap_node(pos, {name="reentry_nodes:door_bottom_open"})
			minetest.swap_node(vector.offset(pos, 0, 1, 0), {name = "reentry_nodes:door_top_open"})
		end
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
		if reentry_systems.get_power() == "on" then
			minetest.swap_node(pos, {name="reentry_nodes:door_bottom"})
			minetest.swap_node(vector.offset(pos, 0, 1, 0), {name = "reentry_nodes:door_top"})
		end
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
	return nil
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
		"field[0.3,2.3;0.9,0.5;keep_active;Keep Active;" .. reentry_nodes.into_to_boolstr(meta:get_int("keep_active")) .. "]"
		--"field[3.4,2.4;3,0.4;reset_delay;Reset Delay;" .. meta:get_int("reset_delay") .. "]"
	return formspec
end

reentry_nodes.trigger_on_construct = function(pos)
	local meta = minetest.get_meta(pos)
	reentry_nodes.vector3_to_meta(vector.new(0, 0, 0), meta, "min")
	reentry_nodes.vector3_to_meta(vector.new(0, 0, 0), meta, "max")
	meta:set_float("timer_delay", 0.5)
	meta:set_int("active", 0) -- used as boolean just like C
	meta:set_int("keep_active", 0) -- ditto
	meta:set_string("trigger", "none")
	meta:set_string("parameter1", "")
	meta:set_string("parameter2", "")
end

reentry_nodes.trigger_on_rightlick = function(pos, node, clicker, itemstack, pointed_thing)
	local privs = minetest.get_player_privs(clicker:get_player_name())
	if privs.server then minetest.show_formspec(clicker:get_player_name(), "trigger_" .. minetest.pos_to_string(pos, 0), reentry_nodes.create_trigger_formspec(pos)) end
end

reentry_nodes.trigger_on_timer = function(pos, elapsed)
	local meta = minetest.get_meta(pos)
	local posmin = vector.add(pos, reentry_nodes.meta_to_vector3(meta, "min")) or vector.new(64, 64, 64)
	local posmax = vector.add(pos, reentry_nodes.meta_to_vector3(meta, "max")) or vector.new(-64, -64, -64)
	local activated = reentry_nodes.trigger_check(posmin, posmax, "player")
	if activated ~= nil and meta:get_string("trigger") ~= "none" and activated:is_player() then
		if meta:get_int("active") == 1 then reentry_nodes.trigger_run(meta:get_string("trigger"), {pos = pos, player = activated, meta = meta, param1 = meta:get_string("parameter1"), param2 = meta:get_string("parameter2")}) end
		if meta:get_int("keep_active") == 0 then meta:set_int("active", 0) end-- if keep_active disabled, deactivate trigger
	end
	return true
end

reentry_nodes.register_trigger_node = function(def)
	minetest.register_node("reentry_nodes:" .. def.type .. "_trigger", {
		description = def.desc,
		tiles = {"reentry_nodes_" .. def.type .. "_trigger.png"},
		groups = {mapnode = 1, trigger=1},
		on_construct = function(...)
			reentry_nodes.trigger_on_construct(...)
		end,
		on_rightclick = function(...)
			reentry_nodes.trigger_on_rightlick(...)
		end,
		on_timer = function(...)
			return reentry_nodes.trigger_on_timer(...)
		end,
	})
end

reentry_nodes.register_trigger_node({
	desc = "Spaceship Floor Trigger",
	type = "solid_floor",
})

reentry_nodes.register_trigger_node({
	desc = "Spaceship Wall Trigger",
	type = "solid_wall",
})

reentry_nodes.register_trigger_node({
	desc = "Spaceship Ceiling Trigger",
	type = "solid_ceiling",
})

minetest.register_node("reentry_nodes:lever", {
	description = "Lever",
	drawtype = "mesh",
	mesh = "lever.obj",
	tiles = {
		"reentry_nodes_lever_frame.png",
		"reentry_nodes_lever.png"
	},
	selection_box = {
		type = "wallmounted",
		wallmounted = {0.35, 0.35, 0.35, -0.35, -0.5, -0.35},
	},
	walkable = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	place_param2 = 2,
	sunlight_propagates = true,
	groups = {mapnode = 1},
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		reentry_nodes.trigger_run("lights_off", {pos = pos, player = clicker, param1 = "pos1_64", param2 = "pos2_64"})
		minetest.set_node(pos, {name="reentry_nodes:lever_off"})
	end,
})

minetest.register_node("reentry_nodes:lever_off", {
	description = "Lever (off)",
	drawtype = "mesh",
	mesh = "lever_off.obj",
	tiles = {
		"reentry_nodes_lever_frame.png",
		"reentry_nodes_lever.png"
	},
	selection_box = {
		type = "wallmounted",
		wallmounted = {0.35, 0.35, 0.35, -0.35, -0.5, -0.35},
	},
	walkable = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	place_param2 = 2,
	sunlight_propagates = true,
	groups = {mapnode = 1},
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		reentry_nodes.trigger_run("lights_on", {pos = pos, player = clicker, param1 = "pos1_64", param2 = "pos2_64"})
		reentry_nodes.trigger_run("storyline", {pos = pos, player = clicker, param1 = "player", param2 = "lever"})
		minetest.set_node(pos, {name="reentry_nodes:lever"})
	end,
})

--[[
	minetest.register_node("reentry_nodes:solid_floor_trigger", {
	description = "Spaceship Floor Trigger",
	tiles = {"reentry_nodes_solid_floor_trigger.png"},
    groups = {mapnode = 1, trigger=1},
	on_construct = function(...)
		reentry_nodes.trigger_on_construct(...)
	end,
	on_rightclick = function(...)
		reentry_nodes.trigger_on_rightlick(...)
	end,
	on_timer = function(...)
		reentry_nodes.trigger_on_timer(...)
	end,
})
]]

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
			timer:stop()
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

reentry_nodes.start_triggers = function(pos)
	local nodepositions, nodecounts = core.find_nodes_in_area(vector.offset(pos, 64, 64, 64), vector.offset(pos, -64, -64, -64), {
		"reentry_nodes:solid_floor_trigger",
		"reentry_nodes:solid_wall_trigger",
		"reentry_nodes:solid_ceiling_trigger",
	}, false)

	minetest.log(type(nodepositions))
	
    for i, pos in pairs(nodepositions) do
		minetest.log(type(pos))
		local meta = minetest.get_meta(pos)
        local timer = minetest.get_node_timer(pos)
		timer:stop()
		timer:start(meta:get_int("timer_delay"))
		meta:set_int("active", 1)
    end
end

minetest.register_chatcommand("start_triggers", {
	description = "Activate all triggers",
	privs = {interact=1},
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if player:is_player() then
			reentry_nodes.start_triggers(player:get_pos())
		else
			return false, "You must be a player to run this command"
		end
	end
})

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