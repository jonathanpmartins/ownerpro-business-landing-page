<script setup>
import { ref, computed, inject } from 'vue'

const primaryColor = inject('primaryColor')
const secondaryColor = inject('secondaryColor')

const propertyCount = ref(25)

const pricingPlans = [
  { min: 1, max: 20, fixed: 390, perUnit: 19 },
  { min: 21, max: 50, fixed: 490, perUnit: 14 },
  { min: 51, max: 100, fixed: 590, perUnit: 12 },
  { min: 101, max: 200, fixed: 690, perUnit: 11 },
  { min: 201, max: 500, fixed: 890, perUnit: 10 },
]

const currentPrice = computed(() => {
  const count = propertyCount.value
  const plan = pricingPlans.find(p => count >= p.min && count <= p.max)
  
  if (!plan) {
    const lastPlan = pricingPlans[pricingPlans.length - 1]
    return {
      fixed: lastPlan.fixed,
      perUnit: lastPlan.perUnit,
      total: lastPlan.fixed + (count * lastPlan.perUnit),
      plan: lastPlan
    }
  }
  
  return {
    fixed: plan.fixed,
    perUnit: plan.perUnit,
    total: plan.fixed + (count * plan.perUnit),
    plan
  }
})

const isCurrentPlan = (plan) => {
  return propertyCount.value >= plan.min && propertyCount.value <= plan.max
}

const formatNumber = (num) => {
  return num.toLocaleString('pt-BR')
}
</script>

<template>
  <section id="precos" class="py-20 bg-white">
    <div class="max-w-4xl mx-auto px-6">
      <div class="text-center mb-12">
        <h2 class="text-3xl font-bold text-gray-800 mb-4">Investimento</h2>
        <p class="text-gray-600">
          Preços que acompanham o crescimento da sua operação
        </p>
      </div>
      
      <!-- Calculadora -->
      <div 
        class="rounded-lg p-6 mb-8 text-white"
        :style="{ backgroundColor: primaryColor }"
      >
        <h3 class="text-lg font-semibold mb-4">Calcule seu investimento</h3>
        <div class="flex flex-col md:flex-row gap-6 items-center">
          <div class="flex-1 w-full">
            <label class="block text-sm opacity-80 mb-2">
              Quantos imóveis você administra?
            </label>
            <input
              type="number"
              min="1"
              max="1000"
              v-model.number="propertyCount"
              class="w-full px-4 py-3 border-0 rounded-lg text-lg font-semibold text-center text-gray-800 focus:ring-2 focus:outline-none"
            />
            <input
              type="range"
              min="1"
              max="500"
              :value="Math.min(propertyCount, 500)"
              @input="propertyCount = parseInt($event.target.value)"
              class="w-full mt-3"
              :style="{ accentColor: secondaryColor }"
            />
          </div>
          <div class="flex-1 w-full bg-white/10 backdrop-blur rounded-lg p-6 text-center">
            <p class="text-sm opacity-80 mb-1">Valor mensal</p>
            <p class="text-4xl font-bold mb-2">
              R$ {{ formatNumber(currentPrice.total) }}
            </p>
            <p class="text-sm opacity-80">
              R$ {{ currentPrice.fixed }} + ({{ propertyCount }} × R$ {{ currentPrice.perUnit }})
            </p>
          </div>
        </div>
      </div>

      <!-- Tabela -->
      <div class="bg-gray-50 rounded-lg border border-gray-200 overflow-hidden">
        <table class="w-full">
          <thead class="bg-gray-100">
            <tr class="text-gray-600">
              <th class="px-6 py-4 text-left font-semibold text-sm">Imóveis</th>
              <th class="px-6 py-4 text-left font-semibold text-sm">Valor Fixo</th>
              <th class="px-6 py-4 text-left font-semibold text-sm">Por Imóvel</th>
            </tr>
          </thead>
          <tbody>
            <tr 
              v-for="(plan, i) in pricingPlans"
              :key="i"
              class="border-t border-gray-200 transition"
              :style="isCurrentPlan(plan) ? { backgroundColor: primaryColor + '10' } : {}"
            >
              <td class="px-6 py-4 text-gray-800">
                <span class="flex items-center gap-2">
                  <span 
                    v-if="isCurrentPlan(plan)"
                    class="w-2 h-2 rounded-full"
                    :style="{ backgroundColor: secondaryColor }"
                  />
                  {{ plan.min }} - {{ plan.max }}
                </span>
              </td>
              <td class="px-6 py-4 font-semibold text-gray-800">R$ {{ plan.fixed }}</td>
              <td class="px-6 py-4 font-semibold" :style="{ color: secondaryColor }">R$ {{ plan.perUnit }}</td>
            </tr>
          </tbody>
        </table>
      </div>

      <p class="text-center text-gray-500 text-sm mt-6">
        * Implantação e emissão de notas fiscais possuem valores à parte. Consulte-nos para mais informações.
      </p>
    </div>
  </section>
</template>
