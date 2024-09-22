# Use node image
FROM node:18-alpine AS build

# Set working directory
WORKDIR /app

# Copy all files to the container
COPY . .

# Install dependencies
RUN npm install

# Build the React app
RUN npm run build

# Use nginx to serve the build
FROM nginx:alpine

# Copy built files from the previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port
EXPOSE 3000

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
