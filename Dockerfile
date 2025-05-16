# 1. Use official Flutter image from GitHub Container Registry
FROM ghcr.io/cirruslabs/flutter:latest AS builder

# 2. Enable Flutter web support
RUN flutter config --enable-web

# 3. Set working directory
WORKDIR /app

# 4. Copy project files
COPY . .

# 5. Get dependencies
RUN flutter pub get

# 6. Build web app (retain Material Icons if needed)
RUN flutter build web --no-tree-shake-icons

# ----------------------------------

# 7. Serve app with Nginx
FROM nginx:alpine

# 8. Copy build output from Flutter builder
COPY --from=builder /app/build/web /usr/share/nginx/html

# 9. Expose port 80
EXPOSE 80

# 10. Start Nginx
CMD ["nginx", "-g", "daemon off;"]
