<script setup>
import { ref, provide, computed } from 'vue'
import Header from './components/Header.vue'
import Hero from './components/Hero.vue'
import TargetAudience from './components/TargetAudience.vue'
import ProblemSolution from './components/ProblemSolution.vue'
import Features from './components/Features.vue'
import Differentials from './components/Differentials.vue'
import OwnerPortal from './components/OwnerPortal.vue'
import PricingCalculator from './components/PricingCalculator.vue'
import CtaSection from './components/CtaSection.vue'
import FooterSection from './components/FooterSection.vue'
import WhatsAppFab from './components/WhatsAppFab.vue'
import ColorPicker from './components/ColorPicker.vue'

// Cores do tema - Coastal Calm
const primaryColor = ref('#0F766E')
const secondaryColor = ref('#FB923C')

// Cores das tags
const tagColorOptions = [
  { name: 'Verde', bg: '#e8f5e9', text: '#2e7d32' },
  { name: 'Teal', bg: '#e0f2f1', text: '#24847f' },
  { name: 'Azul', bg: '#e3f2fd', text: '#1565c0' },
  { name: 'Âmbar', bg: '#fff8e1', text: '#f57f17' },
  { name: 'Primária', bg: null, text: null },
  { name: 'Secundária', bg: null, text: null },
  { name: 'Custom', bg: null, text: null },
]
const selectedTagColor = ref(4) // 4 = Primária
const customTagColor = ref('#6366f1')

// Cor dos ícones sobre fundo primário (checks, etc)
const accentOnPrimaryOptions = ['Branco', 'Secundária']
const selectedAccentOnPrimary = ref(1) // 0 = Branco, 1 = Secundária

// Cor dos boxes de ícones (seção Funcionalidades)
const iconBoxColorOptions = ['Primária', 'Secundária']
const selectedIconBoxColor = ref(1) // 0 = Primária, 1 = Secundária

// Função para clarear uma cor
const lightenColor = (hex, percent = 85) => {
  const num = parseInt(hex.replace('#', ''), 16)
  const r = Math.min(255, (num >> 16) + Math.round((255 - (num >> 16)) * percent / 100))
  const g = Math.min(255, ((num >> 8) & 0x00FF) + Math.round((255 - ((num >> 8) & 0x00FF)) * percent / 100))
  const b = Math.min(255, (num & 0x0000FF) + Math.round((255 - (num & 0x0000FF)) * percent / 100))
  return '#' + (0x1000000 + r * 0x10000 + g * 0x100 + b).toString(16).slice(1)
}

// Cor da tag computada
const tagColor = computed(() => {
  const option = tagColorOptions[selectedTagColor.value]
  if (option.name === 'Primária') {
    return { bg: primaryColor.value + '20', text: primaryColor.value }
  }
  if (option.name === 'Secundária') {
    return { bg: secondaryColor.value + '20', text: secondaryColor.value }
  }
  if (option.name === 'Custom') {
    return { bg: lightenColor(customTagColor.value), text: customTagColor.value }
  }
  return { bg: option.bg, text: option.text }
})

// Cor do acento sobre fundo primário
const accentOnPrimary = computed(() => {
  return selectedAccentOnPrimary.value === 0 ? 'rgba(255,255,255,0.9)' : secondaryColor.value
})

// Cor dos boxes de ícones
const iconBoxColor = computed(() => {
  return selectedIconBoxColor.value === 0 ? primaryColor.value : secondaryColor.value
})

// Disponibiliza as cores para todos os componentes filhos
provide('primaryColor', primaryColor)
provide('secondaryColor', secondaryColor)
provide('tagColor', tagColor)
provide('accentOnPrimary', accentOnPrimary)
provide('iconBoxColor', iconBoxColor)

// Controle do color picker - ativado via ?colors=view na URL
const urlParams = new URLSearchParams(window.location.search)
const showColorPicker = ref(urlParams.get('colors') === 'view')

// Função para escurecer cor
const darkenColor = (hex, percent) => {
  const num = parseInt(hex.replace('#', ''), 16)
  const amt = Math.round(2.55 * percent)
  const R = Math.max((num >> 16) - amt, 0)
  const G = Math.max((num >> 8 & 0x00FF) - amt, 0)
  const B = Math.max((num & 0x0000FF) - amt, 0)
  return '#' + (0x1000000 + R * 0x10000 + G * 0x100 + B).toString(16).slice(1)
}

provide('darkenColor', darkenColor)
</script>

<template>
  <div class="min-h-screen bg-gray-50 font-sans">
    <!-- Color Picker - ativado via ?colors=view -->
    <ColorPicker
      v-if="showColorPicker"
      v-model:primary="primaryColor"
      v-model:secondary="secondaryColor"
      v-model:selectedTag="selectedTagColor"
      v-model:customTagColor="customTagColor"
      v-model:selectedAccent="selectedAccentOnPrimary"
      v-model:selectedIconBox="selectedIconBoxColor"
      :tagColorOptions="tagColorOptions"
      :accentOnPrimaryOptions="accentOnPrimaryOptions"
      :iconBoxColorOptions="iconBoxColorOptions"
      :lightenColor="lightenColor"
      @close="showColorPicker = false"
    />

    <button
      v-if="!showColorPicker && urlParams.get('colors') === 'view'"
      @click="showColorPicker = true"
      class="fixed top-4 right-4 z-50 bg-white rounded-full shadow-lg p-3 hover:shadow-xl transition border border-gray-200"
      title="Abrir seletor de cores"
    >
      🎨
    </button>

    <Header />
    <Hero />
    <TargetAudience />
    <ProblemSolution />
    <Features />
    <Differentials />
    <OwnerPortal />
    <PricingCalculator />
    <CtaSection />
    <FooterSection />
    <WhatsAppFab />
  </div>
</template>
