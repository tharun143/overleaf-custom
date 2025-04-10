FROM node:18-slim

# Install system build tools for node-gyp
RUN apt-get update && \
    apt-get install -y git curl python3 make g++ && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Clone Overleaf source
RUN git clone https://github.com/overleaf/overleaf.git . && \
    git checkout main

# Enter the web directory
WORKDIR /app/web

# Install dependencies for the web component
RUN npm install

# Use non-root user for OpenShift compatibility
USER node

# Set default port
ENV PORT=80

# ✅ Start the web server directly
CMD ["node", "server.js"]
