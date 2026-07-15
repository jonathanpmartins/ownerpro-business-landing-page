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

const planFor = (count) =>
  pricingPlans.find(p => count >= p.min && count <= p.max) ?? pricingPlans[pricingPlans.length - 1]

const currentPrice = computed(() => {
  const count = propertyCount.value || 1
  const plan = planFor(count)

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

const perPropertyPrice = computed(() => {
  return (currentPrice.value.total / (propertyCount.value || 1)).toLocaleString('pt-BR', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2
  })
})

// Curva de custo por imóvel: fixo/n + unitário, de 1 a 500 imóveis
const CHART = { w: 440, h: 88, padTop: 18, yMin: 10 }

const costPerUnit = (n) => {
  const plan = planFor(n)
  return plan.fixed / n + plan.perUnit
}

const clampedCount = computed(() =>
  Math.min(Math.max(propertyCount.value || 1, 1), 500)
)

// Escala log: cobre de R$ ~11 (500 imóveis) a R$ ~409 (1 imóvel) sem deformar
const yTop = costPerUnit(1) * 1.08

const chartX = (n) => ((n - 1) / 499) * CHART.w
const chartY = (v) => {
  const t = (Math.log10(v) - Math.log10(CHART.yMin)) / (Math.log10(yTop) - Math.log10(CHART.yMin))
  return CHART.padTop + CHART.h - t * CHART.h
}

const buildCurve = () => {
  const points = []
  for (let n = 1; n <= 500; n += 2) {
    points.push(`${chartX(n).toFixed(1)},${chartY(costPerUnit(n)).toFixed(1)}`)
  }
  points.push(`${CHART.w},${chartY(costPerUnit(500)).toFixed(1)}`)
  return points.join(' L')
}

const curvePath = `M${buildCurve()}`
const areaPath = `M${buildCurve()} L${CHART.w},${CHART.padTop + CHART.h} L0,${CHART.padTop + CHART.h} Z`

const chartDot = computed(() => {
  const n = clampedCount.value
  const y = chartY(costPerUnit(n))
  const nearTop = y - 10 < 12
  return {
    x: chartX(n),
    y,
    labelX: Math.min(Math.max(chartX(n), 34), CHART.w - 34),
    labelY: nearTop ? y + 20 : y - 10
  }
})
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
        <div class="flex flex-col md:flex-row gap-6 md:items-stretch">
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
            <div class="mt-4">
              <p class="text-sm opacity-80 mb-2">Valor por imóvel conforme a quantidade</p>
              <svg
                :viewBox="`0 0 ${CHART.w} ${CHART.padTop + CHART.h + 4}`"
                class="w-full block"
                aria-hidden="true"
              >
                <!-- gridlines -->
                <g v-for="v in [20, 40, 100, 400]" :key="v">
                  <line
                    x1="0" :x2="CHART.w"
                    :y1="chartY(v)" :y2="chartY(v)"
                    stroke="white" stroke-opacity="0.15" stroke-width="1"
                  />
                  <text
                    :x="CHART.w - 4" :y="chartY(v) - 3"
                    fill="white" fill-opacity="0.5" font-size="10" text-anchor="end"
                  >R$ {{ v }}</text>
                </g>
                <path :d="areaPath" fill="white" fill-opacity="0.08" />
                <path
                  :d="curvePath"
                  fill="none" stroke="white" stroke-width="2"
                  stroke-linejoin="round" stroke-linecap="round"
                />
                <circle
                  :cx="chartDot.x" :cy="chartDot.y" r="5"
                  :fill="secondaryColor" :stroke="primaryColor" stroke-width="2"
                />
                <text
                  :x="chartDot.labelX" :y="chartDot.labelY"
                  fill="white" font-size="12" font-weight="bold" text-anchor="middle"
                >R$ {{ perPropertyPrice }}</text>
              </svg>
            </div>
            <input
              type="range"
              min="1"
              max="500"
              :value="Math.min(propertyCount, 500)"
              @input="propertyCount = parseInt($event.target.value)"
              class="w-full mt-1"
              :style="{ accentColor: secondaryColor }"
            />
          </div>
          <div class="flex-1 w-full flex flex-col">
            <p class="text-sm opacity-80 mb-2 md:text-right">Como o cálculo é feito</p>
            <div class="flex-1 bg-white/10 backdrop-blur rounded-lg p-6 text-center flex flex-col justify-center">
              <p class="text-sm opacity-80 mb-1">Valor mensal</p>
              <p class="text-sm opacity-80 mb-1">
                R$ {{ currentPrice.fixed }} + ({{ propertyCount }} × R$ {{ currentPrice.perUnit }})
              </p>
              <p class="text-4xl font-bold mb-2">
                R$ {{ formatNumber(currentPrice.total) }}
              </p>
              <p class="text-sm opacity-80">
                <span class="font-bold">R$ {{ perPropertyPrice }}</span> por imóvel
              </p>
            </div>
          </div>
        </div>
      </div>

      <!-- Tabela -->
      <div class="bg-gray-50 rounded-lg border border-gray-200 overflow-hidden">
        <table class="w-full">
          <thead class="bg-gray-100">
            <tr class="text-gray-600">
              <th class="px-6 py-4 text-center font-semibold text-sm">Imóveis</th>
              <th class="px-6 py-4 text-center font-semibold text-sm">Valor Fixo</th>
              <th class="px-6 py-4 text-center font-semibold text-sm">Por Imóvel</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="(plan, i) in pricingPlans"
              :key="i"
              class="border-t border-gray-200 transition"
              :style="isCurrentPlan(plan) ? {
                backgroundColor: primaryColor + '10',
                boxShadow: `inset 4px 0 0 ${secondaryColor}`
              } : {}"
            >
              <td class="px-6 py-4 text-gray-800 text-center">
                {{ plan.min }} - {{ plan.max }}
              </td>
              <td class="px-6 py-4 font-semibold text-gray-800 text-center">R$ {{ plan.fixed }}</td>
              <td class="px-6 py-4 font-semibold text-center" :style="{ color: secondaryColor }">R$ {{ plan.perUnit }}</td>
            </tr>
          </tbody>
        </table>
      </div>

      <p class="text-center text-gray-500 text-sm mt-6">
        * Implantação possue valor à parte, consulte-nos para mais informações.
      </p>
    </div>
  </section>
</template>
