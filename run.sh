#!/bin/bash
################################################################
#
#  Author: Ambud Sharma
#
################################################################

set -eu

envsubst < /tmp/mirror-maker/producer.config > /etc/mirror-maker/producer.config
envsubst < /tmp/mirror-maker/consumer.config > /etc/mirror-maker/consumer.config

/usr/hdp/current/kafka-broker/bin/kafka-mirror-maker.sh --whitelist ${WHITELIST} --abort.on.send.failure false --new.consumer --producer.config /etc/mirror-maker/producer.config --consumer.config /etc/mirror-maker/consumer.config
