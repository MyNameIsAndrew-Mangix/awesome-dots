local awful = require("awful")
local gears = require("gears")


awful.screen.connect_for_each_screen(function(s)
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 2, function() awful.layout.set(awful.layout.layouts[1]) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end),
        awful.button({}, 6, function() awful.layout.inc(-1) end),
        awful.button({}, 7, function() awful.layout.inc(-1) end),
        awful.button({}, 8, function() awful.layout.inc(-1) end),
        awful.button({}, 9, function() awful.layout.inc(-1) end)))
end)
