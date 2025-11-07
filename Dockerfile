FROM node:18
WORKDIR /app
COPY . /app

# Install backend
WORKDIR /app/backend
RUN npm install

# Build frontend
WORKDIR /app/frontend
RUN npm install
RUN npm run build

# Serve from backend
WORKDIR /app/backend
EXPOSE 3001        # ← CHANGE FROM 8080 TO 3001
CMD ["npm", "start"]
