-- Luacheck configuration for CloudMonitoring

-- Allow access to Factorio API globals
globals = {
  "game",
  "script",
  "defines",
  "data"
}

-- Don't warn about unused arguments in callbacks
unused_args = false

-- Don't enforce max line length
max_line_length = false

-- Read-only Factorio API globals
read_globals = {
  "game",
  "script", 
  "defines",
  "data",
  "settings",
  "serpent"
}

-- Ignore specific warnings
ignore = {
  "212", -- Unused argument
}
