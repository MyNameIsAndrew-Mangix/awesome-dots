local wibox = require("wibox")
local theme = require("themes.relax.theme")
local lain = require("lain")
local markup = lain.util.markup

-- Net
netdownicon = wibox.widget.imagebox(theme.widget_netdown)
netdowninfo = wibox.widget.textbox()
netupicon = wibox.widget.imagebox(theme.widget_netup)
netupinfo = lain.widget.net({
    settings = function()
        --[[ uncomment if using the weather widget
        if iface ~= "network off" and
           string.match(theme.weather.widget.text, "N/A")
        then
            theme.weather.update()
        end
        --]]

        widget:set_markup(markup.fontfg(theme.font, "#e54c62", net_now.sent .. " "))
        netdowninfo:set_markup(markup.fontfg(theme.font, "#87af5f", net_now.received .. " "))
    end
})