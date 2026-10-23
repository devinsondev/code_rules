# Security and privacy

Canonical contract: [SKILL.md](../SKILL.md).

## Feature-to-permission audit
For each feature: `feature → API → permissions/hosts → reason → time of request → denial behavior`.
Default to no host access; prefer `activeTab` or `optional_host_permissions` where viable. No blanket `<all_urls>`, `tabs`, `cookies`, `history`, `debugger`, `nativeMessaging` by default. Use `permissions.contains` and removal events when relevant.

## Boundary checklist
- Webpage DOM, postMessage, content scripts, URLs and network input may be attacker-controlled.
- Gate privileged runtime handlers on narrow command allowlists, schemas, size budgets, and relevant sender identity/tab/origin. No generic privileged proxy.
- No `eval`, `new Function`, remote hosted JS/WASM, hidden code loaders, remote bundler runtime or loosened CSP.
- Render external strings with `textContent`, not raw HTML sinks. Treat unsafe selectors, regexes and URLs as injection surfaces.
- HTTPS only, allowlisted hosts, timeouts, redirect and response validation, bounded retries. No silent browsing/page-data exfiltration.
- Only collect/retain necessary data and communicate all transfers. Local extension storage is not encrypted secret storage; never ship tokens, keys or credentials in source.
- Chrome Web Store and AMO disclosures must match real processing. Firefox `gecko.data_collection_permissions.required: ["none"]` is appropriate only if **no** data in the platform taxonomy is collected.
- Check `web_accessible_resources` exposure, third-party scripts and dependency lifecycle code; commit pinned lockfiles. Protect CI tokens/store credentials and audit ZIP/XPI contents.
