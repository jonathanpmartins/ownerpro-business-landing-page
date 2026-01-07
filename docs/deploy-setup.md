# Guia de Configuração - Deploy AWS S3 + CloudFront

Este documento descreve o passo a passo para configurar a infraestrutura de hospedagem da landing page OwnerPro Business.

**URL final**: https://business.ownerpro.com.br

---

## Pré-requisitos

- Conta AWS ativa
- AWS CLI instalado ([instruções](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html))
- Acesso ao Registro.br (ou seu provedor DNS)
- Repositório no GitHub

---

## Passo 0: Configurar AWS CLI (Local)

Configure um profile nomeado para este projeto:

```bash
aws configure --profile ownerpro
```

Informe:
- **AWS Access Key ID**: (será criado no Passo 8)
- **AWS Secret Access Key**: (será criado no Passo 8)
- **Default region**: `sa-east-1`
- **Default output format**: `json`

> **Nota**: Se ainda não tem as credenciais, pule para o Passo 1 e volte aqui após o Passo 8.

As credenciais ficam salvas em:
```
~/.aws/credentials    # Chaves de acesso
~/.aws/config         # Região e formato
```

Para usar o profile em comandos:
```bash
aws s3 ls --profile ownerpro
```

Ou defina como padrão na sessão:
```bash
export AWS_PROFILE=ownerpro
```

---

## Passo 1: Criar Bucket S3

1. Acesse o [Console S3](https://s3.console.aws.amazon.com/s3/)
2. Clique em **Create bucket**
3. Configure:
   - **Bucket name**: `ownerpro-business-landing-page`
   - **AWS Region**: `sa-east-1` (South America - São Paulo)
   - **Block all public access**: ✅ Manter habilitado (CloudFront vai acessar via OAC)
4. Clique em **Create bucket**

> **Nota**: Não habilite "Static website hosting". O CloudFront vai servir os arquivos diretamente.

---

## Passo 2: Criar Certificado SSL no ACM

⚠️ **IMPORTANTE**: O certificado DEVE ser criado na região **us-east-1** (N. Virginia) para funcionar com CloudFront.

1. Acesse o [Console ACM em us-east-1](https://us-east-1.console.aws.amazon.com/acm/home?region=us-east-1)
2. Clique em **Request a certificate**
3. Selecione **Request a public certificate** → Next
4. Configure:
   - **Domain name**: `business.ownerpro.com.br`
   - **Validation method**: DNS validation
5. Clique em **Request**
6. Na lista de certificados, clique no certificado criado
7. Em **Domains**, copie o **CNAME name** e **CNAME value**
8. Vá para o **Passo 3** para adicionar o registro DNS

---

## Passo 3: Validar Certificado no Registro.br

1. Acesse o [Registro.br](https://registro.br)
2. Vá em **Meus domínios** → `business.ownerpro.com.br` → **DNS**
3. Adicione um novo registro:
   - **Tipo**: CNAME
   - **Nome**: Cole o CNAME name do ACM (sem o domínio final)
     - Exemplo: Se o ACM mostrar `_abc123.business.ownerpro.com.br`, use apenas `_abc123`
   - **Valor**: Cole o CNAME value do ACM
4. Salve e aguarde a propagação (pode levar alguns minutos)
5. Volte ao ACM e verifique se o status mudou para **Issued** (Emitido)

> **Dica**: A validação geralmente leva de 5 a 30 minutos.

---

## Passo 4: Criar Distribuição CloudFront

1. Acesse o [Console CloudFront](https://console.aws.amazon.com/cloudfront/)
2. Clique em **Create distribution**
3. Configure a **Origin**:
   - **Origin domain**: Selecione o bucket `ownerpro-business-landing-page.s3.sa-east-1.amazonaws.com`
   - **Origin access**: Selecione **Origin access control settings (recommended)**
   - Clique em **Create new OAC**
     - **Name**: `ownerpro-business-oac`
     - Clique em **Create**
4. Configure o **Default cache behavior**:
   - **Viewer protocol policy**: Redirect HTTP to HTTPS
   - **Allowed HTTP methods**: GET, HEAD
   - **Cache policy**: CachingOptimized (recomendado)
5. Configure **Settings**:
   - **Price class**: Use only North America and Europe (mais barato) ou All edge locations
   - **Alternate domain name (CNAME)**: `business.ownerpro.com.br`
   - **Custom SSL certificate**: Selecione o certificado criado no Passo 2
   - **Default root object**: `index.html`
6. Clique em **Create distribution**
7. **IMPORTANTE**: Após criar, o CloudFront mostrará um banner azul pedindo para atualizar a policy do S3. Clique em **Copy policy**.

---

## Passo 5: Configurar Bucket Policy no S3

1. Volte ao [Console S3](https://s3.console.aws.amazon.com/s3/)
2. Clique no bucket `ownerpro-business-landing-page`
3. Vá na aba **Permissions**
4. Em **Bucket policy**, clique em **Edit**
5. Cole a policy que você copiou do CloudFront (ou use esta, substituindo os valores):

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowCloudFrontServicePrincipal",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::ownerpro-business-landing-page/*",
            "Condition": {
                "StringEquals": {
                    "AWS:SourceArn": "arn:aws:cloudfront::SEU-ACCOUNT-ID:distribution/SEU-DISTRIBUTION-ID"
                }
            }
        }
    ]
}
```

6. Clique em **Save changes**

---

## Passo 6: Configurar Error Pages para SPA

1. No [Console CloudFront](https://console.aws.amazon.com/cloudfront/), clique na sua distribuição
2. Vá na aba **Error pages**
3. Clique em **Create custom error response**
4. Configure para erro 403:
   - **HTTP error code**: 403
   - **Customize error response**: Yes
   - **Response page path**: `/index.html`
   - **HTTP response code**: 200
5. Clique em **Create**
6. Repita para erro 404:
   - **HTTP error code**: 404
   - **Response page path**: `/index.html`
   - **HTTP response code**: 200

> **Por que isso?** Como é uma SPA (Single Page Application), todas as rotas devem retornar o index.html.

---

## Passo 7: Configurar DNS Final no Registro.br

1. Copie o **Distribution domain name** do CloudFront (ex: `d1abc2xyz3.cloudfront.net`)
2. Acesse o [Registro.br](https://registro.br)
3. Vá em **Meus domínios** → `business.ownerpro.com.br` → **DNS**
4. Adicione um novo registro:
   - **Tipo**: CNAME
   - **Nome**: `@` (ou deixe vazio para o domínio raiz)
   - **Valor**: `d1abc2xyz3.cloudfront.net` (seu domínio do CloudFront)

   > **Nota**: Se o Registro.br não aceitar CNAME para domínio raiz, use um registro **ALIAS** ou configure o **www** como CNAME e redirecione o raiz.

5. Salve

> **Nota**: A propagação DNS pode levar até 24 horas, mas geralmente é bem mais rápida.

---

## Passo 8: Criar Usuário IAM para CI/CD

1. Acesse o [Console IAM](https://console.aws.amazon.com/iam/)
2. Vá em **Users** → **Create user**
3. Configure:
   - **User name**: `ownerpro-business-deploy`
   - Clique em **Next**
4. Em **Set permissions**, selecione **Attach policies directly**
5. Clique em **Create policy** (abre nova aba)
6. Selecione a aba **JSON** e cole:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "S3DeployAccess",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::ownerpro-business-landing-page",
                "arn:aws:s3:::ownerpro-business-landing-page/*"
            ]
        },
        {
            "Sid": "CloudFrontInvalidation",
            "Effect": "Allow",
            "Action": "cloudfront:CreateInvalidation",
            "Resource": "*"
        }
    ]
}
```

7. Clique em **Next**
8. **Policy name**: `ownerpro-business-deploy-policy`
9. Clique em **Create policy**
10. Volte à aba de criação de usuário, clique em 🔄 refresh e selecione a policy criada
11. Clique em **Next** → **Create user**
12. Clique no usuário criado → **Security credentials**
13. Em **Access keys**, clique em **Create access key**
14. Selecione **Application running outside AWS** → **Next** → **Create access key**
15. **IMPORTANTE**: Copie e salve:
    - **Access key ID**
    - **Secret access key**

> ⚠️ A secret key só é mostrada uma vez! Salve em local seguro.

---

## Passo 9: Configurar GitHub Secrets

1. Acesse seu repositório no GitHub
2. Vá em **Settings** → **Secrets and variables** → **Actions**
3. Clique em **New repository secret** e adicione:

| Name | Value |
|------|-------|
| `AWS_ACCESS_KEY_ID` | Sua Access Key ID do Passo 8 |
| `AWS_SECRET_ACCESS_KEY` | Sua Secret Access Key do Passo 8 |
| `CLOUDFRONT_DISTRIBUTION_ID` | ID da distribuição CloudFront (ex: `E1ABC2XYZ3`) |

> **Onde encontrar o Distribution ID?** No Console CloudFront, é a coluna "ID" na lista de distribuições.

---

## Passo 10: Fazer o Primeiro Deploy

### Opção A: Via GitHub Actions (automático)

```bash
git add .
git commit -m "Setup deploy infrastructure"
git push origin main
```

O deploy será executado automaticamente. Acompanhe em **Actions** no GitHub.

### Opção B: Via script manual

```bash
# Execute o deploy
chmod +x deploy.sh  # primeira vez
./deploy.sh
```

---

## Verificação Final

Após o deploy, verifique:

1. [ ] Acesse https://business.ownerpro.com.br
2. [ ] Verifique se o certificado SSL está válido (cadeado verde)
3. [ ] Teste a navegação pelo site
4. [ ] Verifique se o GitHub Actions executou com sucesso

---

## Troubleshooting

### Certificado não valida
- Verifique se o CNAME foi adicionado corretamente no Registro.br
- Aguarde até 30 minutos para propagação

### Erro 403 no site
- Verifique se a bucket policy está correta
- Verifique se o OAC está configurado no CloudFront

### Alterações não aparecem
- Execute uma invalidação no CloudFront:
  ```bash
  aws cloudfront create-invalidation --distribution-id SEU-ID --paths "/*"
  ```

### GitHub Actions falha
- Verifique se os 3 secrets estão configurados corretamente
- Verifique os logs do workflow em Actions

---

## Informações de Referência

| Recurso | Valor |
|---------|-------|
| Bucket S3 | `ownerpro-business-landing-page` |
| Região S3 | `sa-east-1` |
| Domínio | `business.ownerpro.com.br` |
| CloudFront Distribution ID | _(preencher após criar)_ |
| Usuário IAM | `ownerpro-business-deploy` |
