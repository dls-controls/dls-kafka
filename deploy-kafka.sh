#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami

helm upgrade -n controls-kafka -i kafka2 bitnami/kafka -f kafka-values.yaml