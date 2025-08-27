FROM ghcr.io/cirruslabs/flutter:3.35.2 AS build

WORKDIR /app
COPY . .
WORKDIR /app/app
RUN flutter pub get
RUN flutter build web --release --no-wasm-dry-run --dart-define=PB_URL=$PB_URL

FROM nginx:1.27-alpine AS runtime

RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/app/build/web /usr/share/nginx/html
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]