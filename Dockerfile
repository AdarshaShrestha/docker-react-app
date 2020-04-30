#start build phase with node:alpine as base image and name it 'build'
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#start run phase with base image of nginx
FROM nginx

#port mapping
EXPOSE 80

#copy over the build folder from 'build' into the nginx container  
COPY --from=builder /app/build /usr/share/nginx/html