import { ViteSSG } from 'vite-ssg/single-page'
import './style.css'
import App from './App.vue'

// Pré-renderiza o HTML no build (vite-ssg build); no browser, hidrata normalmente
export const createApp = ViteSSG(App)
