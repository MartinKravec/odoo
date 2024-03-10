#!/bin/bash
set -e

# Custom startup commands can go here

exec /opt/odoo/odoo-bin -c /opt/odoo/odoo.conf -d odoo -i base

# Start Odoo
# exec /opt/odoo/odoo-bin -c /etc/odoo/odoo.conf
exec /opt/odoo/odoo-bin -c /opt/odoo/odoo.conf
