<script setup>
import { inject, computed } from 'vue'

const primaryColor = inject('primaryColor')
const secondaryColor = inject('secondaryColor')
const darkenColor = inject('darkenColor')

const gradientStyle = computed(() => ({
  background: `linear-gradient(135deg, ${primaryColor.value} 0%, ${darkenColor(primaryColor.value, 25)} 100%)`
}))
</script>

<template>
  <section
    class="text-white py-20 lg:py-28"
    :style="gradientStyle"
  >
    <div class="max-w-6xl mx-auto px-6">
      <div class="max-w-4xl">
        <div
          class="inline-flex items-center gap-2 px-4 py-2 rounded-full mb-6 text-sm font-medium"
          style="background-color: rgba(255,255,255,0.15)"
        >
          <span
            class="status-dot w-2 h-2 rounded-full"
            :style="{ backgroundColor: secondaryColor, '--glow-color': secondaryColor }"
          ></span>
          Sistema financeiro e operacional
        </div>

        <h1 class="text-4xl lg:text-5xl font-bold leading-tight mb-6">
          Controle financeiro para gestores de aluguel por temporada
        </h1>

        <p class="text-xl opacity-90 mb-4 leading-relaxed">
          O OwnerPro Business centraliza o financeiro da sua empresa, a gestão de repasses aos proprietários e toda a operação do dia a dia em um único lugar.
        </p>

        <p class="text-lg opacity-75 mb-8">
          Desenvolvida por quem vive a gestão na prática. Não é apenas software — é uma ferramenta de gestão para quem quer crescer com controle.
        </p>

        <div class="flex flex-col sm:flex-row gap-4">
          <a
            href="https://wa.me/5554991864582?text=Ol%C3%A1!%20Quero%20conhecer%20o%20OwnerPro%20Business."
            target="_blank"
            rel="noopener noreferrer"
            class="bg-white px-8 py-4 rounded font-semibold transition shadow-lg hover:shadow-xl text-center"
            :style="{ color: primaryColor }"
          >
            Agendar Demonstração
          </a>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.status-dot {
  animation: glow 2s ease-in-out infinite;
}

@keyframes glow {
  0%, 100% {
    box-shadow: 0 0 1px var(--glow-color);
    filter: brightness(1);
  }
  50% {
    box-shadow: 0 0 3px var(--glow-color), 0 0 6px var(--glow-color);
    filter: brightness(1.4);
  }
}
</style>
