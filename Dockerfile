FROM nimmis/java-centos:oracle-8-jre
MAINTAINER Ambud Sharma

ENV WHITELIST *

RUN yum -y install wget
RUN rpm --import http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.5.3.0/RPM-GPG-KEY/RPM-GPG-KEY-Jenkins
RUN cd /etc/yum.repos.d/;wget http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.5.3.0/hdp.repo
RUN yum -y install kafka

RUN mkdir -p /etc/mirror-maker/
ADD ./consumer.config /etc/mirror-maker/
ADD ./producer.config /etc/mirror-maker/
ADD ./run.sh /etc/mirror-maker/
RUN chmod +x /etc/mirror-maker/run.sh

CMD /etc/mirror-maker/run.sh
