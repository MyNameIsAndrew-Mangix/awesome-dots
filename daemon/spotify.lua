local awful = require("awful")
local naughty = require("naughty")

local function emit_info(playerctl_output)
    local artist = playerctl_output:match('artist_start(.*)title_start')
    local title = playerctl_output:match('title_start(.*)position_start')
    local position = playerctl_output:match('position_start(.*)length_start')
    local length = playerctl_output:match('length_start(.*)status_start')
    -- Use the lower case of status
    local status = playerctl_output:match('status_start(.*)'):lower()
    status = string.gsub(status, '^%s*(.-)%s*$', '%1')

    awesome.emit_signal("daemon::spotify", artist, title, position, length, status)
end

-- Sleeps until spotify changes state (pause/play/next/prev)
local spotify_script = [[
  bash -c '
    playerctl --player spotify metadata --format artist_start{{artist}}title_start{{title}}position_start{{duration\(position\)}}length_start{{duration\(mpris:length\)}}status_start{{status}} --follow
  ']]

-- Kill old playerctl process
awful.spawn.easy_async_with_shell("ps x | grep \"playerctl --player spotify metadata\" | grep -v grep | awk '{print $1}' | xargs kill", function ()
    -- Emit song info with each line printed
    awful.spawn.with_line_callback(spotify_script, {
        stdout = function(line)
                        emit_info(line)
            --naughty.notify({text = line})
        end,
        stderr = function(line)
            naughty.notify({
                preset = naughty.config.presets.critical,
                text = line})

        end
    })
end)
