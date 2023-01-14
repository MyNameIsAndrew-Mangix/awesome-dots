local wibox = require("wibox")
local lain = require("lain")
local theme = require("themes.relax.theme")
local markup = lain.util.markup

-- Coretemp
tempicon = wibox.widget.imagebox(theme.widget_temp)
temp = lain.widget.temp({
    timeout = 10,
    tempfile = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon1/temp1_input",
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#f1af5f", coretemp_now .. "°C "))
    end
})