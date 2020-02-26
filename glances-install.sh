#!/usr/bin/env bash

echo "Installing curl..."
yum install -y curl

echo "Installing glances..."
curl -L https://bit.ly/glances | /bin/bash

echo "Installing pip bottle..."
pip install bottle

echo "Configuring glancesweb..."
(
cat <<EOF
[Unit]
Description = Glances in Web Server Mode
After = network.target
[Service]
ExecStart = /usr/bin/glances  -w  -t  5
[Install]
WantedBy = multi-user.target
EOF
) > /etc/systemd/system/glancesweb.service

systemctl enable glancesweb

echo "Starting glancesweb..."
systemctl start glancesweb

echo "=================Glancesweb started================"
