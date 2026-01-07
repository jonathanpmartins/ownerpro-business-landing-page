<script setup>
import { inject } from 'vue'
import Logo from './Logo.vue'

const primaryColor = inject('primaryColor')
</script>

<template>
  <header class="bg-white border-b border-gray-200 sticky top-0 z-40">
    <div class="header-container max-w-6xl mx-auto px-6 py-4 flex items-center justify-between">
      <div class="flex items-center gap-3">
        <Logo />
      </div>

      <nav class="hidden md:flex items-center gap-8">
        <a href="#funcionalidades" class="text-gray-600 hover:opacity-70 transition">Funcionalidades</a>
        <a href="#diferenciais" class="text-gray-600 hover:opacity-70 transition">Diferenciais</a>
        <a href="#precos" class="text-gray-600 hover:opacity-70 transition">Preços</a>
      </nav>

      <a
        href="https://wa.me/5554991864582?text=Ol%C3%A1!%20Quero%20falar%20com%20um%20consultor%20OwnerPro%20Business."
        target="_blank"
        class="header-cta text-white px-5 py-2.5 rounded font-medium transition shadow-sm hover:shadow-md"
        :style="{ backgroundColor: primaryColor }"
      >
        Fale Conosco
      </a>
    </div>
  </header>
</template>

<style scoped>
@media (max-width: 420px) {
  .header-container {
    justify-content: center;
  }
  .header-cta {
    display: none;
  }
}
</style>
