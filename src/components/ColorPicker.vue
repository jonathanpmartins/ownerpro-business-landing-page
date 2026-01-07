<script setup>
import { ref } from 'vue'

const props = defineProps({
  primary: String,
  secondary: String,
  selectedTag: Number,
  customTagColor: String,
  tagColorOptions: Array,
  selectedAccent: Number,
  accentOnPrimaryOptions: Array,
  lightenColor: Function
})

const emit = defineEmits(['update:primary', 'update:secondary', 'update:selectedTag', 'update:customTagColor', 'update:selectedAccent', 'close'])

// Paletas pré-definidas
const palettes = [
  { name: 'OwnerPro Original', primary: '#24847f', secondary: '#8f0000' },
  { name: 'Ocean & Sand', primary: '#0077B6', secondary: '#F4A261' },
  { name: 'Forest & Sunset', primary: '#2D6A4F', secondary: '#E07A5F' },
  { name: 'Modern Trust', primary: '#3B82F6', secondary: '#10B981' },
  { name: 'Warm Professional', primary: '#6366F1', secondary: '#F59E0B' },
  { name: 'Coastal Calm', primary: '#0F766E', secondary: '#FB923C' },
]

const primaryColors = [
  // OwnerPro
  { name: 'OwnerPro Original', hex: '#24847f' },
  { name: 'Petróleo Escuro', hex: '#143947' },
  { name: 'Teal Escuro', hex: '#27555A' },
  { name: 'Teal Médio', hex: '#3C6267' },
  { name: 'Verde Floresta', hex: '#1D4E4A' },
  { name: 'Verde Azulado', hex: '#0D5C63' },
  // Novas
  { name: 'Azul Oceano', hex: '#0077B6' },
  { name: 'Verde Floresta', hex: '#2D6A4F' },
  { name: 'Azul Tech', hex: '#3B82F6' },
  { name: 'Índigo', hex: '#6366F1' },
  { name: 'Teal Costeiro', hex: '#0F766E' },
  { name: 'Azul Marinho', hex: '#1E40AF' },
]

const secondaryColors = [
  // OwnerPro
  { name: 'Vermelho Original', hex: '#8f0000' },
  { name: 'Amber Claro', hex: '#FBBF24' },
  { name: 'Amber', hex: '#F59E0B' },
  { name: 'Amber Médio', hex: '#E8930A' },
  { name: 'Amber Queimado', hex: '#DC8508' },
  { name: 'Amber Escuro', hex: '#D97706' },
  { name: 'Bronze', hex: '#B45309' },
  { name: 'Laranja', hex: '#EA580C' },
  { name: 'Coral', hex: '#F43F5E' },
  // Novas
  { name: 'Areia', hex: '#F4A261' },
  { name: 'Terracota', hex: '#E07A5F' },
  { name: 'Verde Sucesso', hex: '#10B981' },
  { name: 'Laranja Coral', hex: '#FB923C' },
  { name: 'Rosa Vibrante', hex: '#EC4899' },
  { name: 'Roxo', hex: '#8B5CF6' },
]

const applyPalette = (palette) => {
  emit('update:primary', palette.primary)
  emit('update:secondary', palette.secondary)
}

const selectedPrimaryName = () => primaryColors.find(c => c.hex === props.primary)?.name || ''
const selectedSecondaryName = () => secondaryColors.find(c => c.hex === props.secondary)?.name || ''
</script>

<template>
  <div class="fixed top-4 right-4 z-50 bg-white rounded-lg shadow-2xl border border-gray-200 p-3 w-80 max-h-[90vh] overflow-y-auto">
    <div class="flex justify-between items-center mb-3">
      <h3 class="font-semibold text-gray-800 text-sm">🎨 Cores</h3>
      <button
        @click="emit('close')"
        class="text-gray-400 hover:text-gray-600"
      >
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
        </svg>
      </button>
    </div>

    <!-- Paletas -->
    <div class="mb-3 pb-3 border-b border-gray-200">
      <label class="text-xs font-medium text-gray-500 uppercase tracking-wider">Paletas</label>
      <select
        @change="applyPalette(palettes[$event.target.selectedIndex - 1])"
        class="w-full mt-1 text-sm border border-gray-200 rounded px-2 py-1.5 focus:outline-none focus:ring-1 focus:ring-gray-300"
      >
        <option disabled selected>Escolher paleta...</option>
        <option v-for="palette in palettes" :key="palette.name">
          {{ palette.name }}
        </option>
      </select>
      <div class="flex gap-1 mt-2">
        <button
          v-for="palette in palettes"
          :key="palette.name"
          @click="applyPalette(palette)"
          class="flex-1 h-5 rounded-sm flex overflow-hidden border border-gray-200 hover:scale-105 transition"
          :title="palette.name"
        >
          <div class="w-1/2 h-full" :style="{ backgroundColor: palette.primary }"></div>
          <div class="w-1/2 h-full" :style="{ backgroundColor: palette.secondary }"></div>
        </button>
      </div>
    </div>

    <!-- Cor Primária -->
    <div class="mb-3">
      <label class="text-xs font-medium text-gray-500 uppercase tracking-wider">Primária</label>
      <div class="grid grid-cols-6 gap-1 mt-1">
        <button
          v-for="color in primaryColors"
          :key="color.hex"
          @click="emit('update:primary', color.hex)"
          class="w-full aspect-square rounded border-2 transition-all"
          :class="primary === color.hex ? 'border-gray-800 scale-110' : 'border-transparent hover:scale-105'"
          :style="{ backgroundColor: color.hex }"
          :title="color.name"
        />
      </div>
      <div class="flex items-center gap-1 mt-1">
        <input
          type="color"
          :value="primary"
          @input="emit('update:primary', $event.target.value)"
          class="w-6 h-6 rounded cursor-pointer border-0"
        />
        <code class="bg-gray-100 px-1 rounded text-xs flex-1">{{ primary }}</code>
      </div>
    </div>

    <!-- Cor Secundária -->
    <div class="mb-3">
      <label class="text-xs font-medium text-gray-500 uppercase tracking-wider">Secundária</label>
      <div class="grid grid-cols-6 gap-1 mt-1">
        <button
          v-for="color in secondaryColors"
          :key="color.hex"
          @click="emit('update:secondary', color.hex)"
          class="w-full aspect-square rounded border-2 transition-all"
          :class="secondary === color.hex ? 'border-gray-800 scale-110' : 'border-transparent hover:scale-105'"
          :style="{ backgroundColor: color.hex }"
          :title="color.name"
        />
      </div>
      <div class="flex items-center gap-1 mt-1">
        <input
          type="color"
          :value="secondary"
          @input="emit('update:secondary', $event.target.value)"
          class="w-6 h-6 rounded cursor-pointer border-0"
        />
        <code class="bg-gray-100 px-1 rounded text-xs flex-1">{{ secondary }}</code>
      </div>
    </div>

    <!-- Cor das Tags -->
    <div class="mb-3 pt-3 border-t border-gray-200">
      <label class="text-xs font-medium text-gray-500 uppercase tracking-wider">Tags</label>
      <div class="flex flex-wrap gap-1 mt-1">
        <button
          v-for="(option, i) in tagColorOptions.filter(o => o.name !== 'Custom')"
          :key="option.name"
          @click="emit('update:selectedTag', tagColorOptions.findIndex(o => o.name === option.name))"
          class="px-2 py-1 rounded text-xs font-medium transition border"
          :style="{
            backgroundColor: option.bg || (secondary + '20'),
            color: option.text || secondary,
            borderColor: tagColorOptions[selectedTag]?.name === option.name ? (option.text || secondary) : 'transparent'
          }"
        >
          {{ option.name }}
        </button>
      </div>
      <div class="flex items-center gap-1 mt-2">
        <input
          type="color"
          :value="customTagColor"
          @input="emit('update:customTagColor', $event.target.value); emit('update:selectedTag', tagColorOptions.findIndex(o => o.name === 'Custom'))"
          class="w-6 h-6 rounded cursor-pointer border-0"
        />
        <button
          @click="emit('update:selectedTag', tagColorOptions.findIndex(o => o.name === 'Custom'))"
          class="px-2 py-1 rounded text-xs font-medium transition border"
          :style="{
            backgroundColor: lightenColor(customTagColor),
            color: customTagColor,
            borderColor: tagColorOptions[selectedTag]?.name === 'Custom' ? customTagColor : 'transparent'
          }"
        >
          Custom
        </button>
        <code class="bg-gray-100 px-1 rounded text-xs">{{ customTagColor }}</code>
      </div>
    </div>

    <!-- Ícones sobre fundo primário -->
    <div class="mb-3">
      <label class="text-xs font-medium text-gray-500 uppercase tracking-wider">Checks/Ícones</label>
      <div class="flex gap-1 mt-1">
        <button
          v-for="(option, i) in accentOnPrimaryOptions"
          :key="option"
          @click="emit('update:selectedAccent', i)"
          class="flex-1 px-2 py-1.5 rounded text-xs font-medium transition border flex items-center justify-center gap-1"
          :class="selectedAccent === i ? 'border-gray-800' : 'border-gray-200'"
          :style="{ backgroundColor: primary }"
        >
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"
            :style="{ color: i === 0 ? 'rgba(255,255,255,0.9)' : secondary }">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
          </svg>
          <span :style="{ color: i === 0 ? 'rgba(255,255,255,0.9)' : secondary }">{{ option }}</span>
        </button>
      </div>
    </div>

    <!-- Preview -->
    <div class="pt-2 border-t border-gray-200">
      <p class="text-xs text-gray-400 mb-1">Preview:</p>
      <div class="flex gap-1">
        <div class="flex-1 h-6 rounded" :style="{ backgroundColor: primary }"></div>
        <div class="flex-1 h-6 rounded" :style="{ backgroundColor: secondary }"></div>
        <div
          class="flex-1 h-6 rounded flex items-center justify-center text-xs"
          :style="{
            backgroundColor: tagColorOptions[selectedTag]?.name === 'Custom'
              ? lightenColor(customTagColor)
              : (tagColorOptions[selectedTag]?.bg || secondary + '20'),
            color: tagColorOptions[selectedTag]?.name === 'Custom'
              ? customTagColor
              : (tagColorOptions[selectedTag]?.text || secondary)
          }"
        >
          Tag
        </div>
      </div>
    </div>
  </div>
</template>
