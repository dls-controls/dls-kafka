#!/bin/bash

kubectl config set-context kafka --user default --cluster default --namespace kafka
kubectl config use-context kafka

kubectl create namespace kafka



helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm upgrade -i kafka bitnami/kafka -f gk-kafka-values.yaml

# helm upgrade -i kafka-monitor prometheus-community/prometheus-kafka-exporter \
#    --set "kafkaServer={gknuc:30006,gknuc:30007,gknuc:30008}"
