# 1. Use the official Dart image with Flutter preinstalled
FROM dartlang/flutter:stable AS builder

# 2. Enable web
RUN flutter config --enable-web

# 3. Set working directory
WORKDIR /app

# 4. Copy source
COPY . .

# 5. Get dependencies
RUN flutter pub get

# 6. Build the web app (with Material Icons kept if needed)
RUN flutter build web --no-tree-shake-icons

# ---------------------------------------------

# 7. Use a minimal web server (Nginx) to serve the app
FROM nginx:alpine

# 8. Copy built web assets from builder
COPY --from=builder /app/build/web /usr/share/nginx/html

# 9. Remove default nginx.conf (optional for customization)
# COPY nginx.conf /etc/nginx/nginx.conf

# 10. Expose port
EXPOSE 80

# 11. Start nginx
CMD ["nginx", "-g", "daemon off;"]
