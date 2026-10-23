# Minimal cross-browser MV3 example

Runnable, dependency-free extension showing a popup to background message. No host/API permissions, network or data collection.

1. Replace `replace-me@example.invalid` in `manifest.json` with your own stable Gecko ID **before signing**.
2. Chrome: `chrome://extensions` → Developer mode → Load unpacked → select this folder.
3. Firefox: `web-ext lint --source-dir .` and `web-ext run --source-dir .`, or `about:debugging`.
4. Click the extension icon → **Check version**.

The manifest declares a Chrome service worker and Firefox background scripts that run the same DOM-free file. The Gecko ID here is a local placeholder; it must not be reused for publication. This starter is not a published/verified store package. See [canonical rules](../../SKILL.md).
