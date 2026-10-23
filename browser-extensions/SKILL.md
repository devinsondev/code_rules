---
name: cross-browser-extension-engineering
description: Canonical secure engineering rules for Chrome and Firefox Manifest V3 extensions.
---

# Browser Extension Engineering — CANONICAL STANDARD

Applies only to **Chrome and Firefox WebExtensions**, not Android. This file wins over supporting `rules/`; official current platform documentation governs version-specific behavior. Follow [SOURCES.md](SOURCES.md).

## 1. Mandatory AI contract

- Inspect the existing repository, actual features, manifests, target browsers/minimum versions, dependencies, test setup and privacy needs BEFORE editing.
- Preserve working product behavior. Deliver complete code rather than TODOs, stubs or unverifiable promises.
- Use one shared WebExtensions implementation where possible with **explicit narrow browser adapters**. Test differences rather than assuming API parity.
- Prefer TypeScript `strict` for nontrivial extensions, native APIs, semantic HTML/CSS, small feature-focused modules, explicit errors and unit-testable domain logic. A tiny dependency-free extension may use JavaScript.
- Commit lockfiles and reproducible build instructions. Add dependencies only with clear value; review transitive dependencies and build lifecycle scripts.
- Never claim that a build was tested in Chrome/Firefox or published to a store unless it actually was.

## 2. Manifest V3 and compatibility

- Target Manifest V3 for new extensions, unless a documented browser/API constraint requires otherwise.
- Chrome MV3 background: `background.service_worker`; Firefox MV3 background: `background.scripts` nonpersistent event page (Firefox does not currently support extension background service workers). Use separate generated manifests or a **verified** dual-background manifest where browser versions support it.
- Shared background code must be worker-safe: no `window`, `document` or DOM usage. Register event listeners **synchronously at top level**, not after an initial await.
- Background contexts may be suspended and restarted: save durable state in storage/IndexedDB, rebuild ephemeral caches, design event handlers for duplicate execution; use alarms/events instead of permanent polling/keepalive tricks.
- Prefer minimum permissions: `activeTab` when adequate, optional host grants for optional features, narrow host patterns. Handle grant denial and revocation. Explain each requested permission.
- Separate `permissions`, `host_permissions`, `optional_host_permissions` and `content_scripts.matches`. Keep `web_accessible_resources` tightly scoped.
- Use a browser API adapter or maintained compatibility polyfill where necessary. Chrome added `browser.*` in later releases; earlier versions use `chrome.*`. Test individual APIs and promise/message behavior against declared minimum versions.
- Firefox MV3 signing requires `browser_specific_settings.gecko.id`. New AMO submissions must declare `browser_specific_settings.gecko.data_collection_permissions`; `required: ["none"]` only if truthful.
- See [compatibility details](rules/COMPATIBILITY.md).

## 3. Hard security rules

- Hostile webpage DOM, postMessage, content-script data, tab URLs and network responses are **untrusted**. Runtime-validate message type, payload, length, sender/context and origin where appropriate before any privileged operation. Never offer generic privileged fetch/script-execution bridges.
- Never use `eval`, `new Function`, downloaded executable JS/WASM, remotely hosted scripts, or unexpected dynamic code loaders.
- Never interpolate untrusted HTML into `innerHTML`/HTML injection APIs. Use `textContent` and safe DOM construction; sanitize only where real rich HTML is required and documented.
- No baked-in credentials, tokens, signing keys, analytics or collection without explicit feature need and disclosures. Browser storage is not a vault for long-term secrets.
- Network: HTTPS and narrow allowlists, validate responses, handle redirects carefully, timeouts/cancellation and rate limiting. Don't silently upload page content or URLs.
- CSP must stay restrictive. Don't add `unsafe-eval` or remote script origins to make a bundler work.
- Review packages, permissions, artifacts and store privacy disclosures.
- See [security details](rules/SECURITY.md).

## 4. Architecture, UI and performance

- Separate `background`, `content`, `popup/options`, shared core, storage and browser adapters as applicable. No god files, accidental global state or needless abstractions.
- Use structured, versionable JSON-compatible message types and runtime validation. Chrome and Firefox differ in serialization; avoid nonportable objects. For async messaging, use a verified browser-compatible listener strategy, not indiscriminate `async` listener functions.
- Persist schema/version and test migrations and concurrent writes.
- Content scripts must be scoped, idempotent, safe to detach and non-disruptive to the website. Minimize observers, injected CSS, DOM scans and permissions.
- UI: keyboard navigation, focus visibility, screen reader labels/live states, light/dark and zoom support. Handle loading, empty, offline, errors and denied permissions.
- See [architecture](rules/ARCHITECTURE.md), [UX/performance](rules/UX_PERFORMANCE.md).

## 5. Verification before completion

For the actual final distribution build:
1. Validate both target manifests and required assets. Inspect permissions, hosts, CSP, remote code, dependency tree, secrets and archives.
2. Run available format/lint, typecheck, unit tests, build and relevant integration tests; don't disable checks to greenwash results.
3. Run `web-ext lint` on the **Firefox distribution folder**.
4. Load the packaged output in Chrome (`chrome://extensions`) and Firefox (`web-ext run`/`about:debugging`), test UI and messaging, background restart, site injection, permissions denial/revocation, storage migration and network failures as applicable.
5. Verify actual browser versions, package version, privacy declarations and store-specific signing/submission requirements.

When a browser, executable or credential is unavailable, mark its result **NOT VERIFIED**, not PASS. See [release matrix](rules/VERIFICATION.md).

## 6. READY TO RELEASE means

Only declare **READY TO RELEASE** when real-browser smoke tests pass for every claimed browser/version; release artifacts, permissions, data disclosures and signing requirements are correct; relevant test/build/security checks pass; and no unresolved critical issue remains.

Otherwise report **NOT READY** with failures, unperformed checks and concrete follow-up steps. A git commit does NOT mean Chrome Web Store/AMO approval. Never publish implicitly.
