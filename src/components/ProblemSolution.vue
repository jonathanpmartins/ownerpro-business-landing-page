<script setup>
import { inject } from 'vue'

const primaryColor = inject('primaryColor')
const secondaryColor = inject('secondaryColor')

const problems = [
  'Planilhas complexas para calcular repasses de proprietários',
  'Falta de visão clara do financeiro da empresa',
  'Erros manuais que geram retrabalho e desconfiança',
  'Dificuldade em escalar a operação sem perder o controle',
  'Prestação de contas desorganizada para proprietários',
]

const solutions = [
  'Cálculo automático de repasses com regras personalizadas',
  'DRE, fluxo de caixa e visão consolidada do negócio',
  'Integração com channel manager elimina erros',
  'Estrutura que sustenta o crescimento da operação',
  'Prestação de contas clara e profissional',
]
</script>

<template>
  <section class="py-16 bg-gray-50">
    <div class="max-w-6xl mx-auto px-6">
      <div class="grid lg:grid-cols-2 gap-12 items-center">
        <div>
          <h2 class="text-3xl font-bold text-gray-800 mb-6">
            Você conhece esses problemas?
          </h2>
          <div class="space-y-4">
            <div
              v-for="(problem, i) in problems"
              :key="i"
              class="flex items-start gap-3"
            >
              <span class="text-red-500 mt-1">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </span>
              <p class="text-gray-700">{{ problem }}</p>
            </div>
          </div>
        </div>

        <div
          class="p-8 rounded-lg text-white"
          :style="{ backgroundColor: primaryColor }"
        >
          <h3 class="text-2xl font-bold mb-6">OwnerPro Business resolve</h3>
          <div class="space-y-4">
            <div
              v-for="(solution, i) in solutions"
              :key="i"
              class="flex items-start gap-3"
            >
              <span class="text-white/90">
                <svg class="w-5 h-5 mt-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
              </span>
              <p class="opacity-95">{{ solution }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>
