FROM node:13.8 as build
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH=/app/node_modules/.bin:$PATH
ENV SASS_PATH=/app/node_modules:src

# install and cache app dependencies
COPY package.json /app/package.json

RUN yarn install --ignore-engines
RUN yarn global add react-scripts@3.4.1 --ignore-engines 
RUN npm rebuild node-sass --force

CMD ["npm", "start"]
