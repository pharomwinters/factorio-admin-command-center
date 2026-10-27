-- scripts/combat/gun_speed_boost.lua
-- Live slider: adjusts gun speed modifiers by delta (new - old).

local M = {}
local math_util = require("scripts/utils/flib_math")

local MAX_BONUS = 1000
local MIN_MODIFIER = -1

-- Known ammo categories affected by gun-speed technologies.
local AMMO_CATEGORIES = {
  "bullet",
  "shotgun-shell",
  "rocket",
  "laser",
  "railgun",
  "tesla",
  "electric",
  "beam"
}

local function clamp_slider(value)
  return math_util.clamp_number(value, 0, MAX_BONUS, 0)
end

local function safe_get(force, ammo_category)
  local ok, result = pcall(function()
    return force.get_gun_speed_modifier(ammo_category)
  end)
  if not ok then
    return nil
  end
  return result or 0
end

local function safe_set(force, ammo_category, value)
  return pcall(function()
    force.set_gun_speed_modifier(ammo_category, value)
  end)
end

--- Shifts every known modifier by the slider delta (new - old). No permission check.
-- @param force LuaForce
-- @return number|nil how many modifiers were set, or nil when there was nothing to do
function M.apply_to_force(force, old, new)
  if not (force and force.valid) then
    return nil
  end

  local old_bonus = clamp_slider(old)
  local new_bonus = clamp_slider(new)
  local delta = new_bonus - old_bonus
  if delta == 0 then
    return nil
  end

  local applied_count = 0

  for _, ammo_category in ipairs(AMMO_CATEGORIES) do
    local current = safe_get(force, ammo_category)
    if current ~= nil then
      local result = math_util.max(MIN_MODIFIER, current + delta)
      local ok_set = safe_set(force, ammo_category, result)
      if ok_set then
        applied_count = applied_count + 1
      end
    end
  end

  return applied_count
end

--- Same as apply_to_force, on the player's force, after a permission check.
-- @param player LuaPlayer
function M.apply(player, old, new)
  if not is_allowed(player) then
    player.print({"facc.not-allowed"})
    return
  end
  if M.apply_to_force(player.force, old, new) == 0 then
    player.print({"facc.runtime-compat-error", "slider_gun_speed_boost"})
  end
end

return M
