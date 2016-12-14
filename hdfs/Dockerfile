FROM sequenceiq/hadoop-docker
MAINTAINER James Dalton <tarpdalton@gmail.com>

# update and install basic tools
#RUN yum update
RUN yum install -y java-1.8.0-openjdk
ENV GOBBLIN_JOB_CONFIG_DIR=/opt/ground-ingest/ground-ingest-plugin-0.1-SNAPSHOT/conf/jobConf
ENV GOBBLIN_WORK_DIR=/opt/ground-ingest
ENV HADOOP_HOME=/usr/local/hadoop
ENV JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk.x86_64
ENV PATH=/usr/local/hadoop/bin/:$PATH
