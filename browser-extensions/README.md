# Browser Extensions — Chrome + Firefox

**AI instruction:** [SKILL.md](SKILL.md), canonical for new/modified browser extensions.

> Follow https://github.com/devinsondev/code_rules/blob/main/browser-extensions/SKILL.md. Build secure Manifest V3 WebExtensions for Chrome and Firefox, test actual release outputs in both browsers, and explicitly report incomplete checks.

### Guides
- [Architecture](rules/ARCHITECTURE.md)
- [Security and privacy](rules/SECURITY.md)
- [Chrome + Firefox compatibility](rules/COMPATIBILITY.md)
- [UI and performance](rules/UX_PERFORMANCE.md)
- [Verification and release](rules/VERIFICATION.md)
- [Official sources](SOURCES.md)

### Example
[Minimal MV3 starter](examples/minimal-mv3/README.md): a dependency-free action popup sending a message to shared background code. No host permissions, remote code or data collection.

**Version caveats:** Chrome background = service worker; Firefox background = event page/scripts. Firefox MV3 signing requires a Gecko extension ID. New AMO submissions since November 3, 2025 must declare Gecko data collection permissions accurately. Confirm minimum supported browser versions, API differences and current store rules before distribution.
