# OwnerPro Business - Landing Page

Landing page para o produto OwnerPro Business, desenvolvida com **Vite + Vue 3 + Tailwind CSS**.

## 🚀 Quick Start

### Pré-requisitos
- Node.js 18+ 
- npm ou yarn

### Instalação

```bash
# Clone ou copie o projeto
cd ownerpro-business

# Instale as dependências
npm install

# Inicie o servidor de desenvolvimento
npm run dev
```

O projeto estará disponível em `http://localhost:5173`

## 📦 Build para Produção

```bash
# Gerar build otimizado
npm run build

# Preview do build
npm run preview
```

Os arquivos serão gerados na pasta `dist/`

## 🎨 Personalização de Cores

### Modo Desenvolvimento
Use o seletor de cores (🎨) no canto superior direito para testar combinações.

### Produção
Edite as cores em `src/App.vue`:

```javascript
const primaryColor = ref('#27555A')   // Verde principal
const secondaryColor = ref('#D97706') // Acento (amber)
```

### Remover Color Picker em Produção
Em `src/App.vue`, altere:
```javascript
const showColorPicker = ref(false)
```

Ou remova completamente o componente `<ColorPicker>` e o botão de toggle.

## 🔤 Fonte CaviarDreams

A fonte CaviarDreams já está incluída no projeto em `public/fonts/`:
- `CaviarDreams.woff` (regular)
- `CaviarDreams_Bold.woff` (bold)

## 📁 Estrutura do Projeto

```
ownerpro-business/
├── public/
│   ├── favicon.svg
│   └── fonts/
│       └── CaviarDreams.woff2
├── src/
│   ├── App.vue                    # Componente raiz
│   ├── main.js                    # Entry point
│   ├── style.css                  # Estilos globais + Tailwind
│   └── components/
│       ├── Header.vue             # Cabeçalho com logo e nav
│       ├── Hero.vue               # Seção principal
│       ├── TargetAudience.vue     # Para quem é
│       ├── ProblemSolution.vue    # Problemas e soluções
│       ├── Features.vue           # Funcionalidades
│       ├── Differentials.vue      # Diferenciais
│       ├── OwnerPortal.vue        # Portal do proprietário
│       ├── PricingCalculator.vue  # Calculadora de preços
│       ├── CtaSection.vue         # Call to action
│       ├── FooterSection.vue      # Rodapé
│       ├── Logo.vue               # Logo OwnerPro Business
│       └── ColorPicker.vue        # Seletor de cores (dev)
├── index.html
├── package.json
├── vite.config.js
├── tailwind.config.js
└── postcss.config.js
```

## Deploy

**Produção**: https://business.ownerpro.com.br

A landing page é hospedada na AWS usando **S3 + CloudFront**.

### Deploy Automático (CI/CD)

O deploy é feito automaticamente via GitHub Actions quando você faz push para a branch `main`.

**Configuração necessária** (GitHub → Settings → Secrets → Actions):

| Secret | Descrição |
|--------|-----------|
| `AWS_ACCESS_KEY_ID` | Chave de acesso do usuário IAM |
| `AWS_SECRET_ACCESS_KEY` | Chave secreta do usuário IAM |
| `CLOUDFRONT_DISTRIBUTION_ID` | ID da distribuição CloudFront |

### Deploy Manual

Para deploy manual, use o script `deploy.sh`:

```bash
# Configure o ID do CloudFront (apenas uma vez)
export CLOUDFRONT_DISTRIBUTION_ID=seu-id-aqui

# Execute o deploy
chmod +x deploy.sh  # primeira vez
./deploy.sh
```

### Infraestrutura AWS

| Recurso | Nome/ID |
|---------|---------|
| Bucket S3 | `ownerpro-business-landing-page` |
| Região | `sa-east-1` (São Paulo) |
| CloudFront | Configurado com HTTPS |
| Certificado SSL | ACM (us-east-1) |

## ✏️ Edições Comuns

### Alterar WhatsApp
Busque por `5554991864582` e substitua pelo número desejado.

### Alterar E-mail
Busque por `daniele@rosa.imb.br` e substitua.

### Alterar Preços
Edite o array `pricingPlans` em `src/components/PricingCalculator.vue`:

```javascript
const pricingPlans = [
  { min: 1, max: 20, fixed: 390, perUnit: 19 },
  // ...
]
```

### Adicionar Screenshot do Portal
Substitua o placeholder em `src/components/OwnerPortal.vue` por uma imagem real.

## 🛠️ Tecnologias

- [Vue 3](https://vuejs.org/) - Framework JavaScript
- [Vite](https://vitejs.dev/) - Build tool
- [Tailwind CSS](https://tailwindcss.com/) - Framework CSS
- [PostCSS](https://postcss.org/) - Processador CSS

## 📄 Licença

Propriedade de OwnerPro. Todos os direitos reservados.
