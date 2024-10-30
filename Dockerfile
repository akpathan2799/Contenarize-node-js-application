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
FROM node AS builder
WORKDIR /app
COPY package.sjon /app
RUN  npm install
COPY . .

# Stage Two

FROM gcr.io/distroless/nodejs18-debian12
WORKDIR /app
COPY --from=builder /app /app
EXPOSE 3000
CMD ["npm","run","start"]
