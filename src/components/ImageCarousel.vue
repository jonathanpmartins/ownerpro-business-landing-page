<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

const props = defineProps({
  images: {
    type: Array,
    required: true,
    // Each image: { src: string, srcFull?: string, alt: string }
  },
  borderColor: {
    type: String,
    default: null
  },
  autoplayInterval: {
    type: Number,
    default: 5000
  },
  showLightbox: {
    type: Boolean,
    default: true
  }
})

const currentSlide = ref(0)
const lightboxOpen = ref(false)
let autoplayTimer = null

const nextSlide = () => {
  currentSlide.value = (currentSlide.value + 1) % props.images.length
}

const prevSlide = () => {
  currentSlide.value = (currentSlide.value - 1 + props.images.length) % props.images.length
}

const goToSlide = (index) => {
  currentSlide.value = index
  resetAutoplay()
}

const resetAutoplay = () => {
  if (autoplayTimer) clearInterval(autoplayTimer)
  if (props.autoplayInterval > 0) {
    autoplayTimer = setInterval(nextSlide, props.autoplayInterval)
  }
}

const openLightbox = () => {
  if (!props.showLightbox) return
  lightboxOpen.value = true
  if (autoplayTimer) {
    clearInterval(autoplayTimer)
    autoplayTimer = null
  }
  window.addEventListener('keydown', handleKeydown)
}

const closeLightbox = () => {
  lightboxOpen.value = false
  resetAutoplay()
  window.removeEventListener('keydown', handleKeydown)
}

const handleKeydown = (e) => {
  if (!lightboxOpen.value) return
  if (e.key === 'ArrowRight') nextSlide()
  else if (e.key === 'ArrowLeft') prevSlide()
  else if (e.key === 'Escape') closeLightbox()
}

onMounted(() => {
  if (props.autoplayInterval > 0) {
    autoplayTimer = setInterval(nextSlide, props.autoplayInterval)
  }
})

onUnmounted(() => {
  if (autoplayTimer) clearInterval(autoplayTimer)
  window.removeEventListener('keydown', handleKeydown)
})
</script>

<template>
  <div>
    <!-- Carousel Box -->
    <div
      class="rounded p-1"
      :style="borderColor ? { backgroundColor: borderColor } : {}"
      :class="{ 'bg-transparent': !borderColor }"
    >
      <div class="bg-white rounded overflow-hidden">
        <!-- Carousel Container -->
        <div class="relative">
          <!-- Slides -->
          <div class="relative">
            <img
              v-for="(image, index) in images"
              :key="index"
              :src="image.src"
              :alt="image.alt"
              class="w-full h-auto transition-opacity duration-400"
              :class="[
                index === currentSlide ? 'opacity-100 relative' : 'opacity-0 absolute inset-0',
                showLightbox ? 'cursor-pointer' : ''
              ]"
              @click="openLightbox"
            />
          </div>

          <!-- Navigation Arrows -->
          <button
            v-if="images.length > 1"
            @click="prevSlide"
            aria-label="Slide anterior"
            class="absolute left-2 top-1/2 -translate-y-1/2 bg-white/80 hover:bg-white p-2 rounded-full shadow-md transition-all"
          >
            <svg class="w-5 h-5 text-gray-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
            </svg>
          </button>
          <button
            v-if="images.length > 1"
            @click="nextSlide"
            aria-label="Próximo slide"
            class="absolute right-2 top-1/2 -translate-y-1/2 bg-white/80 hover:bg-white p-2 rounded-full shadow-md transition-all"
          >
            <svg class="w-5 h-5 text-gray-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
            </svg>
          </button>
        </div>
      </div>
    </div>

    <!-- Dots Indicator -->
    <div v-if="images.length > 1" class="flex justify-center gap-2 mt-4">
      <button
        v-for="(_, index) in images"
        :key="index"
        @click="goToSlide(index)"
        :aria-label="`Ir para slide ${index + 1}`"
        class="w-2 h-2 rounded-full transition-all"
        :class="currentSlide === index ? 'w-6' : 'bg-gray-300 hover:bg-gray-400'"
        :style="currentSlide === index && borderColor ? { backgroundColor: borderColor } : {}"
      />
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
            aria-label="Fechar"
            @click="closeLightbox"
          >
            <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>

          <!-- Previous Button -->
          <button
            v-if="images.length > 1"
            class="absolute left-4 top-1/2 -translate-y-1/2 text-white hover:text-gray-300 bg-black/50 hover:bg-black/70 p-3 rounded-full transition-all z-10"
            aria-label="Anterior"
            @click.stop="prevSlide"
          >
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
            </svg>
          </button>

          <!-- Next Button -->
          <button
            v-if="images.length > 1"
            class="absolute right-4 top-1/2 -translate-y-1/2 text-white hover:text-gray-300 bg-black/50 hover:bg-black/70 p-3 rounded-full transition-all z-10"
            aria-label="Próximo"
            @click.stop="nextSlide"
          >
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
            </svg>
          </button>

          <!-- Image -->
          <img
            :src="images[currentSlide].srcFull || images[currentSlide].src"
            :alt="images[currentSlide].alt"
            loading="lazy"
            class="max-w-full max-h-full object-contain"
            @click.stop
          />

          <!-- Counter -->
          <div v-if="images.length > 1" class="absolute bottom-4 left-1/2 -translate-x-1/2 text-white text-sm bg-black/50 px-3 py-1 rounded-full">
            {{ currentSlide + 1 }} / {{ images.length }}
          </div>
        </div>
      </transition>
    </teleport>
  </div>
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
