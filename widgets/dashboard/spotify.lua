local wibox = require("wibox")
local naughty = require("naughty")
local gears = require("gears")
local awful = require("awful")

-- Declare widgets
local spotify_artist = wibox.widget.textbox()
local spotify_title = wibox.widget.textbox()
local spotify_length = wibox.widget.textbox()
local spotify_position = wibox.widget.textbox()
local spotify_progressbar = wibox.widget.progressbar()
local spotify_art = wibox.widget.imagebox()
local art_foreground = wibox.widget.imagebox()

spotify_bar_widget = wibox.widget {
    {
        resize = true,
        widget = spotify_art,
        forced_height = dpi(200),
        forced_width = dpi(200)
    },
    {
        resize = true,
        widget = art_foreground,
        image = ("/home/andrew/.config/awesome/themes/relax/icons/spotify-widget-gradient.png"),
        forced_height = dpi(200),
        forced_width = dpi(600)
    },
    {
        max_value = 00,
        value = 00,
        direction = 'east',
        forced_height = 1,
        forced_width = 30,
        color = "#1ED760",
        background_color = "#5E5E5E",
        shape = gears.shape['rounded_bar'],
        widget = spotify_progressbar
    },
    {
        {
            align = "left",
            text = "00:00",
            font = "sans 10",
            widget = spotify_position
        },
        {
            align = "right",
            text = "00:00",
            font = "sans 10",
            widget = spotify_length
        },
        layout = wibox.layout.align.horizontal,
    },
    -- Title widget
    {
        align = "center",
        text = "Spotify",
        font = "sans 14",
        widget = spotify_title
    },
    -- Artist widget
    {
        align = "center",
        text = "unavailable",
        font = "sans 10",
        widget = spotify_artist
    },
}

-- Main widget that includes all others
spotify_widget = wibox.widget {
    --homogeneous = false,
    expand = true,
    spacing = 5,
    superpose = true,
    forced_num_rows = 15,
    min_cols_size = 2,
    layout = wibox.layout.grid
}
spotify_widget:add_widget_at(spotify_art, 2, 20, 9, 9)
spotify_widget:add_widget_at(art_foreground, 2, 2, 12, 27)
spotify_widget:add_widget_at(spotify_title, 3, 2, 1, 14)
spotify_widget:add_widget_at(spotify_artist, 4, 2, 1, 14)
spotify_widget:add_widget_at(spotify_progressbar, 5, 5, 1, 8)
spotify_widget:add_widget_at(spotify_position, 5, 3, 1, 2)
spotify_widget:add_widget_at(spotify_length, 5, 13, 1, 2)
spotify_widget:insert_column(30)

local function min_sec_to_int(time)
    local number = 0
    local first_half
    local second_half
    if time:len() == 5 then
        first_half = time:sub(1, 2)
        second_half = time:sub(4, 5)
    elseif time:len() == 6 then
        first_half = time:sub(1, 3)
        second_half = time:sub(5, 6)
    else
        first_half = time:sub(1, 1)
        second_half = time:sub(3, 4)
    end
    first_half = tonumber(first_half)
    second_half = tonumber(second_half)
    number = (first_half * 60) + second_half
    return number
end

-- Subcribe to spotify updates
awesome.connect_signal("daemon::spotify", function(artist, title, position, length, status)
    -- Do whatever you want with artist, title, status
    -- ...
    local path = "/tmp/awesome/spotify/cover.png"
    if spotify_title.text ~= title then
        spotify_title.text = title
        spotify_artist.text = artist
        naughty.notify({ title = "Spotify | Now Playing", text = spotify_title.text .. " by " .. spotify_artist.text })
        awful.spawn("/home/andrew/scripts/get-art.sh")
        spotify_art.image = gears.surface.load_uncached("/tmp/awesome/spotify/cover.png")
        gears.timer.start_new(1, function()
            spotify_art.image = gears.surface.load_uncached(path)
            return true
        end)
    end
    spotify_length.text = length
    spotify_position.text = position
    spotify_progressbar.value = min_sec_to_int(position)
    spotify_progressbar.max_value = min_sec_to_int(length)
    -- spotify_art.image = gears.surface.load_uncached("/tmp/awesome/spotify/cover.png")

    --spotify_time.textbox = length
    --naughty.notify({text=position})

    -- Example notification (might not be needed if spotify already sends one)
        --
end)

return spotify_widget
