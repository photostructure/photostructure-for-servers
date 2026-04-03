// Minimal service worker for PWA installability.
// PhotoStructure is a self-hosted LAN app — offline caching is not meaningful.
self.addEventListener("install", () => self.skipWaiting());
self.addEventListener("activate", (e) => e.waitUntil(self.clients.claim()));
self.addEventListener("fetch", () => {});
