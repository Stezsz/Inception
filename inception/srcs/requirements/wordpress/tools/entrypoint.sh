#!/bin/sh
set -eu

# Expected environment variables (from .env)
# MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD
# WP_URL, WP_TITLE, WP_ADMIN_USER, WP_ADMIN_PASSWORD, WP_ADMIN_EMAIL
# Optional: WP_USER, WP_USER_EMAIL, WP_USER_PASSWORD

readonly WP_PATH="${WP_PATH:-/var/www/html}"
readonly DB_HOST="${DB_HOST:-mariadb}"
readonly WP_CLI_CACHE_DIR="/tmp/wp-cli-cache"
export WP_CLI_CACHE_DIR

# Wait for database connection
wait_for_db() {
	local tries=30
	local i=1

	echo "Waiting for database at ${DB_HOST}..."
	while [ "$i" -le "$tries" ]; do
		if mariadb -h"${DB_HOST}" -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -e 'SELECT 1' >/dev/null 2>&1; then
			echo "Database is ready."
			return 0
		fi
		sleep 2
		i=$((i + 1))
	done

	echo "Database not ready after ${tries} tries" >&2
	return 1
}

# Ensure WordPress is downloaded and configured
ensure_wp() {
	mkdir -p "$WP_PATH" "$WP_CLI_CACHE_DIR"
	cd "$WP_PATH"

	if [ ! -f wp-config.php ]; then
		echo "Downloading WordPress..."
		wp core download --allow-root --path="$WP_PATH"

		echo "Generating wp-config.php..."
		wp config create \
			--allow-root \
			--dbname="$MYSQL_DATABASE" \
			--dbuser="$MYSQL_USER" \
			--dbpass="$MYSQL_PASSWORD" \
			--dbhost="$DB_HOST" \
			--path="$WP_PATH"
	fi
}

# Install WordPress
install_wp() {
	wp core is-installed --allow-root --path="$WP_PATH" 2>/dev/null && return 0

	local url="${WP_URL:-}"
	local title="${WP_TITLE:-Inception WP}"
	local admin="${WP_ADMIN_USER:-}"
	local admin_pass="${WP_ADMIN_PASSWORD:-}"
	local admin_email="${WP_ADMIN_EMAIL:-admin@example.com}"

	# Validate WP_URL (required and must be HTTPS)
	[ -z "$url" ] && {
		echo "[ERROR] WP_URL is not set. Set WP_URL to an https:// domain." >&2
		exit 2
	}

	case "$url" in
		https://*)
			;;
		*)
			echo "[ERROR] WP_URL must start with https:// (value: $url)" >&2
			exit 2
			;;
	esac

	# Validate admin username (required and cannot contain 'admin')
	[ -z "$admin" ] && {
		echo "[ERROR] WP_ADMIN_USER is not set. Set WP_ADMIN_USER to a valid username." >&2
		exit 2
	}

	printf '%s' "$admin" | grep -iq 'admin' && {
		echo "[ERROR] Admin username '$admin' is invalid (contains 'admin'). Set WP_ADMIN_USER to a compliant value." >&2
		exit 2
	}

	# Validate admin password (required)
	[ -z "$admin_pass" ] && {
		echo "[ERROR] WP_ADMIN_PASSWORD is not set." >&2
		exit 2
	}

	echo "Installing WordPress site..."
	wp core install --allow-root \
		--url="$url" \
		--title="$title" \
		--admin_user="$admin" \
		--admin_password="$admin_pass" \
		--admin_email="$admin_email" \
		--path="$WP_PATH"

	# Create additional user (optional)
	if [ -n "${WP_USER:-}" ] && [ -n "${WP_USER_PASSWORD:-}" ]; then
		wp user create "$WP_USER" "${WP_USER_EMAIL:-user@example.com}" \
			--role=author \
			--user_pass="$WP_USER_PASSWORD" \
			--allow-root 2>/dev/null || true
	fi
}

# Start PHP-FPM
start_php_fpm() {
	echo "Starting PHP-FPM..."

	for php_bin in php-fpm php-fpm8.2 php-fpm8.1 php-fpm7.4; do
		if command -v "$php_bin" >/dev/null 2>&1; then
			exec "$php_bin" -F
		fi
	done

	echo "php-fpm binary not found" >&2
	exit 1
}

# Main function
main() {
	wait_for_db
	ensure_wp
	install_wp
	start_php_fpm
}

main "$@"
