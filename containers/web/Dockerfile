FROM nginx:latest

# Copy the web files to the nginx directory
COPY dashboard /usr/share/nginx/html
COPY network-config /usr/share/nginx/html
COPY security /usr/share/nginx/html

# Expose the web interface port
EXPOSE 80

