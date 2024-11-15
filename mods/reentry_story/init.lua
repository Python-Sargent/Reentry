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
        if huds.bg ~= nil then player:hud_remove(huds.bg) elseif
            huds.quest_title ~= nil then player:hud_remove(huds.quest_title) elseif
            huds.quest_desc ~= nil then player:hud_remove(huds.quest_desc)
        end
    end
end

reentry_story.add_HUDs = function(player)
    local bg = player:hud_add({
        hud_elem_type = "image",
        position  = {x = 1, y = 0.425},
        offset    = {x = -2, y = 16},
        text      = "reentry_story_bg.png",
        scale     = { x = 5, y = 2},
        alignment = { x = -1, y = 0 },
    })
    local quest_title = player:hud_add({
        hud_elem_type = "text",
        position      = {x = 1, y = 0.425}, -- pos normalized (-1 to 1)
        offset        = {x = -8,   y = 0}, -- offset (px)
        text          = reentry_story.quest.title,
        alignment     = {x = -1, y = 0}, -- alignment normalized (-1 to 1)
        scale         = {x = 1, y = 1}, -- scale (px)
        number        = 0xBBAAFF, -- color (hex) using table to convert colortext to hex
    })
    local quest_desc = player:hud_add({
        hud_elem_type = "text",
        position      = {x = 1, y = 0.425}, -- pos normalized (-1 to 1)
        offset        = {x = -8,   y = 32}, -- offset (px)
        text          = reentry_story.quest.desc,
        alignment     = {x = -1, y = 0}, -- alignment normalized (-1 to 1)
        scale         = {x = 1, y = 1}, -- scale (px)
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
    ["intro"] = {title = "Introduction", text = {
        "You wake up with a slight bump on your head. What happened? ",
        "Oh the asteroid" .. minetest.formspec_escape(",") .. " and the fuel leak. ",
        "I've got to do something! We are in a decaying orbit! ",
        "If I don't repair everything that is destroyed then we will burn up on reentry.", 
        "The station will be destroyed" .. minetest.formspec_escape(",") .. " and we will all be killed."
    }, quest = "what_happened"},

    ["lights"] = {title = "Uh oh", text = {
        "The lights went out, that's strange.",
        "It must be the main generator" .. minetest.formspec_escape(",") .. " but why would that stop running?",
        "If the generator doesn't turn back on the oxygen regulators will stop working" .. minetest.formspec_escape(","),
        "and the temperature regulators won't continue to condition the false atmosphere in the station.", 
        "I need to get to the Main Generator, and figure out why it's not working."
    }, quest = "fix_generator"},

    ["airlock"] = {title = "The Airlock", text = {
        "Oh this is the airlock" .. minetest.formspec_escape(",") .. " nothing much to see out here I guess.",
        "The Airlock doors won't open anyways if the power is out",
        "Although I'm sure I'd be fine to explore for a while with my spacesuit.",
    }},

    ["generator"] = {title = "Find the Generator", text = {
        "Looks like the generator room should be on the right.",
        "I need to turn that on before I do anything else.",
    }},

    ["generator_2"] = {title = "The Auxilary Generator", text = {
        "The main generator must be damaged" .. minetest.formspec_escape(",") .. " let's turn the auxilary one on.",
        "There's a lever on the other side of the room.",
    }},

    ["lever"] = {title = "Powered Up", text = {
        "Looks like that did it" .. minetest.formspec_escape(",") .. " maybe the doors will work now so I can explore further."
    }, quest = "what_happened"},

    ["monitor"] = {title = "Spaceship's Heart-Meter", text = {
        "Looks like this machine still works" .. minetest.formspec_escape(",") .. " now that I've turned the power on."
    }},

    ["lab"] = {title = "Testing Grounds", text = {
        "The lab is on the left" .. minetest.formspec_escape(",") .. " that's where they had been doing some tests on plasma.",
        "Plasma is the form of matter that builds outside spacecraft during reentry interestingly enough" .. minetest.formspec_escape(","),
        "It is also what lighting is made up of" .. minetest.formspec_escape(",") .. " so you can expect it to be dangerous to work with."
    }},

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

reentry_story.story = function(player, line)
    minetest.show_formspec(player:get_player_name(), "storyline", reentry_story.create_formspec(line))
    local story = reentry_story.get_story(line)
    if story.quest ~= nil then reentry_story.set_quest(story.quest) reentry_story.update_quest() else minetest.log("quest type: " .. type(story.quest)) end
end