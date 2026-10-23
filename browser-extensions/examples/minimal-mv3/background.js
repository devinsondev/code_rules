"use strict";
const api = globalThis.browser ?? globalThis.chrome;

// Register immediately: Chrome worker and Firefox event page may be restarted.
api.runtime.onMessage.addListener((message, sender, sendResponse) => {
  if (!message || message.type !== "GET_VERSION") return false;
  if (sender.id !== api.runtime.id) return false;
  sendResponse({ ok: true, version: api.runtime.getManifest().version });
  return false;
});
