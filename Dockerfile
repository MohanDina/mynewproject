# # Stage 1: Build the Angular app
# FROM node:20 AS builder

# WORKDIR /usr/src/app

# COPY package*.json ./
# RUN npm install -g @angular/cli
# RUN npm install
# COPY . .
# RUN ng build

# # Stage 2: Serve the Angular app with Nginx
# FROM nginx:alpine

# # Copy built Angular app from the builder stage to Nginx directory
# COPY --from=build /usr/src/app/dist/my-angular-app/browser /usr/share/nginx/html

# EXPOSE 80

# CMD ["nginx", "-g", "daemon off;"]


# FROM node:18
# LABEL maintainer="Naresh <naresh03@gmail.com>"
# RUN echo " Try to build my application"
# WORKDIR /app
# COPY package.json package-lock.json ./
# RUN npm install
# EXPOSE 3000
# ENTRYPOINT ["npm","start"]

# Use an official Node.js runtime as a parent image
FROM node:20 AS build

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install Angular CLI globally
RUN npm install -g @angular/cli

# Install dependencies
RUN npm install

# Copy the remaining application code to the working directory
COPY . .

# Build the Angular app for production
RUN ng build

# Use Nginx as the base image for serving content
FROM nginx:alpine

# Copy the built Angular app from the previous stage to the NGINX HTML directory
COPY --from=build /usr/src/app/dist/my-angular-app/browser /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start NGINX server when the container starts
CMD ["nginx", "-g", "daemon off;"]
