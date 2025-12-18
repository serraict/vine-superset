# Custom Superset Docker Image

This directory contains a custom Docker image for Apache Superset
that includes all necessary dependencies pre-installed,
eliminating the need to download them on each startup.

This is a drop-in replacement for Apache Superset 5.0.0 used in Serra Vine.

## Features

- Based on Apache Superset 5.0.0
- Pre-installed custom Python dependencies:
  - `trino` - Trino database connector
  - `sqlalchemy_dremio` - Dremio database connector, patched to fix the `datetime[ms]` mapping error
  - `sqlalchemy-firebird` - Firebird database connector
  - `fdb` - Firebird database driver
  - `prometheus-flask-exporter` - Prometheus metrics exporter
  - `pyodbc` - ODBC database connectivity
  - `pymssql` - Microsoft SQL Server connectivity
  - `authlib`, `flask-oidc`, `flask-openid` - OAuth2/OIDC authentication for Authelia integration

- Pre-installed system dependencies:
  - `libfbclient2` - Firebird client library
  - `firebird-utils` - Firebird utilities

## Files

- `Dockerfile` - Custom Docker image definition
- `requirements-local.txt` - Python dependencies to install
- `docker/` - Custom Docker scripts (modified to skip runtime dependency installation)
- `build.sh` - Build script for the Docker image

## Building the Image

1. Make the build script executable:

   ```bash
   chmod +x build.sh
   ```

2. Build the image:

   ```bash
   ./build.sh
   ```

   Or with a version tag:

   ```bash
   ./build.sh v1.0.0
   ```

3. Pull the image:

   ```bash
   docker pull ghcr.io/serraict/vine-superset:latest
   ```

## Running the Services

1. Copy your `.env` file from the original superset directory to this directory.

2. Start the services:

   ```bash
   docker-compose up -d
   ```

## Key Improvements

1. **Faster startup times** - Dependencies are installed during image build, not at runtime
2. **Reduced network usage** - No downloads during container startup
3. **More reliable deployments** - Dependencies are baked into the image
4. **Consistent environments** - Same dependency versions across all deployments

## Migration from Original Setup

To migrate from the original setup:

1. Build this custom image
2. Update your existing docker-compose file to use `ghcr.io/serraict/vine-superset:latest` instead of `apache/superset:4.0.2`

## Production Deployment

For production use:

1. Build and tag the image with a specific version
2. Push to your container registry
3. Update the docker-compose file to use your registry image
4. Deploy using your orchestration platform (Docker Swarm, Kubernetes, etc.)

## Next

- ⏳ update to superset v5.0.0
- add reporting tools to default image
