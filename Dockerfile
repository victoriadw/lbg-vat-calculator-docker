FROM node:20-alpine as build

# change into a folder called /app
WORKDIR /app

# only copy package.json
COPY package*.json /app/

# download the project dependencies
RUN npm install

# copy everything from the react app folder to the /app folder in the container
COPY . .

# package up the react project in the /app directory
RUN npm run build

CMD ["npm", "run", "start"]

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx/nginx.conf /etc/nginx/nginx.conf
CMD ["nginx", "-g", "daemon-off"]
