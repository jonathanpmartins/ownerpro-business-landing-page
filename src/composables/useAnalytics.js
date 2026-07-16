// Eventos GA4. No-op quando gtag não existe (SSR do build, adblock, dev sem GA)
export const trackEvent = (name, params = {}) => {
  if (typeof window !== 'undefined' && typeof window.gtag === 'function') {
    window.gtag('event', name, params)
  }
}
