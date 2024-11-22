reentry_story = {}

reentry_story.quest = {
    name = "play_the_game",
    title = "Welcome to the IOSRLab",
    desc = "The most advanced microgravity lab 'on' the planet."
}

reentry_story.quests = {}

reentry_story.register_quest = function(params)
    reentry_story.quests[params.name] = {
        title = params.title,
        desc = params.desc
    }
end

reentry_story.register_quest({
    name = "what_happened",
    title = "Where Am I",
    desc = "Find out what happened"
})

reentry_story.register_quest({
    name = "fix_generator",
    title = "Generator Trouble",
    desc = "Fix the generator"
})

reentry_story.register_quest({
    name = "find_the_damage",
    title = "What broke now?",
    desc = "Find and fix the failures"
})

reentry_story.register_quest({
    name = "restart_engine",
    title = "Restart the Engines",
    desc = "Fix and start the main thruster"
})

reentry_story.set_quest = function(name)
    local quest = reentry_story.quests[name]
    if quest ~= nil then reentry_story.quest = quest else minetest.log("invalid quest: " .. name) end
end

reentry_story.get_quest = function()
    return reentry_story.quest
end

reentry_story.HUDs = {}

reentry_story.remove_HUDs = function(player)
    local huds = reentry_story.HUDs[player:get_player_name()]
    if huds ~= nil then
        if huds.bg ~= nil then player:hud_remove(huds.bg) end
        if huds.quest_title ~= nil then player:hud_remove(huds.quest_title) end
        if huds.quest_desc ~= nil then player:hud_remove(huds.quest_desc) end
    end
end

reentry_story.add_HUDs = function(player)
    local bg = player:hud_add({
        hud_elem_type = "image",
        position  = {x = 1, y = 0.425},
        offset    = {x = -2, y = 24},
        text      = "reentry_story_bg.png",
        scale     = { x = 10, y = 3},
        alignment = { x = -1, y = 0 },
    })
    local quest_title = player:hud_add({
        hud_elem_type = "text",
        position      = {x = 1, y = 0.425}, -- pos normalized (-1 to 1)
        offset        = {x = -16,   y = 0}, -- offset (px)
        text          = reentry_story.quest.title,
        alignment     = {x = -1, y = 0}, -- alignment normalized (-1 to 1)
        size         = {x = 2, y = 2}, -- scale (px)
        number        = 0xBBAAFF, -- color (hex) using table to convert colortext to hex
    })
    local quest_desc = player:hud_add({
        hud_elem_type = "text",
        position      = {x = 1, y = 0.425}, -- pos normalized (-1 to 1)
        offset        = {x = -24,   y = 32}, -- offset (px)
        text          = reentry_story.quest.desc,
        alignment     = {x = -1, y = 0}, -- alignment normalized (-1 to 1)
        size         = {x = 1, y = 1}, -- scale (px)
        number        = 0xFFFFFF, -- color (hex) using table to convert colortext to hex
    })
    reentry_story.HUDs[player:get_player_name()] = {bg = bg, quest_title = quest_title, quest_desc = quest_desc}
end

reentry_story.update_quest = function()
    local players = minetest.get_connected_players()

    for i, player in pairs(players) do
        reentry_story.remove_HUDs(player)
        reentry_story.add_HUDs(player)
    end
end

reentry_story.storyline = {
    ["intro"] = {title = "Wake up!", text = {
        "You wake up with a slight bump on your head. What happened? Why am I wearing my spacesuit?",
        "You can't remeber why you are sitting here above the control room" .. minetest.formspec_escape(","),
        "Or even why you are here at all" .. minetest.formspec_escape(",") .. " as you stand breathing heavily your memory slowly comes back.",
        "I was up here keeping watch over the systems" .. minetest.formspec_escape(",") .. " there had been a field of asteroids detected",
        "But the ship navigated through unharmed" .. minetest.formspec_escape(",") .. " It's oddly silent too.",
    }, quest = "what_happened", read = nil},

    ["lights"] = {title = "Uh oh...", text = {
        "The lights went out" .. minetest.formspec_escape(",") .. " that's strange.",
        "It must be the main generator" .. minetest.formspec_escape(",") .. " but why would that stop running?",
        "If the generator doesn't turn back on the oxygen regulators will stop working" .. minetest.formspec_escape(","),
        "and the temperature regulators won't continue to condition the false atmosphere in the station.", 
        "I need to get to the Main Generator" .. minetest.formspec_escape(",") .. " and figure out why it's not working."
    }, quest = "fix_generator", read = nil},

    ["airlock"] = {title = "The Airlock.", text = {
        "Oh this is the airlock" .. minetest.formspec_escape(",") .. " nothing much to see out here I guess.",
        "The Airlock doors won't open anyways if the power is out",
        "Although I'm sure I'd be fine to explore for a while with my spacesuit.",
    }, read = nil},

    ["generator"] = {title = "Find the Generator.", text = {
        "Looks like the generator room should be on the right.",
        "I need to turn that on before I do anything else.",
    }, read = nil},

    ["generator_2"] = {title = "The Auxilary Generator.", text = {
        "The main generator must be damaged" .. minetest.formspec_escape(",") .. " let's turn the auxilary one on.",
        "There's a lever on the other side of the room.",
    }, read = nil},

    ["lever"] = {title = "Powered Up.", text = {
        "Looks like that did it" .. minetest.formspec_escape(",") .. " maybe the doors will work now so I can explore further."
    }, quest = "what_happened", read = false},

    ["lab"] = {title = "Testing Grounds", text = {
        "The lab is on the left" .. minetest.formspec_escape(",") .. " that's where they had been doing some tests on plasma.",
        "Plasma is the form of matter that builds outside spacecraft during reentry interestingly enough" .. minetest.formspec_escape(","),
        "It is also what lightning is made up of" .. minetest.formspec_escape(",") .. " so you can expect it to be dangerous to work with."
    }, read = nil},

    ["plasma"] = {title = "Hot Air", text = {
        "There are two plasma containment facilities in this room" .. minetest.formspec_escape(","),
        "The one on the right is much bigger and holds up to nine times as much plasma" .. minetest.formspec_escape(","),
        "But it also takes more power to run so generally the smaller plasma generator on the left is used.",
        "Let's take a look and see if everything is in order before we move on."
    }, read = nil},

    ["view"] = {title = "Excellent View", text = {
        "Ah" .. minetest.formspec_escape(",") .. " the Cupola is just above" .. minetest.formspec_escape(","),
        "I wonder if I could see what is wrong if I got up there."
    }, read = nil},

    ["control"] = {title = "Backtrack", text = {
        "Strange" .. minetest.formspec_escape(",") .. " there's a high quantity of ice particles in the area",
        "Almost as if an asteroid was decimated recently near here. I guess now that the power is on" .. minetest.formspec_escape(","),
        "I should check the control room monitors" .. minetest.formspec_escape(",") .. " maybe there's some information still on them."
    }, read = nil},

    ["monitor"] = {title = "Spaceship's Heart-Meter.", text = {
        "Looks like this machine still works" .. minetest.formspec_escape(",") .. " now that I've turned the power on."
    }, read = false},

    ["monitor2"] = {title = "Somthins' Broke.", text = {
        "Wow" .. minetest.formspec_escape(",") .. " that's a lot of errors. No wonder I am wearing my spacesuit if the Oxygen levels are so low.",
        "I suspected that the radio would be down" .. minetest.formspec_escape(",") .. " for some reason the satelite comms are down too.",
        "I need to fix the battery bank" .. minetest.formspec_escape(",") .. " there is something wrong with it.",
        "Oh" .. minetest.formspec_escape(",") .. " 'Critical Infrastructure Failure'" .. minetest.formspec_escape(",") .. " what could that be?"
    }, quest = "find_the_damage", read = false},

    ["battery"] = {title = "The Battery Bank.", text = {
        "The battery bank is to the right" .. minetest.formspec_escape(",") .. " I think it needs to be fixed."
    }, read = nil},

    ["short"] = {title = "Electrical Short Circuit.", text = {
        "Oh no" .. minetest.formspec_escape(",") .. " not again" .. minetest.formspec_escape(",") .. " something is shorted out now" .. minetest.formspec_escape(",") .. " I'm going to have to turn the battery bypass on.",
        "That must be why the batteries were so low."
    }, read = nil},

    ["reserves"] = {title = "Reserves.", text = {
        "This is the reserves room" .. minetest.formspec_escape(",") .. " it holds all of the oxygen" .. minetest.formspec_escape(",") .. " food" .. minetest.formspec_escape(",") .. " water and other reserves.",
        "I've always wondered why it was all in the same room."
    }, read = nil},

    ["asteroid"] = {title = "Critical Failure.", text = {
        "Oh. Oh no. That's bad" .. minetest.formspec_escape(",") .. " *wheeze*. Why is *Wheeze* my suit not working.",
        "I need to figure this out quickly and then go back to the ship."
    }, read = nil},

    ["asteroid_2"] = {title = "The Asteroid.", text = {
        "Wow. That's what did it. That's a huge asteroid" .. minetest.formspec_escape(",") .. " that explains the ice shards I saw.",
        "I wonder if it damaged anything else" .. minetest.formspec_escape(",") .. " I should get my breath back before I explore more."
    }, read = nil},

    ["engine"] = {title = "33 Raptor Engines.", text = {
        "This is the thruster" .. minetest.formspec_escape(",") .. " it controls most of the velocity" .. minetest.formspec_escape(",") .. " while the RCS makes sure the ship is oriented correctly.",
        "However it doesn't seem to be running" .. minetest.formspec_escape(",") .. " which is weird because th ship isn't in full orbit right now.",
        "The engine should be on right now to get it back into orbit" .. minetest.formspec_escape(",") .. " I hope it's not broken."
    }, read = nil},

    ["thruster"] = {title = "It's Not On.", text = {
        "Yes" .. minetest.formspec_escape(",") .. " it's definitely not on. That's strange. It's should be on by now.",
        "I wonder if the asteroid broke it?"
    }, quest = "restart_engine", read = nil},

    ["engine_room"] = {title = "The Engine Room.", text = {
        "Looks like I've found the engine room.",
        "Let's see if I can turn it on."
    }, read = nil},

    ["engine_started"] = {title = "The End.", text = {
        "You did it! The engine is started and the laboratory is saved.",
        "Soon there will be contact with the surface and everything will be put to normal."
    }, read = false, the_end = true},

    --[[ ["intro"] = {title = "Introduction", text = "You are going to die soon prob," ..
    " remedy the horrible situation you are in by beating your head again'st the sidewall, do it. I dare you to." ..
    " I garuntee it will hurt, but if you do it hard enough you won't have to woryy about that. If you see this text in the Game Jam Submission" ..
    " something has gone horribly wrong, and I hope I don't beat myself up to much about it."},
    ["trigger"] = {title = "The Trigger", text = "Triggers can be set to trigger different events in the reentry systems mod." ..
    " At some point I plan to make it so that these triggers are defined dynamically and not hardcoded, but for now that's how it is." ..
    " The text you are seeing is the result of a trigger, which called a function that showed you this formspec that you are now reading."}, ]]
}

reentry_story.get_story = function(line)
    local story = reentry_story.storyline[line]
    if story ~= nil and story.text ~= nil and story.title ~= nil then
        return story
    else
        return {text = {"Failed to retrieve story", "Check to make sure you used the correct name"}, title = "Failed"}
    end
end

reentry_story.create_story = function(story)
    local storytext = ""
    for i, line in pairs(story.text) do
        storytext = storytext .. "," .. line
    end
    return storytext
end

reentry_story.create_formspec = function(line)
    local story = reentry_story.get_story(line)
    local formspec = "size[11,10]" ..
        "bgcolor[#333333]" ..
        "label[0.25,0;" .. story.title .. "]" ..
        "textlist[0.25,0.5;10.5,9;story;" .. reentry_story.create_story(story) .. "]" ..
		"button_exit[0.25,9.5;10.5,1;done;Done]"
	return formspec
end

local end_huds = {}

reentry_story.blackout = function(player)
    local bg = player:hud_add({
        hud_elem_type = "image",
        position  = {x = 0, y = 0},
        offset    = {x = 0, y = 0},
        text      = "reentry_story_end_bg.png",
        scale     = { x = 16, y = 16},
        alignment = { x = 1, y = 1 },
        z_index   = -400,
    })
    end_huds[player:get_player_name()] = bg
end

reentry_story.end_text = function(player)
    local respawned = player:hud_add({
        hud_elem_type = "text",
        position      = {x = 0.5, y = 0.5}, -- pos normalized (-1 to 1)
        offset        = {x = -128,   y = -64}, -- offset (px)
        text          = "The End",
        alignment     = {x = 1, y = 1}, -- alignment normalized (-1 to 1)
        size         = {x = 6, y = 6}, -- scale (px)
        number        = 0xBBAA11, -- color (hex) using table to convert colortext to hex
    })
end

reentry_story.tp_end = function(player)
    player:set_pos(vector.new(49, 2, -4))
    player:add_player_velocity(-player:get_velocity())
    player:set_hp(20)
    player:set_look_horizontal(0.75)
    player:set_look_vertical(0.75)
end

reentry_story.tp_endscreen = function(player)
    player:set_pos(vector.new(1000, 1003, 1000))
    player:add_velocity(-player:get_velocity())
    player:set_hp(20)
    minetest.after(0.2, reentry_systems.place_end)
end

reentry_story.end_game = function(player, pos)
    minetest.close_formspec(player:get_player_name(), "control_" .. minetest.pos_to_string(pos, 0))
    reentry_story.remove_HUDs(player)
    minetest.after(15, reentry_story.blackout, player)
    minetest.after(15.25, reentry_story.end_text, player)
    minetest.after(10, reentry_story.tp_endscreen, player)
    minetest.after(0, reentry_story.tp_end, player)
end

reentry_story.story = function(player, line, pos)
    if reentry_story.storyline[line].read == false then
        minetest.show_formspec(player:get_player_name(), "storyline", reentry_story.create_formspec(line))
        reentry_story.storyline[line].read = true
        local story = reentry_story.get_story(line)
        if story.quest ~= nil then reentry_story.set_quest(story.quest) reentry_story.update_quest() end
        if story.the_end == true then
            reentry_story.end_game(player, pos)
        end
    elseif reentry_story.storyline[line].read == nil then
        minetest.show_formspec(player:get_player_name(), "storyline", reentry_story.create_formspec(line))
        local story = reentry_story.get_story(line)
        if story.quest ~= nil then reentry_story.set_quest(story.quest) reentry_story.update_quest() end
    end
end