FROM dremio/dremio-oss

EXPOSE 9047 31010 45678 32010
ENV DREMIO_JAVA_SERVER_EXTRA_OPTS="-Dpaths.dist=file:///opt/dremio/data/dist"

# Create necessary directories
RUN mkdir -p /opt/dremio/data/dist
WORKDIR /opt/dremio

CMD ["run"]