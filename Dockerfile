FROM node:18-slim

# Install dependencies
RUN apt-get update && \
    apt-get install -y git curl && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Clone the Overleaf repo
RUN git clone https://github.com/overleaf/overleaf.git . && \
    git checkout main

# Move into the web component
WORKDIR /app/web

# Install only the web app dependencies
RUN npm install

# Use a safe user for OpenShift
USER node

# Expose expected port
ENV PORT=80

# Run Overleaf web service
CMD ["npm", "run", "start"]
