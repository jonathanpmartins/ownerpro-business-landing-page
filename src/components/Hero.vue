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
      <div class="max-w-3xl">
        <div 
          class="inline-flex items-center gap-2 px-4 py-2 rounded-full mb-6 text-sm font-medium"
          style="background-color: rgba(255,255,255,0.15)"
        >
          <span 
            class="w-2 h-2 rounded-full animate-pulse"
            :style="{ backgroundColor: secondaryColor }"
          ></span>
          Sistema financeiro e operacional completo
        </div>
        
        <h1 class="text-4xl lg:text-5xl font-bold leading-tight mb-6">
          Controle financeiro real para gestores de aluguel por temporada
        </h1>
        
        <p class="text-xl opacity-90 mb-4 leading-relaxed">
          A OwnerPro centraliza o financeiro da sua empresa, a gestão de repasses aos proprietários e toda a operação do dia a dia em um único lugar.
        </p>
        
        <p class="text-lg opacity-75 mb-8">
          Desenvolvida por quem vive a gestão na prática. Não é apenas software — é uma ferramenta de gestão para quem quer crescer com controle.
        </p>
        
        <div class="flex flex-col sm:flex-row gap-4">
          <a 
            href="https://wa.me/5554991864582"
            target="_blank" 
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
