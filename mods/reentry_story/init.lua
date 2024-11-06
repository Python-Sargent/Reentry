reentry_story = {}

reentry_story.storyline = {
    ["intro"] = {title = "Introduction", text = "You are going to die soon prob," ..
    " remedy the horrible situation you are in by beating your head again'st the sidewall, do it. I dare you to." ..
    " I garuntee it will hurt, but if you do it hard enough you won't have to woryy about that. If you see this text in the Game Jam Submission" ..
    " something has gone horribly wrong, and I hope I don't beat myself up to much about it."},
    ["trigger"] = {title = "The Trigger", text = "Triggers can be set to trigger different events in the reentry systems mod." ..
    " At some point I plan to make it so that these triggers are defined dynamically and not hardcoded, but for now that's how it is." ..
    " The text you are seeing is the result of a trigger, which called a function that showed you this formspec that you are now reading."},
}

reentry_story.get_story = function(line)
    local story = reentry_story.storyline[line]
    if story ~= nil and story.text ~= nil and story.title ~= nil then
        return story
    else
        return {text = "Failed to retrieve story", title = "Failed"}
    end
end

reentry_story.create_formspec = function(line)
    local story = reentry_story.get_story(line)
    local formspec = "size[8,6]" ..
        "bgcolor[#333333]" ..
        "label[0.5,0;" .. story.title .. "]" ..
        "textlist[0.5,0.5;7,5;<name>;" .. story.text .. "]" ..
		"button_exit[0.5,5.5;7,1;done;Done]"
	return formspec
end

reentry_story.story = function(player, line)
    minetest.show_formspec(player:get_player_name(), "storyline", reentry_story.create_formspec(line))
end