# Factorio Admin Command Center Redux (FACC Redux)

A compact admin toolkit for Factorio 2.1 with a category-based GUI, live sliders/switches, and no console dependency for most actions.

FACC Redux continues [Factorio Admin Command Center](https://mods.factorio.com/mod/factorio-admin-command-center) by louanbastos (Louan Fontenele), which doesn't support Factorio 2.1. It replaces the original mod in existing saves: remove the original, add FACC Redux, and your saved state carries over.

- 🔗 Mod Portal: https://mods.factorio.com/mod/facc-redux
- 🔗 GitHub: https://github.com/pharomwinters/factorio-admin-command-center
- 🔗 Original mod: https://github.com/factoriocenter/factorio-admin-command-center

## Current Version

- 🏷️ Version: `4.4.0`
- 📝 Changelog: [changelog.txt](changelog.txt)

## Features (All Current)

### 🧪 Cheats:
- 🧙 `Cheat Mode`
- 🗺️ `Toggle editor mode`
- 💻 `Console`
- 🍲 `Unlock All Recipes`
- 🔬 `Unlock All Technologies`
- 🎯 `Set Infinite Researches to Level 100`
- ➕ `Add +100 to Infinite Researches`
- 💰 `Receive Coins (Tight spot or Rocket rush)`
- ⏱️ `Auto Instant Research`
- ⚡ `Adjust Game Speed`
- 🧪 `Laboratory Speed Bonus`
- 🧪 `Laboratory Productivity Bonus`

### 🛡️ Armor:
- 🤖 `Create Full Armor`

### 📐 Blueprints:
- 👻 `Enable ghosts on entity death`
- 🏗️ `Instant Blueprint Building`
- 🧹 `Instant Deconstruction`
- ⬆️ `Instant Upgrading`
- 🛤️ `Instant Rail Planner`
- 🧱 `Build All Ghosts`
- 🔧 `Repair and Rebuild`
- 🚧 `Remove Marked Structures`
- 💎 `Upgrade Inventory Blueprints to Legendary (Quality)`

### 🚶 Character:
- 👻 `Ghost Mode`
- 🛡️ `Invincible Player`
- 🩹 `Repair Mined Item`
- ✂️ `Delete Orphaned Characters`
- 🎒 `Convert Inventory to Legendary (Quality)`
- 🎛️ `Set Inventory Slots Bonus`
- 🗑️ `Character Trash Slot Bonus`
- 🏃 `Run Faster`
- ❤️ `Character Health Bonus`
- 🛠️ `Adjust Handcraft Speed`
- ⛏️ `Adjust Mining Speed`
- 📐 `Build Distance`
- 🤚 `Reach Distance`
- ⛏️ `Resource Reach Distance`
- 📦 `Item Drop Distance`
- 🤲 `Item Pickup Distance`
- 🧲 `Loot Pickup Distance`

### ⚔️ Combat:
- 🚫 `Disable Friendly Fire`
- 🔒 `Indestructible Builds`
- ☮️ `Peaceful Mode`
- 🔐 `Indestructible Builds (Permanent)`
- 🎯 `Fill Empty Turrets`
- 💥 `Ammo Damage Boost`
- 🔫 `Turret Damage Boost`
- 🔫 `Gun Speed Boost`
- 🧨 `Artillery Range Boost`

### 👾 Enemies:
- 🛑 `Disable Enemy Expansion`
- 💣 `Remove Enemy Nests`

### 🌍 Environment:
- ⏸️ `Freeze Daytime (Surface)`
- ☮️ `Peaceful Mode (Surface)`
- 🚫 `Don't Generate Enemies (Surface)`
- ☀️ `Perpetual Day`
- 🚫 `Disable Pollution`
- ♻️ `Auto Clean Pollution`
- 🌞 `Set Midday (Surface)`
- 🌚 `Set Midnight (Surface)`
- 🧽 `Clear Pollution`
- 🌫️ `Hide Map`
- 🗑️ `Remove Ground Items`
- 🕒 `Set Daytime (Surface)`
- 🌬️ `Set Surface Pressure (Space Age)`
- 🧲 `Set Surface Magnetic Field (Space Age)`
- 🌌 `Set Surface Gravity (Space Age)`
- 🔍 `Reveal Map`
- ⛰️ `Remove Cliffs`

### 🤖 Logistic Network:
- 📦 `Instant Personal Logistics`
- 🗑️ `Instant Trash`
- 🤖 `Add Robots`
- 🐇 `Increase worker robot speed`
- 📦 `Worker Robot Storage Bonus`
- 🔋 `Worker Robot Battery Bonus`
- ⏳ `Following Robot Lifetime Bonus`
- 🤖 `Maximum Following Robot Count`
- 🦾 `Inserter Stack Size Bonus`
- 📥 `Bulk Inserter Capacity Bonus`
- 📦 `Belt Stack Size Bonus`
- 📡 `Beacon Distribution Bonus`

### ⛏️ Mining:
- ⛏️ `Entity Minability`
- 🚫 `Non-minable Builds (Permanent, Current Surface)`
- ⛏️ `Mining Drill Productivity Bonus`

### 🪐 Planets:
- ♻️ `Regenerate Resources`
- 📈 `Increase Resources`
- 🗺️ `Generate Planets Surfaces and Chart Area (Space Age)`
- 🌍 `Teleport to Planets (Space Age progression)`
- 🧭 `Fast Teleport Manager`

### ⚡ Power:
- 🔋 `Recharge Energy`
- ☀️ `Set Surface Solar Power Multiplier`

### 🚂 Trains:
- 🚆 `Automatic Trains`
- 🛑 `Train Braking Force Bonus`

### 🛰️ Transportation:
- 🛡️ `Create Full Tank`
- 🕷️ `Create Full Spidertron`
- ⛽ `Refuel Platform Thrusters (Space Age)`
- 📏 `Platform Distance (Space Age)`

## Extra Tools

- 🔘 Toolbar shortcut: open/close Admin GUI.
- 🧰 Toolbar shortcut: equip `Legendary Upgrader (Quality)`.
- 🧭 Hotkey for Fast Teleport Manager (`Ctrl + Shift + T` by default).
- 📊 Stats HUD (coordinates, time/day, playtime, evolution, pollution, research ETA, movement/vehicle speed, fuel, handcraft timer).
- 🌐 Public Remote API for mod integrations: [`docs/REMOTE_API.md`](docs/REMOTE_API.md)
- 💻 Lua console window with `Ctrl + Enter` execution.
- 📦 Optional `Cheat Tools` crafting tab (startup setting) with recipes for: `infinity-chest`, `infinity-pipe`, `heat-interface`, `electric-energy-interface`, `loader`/`fast-loader`/`express-loader`/`turbo-loader` (when available), `linked-chest`, `lane-splitter`, `infinity-cargo-wagon`, `burner-generator`.

## Startup Settings
- 📋 `Show Cheat Tools tab`
- 🏆 `Enable achievement overrides`
- 🧩 `Show internal names`
- ♾️ `Infinite Resources`
- 🪨 `Infinite Resources Multiplier (Solid)`
- 💧 `Infinite Resources Multiplier (Fluid)`
- ⛏️ `Instant mining drills`
- 🏭 `Instant crafting machines`
- ⚡ `Remove electricity requirement from machines`
- ⛽ `Remove fuel requirement from machines and vehicles`
- 🧪 `Ignore recipe ingredient inputs`
- 🔫 `Infinite ammo (weapons and turrets)`
- 🔄 `Enable auto resource regeneration`
- 🧵 `Enable background optimization for heavy actions`
- 📊 `Stats HUD toggles and layout presets`

## Controls

- ⌨️ `Ctrl + .` -> Toggle Admin GUI
- ⌨️ `Ctrl + Enter` -> Execute Lua console command
- ⌨️ `Ctrl + Shift + T` -> Toggle Fast Teleport Manager
- ⚙️ All shortcuts are rebindable in `Settings -> Controls -> Mods`

## Compatibility

- 🎮 Factorio: `2.1` (base `>= 2.1.7`)
- 📚 Required library: `flib >= 0.17.0`
- 🔌 Optional integrations: `quality >= 2.1.7`, `space-age >= 2.1.7`, `elevated-rails >= 2.1.7`
- 🚫 Incompatible with the original `factorio-admin-command-center` mod (FACC Redux replaces it).
- 👥 In multiplayer, admin tools are available to admins only.

## Languages

- 🇺🇸 English
- 🇧🇷 Portuguese (Brazil)

## Installation

1. ✅ Install from Mod Portal (recommended): https://mods.factorio.com/mod/facc-redux
2. 📦 Or download from Releases and place the `.zip` in your Factorio `mods` folder.

### Switching from the original mod

1. 💾 Back up your save.
2. ❌ Disable or remove `Factorio Admin Command Center`.
3. ✅ Enable `Factorio Admin Command Center Redux` and load the save.

FACC Redux uses Factorio 2.1's `migrates_from` to take over the original mod's saved state, GUIs and scheduled tasks.

## License

[MIT](LICENSE) © <!-- change year start --> 2026<!-- change year end --> pharomwinters

Based on the original Factorio Admin Command Center, © 2025 Louan Fontenele (Factorio Center), also MIT licensed.

<!-- readme: contributors,bot/- -end -->
