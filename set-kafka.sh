#!/bin/bash

kubectl config set-context kafka --user cluster-user --cluster argus --namespace controls-kafka
kubectl config use-context kafka
