#!/usr/bin/env bash

if [ "$PIKI_INCLUDE_LIGHTTPD" == "yes" ]
then
    # Add the repos necessary to install php 7.0
    cat <<EOT >> /etc/apt/sources.list
deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi
EOT

    cat <<EOT >> /etc/apt/preferences
Package: *
Pin: release n=jessie
Pin-Priority: 600
EOT

    apt-get update

    DEBIAN_FRONTEND=noninteractive apt-get install -y -t stretch lighttpd php7.0-common php7.0-cgi php7.0 php7.0-opcache php7.0-curl php7.0-common php7.0-cli php7.0-xml php7.0-mbstring
    lighty-enable-mod fastcgi-php
    #service lighttpd force-reload
    chown -R www-data:www-data /var/www/html
    chmod 775 /var/www/html
    usermod -a -G www-data pi
    systemctl enable clear_lighttpd_cache.service
    systemctl enable ssh.socket

    pushd /var/www/html
        #Put git clones in place
        if [ "${PIKI_INCLUDE_DASHBOARD}" == "yes" ]
        then
            gitclone PIKI_DASHBOARD_REPO PikiDashboard
            chown -R pi:pi PikiDashboard
            chown -R www-data:www-data PikiDashboard
            chmod 775 PikiDashboard
            pushd /var/www/html/PikiDashboard
                  php -r "readfile('https://getcomposer.org/installer');" | php
                  # Install App dependencies using Composer
                  ./composer.phar install --no-interaction --no-ansi --optimize-autoloader
            popd
        fi
    popd

    cat <<EOT > /etc/lighttpd/lighttpd.conf
server.modules = (
        "mod_access",
        "mod_alias",
        "mod_compress",
        "mod_redirect",
)

server.document-root        = "/var/www/html/PikiDashboard"
server.upload-dirs          = ( "/var/cache/lighttpd/uploads" )
server.errorlog             = "/var/log/lighttpd/error.log"
server.pid-file             = "/var/run/lighttpd.pid"
server.username             = "www-data"
server.groupname            = "www-data"
server.port                 = 80


index-file.names            = ( "index.php", "index.html", "index.lighttpd.html" )
url.access-deny             = ( "~", ".inc" )
static-file.exclude-extensions = ( ".php", ".pl", ".fcgi" )

compress.cache-dir          = "/var/cache/lighttpd/compress/"
compress.filetype           = ( "application/javascript", "text/css", "text/html", "text/plain" )

# default listening port for IPv6 falls back to the IPv4 port
include_shell "/usr/share/lighttpd/use-ipv6.pl " + server.port
include_shell "/usr/share/lighttpd/create-mime.assign.pl"
include_shell "/usr/share/lighttpd/include-conf-enabled.pl"
EOT

chmod 644 /etc/lighttpd/lighttpd.conf


    echo "enabled" > /boot/check_for_httpd
else
    echo "disabled" > /boot/check_for_httpd
fi
