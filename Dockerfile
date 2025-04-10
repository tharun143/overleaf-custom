FROM node:18-slim

# Install build tools for native modules
RUN apt-get update && \
    apt-get install -y git curl python3 make g++ && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Clone the Overleaf repo
RUN git clone https://github.com/overleaf/overleaf.git . && \
    git checkout main

# Move into web app directory
WORKDIR /app/web

# Install Overleaf web dependencies
RUN npm install

# Use non-root user for OpenShift compatibility
USER node

# Expose port
ENV PORT=80

# Start Overleaf web
CMD ["npm", "run", "start"]
