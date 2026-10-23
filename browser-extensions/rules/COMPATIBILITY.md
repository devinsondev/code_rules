# Chrome and Firefox: important differences

Canonical contract: [SKILL.md](../SKILL.md).

| Feature | Chrome MV3 | Firefox MV3 |
| --- | --- | --- |
| Background | `background.service_worker` | `background.scripts` (nonpersistent event page) |
| Background DOM | None | Event page offers DOM, but **shared code must not rely on it** |
| API namespace | `chrome`; newer Chrome also `browser` | Promise-oriented `browser`, `chrome` compatibility varies |
| Firefox metadata | Ignored | Stable Gecko ID for MV3 signing; accurate data collection permissions |
| Permissions | Different UX and optional-grant flows | Different UX/host grants; test denial and revocation |

MDN documents a dual-entry background manifest (`"background":{"service_worker":"background.js","scripts":["background.js"]}`) in currently supported versions. Validate your exact supported minimum; separate platform-specific manifests are equally valid and can be safer for complex extensions.

Chrome's `browser` namespace was added in Chrome 148 (Chrome 152 for DevTools extension contexts). Earlier versions require `chrome` or a tested polyfill. Promise-based `runtime.onMessage` listeners have support/rollout differences; for older Chrome use `sendResponse` plus a literal `return true` for asynchronous response paths (test on each target). Keep messages JSON-compatible, not structured-clone-dependent.

Detect **individual APIs**, not merely user-agent strings. Check injection restrictions on browser-internal pages/stores, frames, private/incognito windows when claimed, and `declarativeNetRequest` limitations per browser/version.

Firefox MV3 signing: set unique `browser_specific_settings.gecko.id`; since 2025-11-03, new AMO submissions must specify `gecko.data_collection_permissions` honestly. Firefox for Android is a **separate** tested support claim.

See [vendor links](../SOURCES.md). Maintain a per-feature browser-version compatibility test.
