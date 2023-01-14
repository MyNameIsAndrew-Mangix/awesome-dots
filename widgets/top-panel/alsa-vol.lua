local wibox = require("wibox")
local lain = require("lain")
local theme = require("themes.relax.theme")
local markup = lain.util.markup

-- ALSA volume
volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = volume_now.level .. "M"
        end

        widget:set_markup(markup.fontfg(theme.font, "#7493d2", volume_now.level .. "% "))
    end
})