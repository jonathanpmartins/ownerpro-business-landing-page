<script setup>
import { inject, computed } from 'vue'
import Logo from './Logo.vue'

const primaryColor = inject('primaryColor')
const darkenColor = inject('darkenColor')

// Footer com versão escura da cor primária
const footerBg = computed(() => darkenColor(primaryColor.value, 40))
</script>

<template>
  <footer class="py-8" :style="{ backgroundColor: footerBg }">
    <div class="max-w-6xl mx-auto px-6">
      <div class="flex flex-col md:flex-row items-center justify-between gap-4">
        <div class="flex items-center gap-3">
          <Logo size="small" textColor="text-gray-400" />
        </div>
        <div class="flex items-center gap-6 text-gray-300 text-sm">
          <span>Gramado, RS</span>
          <span>•</span>
          <span>(54) 99186-4582</span>
        </div>
      </div>
      <div class="mt-6 pt-6 border-t border-gray-700 text-center text-gray-300 text-sm">
        © 2025 OwnerPRO Business. Todos os direitos reservados.
      </div>
    </div>
  </footer>
</template>
