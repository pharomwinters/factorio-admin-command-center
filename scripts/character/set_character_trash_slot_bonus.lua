-- scripts/character/set_character_trash_slot_bonus.lua
-- Sets force character trash slot bonus (delta style) from numeric input.

local M = {}
local math_util = require("scripts/utils/flib_math")
local force_bonus_slider = require("scripts/utils/force_bonus_slider")

local MIN_BONUS = 0
local MAX_BONUS = 65535
local LOGISTIC_ROBOTICS_TECH = "logistic-robotics"
local LOGISTIC_TRASH_MINIMUM = 30

local function get_minimum(force)
  if not (force and force.valid) then
    return MIN_BONUS
  end
  local tech = force.technologies and force.technologies[LOGISTIC_ROBOTICS_TECH]
  if tech and tech.researched then
    return LOGISTIC_TRASH_MINIMUM
  end
  return MIN_BONUS
end

--- Swap the old bonus for the new one on a force. No permission check, no chat output.
-- @param force LuaForce
-- @param old_value any
-- @param new_value any
-- @return boolean ok, number|string value_or_error
function M.apply_to_force(force, old_value, new_value)
  if not (force and force.valid) then
    return false, "invalid-force"
  end
  local old_bonus = math_util.clamp_number(math.floor(tonumber(old_value) or 0), MIN_BONUS, MAX_BONUS, MIN_BONUS)
  local new_bonus = math_util.clamp_number(math.floor(tonumber(new_value) or 0), MIN_BONUS, MAX_BONUS, MIN_BONUS)
  return force_bonus_slider.apply_to_force(force, old_bonus, new_bonus, "character_trash_slot_count", {
    max_bonus = MAX_BONUS,
    min_value = get_minimum(force),
    max_value = MAX_BONUS,
    integer = true
  })
end

--- Set force character trash slot bonus from a user-supplied value.
-- Uses old/new delta semantics to preserve research/base value.
-- Returns the applied total value on success.
-- Returns nil on invalid value.
-- @param player LuaPlayer
-- @param old_value any
-- @param raw_value any
-- @return number|nil, number minimum, number|nil applied_bonus
function M.run(player, old_value, raw_value)
  if raw_value == nil then
    raw_value = old_value
    old_value = 0
  end

  if not is_allowed(player) then
    player.print({"facc.not-allowed"})
    return nil, MIN_BONUS, nil
  end

  local force = player.force
  if not (force and force.valid) then
    player.print({"facc.set-character-trash-slot-bonus-invalid"})
    return nil, MIN_BONUS, nil
  end

  local n = tonumber(raw_value)
  if n == nil then
    player.print({"facc.set-character-trash-slot-bonus-invalid"})
    return nil, get_minimum(force), nil
  end

  local minimum = get_minimum(force)
  local new_bonus = math.floor(n)
  local old_bonus = math.floor(tonumber(old_value) or 0)

  local clamped_new = math_util.clamp_number(new_bonus, MIN_BONUS, MAX_BONUS, MIN_BONUS)
  if clamped_new ~= new_bonus then
    player.print({"facc.set-character-trash-slot-bonus-clamped-max", MAX_BONUS})
  end

  local ok, result = M.apply_to_force(force, old_bonus, clamped_new)

  if not ok then
    player.print({"facc.runtime-compat-error", "facc_character_trash_slot_bonus"})
    return nil, minimum, nil
  end

  player.print({"facc.set-character-trash-slot-bonus-msg", result})
  return result, minimum, clamped_new
end

return M
