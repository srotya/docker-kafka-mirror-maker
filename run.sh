################################################################
#
#  Author: Ambud Sharma
#
################################################################
/usr/hdp/current/kafka-broker/bin/kafka-mirror-maker.sh --whitelist ${WHITELIST} --abort.on.send.failure false --new.consumer --producer.config /etc/mirror-maker/producer.config --consumer.config /etc/mirror-maker/consumer.config
