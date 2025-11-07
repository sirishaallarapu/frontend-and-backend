FROM node:18
WORKDIR /app
COPY . /app

WORKDIR /app/backend
RUN npm install

WORKDIR /app/frontend
RUN npm install
RUN npm run build

WORKDIR /app/backend
EXPOSE 3001
CMD ["npm", "start"]
