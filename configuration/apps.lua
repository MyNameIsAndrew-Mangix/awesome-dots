local dpi = require("beautiful.xresources").apply_dpi
local menubar = require("menubar")

apps = {

  -- Your default terminal
  terminal        = "kitty",

  -- Your default text editor
  editor = os.getenv("EDITOR") or "code",

  -- editor_cmd = terminal .. " -e " .. editor,

  browser = "firefox", -- Default brwoser to run

  -- Your default file explorer
  explorer        = "thunar",

}

apps.editor_cmd   = apps.terminal .. " -e " .. apps.editor
apps.explorer_cmd = apps.terminal .. " -e " .. apps.explorer
menubar.utils.terminal = apps.terminal -- Set the terminal for applications that require it


return apps
