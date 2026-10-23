# Architecture

Canonical contract: [SKILL.md](../SKILL.md).

| Context | Role | Avoid |
| --- | --- | --- |
| Background | Privileged orchestration, browser events, alarms | DOM assumptions, persistent globals |
| Content script | Minimal page observation/interaction | Trusting webpage DOM, broad site changes |
| Popup/options | Small accessible UI, user actions | Coupling UI to privileged services |
| Shared core | Domain logic, validation and types | Browser-dependent globals |
| Adapter | Browser-specific API differences | Unchecked browser-name assumptions |

Recommended for nontrivial projects: `src/background`, `src/content`, `src/popup`, `src/options`, `src/features`, `src/shared`, `src/platform`, `tests`, browser-specific manifest generation.

Define discriminated message unions (`type` + validated payload); constrain sender and privilege. Treat a content script as untrusted input to background. Never implement arbitrary `fetch(url)`, `executeCode()` or `storageGet(key)` proxy commands.

Register background listeners synchronously. Persist required data via `storage.local`/IndexedDB; version and validate schemas, provide idempotent migrations. Handle concurrent writes: ordinary get/set is not an atomic transaction. Use alarms for scheduled work rather than keeping a worker alive.

Keep features narrow and testable: feature trigger, required permissions, contexts, stored data, failure/denial mode and regression test. Prefer small explicit dependencies, bounded retries, typed safe errors and abortable network work.
