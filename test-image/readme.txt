This image is used for performance testing of kafka in cluster

to build:
  docker build -t gcr.io/diamond-privreg/controls/work/tools/kafka-test .
  docker push gcr.io/diamond-privreg/controls/work/tools/kafka-test

run in cluster:
  kubectl run kafka-test --restart='Never' --image gcr.io/diamond-privreg/controls/work/tools/kafka-test --namespace controls-kafka --command -- sleep infinity
  kubectl exec --tty -i pod/kafka-test --namespace controls-kafka -- bash
  kubectl delete pod/kafka-test

at the prompt type the following command for performance testing help
  /librdkafka/examples/rdkafka_performance