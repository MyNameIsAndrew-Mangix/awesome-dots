local wibox = require("wibox")
local lain = require("lain")
local theme = require("themes.relax.theme")
local markup = lain.util.markup

-- CPU
cpuicon = wibox.widget.imagebox(theme.widget_cpu)
cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#e33a6e", cpu_now.usage .. "% "))
    end
})