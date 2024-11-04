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
