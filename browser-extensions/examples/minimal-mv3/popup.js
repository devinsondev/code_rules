"use strict";
const api = globalThis.browser ?? globalThis.chrome;
const button = document.getElementById("check");
const status = document.getElementById("status");

button.addEventListener("click", async () => {
  button.disabled = true;
  status.textContent = "Checking...";
  try {
    const response = await api.runtime.sendMessage({ type: "GET_VERSION" });
    if (response?.ok !== true || typeof response.version !== "string") {
      throw new Error("Unexpected response");
    }
    status.textContent = "Version: " + response.version;
  } catch {
    status.textContent = "Background context did not respond.";
  } finally {
    button.disabled = false;
  }
});
