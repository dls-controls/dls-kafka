# dls-kafka
Configuration files for installing kafka into K8S

This repo contains files for configuring and testing kafka on DLS argus cluster.

To install or update 3 kafka nodes into the namespace controls-kafka use the
following command:
```
helm upgrade -i -n controls-kafka kafka2 bitnami/kafka -f kafka-values.yaml
```


# Performance Testing With librdkafka

## introduction

First you need to be connected to the argus cluster and set default namespace
to controls-kafka. To do this

- module load argus
- ./set-kafka.sh
## Producer

To fire up a test producer::

    cd <root of this repo>
    ./launch-test-consumer.sh
    /librdkafka/examples/rdkafka_performance -P -X message.max.bytes=200000000 -b kafka2:9092 -t test3 -s 1000 -c 1000


Adjust parameters as needed:

- -t is topic
- -s is size of test messages
- -c is count of test messages


## Consumer

To fire up a test consumer::

    cd <root of this repo>
    ./launch-test-consumer.sh
    /librdkafka/examples/rdkafka_performance -C -b kafka2:9092 -t test3 -c 1000 -G a_group

Adjust parameters as needed:

- -t is topic
- -c is count of test messages

# Performance Testing with the official kafka client image.

## create two test pods

```
kubectl -n controls-kafka run kafka-client-producer --restart='Never' --image docker.io/bitnami/kafka:2.8.0-debian-10-r0 -n controls-kafka --command -- sleep infinity
kubectl -n controls-kafka run kafka-client-consumer --restart='Never' --image docker.io/bitnami/kafka:2.8.0-debian-10-r0 -n controls-kafka --command -- sleep infinity
```

## get a producer prompt and produce some messages
```
kubectl -ti -n controls-kafka exec kafka-client-producer -- bash
```
```
kafka-producer-perf-test.sh --producer-props bootstrap.servers=kafka2:9092 max.request.size=200000000 --topic test3 --throughput -1 --num-records 100 --record-size 1443200
```

## get a consumer prompt and consume some messages
```
kubectl -ti -n controls-kafka exec kafka-client-consumer -- bash
```
```
kafka-consumer-perf-test.sh  --bootstrap-server=kafka2:9092 --timeout 60000 --group test-group --topic test3 --messages 100
```

## delete test pods

To clean up later on ...
```
kubectl delete pod/kafka-client-producer
kubectl delete pod/kafka-client-consumer
```

# Global Config Info

## change max message size for a topic

run this from either of the above client pods
```
kafka-configs.sh --bootstrap-server kafka2:9092  --alter --entity-type topics --entity-name test3 --add-config max.message.bytes=100001000
```

## access the bootstrap server from outside the cluster
cs05r-sc-cloud-19:30016
cs05r-sc-cloud-20:30017
cs05r-sc-cloud-21:30018

Above will get you direct to each of the 3 kafka nodes but the ports are nodeports
so any IP in the cluster would route you their (but I assume with extra overhead
for high traffic - How to address these correctly is to be investigated)
