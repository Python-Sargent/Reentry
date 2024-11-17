reentry_systems = {}

local modpath = minetest.get_modpath("reentry_systems")

reentry_systems.power = "on"

reentry_systems.set_power = function(powerstate)
    reentry_systems.power = powerstate
end

reentry_systems.get_power = function()
    return reentry_systems.power
end

reentry_systems.lights_off = function(pos1, pos2, _)
    reentry_systems.set_power("off")

    local nodepositions, nodecounts = core.find_nodes_in_area(pos1, pos2, {
        "reentry_nodes:solid_floor_light",
        "reentry_nodes:solid_wall_light",
        "reentry_nodes:solid_ceiling_light",
    }, false)

    for i, pos in pairs(nodepositions) do
        local nodename = minetest.get_node(pos).name
        if nodename == "reentry_nodes:solid_floor_light" then
            minetest.set_node(pos, {name="reentry_nodes:solid_floor_light_off"})
        elseif nodename == "reentry_nodes:solid_wall_light" then
            minetest.set_node(pos, {name="reentry_nodes:solid_wall_light_off"})
        elseif nodename == "reentry_nodes:solid_ceiling_light" then
            minetest.set_node(pos, {name="reentry_nodes:solid_ceiling_light_off"})
        end
    end
end

reentry_systems.lights_on = function(pos1, pos2, _)
    reentry_systems.set_power("on")

    local nodepositions, nodecounts = core.find_nodes_in_area(pos1, pos2, {
        "reentry_nodes:solid_floor_light_off",
        "reentry_nodes:solid_wall_light_off",
        "reentry_nodes:solid_ceiling_light_off",
    }, false)

    for i, pos in pairs(nodepositions) do
        local nodename = minetest.get_node(pos).name
        if nodename == "reentry_nodes:solid_floor_light_off" then
            minetest.set_node(pos, {name="reentry_nodes:solid_floor_light"})
        elseif nodename == "reentry_nodes:solid_wall_light_off" then
            minetest.set_node(pos, {name="reentry_nodes:solid_wall_light"})
        elseif nodename == "reentry_nodes:solid_ceiling_light_off" then
            minetest.set_node(pos, {name="reentry_nodes:solid_ceiling_light"})
        end
    end
end

reentry_systems.suffocate = function(player, _, _)
    player:set_flags({breathing=false})
end

reentry_systems.suffocate_end = function(player, _, _)
    player:set_flags({breathing=true})
end

reentry_systems.tick = 256
reentry_systems.breath_tick = 0

local function rmhud(player, handle, handle2)
    player:hud_remove(handle)
    player:hud_remove(handle2)
end

minetest.register_globalstep(function(dtime)
    local connected_players = minetest.get_connected_players()

    if reentry_systems.tick <= 0 then
        for i, player in pairs(connected_players) do
            local pflags = player:get_flags()
            if pflags.breathing == false then
                if player:get_breath() <= 0 then player:set_hp(player:get_hp() - 1, "suffocation") end
                player:set_breath(math.max(player:get_breath() - 1, 0))
            end
        end
        reentry_systems.tick = 256
    else
        reentry_systems.tick = reentry_systems.tick - 1
    end

    if reentry_systems.breath_tick <= 0 then
        for i, player in pairs(connected_players) do
            local pflags = player:get_flags()
            if pflags.breathing == true then
                minetest.sound_play({name = "reentry_systems_breath", gain = 1, pitch = 1}, {to_player = player:get_player_name()}, true)
            else
                minetest.sound_play({name = "reentry_systems_breath", gain = 1, pitch = 2}, {to_player = player:get_player_name()}, true)
            end
        end
        reentry_systems.breath_tick = 210
    else
        reentry_systems.breath_tick = reentry_systems.breath_tick - 1
    end
    for i, player in pairs(connected_players) do
        if player:get_pos().y <= -50 then
            player:set_pos({x=72,y=11,z=0}) --TODO set this when I get mapgen setup
			player:add_player_velocity(-player:get_velocity())
            player:set_hp(20)
            local vignette = player:hud_add({
                hud_elem_type = "image",
                position  = {x = 0, y = 0},
                offset    = {x = 0, y = 0},
                text      = "reentry_systems_vignette.png",
                scale     = { x = 16, y = 16},
                alignment = { x = 1, y = 1 },
                z_index   = -400,
            })
            local respawned = player:hud_add({
                hud_elem_type = "text",
                position      = {x = 0.5, y = 0.5}, -- pos normalized (-1 to 1)
                offset        = {x = -216,   y = -32}, -- offset (px)
                text          = "Returned to Airlock",
                alignment     = {x = 1, y = 1}, -- alignment normalized (-1 to 1)
                size         = {x = 3, y = 3}, -- scale (px)
                number        = 0xBBAAFF, -- color (hex) using table to convert colortext to hex
            })
            minetest.after(3, rmhud, player, respawned, vignette)
        end
    end
end)

minetest.register_chatcommand("lights", {
	description = "Control the lights in the spaceship",
    privs={interact=true, server=true},
	func = function(name, param)
		if param == "off" then
            reentry_systems.set_power("off")
            reentry_systems.lights_off(vector.new(64, 64, 64), vector.new(-64, -64, -64))
        elseif param == "on" then
            reentry_systems.set_power("on")
            reentry_systems.lights_on(vector.new(64, 64, 64), vector.new(-64, -64, -64))
        else
           minetest.chat_send_player(name, "Missing paramater, Usage: \n/lights on (turns lights on)\n/lights off (turns lights off)")
        end
	end
})

minetest.register_craftitem("reentry_systems:flashlight", {
    description = "Flashlight",
    inventory_image = "reentry_systems_flashlight.png",
    on_use = function(itemstack, user, pointed_thing)
        return ItemStack("reentry_systems:flashlight_off")
    end,
    on_secondary_use = function(itemstack, user, pointed_thing)
        return ItemStack("reentry_systems:flashlight_off")
    end,
    on_place = function(itemstack, placer, pointed_thing)
        return ItemStack("reentry_systems:flashlight_off")
    end,
})

minetest.register_craftitem("reentry_systems:flashlight_off", {
    description = "Flashlight",
    inventory_image = "reentry_systems_flashlight_off.png",
    on_use = function(itemstack, user, pointed_thing)
        return ItemStack("reentry_systems:flashlight")
    end,
    on_secondary_use = function(itemstack, user, pointed_thing)
        return ItemStack("reentry_systems:flashlight")
    end,
    on_place = function(itemstack, placer, pointed_thing)
        return ItemStack("reentry_systems:flashlight")
    end,
})

wielded_light.register_item_light("reentry_systems:flashlight", 14, false)

reentry_systems.create_engine_particlespawner = function(pos, dir)
    local spawner = {
        amount = 30,
        time = 0,
        texture = "reentry_systems_engine_particle.png",
        animation = {},
        -- Optional, specifies how to animate the particles' texture
        -- v5.6.0 and later: set length to -1 to synchronize the length
        -- of the animation with the expiration time of individual particles.
        -- (-2 causes the animation to be played twice, and so on)
        glow = 14,
        maxpos = vector.add(pos, dir),
        minpos = vector.offset(pos, -0.5, -0.5, -0.5),
        pos = {
            min = vector.offset(pos, 0.5, 0.5, 0.5),
            max = vector.offset(pos, -0.5, -0.5, -0.5),
            bias = 0,
        },
    }
    
end

reentry_systems.ignite_engine = function(pos1, pos2, _)
    local nodepositions, nodecounts = core.find_nodes_in_area(pos1, pos2, {
        "reentry_nodes:thruster_nozzle"
    }, false)

    for i, pos in pairs(nodepositions) do
        if minetest.get_node(vector.offset(pos, 1, 0, 0)).name == "air" then
            minetest.add_particlespawner(reentry_systems.create_engine_particlespawner(pos, vector.new(6, 0, 0)))
            minetest.set_node(vector.offset(pos, 1, 0, 0), {name="reentry_nodes:plasma"})
            minetest.set_node(vector.offset(pos, 2, 0, 0), {name="reentry_nodes:plasma"})
            minetest.set_node(vector.offset(pos, 3, 0, 0), {name="reentry_nodes:plasma"})
        elseif minetest.get_node(vector.offset(pos, -1, 0, 0)).name == "air" then
            minetest.add_particlespawner(reentry_systems.create_engine_particlespawner(pos, vector.new(-6, 0, 0)))
            minetest.set_node(vector.offset(pos, -1, 0, 0), {name="reentry_nodes:plasma"})
            minetest.set_node(vector.offset(pos, -2, 0, 0), {name="reentry_nodes:plasma"})
            minetest.set_node(vector.offset(pos, -3, 0, 0), {name="reentry_nodes:plasma"})
        elseif minetest.get_node(vector.offset(pos, 0, 0, 1)).name == "air" then
            minetest.add_particlespawner(reentry_systems.create_engine_particlespawner(pos, vector.new(0, 0, 6)))
            minetest.set_node(vector.offset(pos, 0, 0, 1), {name="reentry_nodes:plasma"})
            minetest.set_node(vector.offset(pos, 0, 0, 2), {name="reentry_nodes:plasma"})
            minetest.set_node(vector.offset(pos, 0, 0, 3), {name="reentry_nodes:plasma"})
        elseif minetest.get_node(vector.offset(pos, 0, 0, -1)).name == "air" then
            minetest.add_particlespawner(reentry_systems.create_engine_particlespawner(pos, vector.new(0, 0, -6)))
            minetest.set_node(vector.offset(pos, 0, 0, -1), {name="reentry_nodes:plasma"})
            minetest.set_node(vector.offset(pos, 0, 0, -2), {name="reentry_nodes:plasma"})
            minetest.set_node(vector.offset(pos, 0, 0, -3), {name="reentry_nodes:plasma"})
        end
    end
end

reentry_systems.place_map = function()
    minetest.place_schematic(vector.new(19, -6, -35), modpath .. "/schematics/map1.mts", nil, nil, false)
end

reentry_systems.place_end = function()
    minetest.place_schematic(vector.new(9996, 9999, 9996), modpath .. "/schematics/end.mts", nil, nil, true)
end

reentry_systems.map_meta = {}

reentry_systems.save_meta = function()
    local nodepositions, nodecounts = core.find_nodes_in_area(vector.new(64, 64, 64), vector.new(-64, -64, -64), {
        "reentry_nodes:solid_floor_trigger",
        "reentry_nodes:solid_wall_trigger",
        "reentry_nodes:solid_ceiling_trigger",
    }, false)

    for i, pos in pairs(nodepositions) do
        local meta = minetest.get_meta(pos)
        reentry_systems.map_meta[pos] = {
            x1 = meta:get_float("xmin"),
            y1 = meta:get_float("ymin"),
            z1 = meta:get_float("zmin"),

            x2 = meta:get_float("xmax"),
            y2 = meta:get_float("ymax"),
            z2 = meta:get_float("zmax"),

            timer_delay = meta:get_float("timer_delay"),
            active = meta:get_int("active"),
            keep_active = meta:get_int("keep_active"),

            trigger = meta:get_string("trigger"),
            paramater1 = meta:get_string("parameter1"),
            paramater2 = meta:get_string("parameter2")
        }
    end
end

reentry_systems.load_meta = function()
    local nodepositions, nodecounts = core.find_nodes_in_area(vector.new(64, 64, 64), vector.new(-64, -64, -64), {
        "reentry_nodes:solid_floor_trigger",
        "reentry_nodes:solid_wall_trigger",
        "reentry_nodes:solid_ceiling_trigger",
    }, false)

    for i, pos in pairs(nodepositions) do
        local meta = minetest.get_meta(pos)
        meta:set_float("xmin", reentry_systems.map_meta[pos].x1)
        meta:set_float("ymin", reentry_systems.map_meta[pos].y1)
        meta:set_float("zmin", reentry_systems.map_meta[pos].z1)

        meta:set_float("xmax", reentry_systems.map_meta[pos].x2)
        meta:set_float("ymax", reentry_systems.map_meta[pos].y2)
        meta:set_float("zmax", reentry_systems.map_meta[pos].z2)

        meta:set_float("timer_delay", reentry_systems.map_meta[pos].timer_delay)
        meta:set_int("active", reentry_systems.map_meta[pos].active)
        meta:set_int("keep_active", reentry_systems.map_meta[pos].keep_active)

        meta:set_string("trigger", reentry_systems.map_meta[pos].trigger)
        meta:set_string("parameter1", reentry_systems.map_meta[pos].parameter1)
        meta:set_string("paramater2", reentry_systems.map_meta[pos].parameter2)
    end
end

minetest.register_chatcommand("place_map", {
	description = "Place the map",
    privs={interact=true, server=true},
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if player then
			reentry_systems.place_map()
		else
			return false, "You must be a player to run this command"
		end
	end
})
