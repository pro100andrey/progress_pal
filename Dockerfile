FROM ghcr.io/cirruslabs/flutter:3.35.5 AS build


ARG PB_URL
ENV PB_URL=${PB_URL}

WORKDIR /app
COPY . .
WORKDIR /app/app
RUN flutter pub get

RUN flutter build web --release --no-wasm-dry-run --no-tree-shake-icons --dart-define=PB_URL=$PB_URL

FROM nginx:1.29-alpine AS runtime

RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/app/build/web /usr/share/nginx/html
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]