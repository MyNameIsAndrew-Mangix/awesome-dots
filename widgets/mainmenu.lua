local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
require("configuration.apps")
local freedesktop = require("freedesktop")

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", apps.terminal .. " -e man awesome" },
    { "edit config", apps.editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
}
mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
    { "open terminal", apps.terminal }
}
})


awful.util.mymainmenu = freedesktop.menu.build {
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        -- other triads can be put here
    },
    after = {
        { "Open terminal", apps.terminal },
        -- other triads can be put here
    }
}

-- Hide the menu when the mouse leaves it

awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function()
    if not awful.util.mymainmenu.active_child or
        (awful.util.mymainmenu.wibox ~= mouse.current_wibox and
            awful.util.mymainmenu.active_child.wibox ~= mouse.current_wibox) then
        awful.util.mymainmenu:hide()
    else
        awful.util.mymainmenu.active_child.wibox:connect_signal("mouse::leave",
            function()
                if awful.util.mymainmenu.wibox ~= mouse.current_wibox then
                    awful.util.mymainmenu:hide()
                end
            end)
    end
end)
