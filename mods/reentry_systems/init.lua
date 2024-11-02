reentry_systems = {}

reentry_systems.lights_off = function()
    core.find_nodes_in_area(pos1, pos2, nodenames, false)
end