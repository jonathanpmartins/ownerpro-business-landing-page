<script setup>
import { ref, provide } from 'vue'
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
import ColorPicker from './components/ColorPicker.vue'

// Cores do tema - ajuste aqui as cores finais escolhidas
const primaryColor = ref('#24847f')
const secondaryColor = ref('#8f0000')

// Disponibiliza as cores para todos os componentes filhos
provide('primaryColor', primaryColor)
provide('secondaryColor', secondaryColor)

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
      @close="showColorPicker = false"
    />

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
  </div>
</template>
