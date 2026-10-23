// 화면 파일을 폰에 저장해 두어 오프라인에서도 열리게 하는 서비스워커.
// 항상 인터넷을 먼저 시도하고(최신 버전 유지), 안 되면 저장본을 사용합니다.
const CACHE = 'yongdon-v3';
const SHELL = ['./', './index.html', './firebase-config.js', './manifest.webmanifest',
  './icons/icon-192.png', './icons/icon-512.png'];

self.addEventListener('install', e => {
  e.waitUntil(caches.open(CACHE).then(c => c.addAll(SHELL)).then(() => self.skipWaiting()));
});

self.addEventListener('activate', e => {
  e.waitUntil(
    caches.keys().then(keys => Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', e => {
  const req = e.request;
  if (req.method !== 'GET') return;
  const url = new URL(req.url);
  const sameOrigin = url.origin === self.location.origin;
  const sdk = url.hostname === 'www.gstatic.com';
  if (!sameOrigin && !sdk) return; // Firestore/로그인 통신은 건드리지 않음
  e.respondWith(
    fetch(req).then(res => {
      if (res && res.ok) { const copy = res.clone(); caches.open(CACHE).then(c => c.put(req, copy)); }
      return res;
    }).catch(() => caches.match(req).then(r => r || caches.match('./index.html')))
  );
});
