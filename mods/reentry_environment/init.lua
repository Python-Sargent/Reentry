minetest.register_on_joinplayer(function(player)
	player:set_sky({
		clouds = false,
		base_color = "#222233",
		type = "skybox",
        textures = {
            "sky_top.png",
            "sky_bottom.png",
            "sky_east.png",
            "sky_west.png",
            "sky_south.png",
            "sky_north.png"
        },
	})
    player:set_sun({
        visible = true,
        texture = "sun.png",
    })
    player:set_moon({
        visible = true,
        texture = "moon.png",
    })
    player:set_stars({
        visible = true,
        day_opacity = 1.0,
        count = 3000,
        star_color = "#eeddffff",
        scale = 0.5,
    })
end)