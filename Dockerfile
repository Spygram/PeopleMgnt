FROM node:20.19

WORKDIR /app

COPY backend/package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "backend/index.js"]
