-- scripts/utils/reapply_force_bonuses.lua
-- Factorio resets every force's technology effects whenever mods, prototypes or
-- startup settings change, and whenever LuaForce::reset_technology_effects runs.
-- That wipes the force bonuses the FACC sliders added on top of research, while
-- storage.facc_gui_state still remembers them. This puts the stored bonuses back.

local M = {}

local distance_bonus = require("scripts/character/distance_bonus")
local character_health_bonus = require("scripts/character/character_health_bonus")
local set_crafting_speed = require("scripts/character/set_crafting_speed")
local set_inventory_slots_bonus = require("scripts/character/set_inventory_slots_bonus")
local set_character_trash_slot_bonus = require("scripts/character/set_character_trash_slot_bonus")
local laboratory_speed_bonus = require("scripts/cheats/laboratory_speed_bonus")
local laboratory_productivity_bonus = require("scripts/cheats/laboratory_productivity_bonus")
local ammo_damage_boost = require("scripts/combat/ammo_damage_boost")
local turret_damage_boost = require("scripts/combat/turret_damage_boost")
local gun_speed_boost = require("scripts/combat/gun_speed_boost")
local artillery_range_boost = require("scripts/combat/artillery_range_boost")
local increase_robot_speed = require("scripts/logistic-network/increase_robot_speed")
local robot_storage_bonus = require("scripts/logistic-network/robot_storage_bonus")
local robot_battery_bonus = require("scripts/logistic-network/robot_battery_bonus")
local following_robot_lifetime_bonus = require("scripts/logistic-network/following_robot_lifetime_bonus")
local maximum_following_robot_count = require("scripts/logistic-network/maximum_following_robot_count")
local inserter_stack_size_bonus = require("scripts/logistic-network/inserter_stack_size_bonus")
local bulk_inserter_capacity_bonus = require("scripts/logistic-network/bulk_inserter_capacity_bonus")
local belt_stack_size_bonus = require("scripts/logistic-network/belt_stack_size_bonus")
local beacon_distribution_bonus = require("scripts/logistic-network/beacon_distribution_bonus")
local set_mining_speed = require("scripts/mining/set_mining_speed")
local mining_drill_productivity_bonus = require("scripts/mining/mining_drill_productivity_bonus")
local train_braking_force_bonus = require("scripts/trains/train_braking_force_bonus")

-- After a reset nothing of ours is left on the force, so the old slider value is 0.
local function from_zero(module)
  return function(force, value)
    return module.apply_to_force(force, 0, value)
  end
end

-- storage.facc_gui_state.sliders key -> function(force, stored_value)
local REAPPLY = {
  slider_set_crafting_speed = from_zero(set_crafting_speed),
  slider_set_mining_speed = set_mining_speed.apply_to_force,
  slider_character_health_bonus = from_zero(character_health_bonus),
  slider_laboratory_speed_bonus = from_zero(laboratory_speed_bonus),
  slider_laboratory_productivity_bonus = from_zero(laboratory_productivity_bonus),
  slider_ammo_damage_boost = from_zero(ammo_damage_boost),
  slider_turret_damage_boost = from_zero(turret_damage_boost),
  slider_gun_speed_boost = from_zero(gun_speed_boost),
  slider_artillery_range_boost = from_zero(artillery_range_boost),
  slider_increase_robot_speed = from_zero(increase_robot_speed),
  slider_robot_storage_bonus = from_zero(robot_storage_bonus),
  slider_robot_battery_bonus = from_zero(robot_battery_bonus),
  slider_following_robot_lifetime_bonus = from_zero(following_robot_lifetime_bonus),
  slider_maximum_following_robot_count = from_zero(maximum_following_robot_count),
  slider_inserter_stack_size_bonus = from_zero(inserter_stack_size_bonus),
  slider_bulk_inserter_capacity_bonus = from_zero(bulk_inserter_capacity_bonus),
  slider_belt_stack_size_bonus = from_zero(belt_stack_size_bonus),
  slider_beacon_distribution_bonus = from_zero(beacon_distribution_bonus),
  slider_mining_drill_productivity_bonus = from_zero(mining_drill_productivity_bonus),
  slider_train_braking_force_bonus = from_zero(train_braking_force_bonus),
  input_inventory_slots_bonus_bonus = from_zero(set_inventory_slots_bonus),
  input_character_trash_slot_bonus_bonus = from_zero(set_character_trash_slot_bonus),
}

for slider_name, property in pairs(distance_bonus.SLIDER_PROPERTIES) do
  REAPPLY[slider_name] = function(force, value)
    return distance_bonus.apply_to_force(force, property, 0, value)
  end
end

-- Older saves only kept the typed input; the GUI treats that as the applied bonus too.
local INPUT_FALLBACK = {
  input_inventory_slots_bonus_bonus = "input_inventory_slots_bonus",
  input_character_trash_slot_bonus_bonus = "input_character_trash_slot_bonus",
}

local function reapplied_ticks()
  if type(storage.facc_bonus_reapply_tick) ~= "table" then
    storage.facc_bonus_reapply_tick = {}
  end
  return storage.facc_bonus_reapply_tick
end

--- Re-adds every stored slider bonus to a force whose technology effects were just reset.
-- Forces without players are skipped: the sliders only ever touch a player's force.
-- @param force LuaForce
function M.reapply(force)
  if not (force and force.valid and #force.players > 0) then
    return
  end
  reapplied_ticks()[force.index] = game.tick

  local state = storage.facc_gui_state
  if not (type(state) == "table" and type(state.sliders) == "table") then
    return
  end
  local inputs = type(state.inputs) == "table" and state.inputs or {}

  for key, apply in pairs(REAPPLY) do
    local value = tonumber(state.sliders[key])
    if value == nil and INPUT_FALLBACK[key] then
      value = tonumber(inputs[INPUT_FALLBACK[key]])
    end
    if value and value ~= 0 then
      local ok, err = pcall(apply, force, value)
      if not ok then
        log("[FACC][REAPPLY] " .. key .. " failed: " .. tostring(err))
      end
    end
  end
end

--- Reapplies on every force not already handled this tick, so a reset that also
--- raised on_technology_effects_reset doesn't get the bonuses added twice.
function M.reapply_all()
  local ticks = reapplied_ticks()
  for _, force in pairs(game.forces) do
    if ticks[force.index] ~= game.tick then
      M.reapply(force)
    end
  end
end

return M
