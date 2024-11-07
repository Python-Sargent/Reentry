reentry_story = {}

reentry_story.storyline = {
    ["intro"] = {title = "Introduction", text = {
        "You wake up with a slight bump on your head. What happened? ",
        "Oh the asteroid" .. minetest.formspec_escape(",") .. " and the fuel leak. ",
        "I've got to do something! We are in a decaying orbit! ",
        "If I don't repair everything that is destroyed then we will burn up on reentry.", 
        "The station will be destroyed" .. minetest.formspec_escape(",") .. " and we will all be killed."
    }}

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
end