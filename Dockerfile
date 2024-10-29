FROM node

# create working directory app
WORKDIR /app

#copy package.json to app
COPY package.json

# install node package manager
RUN npm install

#copy all the files to app directory
COPY . .

# Expose the port your app runs on 
EXPOSE 3000

# Specify the entry point for the application
CMD ["node","app.js"]
