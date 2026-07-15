<script setup>
import { inject } from 'vue'
import ImageCarousel from './ImageCarousel.vue'

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
          <h2 class="text-3xl md:text-4xl tracking-tight font-bold text-gray-800 mt-2 mb-6">
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
          <ImageCarousel
            :images="screenshots"
            :border-color="primaryColor"
            :autoplay-interval="5000"
            :show-lightbox="true"
          />
        </div>
      </div>
    </div>

  </section>
</template>
