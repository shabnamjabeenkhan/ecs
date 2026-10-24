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
USER nginx
COPY nginx.config /etc/nginx/conf.d/default.conf

