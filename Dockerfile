# Custom Superset Docker Image with Pre-installed Dependencies
# Based on Apache Superset 4.0.2

FROM apache/superset:4.0.2

# Switch to root to install system dependencies
USER root

# Install system dependencies required by custom packages
RUN apt-get update && apt-get install -y \
    libfbclient2 \
    firebird-utils \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file for custom dependencies
COPY requirements-local.txt /app/requirements-local.txt

# Install custom Python dependencies
RUN pip install --no-cache-dir -r /app/requirements-local.txt

# Copy custom Docker scripts
COPY docker/ /app/docker/

# Make scripts executable
RUN chmod +x /app/docker/*.sh

# Create prometheus multiproc directory
RUN mkdir -p /tmp/prometheus_multiproc_dir
ENV PROMETHEUS_MULTIPROC_DIR=/tmp/prometheus_multiproc_dir

# Switch back to superset user for security
USER superset

# Set the default command
CMD ["/app/docker/docker-bootstrap.sh", "app-gunicorn"]
