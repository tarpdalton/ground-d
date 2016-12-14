docker run --detach --name neo --publish=7474:7474 \
--publish=7687:7687 --volume=$HOME/neo4j/data:/data neo4j

docker run --detach --name zookeeper jplock/zookeeper:3.4.6

docker run --detach --name kafka --link zookeeper:zookeeper ches/kafka

docker run --detach --name ground --publish 8080:8080 \
--link neo:neo --link kafka:kafka  groundcontext/hive \
/bin/bash -c 'java -jar /tmp/jars/ground-core-0.1-SNAPSHOT.jar server /tmp/jars/config.yml'



docker run --detach \
--link ground:ground \
--link kafka:kafka \
groundcontext/git /bin/ash -c "python parsegitlog.py"



docker run --detach --name schema-registry --publish 8082:8082 \
  --link zookeeper:zookeeper \
  --link kafka:kafka \
  --hostname=schema-registry \
  -e SCHEMA_REGISTRY_KAFKASTORE_CONNECTION_URL=zookeeper:2181 \
  -e SCHEMA_REGISTRY_HOST_NAME=schema-registry \
  -e SCHEMA_REGISTRY_LISTENERS=http://0.0.0.0:8082 \
  confluentinc/cp-schema-registry:3.1.1


docker run --detach \
  --name hdfs \
  --volume=$HOME/github/ground/plugins/ground-ingest:/tmp/ground-ingest \
  --link kafka:kafka \
  --link schema-registry:schema-registry \
  --link ground:ground \
  groundcontext/hdfs



bash -c "clear && docker exec -it hdfs sh"

./bin/run_scheduler.sh

mv conf/jobConf/ground.pull conf/jobConf/zground.pull

./bin/run_scheduler.sh




#kafka login
bash -c "clear && docker exec -it kafka bash"
unset JMX_PORT

#list topics
bin/kafka-topics.sh --zookeeper zookeeper:2181 --list

#listen to topic
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic SampleTopic --from-beginning

#write to topic
bin/kafka-console-producer.sh --broker-list localhost:9092 --topic SampleTopic


#check hdfs
/usr/local/hadoop/bin/hdfs dfs -ls hdfs://0.0.0.0:9000/user/root/input

#test hive
bash -c "clear && docker exec -it kafka bash"
hive -hiveconf hive.root.logger=WARN,console


