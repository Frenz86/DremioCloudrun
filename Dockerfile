FROM dremio/dremio-oss:latest

# Set the platform
FROM --platform=linux/x86_64

# Expose the necessary ports
EXPOSE 80 31010 32010 45678
ENV DREMIO_WEB_PORT=80
ENV DREMIO_JAVA_SERVER_EXTRA_OPTS="-Dpaths.dist=file:///opt/dremio/data/dist"

# Create necessary directories
RUN mkdir -p /opt/dremio/data/dist

# Set the working directory
WORKDIR /opt/dremio

# The entrypoint is already set in the base image, but we can override it if needed
# ENTRYPOINT ["./bin/dremio-server"]

CMD ["run"]