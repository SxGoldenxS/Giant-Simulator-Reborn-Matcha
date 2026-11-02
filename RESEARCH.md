# Giant Simulator: REBORN / Matcha research

Research and live inspection: **1 November 2026**. Target: **12645083079**. This place was previously called Giant Simulator Classic; scripts for the separate original Giant Simulator still need individual checks.

## Result

Built `matcha.lua` with your **REM-UI Matcha edition**. Training uses the current game's ZAP `TrainClick` message. Owned-chest opening uses the current ZAP batch request and verifies its count decrement in the game's inventory UI. Resource collection accounts for giant-sized feet and has optional controlled movement. Halloween modes farm ghost souls or cycle ready trick-or-treat houses. Progression and idle features use existing Aero remotes. All automation starts off on a fresh load.

No third-party game hub or protected loader was executed. Only your REM UI source is loaded as a dependency. The script contains no GC writes or per-frame character transform writes.

## Public sources reviewed

| Source | Actual finding | Reuse decision |
| --- | --- | --- |
| [shenzeuliyle's readable orb farm](https://scriptblox.com/script/Giant-Simulator-CLASSIC-Auto-farm-15450) | Targets this place and `workspace.Scene.ResourceNodes1`, `NodeType`, and `Prefab`; moves by TweenService. | Resource layout was confirmed live. Reimplemented collection with native touch and walking because Matcha cannot use that TweenService flow. The old author's claimed anti-cheat timing is not treated as a guarantee. |
| [GaksP0wer Reborn listing](https://scriptblox.com/script/Giant-Simulator:-REBORN-GaksP0wer-Hub-240212), [source](https://github.com/esekgakra-jpg/Giant-Sim/blob/main/Gaks%20Hub) | LuaObfuscator output is still readable enough to expose `BuyCrate`, `RebirthRequest`, upgrades, and raw ZAP packets. Builds Roblox GUI instances and uses obsolete numeric packets. | Useful feature/remote leads. Not loadable as-is in Matcha; did not transplant stale packet IDs. Its training packet was byte 10, while the current client uses 12. |
| [NK listing on Rscripts](https://rscripts.net/script/giant-simulator-classic-or-auto-farm-auto-swing-y0np), [ScriptBlox mirror](https://scriptblox.com/script/Giant-Simulator:-REBORN-Giant-Simulator-Reborn-242087), [raw source](https://github.com/zexalten-collab/giantsimulatorclassic/blob/main/script.lua) | Both listings resolve to the same MoonVeil-protected script. Advertises farming, swing, soccer, rebirth, crates, quests. | One source, not independent corroboration. Could not responsibly establish full implementation compatibility from the protected payload. |
| [DEVIL listing](https://rscripts.net/script/giant-simulator-reborn-or-best-script-or-bug-fixes-update-91ol), [loader](https://github.com/DEVIL-Script/DEVIL-Hub/blob/main/DEVIL-Hub-Main) | Broad feature list, including bosses, quests and summer minigames; source is a MoonSec-protected key loader. | Feature leads only. No verified Matcha-compatible implementation extracted. |
| [DeltaScript Reborn page](https://deltascript.dev/giant-simulator-script/) | Republishes the same readable orb farm and NK loader. Prose advertises additional config features not established by its shown code. | Duplicate evidence, not a distinct audited hub. |
| [Dxrknessq/giantsimzx](https://github.com/Dxrknessq/giantsimzx) | Older Giant Simulator script includes `WeaponAnimComplete`. | Legacy lead. This was insufficient for current REBORN XP training. |
| [Old redeem-codes script listing](https://rscripts.net/script/giant-simulator-redeem-codes-script-1421) | Five-year-old original-game listing, with no usable source recovered from the page. | Not used as a current code list or redemption implementation. |

Searches covered Reborn-specific listings, GitHub/source URLs, remote names, open-source farming, and current reward codes. This is a targeted internet sweep, not a claim that every upload or private Discord message was inspected.

## Matcha and UI compatibility

- Read [getting started](https://huoadf.github.io/matcha-docs/), [UI Binding](https://huoadf.github.io/matcha-docs/ui-binding/), [classes](https://huoadf.github.io/matcha-docs/classes/), and [limitations](https://huoadf.github.io/matcha-docs/limitations/).
- Your requested UI is [SxGoldenxS/REM-UI](https://github.com/SxGoldenxS/REM-UI). GitHub connector retrieval failed, but the local clone's GitHub remote was successfully fetched. Runtime source is pinned to commit `4d39214d904a49bbb5dc3579eec290b91cde349a`.
- Bundled `giant-reborn-rem-ui.lua` matches Git blob `353536952bbb3ed6248199871c733b2220c4e2d6` exactly. It is the Drawing edition; native `UI.AddTab` is not used to replace your menu.
- Documentation pages contain conflicting statements about `game:HttpGet`. The new loader uses the documented global `httpget` fallback and prefers the bundled local file.
- Hybrid Mode was observed enabled. `buffer.fromstring`, `firetouchinterest`, and remote dispatch were available. A diagnostic `GetServerClockTime:InvokeServer()` returned `true` rather than a clock number; RPC return values are therefore not displayed as confirmed rewards.

## Owning behavior traced in the live client

The relevant client controllers were decompiled locally; selected snapshots are in `research/`.

- **Training:** `ReplicatedStorage.ZapClient.TrainClick.Fire` writes a single u8 value **12**. Its sender calls `ZAP.ZAP_RELIABLE:FireServer(buffer, instances)`. The script sends `buffer.fromstring(string.char(12)), {}` at a selected rate of 1–5 requests/second, default **5**. Training has its own yielding timer, so farming/progression retain their existing cadence. Delayed ticks never trigger catch-up bursts. This gives XP without starting local weapon animations.
- **Animation/combat:** `PlayerController.AnimKeyframeReached` fires `WeaponAttackStart` at `BeamStart`, then `WeaponAnimComplete` at `End`. Our initial implementation replayed those events. The user found it did not independently train when native auto was off. It was replaced with the separately owned `TrainClick` behavior.
- **Orbs:** `NodeController` uses `Scene.ResourceNodes1` and per-node `NodeType`; it creates a `Prefab` for active nodes. Live inspection found 65 resource nodes. The hub scans this folder every three seconds. Collection measures the gap between the orb and the character's foot bounds, rather than the giant's elevated root center. Touch attempts use the nearest foot within 12 studs. Optional **Move to orbs** uses a controlled CFrame hop within 250 studs, at most once per second, and then waits for confirmation. A node changing to inactive increments the confirmed-pickup counter; sending a touch alone does not.
- **Rebirth:** `RebirthController.AllowRebirth` requires level >=100; `RebirthRequest()` takes no arguments. The script uses the actual leaderstats suffixes (`⚡Level`, `⭕Rebirths`), enforces a minimum threshold of 100, limits to one pending RPC, and waits 15 seconds between attempts.
- **Daily:** `DailyRewardsUIController` calls `GameService:RequestDailyReward()` with no arguments. The server determines eligibility; the hub requests at most once a minute.
- **Idle:** `IdleController` fires `IdleService.ResetIdleTimer` on real input. The hub can request that reset once a minute. Prevention of Roblox's separate platform idle disconnect has not been established.
- **Codes:** `CodesController` uses `ZapClient.RedeemCode.Call({code=...})`, with an RPC response and request-ID bookkeeping. The hub copies researched codes instead of injecting ad-hoc RPC IDs into the game's active client.

## Verification and limits

- Hub and actual bundled REM source compiled successfully.
- **53 contract checks** pass, covering startup/cleanup, training timing, chest acknowledgement and cancellation, the End/Delete key split, giant-foot proximity and pickup confirmation, Halloween attack phases and character replacement, house cooldowns and cancellation, movement exclusivity, auto-train coexisting with both Halloween modes, opposite-side door retry, skipping blocked houses, moving-ghost prediction, out-of-range hit rejection, persistent ghost focus, meter-based soul reporting, final position replication, scheduler stalls, cancellation during final tracking, and native-follow attack ownership and cancellation.
- Real Matcha loaded the current REM pages, including Chests and Halloween. Fresh loads start with all automation off.
- After the user turned native auto off, a bounded eight-request TrainClick probe produced XP popups and observed level advancement from **84 to 86**. The user confirmed XP popups and noted there was no visual swing. A second check held at **86** across two one-second control intervals, then advanced to **87** during eight TrainClick requests. Final corrected hub was reloaded, with its automation switches verified off.
- Reward eligibility, long sessions, and independently attributable rebirth/daily rewards are not claimed end-to-end verified. Live orb results are recorded below.
- Existing server requests cannot be cancelled after dispatch. Stopping prevents later queued requests; unload also disconnects input, removes REM UI, and stops further movement writes.
- All four current researched codes and source disagreements are in [CODES.md](CODES.md). No code has been redeemed by this work.

## Training-rate comparison, 1 November 2026

The user requested faster training and asked about anti-cheat. Hub training was paused, the user confirmed native auto was off, and a two-second control held at level 31. Four bounded 12-second intervals then sent the exact current TrainClick packet at the following rates. Raw records are in `research/train-rate-results.json`.

| Requests/second | Requests sent | Level before → after | Approximate XP from crossed level thresholds |
| --- | --- | --- | --- |
| 2 | 24 | 31 → 46 | 204,140 |
| 5 | 60 | 46 → 58 | 379,788 |
| 10 | 120 | 58 → 65 | 377,104 |
| 2, repeated | 24 | 65 → 68 | 215,504 |

XP estimates use the actual client's `SharedConstants.XpToLevel` formula and sum the thresholds crossed. They omit changes in partial progress within the starting and ending levels, so these are estimates rather than exact XP measurements. Level gain alone is not comparable because later levels cost more XP. The 5/s trials yielded roughly 1.8 times the estimated XP rate of 2/s; 10/s showed no clear gain over 5/s.

This is consistent with server-side throttling or another server-controlled training limit, but does not identify the server's exact rate limiter or anti-cheat policy. Short successful tests do not establish long-session anti-cheat safety. The hub defaults to 5/s and caps its slider there. After reloading, the user's active training toggle and other controls were restored; training was on at 5/s, orb walking/collection off, with Pumpkin still selected.

## Fast owned-chest opening, 1 November 2026

The user explicitly asked to try skipping the opening delay. `ChestInventoryController.OpenChestsPayload` calls `ZapClient.OpenChests.Call({crate=...,count=...})`, receives the rewards, and only then constructs the reveal payload. The animation is separate from awarding the items. `ChestRevealOverlay` spends 1.2 seconds on the burst, delays card readiness, and its Auto flow then waits another 0.9 seconds. The normal UI offers batches of up to three.

The current owned-chest packet is four bytes: opcode **23**, request ID, explicit chest flags, and batch count. Explicit flags for common/rare/epic weapon are **3/5/9**; skin flags are **17/33/65**. No buying or selling opcode is involved. The hub uses request ID 240 only while the native reveal is closed; the game's native Auto must remain off. It cannot reserve this ID in the real client's private RPC table, so users must not operate the native chest opener concurrently.

Matcha's `OnClientEvent` binding was unavailable, and the attempted GC inventory scan produced unusable references. The completed opener does not use GC reads or writes. It reads exact numeric chest counts from the native **Chests inventory tab**, which must stay open. The actual cards are named `chest_t1_wpn_crate`, etc.; multiple React containers can share numeric names. The count reader matches the actual card names and does not assume a unique full dotted path.

The REM **Chests** page provides a chest-type selector, 1–3 items per batch, **Open one batch**, and **Fast open owned chests**. Continuous opening starts off. It dispatches at most one batch per second, waits for the exact expected count decrement before another batch, and stops without retrying after four seconds without confirmation. Empty inventory, malformed/missing counts, a native reveal, or unexpected count changes stop dispatch. Hub training and rebirth pause while a batch is being tracked and resume afterward; Stop all automation does not resume them.

Live validation:

- The raw current packet opened **three common weapon chests**, with the visible count changing **27 → 24** within about **0.75 seconds**, without invoking the reveal UI.
- The new REM button subsequently confirmed another **three common weapon chests**, ending at **15 remaining**. Its status read `Confirmed 3 opened; 15 left | Confirmed opened 3`, and its opening toggle returned to off.
- Tests consumed **six owned common weapon chests** in total. No purchases or sales were made by this work. Continuous opening was left off, and previous hub controls were restored.
- The integrated button initially exposed a missing `chest_` prefix in the count reader. The reader and fixtures were corrected to use the observed live UI names, then the live button and all **24 contract checks** passed.

The one-second interval is a conservative dispatch ceiling, not a measured server maximum. Other chest types, long-running continuous throughput, full-inventory refusal, and concurrency with manual opening were not live-tested. The fail-closed count checks cover refusal without pretending a dispatch acknowledgement is a successful reward.

## End key, orb investigation and Halloween automation, 1 November 2026

**End** now toggles REM through its existing `SetKeybind` API. **Delete** unloads the hub; End no longer runs the unload handler.

Orb investigation found two defects in the original implementation: it measured from the elevated giant root (one live root measured 55 studs across and was far above the feet), and `Humanoid.WalkToPoint` writes did not produce movement in a bounded test. The update measures approximate foot/orb bounding-box separation and uses controlled CFrame hops when **Move to orbs** is enabled. The original 21,000-stud separation from the main orb field was also reported through a new status label. These changes pass targeted fixture checks, but the subsequent isolated live test still recorded **zero confirmed pickups**. Orb reward collection remains unresolved on this server; neither a sent touch nor a movement write is presented as proof of collection. Orb farming is paused during Halloween modes.

Halloween ghost investigation traced `GhostTrackController` and the actual combat sequence: face the ghost, send `WeaponAttackStart`, report the ghost's `Hitbox` through `MeleeHit`, then send `WeaponAnimComplete`. A facing/in-range probe increased the Soul Lantern counter **149 → 151**. The integrated ghost mode subsequently displayed **153** souls. It ignores hidden/reforming ghosts, limits its initial search to 500 studs, waits for position replication and attack windup, serializes swings, and drops pending hits if the character changes.

Trick-or-treat uses the ten house Door ProximityPrompts in `Scene.HalloweenZone.Houses`. Current shared config lists **11 base pumpkins**, **18 studs knock distance**, **2 seconds per-player cooldown**, **10 seconds per-house cooldown**, and **5 seconds door-open animation**. Native prompt invocation avoids manual holding; no server cooldown bypass was established. The cycle waits over two seconds between knocks and over ten seconds before revisiting a house. Rewards were observed as **1.43K → 1.52K**, then two-house cycling **1.52K → 1.61K → 1.69K**; the visible abbreviated counters and player boosts prevent treating those displayed differences as exact base rewards.

The REM **Halloween** page offers **Off / Ghost souls / Trick-or-treat**. Both modes use controlled hops within the local event area. They suspend orb farming and rebirth, and cannot overlap chest opening. Following the user's correction, **auto-train remains independently available with either Halloween mode**. Turning event mode off restores the paused movement/rebirth controls; Stop all automation does not resume them.

An AFK trial initially stopped at a blocked house. The corrected cycle tries the opposite side once, then marks an unreachable house unavailable for 30 seconds and continues to other houses. On the user's AFK request, auto-train, Trick-or-treat, and the game's idle-reset option were enabled. A six-second check observed the hub running, **32 dispatched requests**, and pumpkins **8.20K → 8.38K**. This is short-session evidence, not a guarantee against Roblox's separate platform idle disconnect or long-session detection.

## Ghost soul farming improvement, 1 November 2026

The previous ghost cycle positioned once, then waited before swinging while the ghost continued moving. Ghost hitboxes are animated through CFrame, so their native Velocity stays zero. The updated cycle samples displacement, estimates speed with a 20-stud/second ceiling, and uses the hitbox's track-facing LookVector to lead by at most 0.25 seconds. It positions twice per swing, including just before attack start, rather than writing movement every frame.

Ghost work now runs on a separate yielding 0.1-second worker. Attack start/hit/end are scheduled at 0.15/0.35/0.55 seconds, with the next cycle no earlier than 0.8 seconds. The house loop retains its existing cadence and cooldowns. Ghost focus persists until a target becomes hidden, is removed, or leaves the nearby search area. Hits beyond 10 studs are skipped; active swings close on cancellation. Auto-train remains independent.

The Halloween status reads the native Soul Lantern count and shows observed gains, souls/minute, dispatched hit attempts and proximity misses. An attempt is not a confirmed hit. Observed gain can include bonuses or other soul sources; the rate starts displaying after five seconds.

Live measurements, with hub auto-train running in both intervals:

| Version | Native souls before → after | Duration | Observed souls/minute |
| --- | --- | --- | --- |
| Previous cycle | 157 → 187 (+30) | 30.52 seconds | 59 |
| Updated tracking and cycle | 187 → 280 (+93) | 30.05 seconds | 186 |

Raw results are in `research/ghost-baseline.json` and `research/ghost-improved.json`; the previous implementation is saved as `research/ghost-baseline.lua`. The updated interval reported 38 hit attempts and zero proximity misses. Blood Moon was active at both ends of that interval; its state was not recorded for the baseline. These short intervals show roughly 3.1 times the observed soul rate, but do not isolate timing from event bonuses or random ghost rewards, establish a server maximum, or guarantee sustained throughput.

The updated hub and bundled REM source compiled and all 43 contract checks passed. The updated installed copy matches the project source. After the comparison, the live REM controls were verified as **Trick-or-treat**, **auto-train on**, and **game idle reset on**, preserving the user's AFK setup.

## Intermittent tracking misses, 1 November 2026

The user subsequently observed ghosts moving out of the effective attack position between teleport updates. The earlier `Misses` counter only counted reports skipped by the local 10-stud distance check. Zero on that counter did not establish that every dispatched hit was accepted. The label is now **Range skips**; attempts remain separate from observed soul gains.

The revised cycle adds one position correction just before the hit report, predicts 0.15 seconds along the track tangent, and waits at least 0.15 seconds before dispatch. If that correction is more than 0.3 seconds old when the worker resumes, it re-aims and waits again. Movement remains phase-based, normally three writes per swing, rather than per-frame. Final tracking refuses to follow a target 500 or more studs away, and stopping during the replication wait cancels the hit.

Tracing also found that the previous absolute start/hit/end deadlines could all expire during a scheduler stall, causing all three requests in a single tick. Hit timing now follows the actual start; completion follows the actual hit, with at least 0.2 seconds between each. A new cycle waits at least another 0.1 seconds after completion and no less than the existing 0.8-second cycle floor. These changes prioritize fresh positioning and ordered dispatch over maximum request rate. Hitbox sizes are unchanged because the farmer directly reports the ghost instance rather than relying on native collision detection.

All **47 contract checks** pass, including stalled-worker phase separation, re-aiming after stale positioning, final-wait cancellation, nearby-area bounds, and the moving-target replication wait. The updated source is installed in the existing Matcha workspace loader. Live Matcha tools were unavailable for this revision: it has **not** been hot-loaded or benchmarked, and the previous 186 souls/minute measurement applies to the earlier version. The last verified live setup was changed to **Ghost souls**, with auto-train and game idle reset on; this revision does not establish its current state. A manual reload still starts all automation off by design.

## Possible double hits, 1 November 2026

The user reported occasional apparent double hits within one swing. Inspection of the cached client sources establishes two relevant behaviors, but does not establish a repeat-hit exploit:

- `GhostTrackController._onHit` processes one `GhostHit` response and can show both a `souls` popup and, when `popped` is true, a separate `bonus` popup. It then updates the ghost's hit pips from the response's `hits` field. Two reward popups alone therefore do not prove two accepted hits.
- `PlayerController.AnimKeyframeReached` begins one melee window at `BeamStart` and ends it at `End`, for both single and dual attack animations. Its primary and secondary animations alternate. `Weapons.GetLoadoutAPS` averages main-hand and offhand APS; this does not establish that the same ghost can be rewarded twice within one window.

The cached shared `MeleeHitbox` module computes weapon collision geometry and reach, but contains no per-swing hit bookkeeping. The owning `MeleeController` and server-side acceptance logic are not in the available snapshots. The hub itself sends at most one `MeleeHit` per attack window. Live Matcha tools were unavailable, so duplicate reports, spaced duplicate reports, and actual hit-pip changes could not be compared with a one-report control. No repeat-hit behavior was added, and server acceptance or increased soul throughput is not claimed.

## Live double-hit tests and native-auto ownership, 1 November 2026

The local Matcha MCP server was reachable at the user's supplied `http://127.0.0.1:8765/mcp`, despite the connector tools disappearing from the chat tool list. Live inspection used its standard MCP tools over that endpoint. The session was place 12645083079, job `1e93ea53-a95f-49d7-a3ee-5606a4429368`, with reported ping around 230 ms. The freshly decompiled `MeleeController` is saved in `research/giant-research-MeleeController.lua`: both weapon boxes feed `TryReport`, which resolves each part to its model and permits one report per model in `HitThisSwing` until the next `OnSwingStart`.

The user confirmed native auto was enabled and agreed to leave controls alone. The hub's Halloween mode and the native controller's single boolean `DoAutoClick` were temporarily paused. A cached, type-filtered GC entry was used only during investigation; a direct `readtbl` confirmed false, and a two-second quiet interval held at 5,354 souls. No GC scan or mutation was added to the hub.

The bounded diagnostic in `research/double-hit-probe.lua` compared six swings per block, alternating controls and duplicate reports with matched window duration. No new attack-start request was sent between the first and second report. Blood Moon remained active at the ends of every recorded block:

| Reports per swing / gap | Soul gain in two six-swing blocks | Reports dispatched in those blocks |
| --- | --- | --- |
| One report, short-window control | 17, 22 | 6, 6 |
| Two immediately | 17, 17 | 12, 12 |
| Two, 0.12 seconds apart | 17, 17 | 12, 12 |
| One report, longer-window control | 17, 17 | 6, 6 |
| Two, 0.30 seconds apart | 17, 17 | 11, 11 |
| Two, 0.50 seconds apart | 17, 22 | 11, 10 |

Some late second reports were skipped when the ghost became hidden or left local reach. Raw results are `research/double-hit-short-results.json` and `research/double-hit-late-results.json`. An additional short-gap repeat is retained as `research/double-hit-short-repeat-results.json`: Matcha's loadstring bridge did not forward the requested chunk argument, so that run repeated the short protocol rather than testing longer gaps. The probe now selects the longer protocol through a one-shot global flag. These observations found no useful gain from reporting the same ghost twice within one window; they do not establish the exact server validator or all possible cooldown behavior. No duplicate-hit feature was enabled.

The user then pointed out native auto was faster than the scripted sequence. With native auto restarted through the actual game button and verified true, `research/native-ghost-probe.lua` tested native swings while only following visible ghosts, predicting their motion by 0.2 seconds and writing character position at most five times per second:

| Following with native auto | Exact souls | Duration | Observed souls/minute |
| --- | --- | --- | --- |
| Normal ghost hitboxes | 6,106 → 6,207 (+101) | 20.14 seconds | 301 |
| Local 12×12×12 ghost hitboxes | 6,207 → 6,315 (+108) | 20.09 seconds | 323 |

Raw results are `research/native-ghost-results.json`. The single enlarged-hitbox interval was about 7% higher, but random pop bonuses and the short, sequential comparison prevent attributing that difference to resizing. Every modified size was restored. Enlarged hitboxes were not added to production.

The hub now defaults **Ghost attack source** to **Native auto**. This mode leaves attack timing to the game and only follows the selected ghost at most five times per second; it sends no attack-start, melee-hit or animation-complete requests. The game's Auto must be on. **Scripted** retains the serialized fallback for use with game Auto off. Changing source closes an active scripted window and cancels its queued hit. Target selection, area bounds and motion prediction are shared between both sources. Stop/unload stops hub movement and requests; the game's own Auto remains independently controlled.

All **53 contract checks** pass, including native default behavior, movement throttling, attack-source switching, no native-mode combat dispatch, stop behavior, character changes and hidden/far targets. The installed source matches the project copy. The native-auto revision was hot-loaded with the user's Farming and Progression controls restored. The integrated measurement increased exact souls **7,036 → 7,188 (+152) in 30.01 seconds**, approximately **304 souls/minute**; its raw result is `research/native-hub-results.json`. Final live reads verified **Ghost souls**, **Ghost attack source: Native auto**, **auto-train on**, **native DoAutoClick true**, and all **ten hitboxes at their original 6×8×6 size**. Game idle reset remained off, preserving the setting observed before testing. These are short-session results, not a guaranteed sustained rate or anti-cheat assessment.

## Run locally

Delivery files are also copied into `C:\matcha\workspace`:

```lua
loadstring(readfile("giant-reborn-matcha.lua"))()
```

**End** toggles REM. **Delete** unloads. Emergency stop:

```lua
if _G.GiantRebornMatcha then _G.GiantRebornMatcha.Stop() end
```

Tests are self-contained in this project through the pinned Fengari development dependency. Run from the repository root:

```powershell
npm ci
npm test
```

The research sessions above performed no publication, code redemption, automatic purchases, or inventory sales.

## GitHub packaging, 2 November 2026

The user authorized a public `SxGoldenxS/Giant-Simulator-Reborn-Matcha` repository containing the full project and bundled REM UI. The production hub's HTTP fallback now uses this repository's `giant-reborn-rem-ui.lua`, so a fresh workspace does not depend on the private REM-UI repository. An existing local UI copy still takes precedence. The test runner now resolves the repository's own pinned Fengari dependency. The README documents the web loader, offline loader, controls, verification, and investigative artifacts. No gameplay behavior was changed for publication.
