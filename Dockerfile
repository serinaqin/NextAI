# Step 1: Build the React app
FROM node:18-alpine AS build

# Set working directory
WORKDIR /app

# Copy all project files
COPY . .

# Install dependencies
RUN npm install

# Build the React app
RUN npm run build

# Step 2: Serve the app using a simple static file server
FROM node:18-alpine

# Install 'serve' to serve the app
RUN npm install -g serve

# Copy the built files from the build stage
COPY --from=build /app/build /app

# Use the PORT environment variable provided by Cloud Run
ENV PORT 8080

# Expose the port Cloud Run will use
EXPOSE 8080

# Start the app using 'serve'
CMD ["serve", "-s", "/app", "-l", "8080"]
