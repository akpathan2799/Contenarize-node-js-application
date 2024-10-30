# ############################################
# # Single Stage Build
# ############################################

# FROM node

# # create working directory app
# WORKDIR /app

# #copy package.json to app
# COPY package.json /app

# # install node package manager
# RUN npm install

# #copy all the files to app directory
# COPY . .

# # Expose the port your app runs on 
# EXPOSE 3000

# # Specify the entry point for the application
# CMD ["npm","run","start"]


#################################################
#  Multi Stage Build
#################################################

# Stage One
FROM node:18 AS builder
WORKDIR /app
COPY package.json package-lock.json /app
RUN npm install && \
    npm install express
  
COPY . .
RUN npm run build

# Stage Two

FROM gcr.io/distroless/nodejs18-debian12
WORKDIR /app
COPY --from=builder /app/dist /app
COPY --from=builder /app/node_modules /app/node_modules
COPY --from=builer /app/views /app/views
EXPOSE 3000
CMD ["index.js"]
