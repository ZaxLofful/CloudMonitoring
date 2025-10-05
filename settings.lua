-- CloudMonitoring - Mod Settings
-- Copyright (C) Zax Lofful
-- Licensed under GPL-3.0

data:extend({
  {
    type = "int-setting",
    name = "cloudmonitoring-tick-interval",
    setting_type = "runtime-global",
    default_value = 900,
    minimum_value = 60,
    maximum_value = 18000,
    order = "a"
  },
  {
    type = "bool-setting",
    name = "cloudmonitoring-track-items",
    setting_type = "runtime-global",
    default_value = true,
    order = "b"
  },
  {
    type = "bool-setting",
    name = "cloudmonitoring-track-fluids",
    setting_type = "runtime-global",
    default_value = true,
    order = "c"
  },
  {
    type = "bool-setting",
    name = "cloudmonitoring-verbose-logging",
    setting_type = "runtime-global",
    default_value = false,
    order = "d"
  }
})
