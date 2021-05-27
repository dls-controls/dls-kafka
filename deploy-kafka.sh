#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami

helm upgrade -i -n controls-kafka kafka2 bitnami/kafka -f kafka-values.yaml
