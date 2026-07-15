<script setup>
import { inject } from 'vue'

const primaryColor = inject('primaryColor')

// Pares antes → depois: mesma dor, mesma linha
const transformations = [
  { problem: 'Repasses em planilhas', solution: 'Repasses automáticos' },
  { problem: 'Sem visão financeira', solution: 'Visão financeira completa' },
  { problem: 'Erros manuais', solution: 'Sem erros manuais' },
  { problem: 'Difícil controle de escala', solution: 'Escala com controle' },
  { problem: 'Prestação de contas confusa', solution: 'Prestação de contas clara' },
  { problem: 'Operação via WhatsApp', solution: 'Operação centralizada' },
]
</script>

<template>
  <section class="py-16 bg-gray-50">
    <div class="max-w-4xl mx-auto px-6">
      <div class="text-center mb-12">
        <h2 class="text-3xl font-bold text-gray-800 mb-4">
          Você conhece esses problemas?
        </h2>
        <p class="text-gray-600">
          Veja o que muda quando a operação entra no OwnerPro Business
        </p>
      </div>

      <div class="bg-white rounded-lg border border-gray-200 overflow-hidden divide-y divide-gray-100">
        <div
          v-for="(item, i) in transformations"
          :key="i"
          class="grid md:grid-cols-[1fr_auto_1fr] items-center gap-2 md:gap-4 px-6 py-5"
        >
          <div class="flex items-center gap-3">
            <span class="text-red-400 shrink-0">
              <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </span>
            <p class="text-gray-500">{{ item.problem }}</p>
          </div>

          <span class="hidden md:block text-gray-300">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6" />
            </svg>
          </span>

          <div class="flex items-center gap-3 pl-8 md:pl-0">
            <span class="shrink-0" :style="{ color: primaryColor }">
              <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
              </svg>
            </span>
            <p class="text-gray-800 font-semibold">{{ item.solution }}</p>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>
