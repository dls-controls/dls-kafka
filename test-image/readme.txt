DEPRECATED
This image is not really necessary since the standard kafka client has its own
performance test scripts. See README.md for details


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

To set up a producer with message size s and message count c do this:
  /librdkafka/examples/rdkafka_performance -P -b kafka2-0-external.controls-kafka:9094,kafka2-1-external.controls-kafka:9094,kafka2-2-external.controls-kafka:9094 -t test3 -s 1000 -c 1000
or
  /librdkafka/examples/rdkafka_performance -C -b kafka2:9092 -t test3 -s 1000 -c 1000 -G a_group

A matching consumer should exit when all is received:
  /librdkafka/examples/rdkafka_performance -C -b kafka2-0-external.controls-kafka:9094,kafka2-1-external.controls-kafka:9094,kafka2-2-external.controls-kafka:9094 -t test3 -s 1000 -c 1000 -G a_group
or
  /librdkafka/examples/rdkafka_performance -P -b kafka2:9092 -t test3 -s 1000 -c 1000

To for really big messasges (in topic test3) do this:
  kubectl -n controls-kafka run kafka-client --restart='Never' --image docker.io/bitnami/kafka:2.8.0-debian-10-r0 --namespace controls-kafka --command -- sleep infinity
  kubectl -ti -n controls-kafka exec kafka-client -- bash

  kafka-configs.sh --bootstrap-server kafka2:9092  --alter --entity-type topics --entity-name test3 --add-config max.message.bytes=100001000
