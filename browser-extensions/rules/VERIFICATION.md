# Test matrix and release gates

Canonical contract: [SKILL.md](../SKILL.md).

## Automation
- Reproducible locked dependency installation, lint/format, typecheck if TS, unit tests, build and manifest JSON validation.
- Unit tests for message validation, storage schema migrations and critical features; inspect runtime/host permissions, package contents, remote code and accidental secrets.
- `web-ext lint --source-dir <firefox-dist>` must validate the *final* Firefox build.
- CI minimum token privileges (e.g. `contents: read`), reviewed/pinned actions, no store secret exposure.

## Browser smoke tests

| Case | Chrome | Firefox |
| --- | --- | --- |
| Load final distribution | Required | Required |
| Popup/options accessibility | If UI | If UI |
| Background restart and event wakeup | Required | Required |
| Content injection/restricted URLs | If used | If used |
| Permission grant/deny/revoke | If used | If used |
| Persisted data migrations | If stored | If stored |
| Offline/malformed network response | If networked | If networked |
| Release update from prior version | Before release | Before release |

Chrome: Load unpacked via `chrome://extensions` and inspect service-worker errors. Firefox: `web-ext lint --source-dir <firefox-dist>`, `web-ext run --source-dir <firefox-dist>`; inspect `about:debugging`. Include minimum supported versions in testing or narrow stated support.

## Release report template
```text
Chrome versions: ...
Firefox versions: ...
Manifests: PASS / FAIL / NOT VERIFIED
Lint / typecheck / tests / build: PASS / FAIL / NOT VERIFIED
Chrome runtime smoke: PASS / FAIL / NOT VERIFIED
Firefox runtime smoke: PASS / FAIL / NOT VERIFIED
Security, permissions, privacy: PASS / FAIL / NOT VERIFIED
Package audit: PASS / FAIL / NOT VERIFIED
Decision: READY TO RELEASE / NOT READY
Unverified items and next action: ...
```

Store submission, signing and approval are separate tasks requiring explicit authorization.
