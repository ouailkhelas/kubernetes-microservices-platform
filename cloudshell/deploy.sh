#!/bin/bash
set -e

echo "Initializing Terraform..."
cd ../terraform
terraform init
terraform apply -auto-approve

echo "Fetching AKS credentials..."
az aks get-credentials --resource-group rg-ecommerce-aks --name aks-ecommerce-cluster

echo "Deploying Kubernetes manifests..."
kubectl apply -f ../cloudshell/kubernetes/namespace.yaml
kubectl apply -f ../cloudshell/kubernetes/deployment.yaml
kubectl apply -f ../cloudshell/kubernetes/service.yaml

echo "Deployment complete! Checking workloads..."
kubectl get pods -n ecommerce
