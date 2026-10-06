FROM nginx:alpine

LABEL org.opencontainers.image.title="Nexvion"
LABEL org.opencontainers.image.description="Nexvion static e-commerce frontend"

COPY nginx/default.conf /etc/nginx/conf.d/default.conf

COPY index.html products.html payment.html /usr/share/nginx/html/nexvion/
COPY script.js payment.js /usr/share/nginx/html/nexvion/
COPY style.css products.css payment.css /usr/share/nginx/html/nexvion/
COPY logo.png /usr/share/nginx/html/nexvion/

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
