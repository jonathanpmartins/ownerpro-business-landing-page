<script setup>
import Logo from './Logo.vue'
</script>

<template>
  <footer class="bg-gray-900 py-8">
    <div class="max-w-6xl mx-auto px-6">
      <div class="flex flex-col md:flex-row items-center justify-between gap-4">
        <div class="flex items-center gap-3">
          <Logo size="small" textColor="text-gray-400" />
        </div>
        <div class="flex items-center gap-6 text-gray-400 text-sm">
          <span>Gramado, RS</span>
          <span>•</span>
          <span>(54) 99186-4582</span>
        </div>
      </div>
      <div class="mt-6 pt-6 border-t border-gray-800 text-center text-gray-500 text-sm">
        © 2025 OwnerPRO Business. Todos os direitos reservados.
      </div>
    </div>
  </footer>
</template>
