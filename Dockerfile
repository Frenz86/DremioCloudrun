ARG JAVA_IMAGE="eclipse-temurin:11-jdk"
FROM ${JAVA_IMAGE} as base

LABEL maintainer=Dremio

ARG DOWNLOAD_URL

RUN set -ex; \
    apt-get update && \
    apt-get install -y --no-install-recommends wget ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /opt/dremio /var/lib/dremio /var/run/dremio /var/log/dremio /opt/dremio/data && \
    groupadd --system dremio && \
    useradd --base-dir /var/lib/dremio --system --gid dremio dremio && \
    chown -R dremio:dremio /opt/dremio/data /var/run/dremio /var/log/dremio /var/lib/dremio && \
    if [ -z "$DOWNLOAD_URL" ]; then \
        echo "DOWNLOAD_URL is not set" && exit 1; \
    fi && \
    wget -q "$DOWNLOAD_URL" -O dremio.tar.gz && \
    tar vxfz dremio.tar.gz -C /opt/dremio --strip-components=1 && \
    rm -rf dremio.tar.gz

    
EXPOSE 80
#EXPOSE 9047/tcp
EXPOSE 31010/tcp
EXPOSE 32010/tcp
EXPOSE 45678/tcp

USER dremio
WORKDIR /opt/dremio

ENV DREMIO_WEB_PORT=80
ENV DREMIO_HOME /opt/dremio
ENV DREMIO_PID_DIR /var/run/dremio
ENV DREMIO_GC_LOGS_ENABLED="yes"
ENV DREMIO_GC_LOG_TO_CONSOLE="yes"
ENV DREMIO_LOG_DIR="/var/log/dremio"

ENTRYPOINT ["bin/dremio", "start-fg"]