local gears = require("gears")
local awful = require("awful")
local theme = require("themes.relax.theme")

local function set_wallpaper(s)
  -- Wallpaper
  if theme.wallpaper then
    local wallpaper = theme.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- Set the same wallpaper for each screen, you could change this to have different wallpapers on each screen.
awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)
end)
