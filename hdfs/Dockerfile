FROM sequenceiq/hadoop-docker
MAINTAINER James Dalton <tarpdalton@gmail.com>

RUN (yum install -y java-1.8.0-openjdk || true)

WORKDIR /opt/ground-ingest/ground-ingest-plugin-0.1-SNAPSHOT/

ADD ground-ingest-plugin-0.1-SNAPSHOT /opt/ground-ingest/ground-ingest-plugin-0.1-SNAPSHOT/

ENV GOBBLIN_JOB_CONFIG_DIR=/opt/ground-ingest/ground-ingest-plugin-0.1-SNAPSHOT/conf/jobConf
ENV GOBBLIN_WORK_DIR=/opt/ground-ingest
ENV HADOOP_HOME=/usr/local/hadoop
ENV JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk.x86_64
