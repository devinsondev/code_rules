# UX, accessibility and performance

Canonical contract: [SKILL.md](../SKILL.md).

- Prefer a focused action popup and options for durable settings, rather than generic dashboard clutter.
- Semantic HTML, properly labeled controls, keyboard-only navigation, visible focus, accessible live error/success messages, light/dark and zoom support, reduced-motion preference.
- Explicit loading/empty/permission denied/offline/error/unsupported-page states. Tell the user how to recover.
- Content scripts: narrow selectors, idempotent insertion, namespace CSS, cleanup listeners/MutationObservers, bound/debounce scans and handle SPA navigations. Don't steal focus, intercept global shortcuts, damage page layout or touch credential/payment flows unexpectedly.
- Limit network calls, CPU and memory; prefer events/alarms over polling or service-worker keepalive. Batch storage updates, cancel stale requests, measure popup responsiveness and content-script overhead on representative pages.
- Respect opt-out and never transmit page data without explicit product need and clear notice.
