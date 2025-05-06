# Use Node 20
FROM node:20

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Accept build-time variables for Vite
ARG VITE_API_URL
ARG VITE_NODE_ID

# Inject environment variables into .env file for Vite
RUN echo "VITE_API_URL=$VITE_API_URL" > .env && \
    echo "VITE_NODE_ID=$VITE_NODE_ID" >> .env

# Build the Vite app with env vars available
RUN npm run build

# Expose app port
EXPOSE 5173

# Run Vite preview (for built production site)
CMD ["npm", "run", "preview"]
