local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')
local gears     = require('gears')
local theme     = require("themes.relax.theme")
local lain      = require("lain")
local dpi       = require("beautiful.xresources").apply_dpi
require('widgets.dashboard')

local spotify = require('widgets.dashboard.spotify')

Dashboard = function(s)
    local dashboard_min_width = dpi(600)
    local dashboard_max_width = dpi(1200)
    local dashboard_height = dpi(1220)
    -- local function centered_widget(widget)
    --     w = wibox.widget({
    --         nil,
    --         {
    --             nil,
    --             widget,
    --             expand = "none",
    --             layout = wibox.layout.align.vertical,
    --         },
    --         expand = "none",
    --         layout = wibox.layout.align.horizontal,
    --     })

    --     return w
    -- end

    -- local function create_boxed_widget(widget_to_be_boxed, width, height, bg_color)
    --     local box_container = wibox.container.background()
    --     box_container.bg = bg_color
    --     box_container.forced_height = height
    --     box_container.forced_width = width

    --     local boxed_widget = wibox.widget({
    --         -- Add margins
    --         {
    --             -- Add background color
    --             {
    --                 -- The actual widget goes here
    --                 widget_to_be_boxed,
    --                 top = dpi(9),
    --                 bottom = dpi(9),
    --                 left = dpi(10),
    --                 right = dpi(10),
    --                 widget = wibox.container.margin,
    --             },
    --             widget = box_container,
    --         },
    --         margins = dpi(10),
    --         color = "#FF000000",
    --         widget = wibox.container.margin,
    --     })

    --     return boxed_widget
    -- end

    local dashboard_item = wibox.widget({
        nil,
        {
            s.time_boxed,
            {
                {
                    s.stats_boxed,
                    layout = wibox.layout.fixed.vertical,
                },
                {
                    s.date_boxed,
                    s.todo_boxed,
                    s.weather_boxed,
                    layout = wibox.layout.fixed.vertical,
                },
                layout = wibox.layout.fixed.horizontal,
            },
                spotify,
            layout = wibox.layout.fixed.vertical,
        },
        expand = "none",
        layout = wibox.layout.align.horizontal,
        layout = awful.widget.only_on_screen,
        screen = "primary",
    })
    dashboard = awful.popup({
        type = "dock",
        screen = s,
        maximum_height = dashboard_height,
        minimum_width = dashboard_min_width,
        maximum_width = dashboard_max_width,
        x = s.geometry.x + s.geometry.width / 2 , --half of the width 
        bg = beautiful.transparent,
        ontop = false,
        placement = awful.placement.centered,
        visible = true,
        widget = {
            {
                layout = wibox.layout.flex.horizontal,
                spacing = dpi(10),
                spacing_widget = wibox.widget.separator(
                {
                    span_ratio = 0.80,
                    color = beautiful.lighter_bg,
                }),
                dashboard_item,
                --require("widgets.notif-center")(s),
            },
            bg = beautiful.dashboard_bg,
            widget = wibox.container.background,
        },
        layout = awful.widget.only_on_screen,
        screen = "primary",
    })
end

return Dashboard
