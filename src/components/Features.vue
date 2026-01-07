<script setup>
import { inject } from 'vue'

const primaryColor = inject('primaryColor')
const secondaryColor = inject('secondaryColor')

const features = [
  {
    icon: 'M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z',
    title: 'Gestão Financeira Completa',
    description: 'Controle de contas a pagar e receber, fluxo de caixa, DRE e plano de contas. Visão consolidada dos resultados do seu negócio.',
    highlights: ['Fluxo de caixa', 'DRE', 'Contas a pagar/receber']
  },
  {
    icon: 'M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z',
    title: 'Repasses e Prestação de Contas',
    description: 'Cálculo estruturado de repasses com regras personalizadas por imóvel. Prestação de contas clara e profissional para seus proprietários.',
    highlights: ['Regras por contrato', 'Rastreabilidade', 'Créditos automáticos']
  },
  {
    icon: 'M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4',
    title: 'Integração com Channel Manager',
    description: 'Importação automática das reservas consolidadas. Elimine erros manuais e mantenha financeiro e operação sempre alinhados.',
    highlights: ['Importação automática', 'Dados consolidados', 'Sem erros manuais']
  },
  {
    icon: 'M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z',
    title: 'Check-in, Check-out e Limpeza',
    description: 'Acompanhe a operação diária dos seus imóveis em tempo real. Gerencie equipes de limpeza e controle o status de cada unidade.',
    highlights: ['Status em tempo real', 'Gestão de equipes', 'Controle por imóvel']
  },
  {
    icon: 'M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z M15 12a3 3 0 11-6 0 3 3 0 016 0z',
    title: 'Gestão de Manutenções',
    description: 'Registre e acompanhe manutenções preventivas e corretivas. Vincule custos diretamente ao imóvel e mantenha o histórico completo.',
    highlights: ['Registro de ocorrências', 'Histórico por imóvel', 'Custos vinculados']
  },
  {
    icon: 'M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z',
    title: 'Relatórios Estratégicos',
    description: 'Relatórios de vendas, financeiros e indicadores de desempenho. Visões consolidadas por período, imóvel ou carteira.',
    highlights: ['DRE detalhado', 'Por imóvel', 'Indicadores']
  },
]
</script>

<template>
  <section id="funcionalidades" class="py-20 bg-white">
    <div class="max-w-6xl mx-auto px-6">
      <div class="text-center mb-16">
        <h2 class="text-3xl font-bold text-gray-800 mb-4">Funcionalidades Completas</h2>
        <p class="text-gray-600 max-w-2xl mx-auto">
          Financeiro, operacional e gestão de proprietários integrados em uma única plataforma.
        </p>
      </div>
      
      <div class="grid md:grid-cols-2 gap-8">
        <div 
          v-for="(feature, i) in features"
          :key="i"
          class="bg-gray-50 rounded-lg p-6 hover:shadow-md transition group"
        >
          <div class="flex items-start gap-4">
            <div 
              class="w-12 h-12 rounded-lg flex items-center justify-center text-white flex-shrink-0"
              :style="{ backgroundColor: primaryColor }"
            >
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" :d="feature.icon" />
              </svg>
            </div>
            <div class="flex-1">
              <h3 class="text-lg font-semibold text-gray-800 mb-2">{{ feature.title }}</h3>
              <p class="text-gray-600 text-sm mb-3">{{ feature.description }}</p>
              <div class="flex flex-wrap gap-2">
                <span 
                  v-for="(tag, j) in feature.highlights"
                  :key="j"
                  class="text-xs px-2 py-1 rounded-full"
                  :style="{ backgroundColor: secondaryColor + '20', color: secondaryColor }"
                >
                  {{ tag }}
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>
