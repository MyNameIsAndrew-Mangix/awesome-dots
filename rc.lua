---@diagnostic disable: undefined-global, lowercase-global
-- {{{ Required libraries

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local lain = require("lain")
local menubar = require("menubar")
local freedesktop = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
dpi = beautiful.xresources.apply_dpi

beautiful.init(string.format("%s/.config/awesome/themes/relax/theme.lua", os.getenv("HOME")))
--Init all modules
require("modules.error-handling")
require("modules.sloppy-focus")
require("modules.set-wallpaper")

--Setup UI Elements
require('ui')

-- Setup all configurations
require('configuration.tags')
require('configuration.client')
require('configuration.init')
_G.root.keys(require('configuration.keys.global'))
_G.root.buttons(require('configuration.mouse.desktop'))

-- >> Daemons
-- Make sure to initialize it last in order to allow all widgets to connect to their needed daemon signals.
require("daemon")

awful.util.tagnames = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
-- {{{ Screen

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function (s)
    local only_one = #s.tiled_clients == 1
    for _, c in pairs(s.clients) do
        if only_one and not c.floating or c.maximized or c.fullscreen then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
        end
    end
end)

-- }}}

-- Set keys
--root.keys(globalkeys)

-- }}}


-- {{{ Signals

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)


-- {{{ Autostart Applications
awful.spawn.with_shell("~/.config/awesome/autorun.sh")
awful.spawn.with_shell("~/.config/awesome/setup_monitors.sh")
-- }}}
awful.spawn.with_shell("xrdb -merge ~/.Xresources")
naughty.config.presets.spotify = {
	callback = function(args)
		 return false end}
table.insert(naughty.dbus.config.mapping, {{appname = "Spotify"}, naughty.config.presets.spotify})
