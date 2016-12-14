FROM openjdk:alpine
MAINTAINER James Dalton <tarpdalton@gmail.com>

# update and install basic tools
RUN apk add --update net-tools curl gnupg tar bash perl openssh \
  && rm -rf /var/cache/apk/*



# Versions
ENV HADOOP_VERSION 2.7.3
ENV HADOOP_URL https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

ENV HIVE_VERSION 2.1.1
ENV HIVE_URL http://apache.claz.org/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz


# Create Directories
RUN mkdir -p /usr/local/hadoop/logs
RUN mkdir /hadoop-data
RUN mkdir /usr/local/hive
RUN mkdir -p /tmp/jars


# Install Hadoop
RUN curl -s "$HADOOP_URL" | tar -xz -C /usr/local/hadoop --strip-components 1
RUN ln -s /usr/local/hadoop/etc/hadoop /etc/hadoop
RUN cp /etc/hadoop/mapred-site.xml.template /etc/hadoop/mapred-site.xml


# Environmental variables
ENV HADOOP_PREFIX=/usr/local/hadoop
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV USER=root
ENV PATH $HADOOP_PREFIX/bin/:$PATH
ENV HADOOP_HOME $HADOOP_PREFIX
ENV HADOOP_INSTALL $HADOOP_HOME
ENV PATH $PATH:$HADOOP_INSTALL/sbin
ENV HADOOP_MAPRED_HOME $HADOOP_INSTALL
ENV HADOOP_COMMON_HOME $HADOOP_INSTALL
ENV HADOOP_HDFS_HOME $HADOOP_INSTALL
ENV YARN_HOME $HADOOP_INSTALL
ENV PATH $HADOOP_HOME/bin:$PATH
ENV HIVE_HOME /usr/local/hive
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $HIVE_HOME/bin:$PATH

ENV HIVE_OPTS '--hiveconf mapred.job.tracker=local --hiveconf fs.default.name=file:///tmp'
ENV HIVE_AUX_JARS_PATH /tmp/jars

# install hive
RUN curl -s "$HIVE_URL" | tar -xz -C /usr/local/hive --strip-components 1

# Add ground jars and config
ADD ground-hive-plugin-0.1-SNAPSHOT.jar /tmp/jars
ADD ground-core-0.1-SNAPSHOT.jar /tmp/jars
ADD config.yml /tmp/jars
ADD hive-site.xml $HIVE_HOME/conf

WORKDIR /usr/local/hive

