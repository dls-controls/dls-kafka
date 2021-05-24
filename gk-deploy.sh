#!/bin/bash

kubectl config set-context kafka --user default --cluster default --namespace kafka
kubectl config use-context kafka

kubectl create namespace kafka



helm repo add bitnami https://charts.bitnami.com/bitnami

helm upgrade -i kafka bitnami/kafka -f gk-kafka-values.yaml
