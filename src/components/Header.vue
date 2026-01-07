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
        rel="noopener noreferrer"
        class="header-cta inline-flex items-center gap-2 text-white px-5 py-2.5 rounded font-medium transition shadow-sm hover:shadow-md"
        :style="{ backgroundColor: primaryColor }"
      >
        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
          <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/>
        </svg>
        <span class="header-cta-text">Fale Conosco</span>
      </a>
    </div>
  </header>
</template>

<style scoped>
.header-cta svg {
  display: none;
}

@media (max-width: 420px) {
  .header-cta {
    padding: 0.625rem;
  }
  .header-cta svg {
    display: block;
  }
  .header-cta-text {
    display: none;
  }
}

@media (max-width: 300px) {
  .header-container {
    justify-content: center;
  }
  .header-cta {
    display: none;
  }
}
</style>
