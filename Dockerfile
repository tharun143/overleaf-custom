FROM node:18-slim

# Install required system packages
RUN apt-get update && \
    apt-get install -y build-essential git python-is-python3 texlive-full ghostscript imagemagick poppler-utils curl && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Clone Overleaf CE
RUN git clone https://github.com/overleaf/overleaf.git . && \
    git checkout main

# Install Overleaf dependencies
RUN npm install

# Set non-root user (OpenShift-safe)
RUN useradd -m appuser
USER appuser

# Environment port
ENV PORT=80

# Start Overleaf
CMD ["npm", "start"]
