FROM node:18-slim

# Install build tools
RUN apt-get update && \
    apt-get install -y git curl python3 make g++ && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone Overleaf
RUN git clone https://github.com/overleaf/overleaf.git . && \
    git checkout main

WORKDIR /app/web

RUN npm install

USER node

ENV PORT=80

CMD ["npm", "run", "dev"]
