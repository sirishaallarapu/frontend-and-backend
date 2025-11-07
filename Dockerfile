FROM node:18

WORKDIR /app
COPY . /app

# Install backend dependencies and build frontend
WORKDIR /app/backend
RUN npm install

WORKDIR /app/frontend
RUN npm install
RUN npm run build

# Example: start backend (make sure backend serves built frontend)
WORKDIR /app/backend
EXPOSE 8080
CMD ["npm", "start"]
