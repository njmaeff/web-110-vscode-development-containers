#!/usr/bin/env bash
sudo -E bash /docker/extract-wp.sh
sudo chown vscode:vscode /var/www/html
apache2ctl start
exec "$@"