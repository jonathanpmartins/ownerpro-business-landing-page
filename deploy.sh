#!/bin/bash

# OwnerPro Business - Deploy Script
# Faz deploy manual para S3 + CloudFront

set -e

# Configurações
BUCKET_NAME="ownerpro-business-landing-page"
REGION="sa-east-1"
AWS_PROFILE="ownerpro"

# Verifica se CLOUDFRONT_DISTRIBUTION_ID está definido
if [ -z "$CLOUDFRONT_DISTRIBUTION_ID" ]; then
    echo "Erro: CLOUDFRONT_DISTRIBUTION_ID não está definido."
    echo "Execute: export CLOUDFRONT_DISTRIBUTION_ID=seu-id"
    exit 1
fi

echo "=== OwnerPro Business Deploy ==="
echo ""

# Build
echo "[1/3] Building project..."
npm run build

# Upload para S3
echo ""
echo "[2/3] Uploading to S3..."
aws s3 sync dist/ s3://$BUCKET_NAME --delete --region $REGION --profile $AWS_PROFILE

# Invalidar cache do CloudFront
echo ""
echo "[3/3] Invalidating CloudFront cache..."
aws cloudfront create-invalidation \
    --distribution-id $CLOUDFRONT_DISTRIBUTION_ID \
    --paths "/*" \
    --profile $AWS_PROFILE \
    --output text

echo ""
echo "=== Deploy concluído! ==="
echo "URL: https://ownerprobusiness.com.br"
