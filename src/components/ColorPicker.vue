<script setup>
import { ref } from 'vue'

const props = defineProps({
  primary: String,
  secondary: String
})

const emit = defineEmits(['update:primary', 'update:secondary', 'close'])

const primaryColors = [
  { name: 'Original OwnerPro', hex: '#24847f' },
  { name: 'Petróleo Escuro', hex: '#143947' },
  { name: 'Teal Escuro', hex: '#27555A' },
  { name: 'Teal Médio', hex: '#3C6267' },
  { name: 'Verde Floresta', hex: '#1D4E4A' },
  { name: 'Verde Azulado', hex: '#0D5C63' },
]

const secondaryColors = [
  { name: 'Vermelho Original', hex: '#8f0000' },
  { name: 'Amber Claro', hex: '#FBBF24' },
  { name: 'Amber', hex: '#F59E0B' },
  { name: 'Amber Médio', hex: '#E8930A' },
  { name: 'Amber Queimado', hex: '#DC8508' },
  { name: 'Amber Escuro', hex: '#D97706' },
  { name: 'Bronze', hex: '#B45309' },
  { name: 'Laranja', hex: '#EA580C' },
  { name: 'Coral', hex: '#F43F5E' },
]

const selectedPrimaryName = () => primaryColors.find(c => c.hex === props.primary)?.name || ''
const selectedSecondaryName = () => secondaryColors.find(c => c.hex === props.secondary)?.name || ''
</script>

<template>
  <div class="fixed top-4 right-4 z-50 bg-white rounded-lg shadow-2xl border border-gray-200 p-4 w-72 max-h-[90vh] overflow-y-auto">
    <div class="flex justify-between items-center mb-4">
      <h3 class="font-semibold text-gray-800">🎨 Seletor de Cores</h3>
      <button 
        @click="emit('close')"
        class="text-gray-400 hover:text-gray-600"
      >
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
        </svg>
      </button>
    </div>
    
    <div class="mb-4">
      <label class="text-xs font-medium text-gray-500 uppercase tracking-wider">Cor Primária (Verde)</label>
      <div class="grid grid-cols-3 gap-2 mt-2">
        <button
          v-for="color in primaryColors"
          :key="color.hex"
          @click="emit('update:primary', color.hex)"
          class="w-full aspect-square rounded-lg border-2 transition-all"
          :class="primary === color.hex ? 'border-gray-800 scale-110 shadow-lg' : 'border-transparent hover:scale-105'"
          :style="{ backgroundColor: color.hex }"
          :title="color.name"
        />
      </div>
      <p class="text-xs text-gray-500 mt-1">
        {{ selectedPrimaryName() }} 
        <code class="bg-gray-100 px-1 rounded">{{ primary }}</code>
      </p>
    </div>

    <div class="mb-4">
      <label class="text-xs font-medium text-gray-500 uppercase tracking-wider">Cor Secundária (Acento)</label>
      <div class="grid grid-cols-3 gap-2 mt-2">
        <button
          v-for="color in secondaryColors"
          :key="color.hex"
          @click="emit('update:secondary', color.hex)"
          class="w-full aspect-square rounded-lg border-2 transition-all"
          :class="secondary === color.hex ? 'border-gray-800 scale-110 shadow-lg' : 'border-transparent hover:scale-105'"
          :style="{ backgroundColor: color.hex }"
          :title="color.name"
        />
      </div>
      <p class="text-xs text-gray-500 mt-1">
        {{ selectedSecondaryName() }} 
        <code class="bg-gray-100 px-1 rounded">{{ secondary }}</code>
      </p>
    </div>

    <div class="pt-3 border-t border-gray-200">
      <p class="text-xs text-gray-400">Preview das cores:</p>
      <div class="flex gap-2 mt-2">
        <div class="flex-1 h-8 rounded" :style="{ backgroundColor: primary }"></div>
        <div class="flex-1 h-8 rounded" :style="{ backgroundColor: secondary }"></div>
      </div>
    </div>
  </div>
</template>
