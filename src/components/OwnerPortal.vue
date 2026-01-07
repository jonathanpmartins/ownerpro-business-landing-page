<script setup>
import { inject } from 'vue'

const primaryColor = inject('primaryColor')
const secondaryColor = inject('secondaryColor')

const portalFeatures = [
  { icon: '📊', title: 'Extrato de Repasses', desc: 'Visualização detalhada de todos os valores' },
  { icon: '📅', title: 'Calendário de Reservas', desc: 'Acompanhe ocupação e bloqueie datas' },
  { icon: '📄', title: 'Documentos e Relatórios', desc: 'Acesso a prestações de contas mensais' },
  { icon: '🔔', title: 'Notificações', desc: 'Alertas sobre reservas' },
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
        
        <div 
          class="rounded-lg p-1"
          :style="{ backgroundColor: primaryColor }"
        >
          <div class="bg-white rounded-lg p-6">
            <div class="bg-gray-100 rounded-lg h-80 flex items-center justify-center">
              <div class="text-center text-gray-400">
                <svg class="w-16 h-16 mx-auto mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9.75 17L9 20l-1 1h8l-1-1-.75-3M3 13h18M5 17h14a2 2 0 002-2V5a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                </svg>
                <p class="text-sm">Screenshot do Portal</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>
