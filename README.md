# Giant Simulator: REBORN / Matcha

Matcha Hybrid hub for [Giant Simulator: REBORN](https://www.roblox.com/games/12645083079), using SxGoldenxS's bundled REM UI. All automation starts **off** on a fresh load.

## Load

Join the game, enable Matcha Hybrid Mode, and execute:

```lua
loadstring(httpget("https://raw.githubusercontent.com/SxGoldenxS/Giant-Simulator-Reborn-Matcha/main/matcha.lua"))()
```

The script downloads the bundled REM UI from this repository when `giant-reborn-rem-ui.lua` is absent from the Matcha workspace. An existing local UI file takes precedence.

For an offline installation, copy `matcha.lua` to the Matcha workspace as `giant-reborn-matcha.lua`, copy `giant-reborn-rem-ui.lua` alongside it, and run:

```lua
loadstring(readfile("giant-reborn-matcha.lua"))()
```

**End** toggles the menu. **Delete** unloads the hub. **Stop all automation** stops hub actions. Emergency stop:

```lua
if _G.GiantRebornMatcha then _G.GiantRebornMatcha.Stop() end
```

## Features

- Auto training through the current TrainClick message, with adjustable request rate.
- Nearby orb collection, optional movement, and pickup confirmation.
- Owned-chest batches, with inventory-count acknowledgement and cancellation.
- Ghost soul farming with moving-target prediction. The default **Native auto** attack source requires the game's own Auto to be on; the hub follows ghosts while the game owns attack timing. **Scripted** is the fallback for use with native Auto off.
- Trick-or-treat house cycling with cooldowns and blocked-door handling.
- Level-based auto rebirth, daily-reward requests, and optional game idle-timer reset.
- Researched codes with copy buttons; codes are not automatically redeemed.

Stopping the hub leaves the game's own Auto independently controlled. Existing server requests cannot be cancelled after dispatch. Game idle reset has not been established to prevent Roblox's separate platform idle disconnect.

## Verification and evidence

Install [Node.js](https://nodejs.org/), then run from this repository:

```sh
npm ci
npm test
```

The suite compiles the hub and bundled UI and runs 53 contract checks. It runs locally without Matcha or Roblox. Live observations, including the short native-auto soul-farming comparison, are documented in [RESEARCH.md](RESEARCH.md). Game updates can change transport IDs, controllers, or reward rules; dispatched requests alone do not establish accepted rewards.

## Project contents

- `matcha.lua`: production hub.
- `giant-reborn-rem-ui.lua`: bundled REM UI Drawing edition, originally from SxGoldenxS/REM-UI revision `4d39214d904a49bbb5dc3579eec290b91cde349a`.
- `verification/`: executable contract checks.
- [CODES.md](CODES.md): guide-reported codes, checked 1 November 2026; account validity has not been tested.
- [RESEARCH.md](RESEARCH.md): behavior traces, source links, measurements, and verification limits.
- `research/`: client decompilation snapshots, bounded diagnostic scripts, and recorded results. These files are investigation artifacts and are not loaded by the hub.
- [research/third-party/](research/third-party/README.md): retrieved public-script snapshots and formatting tools from an interrupted investigation. No complete deobfuscation is claimed.

The Matcha API references are [the docs](https://huoadf.github.io/matcha-docs/) and [UI Binding](https://huoadf.github.io/matcha-docs/ui-binding/). The production UI uses the bundled REM Drawing implementation.
