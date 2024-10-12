FROM node:14

# Set working directory
WORKDIR /usr/src/app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the app
COPY . .

# Expose API port
EXPOSE 3000

# Start the API server
CMD ["node", "server.js"]

