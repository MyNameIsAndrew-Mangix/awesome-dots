local wibox = require("wibox")
local lain = require("lain")
local theme = require("themes.relax.theme")
local markup = lain.util.markup

-- Textclock
os.setlocale(os.getenv("LANG")) -- to localize the clock
clockicon = wibox.widget.imagebox(theme.widget_clock)
mytextclock = wibox.widget.textclock(markup("#7788af", "%A %d %B ") .. markup("#ab7367", ">") .. markup("#de5e1e", " %H:%M "))
mytextclock.font = theme.font

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = "Terminus 10",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})