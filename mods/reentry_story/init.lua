reentry_story = {}

reentry_story.storyline = {
    ["intro"] = {title = "Introduction", text = "You are going to die soon prob," ..
    " remedy the horrible situation you are in by beating your head again'st the sidewall, do it. I dare you to." ..
    " I garuntee it will hurt, but if you do it hard enough you won't have to woryy about that. If you see this text in the Game Jam Submission" ..
    " something has gone horribly wrong, and I hope I don't beat myself up to much about it."},
    ["line1"] = {title = "The Trigger", text = "Triggers can be set to trigger different events in the reentry systems mod." ..
    " At some point I plan to make it so that these triggers are defined dynamically and not hardcoded, but for now that's how it is." ..
    " The text you are seeing is the result of a trigger, which called a function that showed you this formspec that you are now reading."},
}

reentry_story.current_line = 1

reentry_story.next = function(player)
    
end