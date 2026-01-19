FROM node:20.19

WORKDIR /app

# Copy package files first for caching
COPY backend/package*.json ./

# Install dependencies
RUN npm install

COPY .env .

COPY backend/app.js ./backend/

COPY public/ ./public/

# Expose app port
EXPOSE 3000

# Run the app
CMD ["node", "backend/app.js"]

