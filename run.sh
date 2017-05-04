#!/bin/bash
################################################################
#
#  Author: Ambud Sharma
#
################################################################

set -e

envsubst < /tmp/mirror-maker/producer.config > /etc/mirror-maker/producer.config
envsubst < /tmp/mirror-maker/consumer.config > /etc/mirror-maker/consumer.config
envsubst < /tmp/mirror-maker/kafka_jaas.conf > /etc/mirror-maker/kafka_jaas.conf

if echo "${SECURITY}" | grep -q "SASL" ;then
  echo "Kerberos is enabled, applying security configuration"
  export KAFKA_KERBEROS_PARAMS="-Djava.security.auth.login.config=/etc/mirror-maker/kafka_jaas.conf"
  cat /etc/mirror-maker/kafka_jaas.conf
  ls -lh /etc/security/keytabs
fi

/usr/hdp/current/kafka-broker/bin/kafka-mirror-maker.sh --whitelist ${WHITELIST} --abort.on.send.failure true --new.consumer --producer.config /etc/mirror-maker/producer.config --consumer.config /etc/mirror-maker/consumer.config
