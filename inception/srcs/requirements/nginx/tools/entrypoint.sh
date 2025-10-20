#!/bin/sh
set -eu

# Configuration
readonly CERT_DIR="${CERT_DIR:-/etc/nginx/ssl}"
readonly CRT="${CERT_DIR}/server.crt"
readonly KEY="${CERT_DIR}/server.key"
readonly DOMAIN="${DOMAIN_NAME:-localhost}"
readonly CONF_FILE="/etc/nginx/conf.d/default.conf"

# Generate self-signed SSL certificate
generate_certificate() {
	mkdir -p "$CERT_DIR"

	if [ -f "$CRT" ] && [ -f "$KEY" ]; then
		echo "SSL certificate already exists."
		return 0
	fi

	echo "Generating self-signed SSL certificate for ${DOMAIN}..."
	openssl req -x509 -nodes -newkey rsa:4096 -days 365 \
		-keyout "$KEY" \
		-out "$CRT" \
		-subj "/C=PT/ST=Lisboa/L=Lisboa/O=42Lisboa/OU=Inception/CN=${DOMAIN}" \
		>/dev/null 2>&1

	chmod 600 "$KEY"
	chmod 644 "$CRT"
	echo "✓ SSL certificate generated successfully."
}

# Substitute environment variables in nginx config
configure_nginx() {
	if [ ! -f "$CONF_FILE" ]; then
		echo "[ERROR] Nginx config file not found: ${CONF_FILE}" >&2
		exit 1
	fi

	# Check if substitution is needed
	if grep -q '\${DOMAIN_NAME}' "$CONF_FILE" 2>/dev/null; then
		echo "Configuring nginx for domain: ${DOMAIN}..."
		sed "s/\${DOMAIN_NAME}/${DOMAIN}/g" "$CONF_FILE" > /tmp/nginx.conf
		mv /tmp/nginx.conf "$CONF_FILE"
		echo "✓ Nginx configured successfully."
	fi
}

# Validate nginx configuration
validate_nginx() {
	echo "Validating nginx configuration..."
	if nginx -t 2>&1 | grep -q 'syntax is ok'; then
		echo "✓ Nginx configuration is valid."
		return 0
	else
		echo "[ERROR] Nginx configuration is invalid!" >&2
		nginx -t
		exit 1
	fi
}

# Start nginx
start_nginx() {
	echo "Starting nginx..."
	exec nginx -g 'daemon off;'
}

# Main function
main() {
	generate_certificate
	configure_nginx
	validate_nginx
	start_nginx
}

main "$@"
