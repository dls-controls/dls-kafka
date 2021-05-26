#!/bin/bash

# includes override to avoid arm architecture nodes
kubectl run kafka-client --restart='Never' --image docker.io/bitnami/kafka:2.8.0-debian-10-r0 --namespace kafka --overrides='{ "nodeSelector": { "beta.kubernetes.io/arch: ": "amd64" } }' --command -- sleep infinity
