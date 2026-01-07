#!/bin/bash

# OwnerPro Business - Deploy Script
# Faz deploy manual para S3 + CloudFront

set -e

# Configurações
BUCKET_NAME="ownerpro-business-landing-page"
REGION="sa-east-1"
AWS_PROFILE="ownerpro-business-deploy"
CLOUDFRONT_DISTRIBUTION_ID="E2NOHZ7D65MMCS"

echo "=== OwnerPro Business Deploy ==="
echo ""

# Build
echo "[1/5] Building project..."
npm run build

# Upload para S3 com cache headers otimizados
echo ""
echo "[2/5] Uploading HTML (no cache)..."
aws s3 sync dist/ s3://$BUCKET_NAME \
    --exclude "*" \
    --include "*.html" \
    --cache-control "no-cache, no-store, must-revalidate" \
    --region $REGION \
    --profile $AWS_PROFILE

echo ""
echo "[3/5] Uploading assets (cache 1 year)..."
aws s3 sync dist/ s3://$BUCKET_NAME \
    --exclude "*.html" \
    --cache-control "public, max-age=31536000, immutable" \
    --region $REGION \
    --profile $AWS_PROFILE

echo ""
echo "[4/5] Cleaning old files..."
aws s3 sync dist/ s3://$BUCKET_NAME --delete --region $REGION --profile $AWS_PROFILE

# Invalidar cache do CloudFront
echo ""
echo "[5/5] Invalidating CloudFront cache..."
aws cloudfront create-invalidation \
    --distribution-id $CLOUDFRONT_DISTRIBUTION_ID \
    --paths "/*" \
    --profile $AWS_PROFILE \
    --output text

echo ""
echo "=== Deploy concluído! ==="
echo "URL: https://ownerprobusiness.com.br"
