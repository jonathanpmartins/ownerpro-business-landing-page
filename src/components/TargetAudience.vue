<script setup>
const targetAudience = [
  { icon: '🏢', title: 'Gestores de Aluguel por Temporada', desc: 'Que precisam de controle financeiro real' },
  { icon: '🏠', title: 'Administradoras de Imóveis', desc: 'Que fazem repasses para proprietários' },
  { icon: '📈', title: 'Operações em Crescimento', desc: 'Que buscam escalar com segurança' },
]
</script>

<template>
  <section class="py-16 bg-white">
    <div class="max-w-6xl mx-auto px-6">
      <div class="text-center mb-12">
        <h2 class="text-3xl md:text-4xl tracking-tight font-bold text-gray-800 mb-2">Para gestores e administradoras de aluguel por temporada</h2>
        <p class="text-gray-600">Ideal para operações que buscam profissionalizar a gestão</p>
      </div>

      <div class="grid md:grid-cols-3 gap-6">
        <div
          v-for="(item, i) in targetAudience"
          :key="i"
          class="text-center p-6 rounded-lg border border-gray-100 hover:border-gray-200 hover:shadow-sm transition"
        >
          <span class="text-4xl mb-4 block">{{ item.icon }}</span>
          <h3 class="font-semibold text-gray-800 mb-1">{{ item.title }}</h3>
          <p class="text-gray-600 text-sm">{{ item.desc }}</p>
        </div>
      </div>
    </div>
  </section>
</template>
