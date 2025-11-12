# Use official Odoo 16 image
FROM odoo:16

# Switch to root to install extra Python packages
USER root

# Install Twilio (for WhatsApp alerts)
RUN pip3 install --no-cache-dir twilio

# Switch back to the odoo user
USER odoo

# Copy any custom addons (folder may be empty, that’s OK)
COPY ./addons /mnt/extra-addons

# Start Odoo and connect to your Render PostgreSQL database
CMD odoo -d odoo_db_f5y5 \
    --db_host=dpg-d49kctemcj7s73ehsk30-a \
    --db_port=5432 \
    --db_user=odoo_db_f5y5_user \
    --db_password=HMjMgBtwx3Opv4iAJerbwTRGgphvtzqZ \
    --http-port=8069 \
    --addons-path=/mnt/extra-addons
