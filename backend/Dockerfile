# Use an official Node.js image
FROM node:18-alpine

# Create app directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy all other files
COPY . .

# Expose backend port
EXPOSE 3000

# Start the app
CMD ["node", "server.js"]
