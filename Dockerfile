#step 1: Build the React App
FROM node:alpine3.18 as build 
WORKDIR /app 
COPY package.json .
RUN npm install 
COPY . . 
RUN npm run build 

#Step2: Serve the react application using Nginx 
FROM nginx:1.23-alpine
WORKDIR /usr/share/mginx/html
RUN rm -rf * 
COPY --from=build /app/build . 
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]

