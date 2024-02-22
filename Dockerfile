# Stage 1: Build the Angular app
FROM node:18 AS builder

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve the Angular app with Nginx
FROM nginx:alpine

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy built Angular app from the builder stage to Nginx directory
COPY --from=builder /usr/src/app/dist/my-angular-app/browser /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]


# FROM node:18
# LABEL maintainer="Naresh <naresh03@gmail.com>"
# RUN echo " Try to build my application"
# WORKDIR /app
# COPY package.json package-lock.json ./
# RUN npm install
# EXPOSE 3000
# ENTRYPOINT ["npm","start"]
