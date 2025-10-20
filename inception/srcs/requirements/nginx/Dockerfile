FROM debian:12

# Environment variables
ENV DEBIAN_FRONTEND=noninteractive \
	CERT_DIR=/etc/nginx/ssl

# Install nginx and openssl
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		nginx \
		openssl \
		gettext-base \
	&& rm -rf /var/lib/apt/lists/*

# Setup directories and remove default configs
RUN rm -f /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default \
	&& mkdir -p /etc/nginx/conf.d ${CERT_DIR} /run/nginx /var/www/html \
	&& chown -R www-data:www-data /var/www/html

# Copy nginx configuration and entrypoint
COPY conf/default.config /etc/nginx/conf.d/default.conf
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose HTTPS port only (443)
EXPOSE 443

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
	CMD nginx -t || exit 1

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
