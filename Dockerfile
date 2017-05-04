FROM nimmis/java-centos:oracle-8-jre
MAINTAINER Ambud Sharma

ENV WHITELIST *
ENV DESTINATION "localhost:6667"
ENV SOURCE "localhost:6667"
ENV SECURITY "PLAINTEXT"
ENV GROUPID "_mirror_maker"
ENV PRINCIPAL "kafka/localhost@EXAMPLE.COM"
ENV KEYTAB_FILENAME "mirror.keytab"

RUN yum -y install wget
RUN rpm --import http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.5.3.0/RPM-GPG-KEY/RPM-GPG-KEY-Jenkins
RUN cd /etc/yum.repos.d/;wget http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.5.3.0/hdp.repo
RUN yum -y install kafka
RUN yum -y install gettext

RUN mkdir -p /etc/mirror-maker/
RUN mkdir /etc/security/keytabs/
ADD ./consumer.config /tmp/mirror-maker/
ADD ./producer.config /tmp/mirror-maker/
ADD ./kafka_jaas.conf /tmp/mirror-maker/
ADD ./run.sh /etc/mirror-maker/
RUN chmod +x /etc/mirror-maker/run.sh

CMD /etc/mirror-maker/run.sh
