# Custom Nginx Docker Image
# Base image: official nginx latest
FROM nginx:latest

# Metadata labels
LABEL maintainer="your-dockerhub-username"
LABEL description="Custom Nginx image for Docker Task 3"
LABEL version="1.0"

# Install curl for healthcheck and useful utilities
RUN apt-get update && \
    apt-get install -y curl vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Remove default nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom nginx configuration
COPY nginx-config/nginx.conf /etc/nginx/nginx.conf
COPY nginx-config/default.conf /etc/nginx/conf.d/default.conf

# Copy custom HTML content
COPY html/ /usr/share/nginx/html/

# Create the volume mount directory inside the container
RUN mkdir -p /var/opt/nginx && \
    chown -R nginx:nginx /var/opt/nginx && \
    chmod -R 755 /var/opt/nginx

# Create log directory for nginx
RUN mkdir -p /var/log/nginx

# Expose port 80 and 443
EXPOSE 80
EXPOSE 443

# Health check to verify nginx is running
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Start nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
