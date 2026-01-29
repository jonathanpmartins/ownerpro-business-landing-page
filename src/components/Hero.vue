<script setup>
import { inject, computed } from 'vue'
import ImageCarousel from './ImageCarousel.vue'

const primaryColor = inject('primaryColor')
const secondaryColor = inject('secondaryColor')

const darkenColor = (hex, percent) => {
  const num = parseInt(hex.replace('#', ''), 16)
  const amt = Math.round(2.55 * percent)
  const R = Math.max((num >> 16) - amt, 0)
  const G = Math.max((num >> 8 & 0x00FF) - amt, 0)
  const B = Math.max((num & 0x0000FF) - amt, 0)
  return `#${(0x1000000 + R * 0x10000 + G * 0x100 + B).toString(16).slice(1)}`
}

const gradientStyle = computed(() => ({
  background: `linear-gradient(135deg, ${primaryColor.value} 0%, ${darkenColor(primaryColor.value, 25)} 100%)`
}))

const screenshots = [
  { src: '/hero/01-960.webp', srcFull: '/hero/01-1600.webp', alt: 'OwnerPro Business - Tela 1' },
  { src: '/hero/02-960.webp', srcFull: '/hero/02-1600.webp', alt: 'OwnerPro Business - Tela 2' },
  { src: '/hero/03-960.webp', srcFull: '/hero/03-1600.webp', alt: 'OwnerPro Business - Tela 3' },
  { src: '/hero/04-960.webp', srcFull: '/hero/04-1600.webp', alt: 'OwnerPro Business - Tela 4' },
  { src: '/hero/05-960.webp', srcFull: '/hero/05-1600.webp', alt: 'OwnerPro Business - Tela 5' },
]
</script>

<template>
  <section
    class="text-white"
    :style="gradientStyle"
  >
    <div class="max-w-6xl mx-auto px-6 py-16 lg:py-24">
      <div class="grid lg:grid-cols-2 gap-12 items-center">
        <!-- Texto -->
        <div>
          <div
            class="inline-flex items-center gap-2 px-4 py-2 rounded-full mb-6 text-sm font-medium"
            style="background-color: rgba(255,255,255,0.15)"
          >
            <span
              class="status-dot w-2 h-2 rounded-full"
              :style="{ backgroundColor: secondaryColor, '--glow-color': secondaryColor }"
            ></span>
            Sistema de aluguel por temporada
          </div>

          <h1 class="text-4xl lg:text-4xl font-bold leading-tight mb-6">
            Organize o financeiro e a operação em um só lugar
          </h1>

          <p class="text-lg opacity-80 mb-6">
            Desenvolvida por quem vive a gestão na prática. Não é apenas software — é uma ferramenta de gestão para quem quer crescer com controle.
          </p>

          <!-- Feature tags -->
          <div class="flex flex-wrap gap-2 mb-8">
            <span
              v-for="tag in ['Prestação de Contas', 'Repasses', 'Notas Fiscais', 'Portal do Proprietário', 'Check-in/out', 'Limpeza', 'Manutenções', 'Relatórios']"
              :key="tag"
              class="px-3 py-1 rounded-full text-sm font-medium"
              style="background-color: rgba(255,255,255,0.15)"
            >
              {{ tag }}
            </span>
          </div>

          <div class="flex flex-col sm:flex-row gap-4">
            <a
              href="https://wa.me/5554991864582?text=Ol%C3%A1!%20Quero%20conhecer%20o%20OwnerPro%20Business."
              target="_blank"
              rel="noopener noreferrer"
              class="inline-flex items-center justify-center gap-2 bg-white px-8 py-4 rounded font-semibold transition shadow-lg hover:shadow-xl"
              :style="{ color: primaryColor }"
            >
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/>
              </svg>
              Agendar Demonstração
            </a>
          </div>
        </div>

        <!-- Carrossel -->
        <div class="hidden lg:block">
          <div class="rounded-lg overflow-hidden shadow-2xl">
            <ImageCarousel
              :images="screenshots"
              :autoplay-interval="5000"
              :show-lightbox="true"
              :minimal="true"
              dot-color="#fff"
            />
          </div>
        </div>
      </div>

      <!-- Mobile: Carrossel abaixo -->
      <div class="lg:hidden mt-10">
        <div class="rounded-lg overflow-hidden shadow-2xl">
          <ImageCarousel
            :images="screenshots"
            :autoplay-interval="5000"
            :show-lightbox="true"
            :minimal="true"
            dot-color="#fff"
          />
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.status-dot {
  animation: glow 2s ease-in-out infinite;
}

@keyframes glow {
  0%, 100% {
    box-shadow: 0 0 1px var(--glow-color);
    filter: brightness(1);
  }
  50% {
    box-shadow: 0 0 3px var(--glow-color), 0 0 6px var(--glow-color);
    filter: brightness(1.4);
  }
}
</style>
