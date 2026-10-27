-- scripts/character/character_health_bonus.lua
-- Live slider: adjusts force character health bonus.

local M = {}
local force_bonus_slider = require("scripts/utils/force_bonus_slider")

local FIELD = "character_health_bonus"
local OPTIONS = {
  max_bonus = 1000,
  min_value = 0,
  integer = true
}

function M.apply(player, old, new)
  return force_bonus_slider.apply(player, old, new, FIELD, OPTIONS)
end

function M.apply_to_force(force, old, new)
  return force_bonus_slider.apply_to_force(force, old, new, FIELD, OPTIONS)
end

return M
