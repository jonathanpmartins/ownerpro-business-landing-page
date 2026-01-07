<script setup>
import { inject, ref, onMounted, onUnmounted } from 'vue'

const primaryColor = inject('primaryColor')
const secondaryColor = inject('secondaryColor')

const portalFeatures = [
  { icon: '📊', title: 'Extrato de Repasses', desc: 'Visualização detalhada de todos os valores' },
  { icon: '📅', title: 'Calendário de Reservas', desc: 'Acompanhe ocupação e bloqueie datas' },
  { icon: '📄', title: 'Documentos e Relatórios', desc: 'Acesso a prestações de contas mensais' },
  { icon: '🔔', title: 'Notificações', desc: 'Alertas sobre reservas' },
]

const screenshots = [
  { src: '/screenshots/portal-1-960.webp', srcFull: '/screenshots/portal-1.webp', alt: 'Tela de Login do Portal' },
  { src: '/screenshots/portal-2-960.webp', srcFull: '/screenshots/portal-2.webp', alt: 'Dashboard de Ocupação' },
  { src: '/screenshots/portal-3-960.webp', srcFull: '/screenshots/portal-3.webp', alt: 'Calendário de Reservas' },
]

const lightboxOpen = ref(false)

const handleKeydown = (e) => {
  if (!lightboxOpen.value) return
  if (e.key === 'ArrowRight') nextSlide()
  else if (e.key === 'ArrowLeft') prevSlide()
  else if (e.key === 'Escape') closeLightbox()
}

const openLightbox = () => {
  lightboxOpen.value = true
  if (autoplayInterval) {
    clearInterval(autoplayInterval)
    autoplayInterval = null
  }
  window.addEventListener('keydown', handleKeydown)
}

const closeLightbox = () => {
  lightboxOpen.value = false
  autoplayInterval = setInterval(nextSlide, 5000)
  window.removeEventListener('keydown', handleKeydown)
}

const currentSlide = ref(0)
let autoplayInterval = null

const nextSlide = () => {
  currentSlide.value = (currentSlide.value + 1) % screenshots.length
}

const prevSlide = () => {
  currentSlide.value = (currentSlide.value - 1 + screenshots.length) % screenshots.length
}

const goToSlide = (index) => {
  currentSlide.value = index
  resetAutoplay()
}

const resetAutoplay = () => {
  if (autoplayInterval) clearInterval(autoplayInterval)
  autoplayInterval = setInterval(nextSlide, 5000)
}

onMounted(() => {
  autoplayInterval = setInterval(nextSlide, 5000)
})

onUnmounted(() => {
  if (autoplayInterval) clearInterval(autoplayInterval)
})
</script>

<template>
  <section class="py-20 bg-gray-50">
    <div class="max-w-6xl mx-auto px-6">
      <div class="grid lg:grid-cols-2 gap-12 items-center">
        <div>
          <span 
            class="text-sm font-semibold uppercase tracking-wider"
            :style="{ color: secondaryColor }"
          >
            Portal do Proprietário
          </span>
          <h2 class="text-3xl font-bold text-gray-800 mt-2 mb-6">
            Prestação de contas profissional
          </h2>
          <p class="text-gray-600 mb-8">
            Seus proprietários acessam um painel completo com total transparência sobre seus imóveis. 
            Construa confiança através de uma comunicação clara e organizada.
          </p>
          
          <div class="space-y-4">
            <div 
              v-for="(item, i) in portalFeatures"
              :key="i"
              class="flex gap-4 items-start p-4 rounded-lg bg-white border border-gray-100"
            >
              <span class="text-2xl">{{ item.icon }}</span>
              <div>
                <h4 class="font-semibold text-gray-800">{{ item.title }}</h4>
                <p class="text-gray-600 text-sm">{{ item.desc }}</p>
              </div>
            </div>
          </div>
        </div>
        
        <div>
          <!-- Carousel Box -->
          <div
            class="rounded p-1"
            :style="{ backgroundColor: primaryColor }"
          >
            <div class="bg-white rounded overflow-hidden">
              <!-- Carousel Container -->
              <div class="relative">
                <!-- Slides - todas as imagens permanecem no DOM -->
                <div class="relative">
                  <img
                    v-for="(screenshot, index) in screenshots"
                    :key="index"
                    :src="screenshot.src"
                    :alt="screenshot.alt"
                    class="w-full h-auto cursor-pointer transition-opacity duration-400"
                    :class="index === currentSlide ? 'opacity-100 relative' : 'opacity-0 absolute inset-0'"
                    @click="openLightbox"
                  />
                </div>

                <!-- Navigation Arrows -->
                <button
                  @click="prevSlide"
                  aria-label="Slide anterior"
                  class="absolute left-2 top-1/2 -translate-y-1/2 bg-white/80 hover:bg-white p-2 rounded-full shadow-md transition-all"
                >
                  <svg class="w-5 h-5 text-gray-700" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
                  </svg>
                </button>
                <button
                  @click="nextSlide"
                  aria-label="Próximo slide"
                  class="absolute right-2 top-1/2 -translate-y-1/2 bg-white/80 hover:bg-white p-2 rounded-full shadow-md transition-all"
                >
                  <svg class="w-5 h-5 text-gray-700" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                  </svg>
                </button>
              </div>
            </div>
          </div>

          <!-- Dots Indicator (fora do box) -->
          <div class="flex justify-center gap-2 mt-4" role="tablist" aria-label="Slides do portal">
            <button
              v-for="(_, index) in screenshots"
              :key="index"
              @click="goToSlide(index)"
              :aria-label="`Ir para slide ${index + 1} de ${screenshots.length}`"
              :aria-selected="currentSlide === index"
              role="tab"
              class="w-2 h-2 rounded-full transition-all"
              :class="currentSlide === index ? 'w-6' : 'bg-gray-300 hover:bg-gray-400'"
              :style="currentSlide === index ? { backgroundColor: primaryColor } : {}"
            />
          </div>
        </div>
      </div>
    </div>

    <!-- Lightbox Modal -->
    <teleport to="body">
      <transition name="lightbox">
        <div
          v-if="lightboxOpen"
          class="fixed inset-0 z-50 flex items-center justify-center bg-black/90 p-4"
          @click="closeLightbox"
        >
          <!-- Close Button -->
          <button
            class="absolute top-4 right-4 text-white hover:text-gray-300 transition-colors z-10"
            aria-label="Fechar visualização"
            @click="closeLightbox"
          >
            <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>

          <!-- Previous Button -->
          <button
            class="absolute left-4 top-1/2 -translate-y-1/2 text-white hover:text-gray-300 bg-black/50 hover:bg-black/70 p-3 rounded-full transition-all z-10"
            aria-label="Imagem anterior"
            @click.stop="prevSlide"
          >
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
            </svg>
          </button>

          <!-- Next Button -->
          <button
            class="absolute right-4 top-1/2 -translate-y-1/2 text-white hover:text-gray-300 bg-black/50 hover:bg-black/70 p-3 rounded-full transition-all z-10"
            aria-label="Próxima imagem"
            @click.stop="nextSlide"
          >
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
            </svg>
          </button>

          <!-- Image -->
          <img
            :src="screenshots[currentSlide].srcFull"
            :alt="screenshots[currentSlide].alt"
            loading="lazy"
            class="max-w-full max-h-full object-contain"
            @click.stop
          />

          <!-- Image Counter -->
          <div class="absolute bottom-4 left-1/2 -translate-x-1/2 text-white text-sm bg-black/50 px-3 py-1 rounded-full">
            {{ currentSlide + 1 }} / {{ screenshots.length }}
          </div>
        </div>
      </transition>
    </teleport>
  </section>
</template>

<style scoped>
.duration-400 {
  transition-duration: 400ms;
}

.lightbox-enter-active,
.lightbox-leave-active {
  transition: opacity 0.3s ease;
}

.lightbox-enter-from,
.lightbox-leave-to {
  opacity: 0;
}
</style>
