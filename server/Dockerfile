# Use node image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy the server files to the container
COPY . .

# Install dependencies
RUN npm install

# Expose the backend port
EXPOSE 8080

# Start the server
CMD ["node", "server.js"]
