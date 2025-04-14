#!/bin/bash
set -e

echo "Создание образа..."
sudo docker build -t custom-app-image . 
minikube image load custom-app-image

echo "Создание ConfigMap..."
kubectl apply -f configmap.yaml

echo "Развёртывание Pod для первичного теста..."
kubectl apply -f pod.yaml

echo "Ждем готовности Pod custom-app-pod..."
kubectl wait --for=condition=Ready pod/custom-app-pod --timeout=60s

echo "Развёртывание Deployment..."
kubectl apply -f deployment.yaml

echo "Ждем готовности Deployment..."
kubectl rollout status deployment/custom-app-deployment --timeout=120s

echo "Создание Service..."
kubectl apply -f service.yaml

echo "Развёртывание DaemonSet (log-agent)..."
kubectl apply -f daemonset.yaml

echo "Развёртывание CronJob для архивирования логов..."
kubectl apply -f cronjob.yaml

kubectl rollout status deployment/custom-app-deployment --timeout=120s

echo "Развёртывание завершено."