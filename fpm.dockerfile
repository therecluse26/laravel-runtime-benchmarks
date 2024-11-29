FROM serversideup/php:8.2-fpm-nginx

# Switch to root so we can do root things
USER root

ARG USER_ID
ARG GROUP_ID

RUN docker-php-serversideup-set-id www-data $USER_ID:$GROUP_ID && \
    \
    # Update the file permissions for our NGINX service to match the new UID/GID
    docker-php-serversideup-set-file-permissions --owner $USER_ID:$GROUP_ID --service nginx

# Install the sqlite extension with root permissions
RUN install-php-extensions sqlite3 pdo_sqlite

# Drop back to our unprivileged user
USER www-data

