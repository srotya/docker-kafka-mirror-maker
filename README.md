# docker-kafka-mirror-maker

An HDP 2.5.3 based Docker image for Kafka Mirror Maker. This allows configuration and deployment of Kafka Mirror-Maker in Dockerized environments like Kubernetes/Openshift or AWS ECS.

### Build
This image is available from Docker hub however, if you would like to build it yourself here are the steps:

```
git clone https://github.com/srotya/docker-kafka-mirror-maker.git
cd docker-kafka-mirror-maker
docker build -t mirror-maker:latest .
```

**Note: Docker is expected to be installed where you run the build**

### Environment Variables
|    Variable Name    |                   Description                |   Defaults |
|---------------------|----------------------------------------------|------------|
|    DESTINATION      | bootstrap.servers for the Destination Kafka Cluster |localhost:6667|
|      SOURCE         | bootstrap.servers for the Source Kafka Cluster |localhost:6667|
|     WHITELIST       | Topics to mirror     | * |
|     SECURITY        | If kerberos is enabled, valid options: PLAINTEXT or SASL_PLAINTEXT | PLAINTEXT |
|     GROUPID         | Consumer group id for Kafka consumer | _mirror_maker |
|    PRINCIPAL        | Kerberos security principal name | kafka/localhost@EXAMPLE.COM |
|  KEYTAB_FILENAME    | File name for Kerberos Keytab | mirror.keytab |

### Volumes
Image requires that the keytab file and krb5.conf be mounted if Kerberos is used when deploying this container.

Keytab files are expected in ```/etc/security/keytabs``` location

Krb5.conf file is expected in ```/etc/krb5.conf``` location

#### Non-Kerberized Usage
```
docker run -it -e DESTINATION=xxx.xxx.com:9092 -e SOURCE=xxx.xxx.com:9092 -e WHITELIST=<TOPIC NAME> mirror-maker:latest
```

#### Kerberized Usage
```
docker run -it -e DESTINATION=xxx.xxx.com:6667 -e SECURITY=SASL_PLAINTEXT -e SOURCE=xxx.xxx.com:6667 -e WHITELIST=<TOPIC NAME> -e KEYTAB_FILENAME=kafka.service.keytab -e PRINCIPAL=kafka/xxx.xxx.com@EXAMPLE.COM -v /etc/security/keytabs/:/etc/security/keytabs/ -v /etc/krb5.conf:/etc/krb5.conf mirror-maker:latest
```

**Note: the image automatically applies Kerberos runtime configuration for Mirror Maker if SASL_PLAINTEXT security is configured**
