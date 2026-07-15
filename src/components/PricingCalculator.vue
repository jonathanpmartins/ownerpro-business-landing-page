<script setup>
import { ref, computed, watch, inject } from 'vue'

const primaryColor = inject('primaryColor')
const secondaryColor = inject('secondaryColor')
const darkenColor = inject('darkenColor')

const propertyCount = ref(30)

// Faixas acima de 500 não aparecem na tabela, mas entram no cálculo
const pricingPlans = [
  { min: 1, max: 20, fixed: 290, perUnit: 17 },
  { min: 21, max: 50, fixed: 390, perUnit: 12 },
  { min: 51, max: 100, fixed: 490, perUnit: 10 },
  { min: 101, max: 200, fixed: 590, perUnit: 9 },
  { min: 201, max: 500, fixed: 790, perUnit: 8 },
  { min: 501, max: 1000, fixed: 1290, perUnit: 7 },
  { min: 1001, max: 2000, fixed: 2290, perUnit: 6 },
  { min: 2001, max: 5000, fixed: 4290, perUnit: 5 },
  { min: 5001, max: 10000, fixed: 9290, perUnit: 4 },
]

const MAX_PROPERTIES = 10000
const visiblePlans = pricingPlans.filter(p => p.max <= 500)

const planFor = (count) =>
  pricingPlans.find(p => count >= p.min && count <= p.max) ??
  pricingPlans[pricingPlans.length - 1]

watch(propertyCount, (v) => {
  if (v > MAX_PROPERTIES) propertyCount.value = MAX_PROPERTIES
})

const currentPrice = computed(() => {
  const count = Math.min(propertyCount.value || 1, MAX_PROPERTIES)
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
const CHART = { w: 440, h: 88, padTop: 18, yMin: 8 }

const costPerUnit = (n) => {
  const plan = planFor(n)
  return plan.fixed / n + plan.perUnit
}

const clampedCount = computed(() =>
  Math.min(Math.max(propertyCount.value || 1, 1), 500)
)

// Escala log: cobre do menor (500 imóveis) ao maior valor (1 imóvel) sem deformar
const yTop = computed(() => costPerUnit(1) * 1.08)

const chartX = (n) => ((n - 1) / 499) * CHART.w
const chartY = (v) => {
  const t = (Math.log10(v) - Math.log10(CHART.yMin)) / (Math.log10(yTop.value) - Math.log10(CHART.yMin))
  return CHART.padTop + CHART.h - t * CHART.h
}

const curvePoints = computed(() => {
  const points = []
  for (let n = 1; n <= 500; n += 2) {
    points.push(`${chartX(n).toFixed(1)},${chartY(costPerUnit(n)).toFixed(1)}`)
  }
  points.push(`${CHART.w},${chartY(costPerUnit(500)).toFixed(1)}`)
  return points.join(' L')
})

const curvePath = computed(() => `M${curvePoints.value}`)
const areaPath = computed(() =>
  `M${curvePoints.value} L${CHART.w},${CHART.padTop + CHART.h} L0,${CHART.padTop + CHART.h} Z`
)

const gridLevels = [10, 30, 100, 300]

const whatsappLink = computed(() => {
  const count = Math.min(propertyCount.value || 1, MAX_PROPERTIES)
  const msg = `Olá! Administro ${count} imóveis e quero uma demonstração do OwnerPro Business.`
  return `https://wa.me/5554991864582?text=${encodeURIComponent(msg)}`
})

const chartDot = computed(() => {
  const n = clampedCount.value
  const y = chartY(costPerUnit(n))
  const nearTop = y - 10 < 12
  return {
    // Acima de 500 o gráfico não cobre — esconde o ponto para não marcar posição errada
    visible: (propertyCount.value || 1) <= 500,
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
        <h2 class="text-3xl md:text-4xl tracking-tight font-bold text-gray-800 mb-4">Planos e preços</h2>
        <p class="text-gray-600">
          Preços que acompanham o crescimento da sua operação
        </p>
      </div>

      <!-- Calculadora -->
      <div
        class="rounded-lg p-6 mb-8 text-white"
        :style="{ backgroundColor: primaryColor }"
      >
        <div class="flex flex-col md:flex-row gap-6 md:items-stretch">
          <div class="flex-1 w-full flex flex-col">
            <label for="property-count" class="block text-sm opacity-90 mb-2">
              Quantos imóveis você administra?
            </label>
            <input
              id="property-count"
              type="number"
              min="1"
              :max="MAX_PROPERTIES"
              v-model.number="propertyCount"
              class="w-full px-4 py-3 border-0 rounded-lg text-lg font-semibold text-center text-gray-800 focus:ring-2 focus:outline-none"
            />
            <div class="mt-4 flex-1 flex flex-col justify-center">
              <p class="text-sm opacity-90 mb-2">Valor por imóvel conforme a quantidade</p>
              <svg
                :viewBox="`0 0 ${CHART.w} ${CHART.padTop + CHART.h + 4}`"
                class="w-full block"
                aria-hidden="true"
              >
                <!-- gridlines -->
                <g v-for="v in gridLevels" :key="v">
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
                <g v-if="chartDot.visible">
                  <circle
                    :cx="chartDot.x" :cy="chartDot.y" r="5"
                    :fill="secondaryColor" :stroke="primaryColor" stroke-width="2"
                  />
                  <text
                    :x="chartDot.labelX" :y="chartDot.labelY"
                    fill="white" font-size="12" font-weight="bold" text-anchor="middle"
                  >R$ {{ perPropertyPrice }}</text>
                </g>
              </svg>
            </div>
            <input
              type="range"
              aria-label="Quantidade de imóveis"
              min="1"
              max="500"
              :value="Math.min(propertyCount, 500)"
              @input="propertyCount = parseInt($event.target.value)"
              class="w-full mt-1"
              :style="{ accentColor: secondaryColor }"
            />
          </div>
          <div class="flex-1 w-full flex flex-col">
            <p class="text-sm opacity-90 mb-2 md:text-right">Como o cálculo é feito</p>
            <div class="flex-1 bg-black/10 backdrop-blur rounded-lg p-6 text-center flex flex-col justify-center">
              <p class="text-sm opacity-90 mb-1">Valor mensal</p>
              <p class="text-sm opacity-90 mb-1">
                R$ {{ currentPrice.fixed }} + ({{ propertyCount }} × R$ {{ currentPrice.perUnit }})
              </p>
              <p class="text-4xl font-bold mb-2">
                R$ {{ formatNumber(currentPrice.total) }}
              </p>
              <p class="text-sm opacity-90">
                <span class="font-bold">R$ {{ perPropertyPrice }}</span> por imóvel
              </p>
            </div>
            <a
              :href="whatsappLink"
              target="_blank"
              rel="noopener noreferrer"
              class="mt-4 inline-flex items-center justify-center gap-2 bg-white px-6 py-3 rounded font-semibold transition shadow-lg hover:shadow-xl"
              :style="{ color: primaryColor }"
            >
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/>
              </svg>
              Falar com um consultor
            </a>
          </div>
        </div>
      </div>

      <!-- Tabela -->
      <div class="bg-gray-50 rounded-lg border border-gray-200 overflow-hidden">
        <table class="w-full">
          <thead class="bg-gray-100">
            <tr class="text-gray-600">
              <th class="px-3 sm:px-6 py-4 text-center font-semibold text-sm whitespace-nowrap">Imóveis</th>
              <th class="px-3 sm:px-6 py-4 text-center font-semibold text-sm whitespace-nowrap">Valor Fixo</th>
              <th class="px-3 sm:px-6 py-4 text-center font-semibold text-sm whitespace-nowrap">Por Imóvel</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="(plan, i) in visiblePlans"
              :key="i"
              class="border-t border-gray-200 transition"
              :style="isCurrentPlan(plan) ? {
                backgroundColor: primaryColor + '10',
                boxShadow: `inset 4px 0 0 ${secondaryColor}`
              } : {}"
            >
              <td class="px-3 sm:px-6 py-4 text-gray-800 text-center whitespace-nowrap">
                {{ plan.min }}–{{ plan.max }}
              </td>
              <td class="px-3 sm:px-6 py-4 font-semibold text-gray-800 text-center whitespace-nowrap">R$ {{ plan.fixed }}</td>
              <td class="px-3 sm:px-6 py-4 font-semibold text-center whitespace-nowrap" :style="{ color: darkenColor(secondaryColor, 30) }">R$ {{ plan.perUnit }}</td>
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
