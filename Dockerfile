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

# ✅ OpenShift-compatible permissions fix
RUN chgrp -R 0 /app && chmod -R g=u /app

# Default port
ENV PORT=80

# No USER statement — OpenShift will assign random UID
CMD ["node", "server.js"]
