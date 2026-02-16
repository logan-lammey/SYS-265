#!/bin/bash

echo "========================================="
echo "Prometheus Monitoring Stack Setup"
echo "========================================="
echo ""

# Check Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker not found. Please install Docker first."
    exit 1
fi

# Check Docker Compose
if ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose not found. Please install Docker Compose first."
    exit 1
fi

echo "✅ Docker and Docker Compose found"
echo ""

# Validate config
echo "🔍 Validating configuration..."
if docker compose config > /dev/null 2>&1; then
    echo "✅ Configuration valid"
else
    echo "❌ Configuration validation failed"
    exit 1
fi

echo ""
echo "🚀 Starting services..."
docker compose up -d

echo ""
echo "⏳ Waiting for services to initialize (30 seconds)..."
sleep 30

echo ""
echo "🔍 Checking service status..."
docker compose ps

echo ""
echo "========================================="
echo "✅ Setup Complete!"
echo "========================================="
echo ""
echo "Access your services:"
echo "  📊 Grafana:     http://localhost:3000"
echo "     Username: admin"
echo "     Password: admin"
echo ""
echo "  📈 Prometheus:  http://localhost:9090"
echo "  🌐 Sample App:  http://localhost:8080"
echo "  📉 Node Export: http://localhost:9100/metrics"
echo ""
echo "Useful commands:"
echo "  View logs:      docker compose logs -f"
echo "  Stop services:  docker compose down"
echo "  Restart:        docker compose restart"
echo ""
