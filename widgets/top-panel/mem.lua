local wibox = require("wibox")
local theme = require("themes.relax.theme")
local lain = require("lain")
local markup = lain.util.markup

-- MEM
memicon = wibox.widget.imagebox(theme.widget_mem)
memory = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#e0da37", mem_now.used .. "M "))
    end
})