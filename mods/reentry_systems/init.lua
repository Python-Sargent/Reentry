reentry_systems = {}

reentry_systems.lights_off = function(pos1, pos2)
    local nodepositions, nodecounts = core.find_nodes_in_area(pos1, pos2, {
        "reentry_nodes:solid_floor_light",
        "reentry_nodes:solid_wall_light",
        "reentry_nodes:solid_ceiling_light",
    }, false)

    for i, pos in pairs(nodepositions) do
        --minetest.log(i)
        --minetest.log(pos)
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

reentry_systems.lights_on = function(pos1, pos2)
    local nodepositions, nodecounts = core.find_nodes_in_area(pos1, pos2, {
        "reentry_nodes:solid_floor_light_off",
        "reentry_nodes:solid_wall_light_off",
        "reentry_nodes:solid_ceiling_light_off",
    }, false)

    for i, pos in pairs(nodepositions) do
        --minetest.log(i)
        --minetest.log(pos)
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

reentry_systems.suffocate = function(player)
    player:set_flags({breathing=false})
    minetest.log("suffocating " .. player:get_player_name())
end

reentry_systems.suffocate_end = function(player)
    player:set_flags({breathing=true})
    minetest.log("giving air to " .. player:get_player_name())
end

reentry_systems.tick = 120
reentry_systems.breath_tick = 0

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
        reentry_systems.tick = 120
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
end)

minetest.register_chatcommand("lights", {
	description = "Control the lights in the spaceship",
    privs={interact=true, server=true},
	func = function(name, param)
		if param == "off" then
            reentry_systems.lights_off(vector.new(64, 64, 64), vector.new(-64, -64, -64))
        elseif param == "on" then
            reentry_systems.lights_on(vector.new(64, 64, 64), vector.new(-64, -64, -64))
        else
           minetest.chat_send_player(name, "Missing paramater, Usage: \n/lights on (turns lights on)\n/lights off (turns lights off)")
        end
	end
})
