-- scripts/logistic-network/inserter_stack_size_bonus.lua
-- Live slider: adjusts inserter stack size bonus.

local M = {}
local force_bonus_slider = require("scripts/utils/force_bonus_slider")

local FIELD = "inserter_stack_size_bonus"
local OPTIONS = {
  max_bonus = 100,
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
