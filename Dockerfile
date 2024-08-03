FROM dremio/dremio-oss

# Expose the necessary ports
EXPOSE 9047 31010 45678 80

ENV DREMIO_WEB_PORT=80

ENV DREMIO_WEB_PORT=80
ENV DREMIO_HOME /opt/dremio
ENV DREMIO_PID_DIR /var/run/dremio
ENV DREMIO_GC_LOGS_ENABLED="yes"
ENV DREMIO_GC_LOG_TO_CONSOLE="yes"
ENV DREMIO_LOG_DIR="/var/log/dremio"

ENTRYPOINT ["bin/dremio", "start-fg"]