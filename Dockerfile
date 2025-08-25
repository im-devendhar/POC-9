# Use a lightweight web server image
FROM nginx:alpine

# Copy the HTML file into the web server's root directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

