<script setup>
import { inject } from 'vue'

const primaryColor = inject('primaryColor')

const differentials = [
  { icon: '👨‍💼', title: 'Feita por Gestores', desc: 'Desenvolvida por quem vive a gestão de imóveis na prática' },
  { icon: '🎯', title: 'Foco no Financeiro', desc: 'Forte ênfase em organização financeira e controle de repasses' },
  { icon: '🔗', title: 'Tudo Integrado', desc: 'Financeiro e operação conectados em um único ambiente' },
  { icon: '🤝', title: 'Implantação Guiada', desc: 'Consultoria especializada para garantir uso correto do sistema' },
]
</script>

<template>
  <section
    id="diferenciais"
    class="py-20"
    :style="{ backgroundColor: primaryColor }"
  >
    <div class="max-w-6xl mx-auto px-6">
      <div class="text-center mb-12">
        <h2 class="text-3xl md:text-4xl tracking-tight font-bold text-white mb-4">Por que o OwnerPro Business?</h2>
        <p class="text-white/90 max-w-2xl mx-auto">
          Mais do que um software, é um processo de organização e amadurecimento da sua operação.
        </p>
      </div>

      <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
        <div
          v-for="(item, i) in differentials"
          :key="i"
          class="bg-black/10 backdrop-blur rounded-lg p-6 text-center text-white"
        >
          <span class="text-4xl mb-4 block">{{ item.icon }}</span>
          <h3 class="font-semibold mb-2">{{ item.title }}</h3>
          <p class="text-sm opacity-90">{{ item.desc }}</p>
        </div>
      </div>
    </div>
  </section>
</template>
