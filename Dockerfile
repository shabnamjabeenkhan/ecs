# Stage One
FROM node:20-alpine AS builder
WORKDIR /app
COPY . .
RUN yarn install
RUN yarn build


# Stage Two
FROM nginx:1.30.3-alpine
COPY --from=builder /app/build /usr/share/nginx/html
RUN chown -R nginx:nginx /var/cache/nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN chown nginx:nginx /run
USER nginx
EXPOSE 8080

