# Retrieved third-party sources

These snapshots were retrieved on 2 November 2026 for static research. They are not dependencies of the production hub. The research/deobfuscation request was cancelled before a full analysis was completed.

| File | Upstream source | Status |
| --- | --- | --- |
| `gaks.original.lua` | [esekgakra-jpg/Giant-Sim, Gaks Hub](https://github.com/esekgakra-jpg/Giant-Sim/blob/main/Gaks%20Hub) | Public LuaObfuscator output. |
| `gaks.formatted.lua` | Same source | Formatting only; Luau `continue` statements preserved. Original variable names were not recovered. |
| `nk.original.lua` | [zexalten-collab/giantsimulatorclassic, script.lua](https://github.com/zexalten-collab/giantsimulatorclassic/blob/main/script.lua) | Public MoonVeil-protected source; payload not recovered. |

These files remain attributed to their respective upstream authors. Inclusion does not claim authorship or a license grant. No third-party hub was executed in the live game. The full hub contains compatibility-sensitive GUI APIs and old packet values, so the snapshots are not presented as Matcha-ready scripts.

`tools/package.json` and its lockfile record the tools installed for local parsing/formatting. Their `node_modules` directory is excluded from Git. Installing those tools is unnecessary for running or testing the production hub.
