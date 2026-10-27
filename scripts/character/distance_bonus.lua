-- scripts/character/distance_bonus.lua
-- Shared slider applier for distance-related character bonuses.

local M = {}
local math_util = require("scripts/utils/flib_math")

local MAX_BONUS = 100

local function clamp_slider(value)
  return math_util.clamp_number(value, 0, MAX_BONUS, 0)
end

-- Slider name -> LuaForce property it drives.
M.SLIDER_PROPERTIES = {
  slider_build_distance = "character_build_distance_bonus",
  slider_reach_distance = "character_reach_distance_bonus",
  slider_resource_reach_distance = "character_resource_reach_distance_bonus",
  slider_item_drop_distance = "character_item_drop_distance_bonus",
  slider_item_pickup_distance = "character_item_pickup_distance_bonus",
  slider_loot_pickup_distance = "character_loot_pickup_distance_bonus",
}

--- Applies a distance bonus slider to a LuaForce property. No permission check.
-- Keeps external bonuses intact by removing previous slider contribution first.
-- @param force LuaForce
-- @param property string
-- @param old_slider number
-- @param new_slider number
function M.apply_to_force(force, property, old_slider, new_slider)
  if not (force and force.valid and type(property) == "string") then
    return
  end

  local ok_read, current = pcall(function()
    return force[property]
  end)
  if not ok_read then
    return
  end

  local old_bonus = clamp_slider(old_slider)
  local new_bonus = clamp_slider(new_slider)
  local base = (tonumber(current) or 0) - old_bonus
  local result = math_util.max(0, base + new_bonus)

  pcall(function()
    force[property] = result
  end)
end

--- Same as apply_to_force, on the player's force, after a permission check.
-- @param player LuaPlayer
function M.apply(player, property, old_slider, new_slider)
  if not is_allowed(player) then
    player.print({"facc.not-allowed"})
    return
  end
  M.apply_to_force(player.force, property, old_slider, new_slider)
end

return M
