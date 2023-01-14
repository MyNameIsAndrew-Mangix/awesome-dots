local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')
local gears     = require('gears')
local theme     = require("themes.relax.theme")
local lain      = require("lain")
local dpi       = require("beautiful.xresources").apply_dpi

configuration = require('configuration.config')
require('widgets.top-panel')

local TopPanel = function(s)
    seperator = wibox.widget.textbox(' <span color="' .. '#794B16' .. '">| </span>')

    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })
    local panel =
    wibox(
        {
            ontop = true,
            screen = s,
            height = configuration.toppanel_height,
            width = s.geometry.width,
            x = s.geometry.x,
            y = s.geometry.y,
            stretch = false,
            bg = beautiful.bg_normal,
            fg = beautiful.fg_normal,
            struts = {
                top = configuration.toppanel_height
            }
        }
    )
    panel:struts(
        {
            top = configuration.toppanel_height
        }
    )


    -- Add widgets to the wibox
    panel:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --s.mylayoutbox,
            s.mytaglist,
            s.mypromptbox,
            seperator
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            seperator,
            mykeyboardlayout,
            wibox.widget.systray(),
            --mailicon,
            --theme.mail.widget,
            netdownicon,
            netdowninfo,
            netupicon,
            netupinfo.widget,
            volicon,
            theme.volume.widget,
            memicon,
            memory.widget,
            cpuicon,
            cpu.widget,
            --fsicon,
            --theme.fs.widget,
            --weathericon,
            --theme.weather.widget,
            tempicon,
            temp.widget,
            --baticon,
            --bat.widget,
            clockicon,
            mytextclock,
            s.mylayoutbox,
        },
    }

    return panel
end

return TopPanel
