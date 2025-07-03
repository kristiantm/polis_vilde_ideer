#!/bin/bash

# Railway Deployment Script for Polis
# This script helps automate the deployment process

set -e

echo "🚀 Polis Railway Deployment Script"
echo "=================================="

# Check if Railway CLI is installed
if ! command -v railway &> /dev/null; then
    echo "❌ Railway CLI is not installed. Installing..."
    npm install -g @railway/cli
fi

# Check if user is logged in
if ! railway whoami &> /dev/null; then
    echo "🔐 Please log in to Railway..."
    railway login
fi

# Ask for deployment type
echo ""
echo "Choose deployment type:"
echo "1) Full deployment (all services - recommended for production)"
echo "2) Minimal deployment (core services only - for testing)"
read -p "Enter your choice (1 or 2): " choice

case $choice in
    1)
        echo "📦 Setting up full deployment..."
        # Use full deployment
        sed -i 's/docker-compose.railway-minimal.yml/docker-compose.railway.yml/g' railway.json
        ;;
    2)
        echo "📦 Setting up minimal deployment..."
        # Use minimal deployment
        sed -i 's/docker-compose.railway.yml/docker-compose.railway-minimal.yml/g' railway.json
        ;;
    *)
        echo "❌ Invalid choice. Using full deployment by default."
        sed -i 's/docker-compose.railway-minimal.yml/docker-compose.railway.yml/g' railway.json
        ;;
esac

# Check if project is initialized
if [ ! -f ".railway" ]; then
    echo "🔧 Initializing Railway project..."
    railway init
fi

# Deploy
echo "🚀 Deploying to Railway..."
railway up

echo ""
echo "✅ Deployment completed!"
echo ""
echo "📋 Next steps:"
echo "1. Add a PostgreSQL database in your Railway project"
echo "2. Configure environment variables (see railway.env.example)"
echo "3. Visit your Railway URL to create an admin user"
echo ""
echo "📚 For detailed instructions, see RAILWAY_DEPLOYMENT.md" 