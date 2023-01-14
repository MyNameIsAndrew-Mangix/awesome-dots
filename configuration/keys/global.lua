local awful = require('awful')
local gears = require("gears")
local menubar = require("menubar")
local naughty = require("naughty")
local lain = require("lain")
local spotify = require("daemon.spotify")

require('awful.autofocus')
local beautiful = require('beautiful')
local hotkeys_popup = require('awful.hotkeys_popup').widget

local modkey = require('configuration.keys.mod').modKey
local altkey = require('configuration.keys.mod').altKey
local apps = require('configuration.apps')

globalKeys = gears.table.join(
-- Destroy all notifications
    awful.key({ "Control", }, "space", function() naughty.destroy_all_notifications() end,
        { description = "destroy all notifications", group = "hotkeys" }),

    -- X screen locker
    awful.key({ altkey, "Control" }, "l", function() os.execute(scrlocker) end,
        { description = "lock screen", group = "hotkeys" }),

    -- Show help
    awful.key({ modkey, }, "s", hotkeys_popup.show_help,
        { description = "show help", group = "awesome" }),

    awful.key({}, "XF86AudioPlay", function() awful.util.spawn("playerctl -p spotify play-pause") end),
    awful.key({}, "XF86AudioNext", function()
        awful.util.spawn("playerctl -p spotify next")
    end),
    awful.key({}, "XF86AudioPrev", function()
        awful.util.spawn("playerctl -p spotify previous")
    end),
    -- Tag browsing
    awful.key({ modkey, }, "Left", awful.tag.viewprev,
        { description = "view previous", group = "tag" }),
    awful.key({ modkey, }, "Right", awful.tag.viewnext,
        { description = "view next", group = "tag" }),
    awful.key({ modkey, }, "Escape", awful.tag.history.restore,
        { description = "go back", group = "tag" }),

    -- Default client focus
    awful.key({ modkey, }, "j",
        function()
            awful.client.focus.byidx(1)
        end,
        { description = "focus next by index", group = "client" }
    ),
    awful.key({ modkey, }, "k",
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = "focus previous by index", group = "client" }
    ),

    -- Menu
    awful.key({ modkey, }, "w", function() awful.util.mymainmenu:show() end,
        { description = "show main menu", group = "awesome" }),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
        { description = "swap with next client by index", group = "client" }),
    awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
        { description = "swap with previous client by index", group = "client" }),
    awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end,
        { description = "focus the next screen", group = "screen" }),
    awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
        { description = "focus the previous screen", group = "screen" }),
    awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }),
    -- Show/hide wibox
    awful.key({ modkey }, "b", function()
        for s in screen do
            s.top_panel.visible = not s.top_panel.visible
        end
    end,
        { description = "toggle wibox", group = "awesome" }),

    -- On-the-fly useless gaps change
    awful.key({ altkey, "Control" }, "+", function() lain.util.useless_gaps_resize(1) end,
        { description = "increment useless gaps", group = "tag" }),
    awful.key({ altkey, "Control" }, "-", function() lain.util.useless_gaps_resize(-1) end,
        { description = "decrement useless gaps", group = "tag" }),

    -- Dynamic tagging
    awful.key({ modkey, "Shift" }, "n", function() lain.util.add_tag() end,
        { description = "add new tag", group = "tag" }),
    awful.key({ modkey, "Shift" }, "r", function() lain.util.rename_tag() end,
        { description = "rename tag", group = "tag" }),
    awful.key({ modkey, "Shift" }, "Left", function() lain.util.move_tag(-1) end,
        { description = "move tag to the left", group = "tag" }),
    awful.key({ modkey, "Shift" }, "Right", function() lain.util.move_tag(1) end,
        { description = "move tag to the right", group = "tag" }),
    awful.key({ modkey, "Shift" }, "d", function() lain.util.delete_tag() end,
        { description = "delete tag", group = "tag" }),

    -- Standard program
    awful.key({ modkey, }, "Return", function() awful.spawn(apps.terminal) end,
        { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey, }, "z", function() awful.spawn(apps.terminal) end,
        { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
        { description = "reload awesome", group = "awesome" }),
    awful.key({ modkey, "Shift" }, "q", awesome.quit,
        { description = "quit awesome", group = "awesome" }),

    awful.key({ modkey, }, "l", function() awful.tag.incmwfact(0.05) end,
        { description = "increase master width factor", group = "layout" }),
    awful.key({ modkey, }, "h", function() awful.tag.incmwfact(-0.05) end,
        { description = "decrease master width factor", group = "layout" }),
    awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
        { description = "increase the number of master clients", group = "layout" }),
    awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
        { description = "decrease the number of master clients", group = "layout" }),
    awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end,
        { description = "increase the number of columns", group = "layout" }),
    awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end,
        { description = "decrease the number of columns", group = "layout" }),
    awful.key({ modkey, }, "space", function() awful.layout.inc(1) end,
        { description = "select next", group = "layout" }),
    awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
        { description = "select previous", group = "layout" }),
    awful.key({ modkey, "Control" }, "Escape", function() awful.spawn("/usr/bin/rofi -show drun -modi drun,window,run") end,
        { description = "launch rofi", group = "launcher" }),
    awful.key({ altkey, }, "Tab", function() awful.spawn("/usr/bin/rofi -show window -modi drun,window,run") end,
        { description = "launch rofi", group = "launcher" }),
    awful.key({ modkey, }, "e", function() awful.spawn("/usr/bin/thunar") end,
        { description = "launch filemanager", group = "launcher" }),

    awful.key({ modkey, "Control" }, "n", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:emit_signal("request::activate", "key.unminimize", { raise = true })
        end
    end, { description = "restore minimized", group = "client" }),

    awful.key({}, "Print", function() awful.spawn.with_shell("/home/andrew/scripts/maimclip.sh") end,
        { description = "capture a screenshot", group = "screenshot" }),

    -- Widgets popups
    awful.key({ altkey, }, "c", function() if beautiful.cal then beautiful.cal.show(7) end end,
        { description = "show calendar", group = "widgets" }),
    awful.key({ altkey, }, "h", function() if beautiful.fs then beautiful.fs.show(7) end end,
        { description = "show filesystem", group = "widgets" }),
    awful.key({ altkey, }, "w", function() if beautiful.weather then beautiful.weather.show(7) end end,
        { description = "show weather", group = "widgets" }),


    -- ALSA volume control
    awful.key({ altkey }, "m",
        function()
            os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
            beautiful.volume.update()
        end,
        { description = "toggle mute", group = "hotkeys" }),
    awful.key({ altkey, "Control" }, "m",
        function()
            os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        { description = "volume 100%", group = "hotkeys" }),
    awful.key({ altkey, "Control" }, "0",
        function()
            os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        { description = "volume 0%", group = "hotkeys" }),

    -- MPD control
    awful.key({ altkey, "Control" }, "Up",
        function()
            os.execute("mpc toggle")
            beautiful.mpd.update()
        end,
        { description = "mpc toggle", group = "widgets" }),
    awful.key({ altkey, "Control" }, "Down",
        function()
            os.execute("mpc stop")
            beautiful.mpd.update()
        end,
        { description = "mpc stop", group = "widgets" }),
    awful.key({ altkey, "Control" }, "Left",
        function()
            os.execute("mpc prev")
            beautiful.mpd.update()
        end,
        { description = "mpc prev", group = "widgets" }),
    awful.key({ altkey, "Control" }, "Right",
        function()
            os.execute("mpc next")
            beautiful.mpd.update()
        end,
        { description = "mpc next", group = "widgets" }),
    awful.key({ altkey }, "0",
        function()
            local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
            if beautiful.mpd.timer.started then
                beautiful.mpd.timer:stop()
                common.text = common.text .. lain.util.markup.bold("OFF")
            else
                beautiful.mpd.timer:start()
                common.text = common.text .. lain.util.markup.bold("ON")
            end
            naughty.notify(common)
        end,
        { description = "mpc on/off", group = "widgets" }),

    -- Copy primary to clipboard (terminals to gtk)
    awful.key({ modkey }, "c", function() awful.spawn.with_shell("xsel | xsel -i -b") end,
        { description = "copy terminal to gtk", group = "hotkeys" }),
    -- Copy clipboard to primary (gtk to terminals)
    awful.key({ modkey }, "v", function() awful.spawn.with_shell("xsel -b | xsel") end,
        { description = "copy gtk to terminal", group = "hotkeys" }),

    -- User programs
    awful.key({ modkey }, "q", function() awful.spawn(apps.browser) end,
        { description = "run browser", group = "launcher" }),
    -- Prompt
    awful.key({ modkey }, "r", function() awful.screen.focused().mypromptbox:run() end,
        { description = "run prompt", group = "launcher" }),

    awful.key({ modkey }, "ö",
        function()
            awful.prompt.run {
                prompt       = "Run Lua code: ",
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        { description = "lua execute prompt", group = "awesome" })
--]]
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalKeys = awful.util.table.join(globalKeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            { description = "view tag #" .. i, group = "tag" }),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            { description = "toggle tag #" .. i, group = "tag" }),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = "move focused client to tag #" .. i, group = "tag" }),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            { description = "toggle focused client on tag #" .. i, group = "tag" })
    )
end

return globalKeys
