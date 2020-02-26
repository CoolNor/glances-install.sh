#!/bin/bash

echo "Installing glances..."
yum install -y glances

echo "Installing pip bottle..."
pip install bottle


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