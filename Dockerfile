FROM odoo:16

USER root
# Install Twilio library
RUN pip3 install --no-cache-dir twilio

USER odoo
# Copy any extra addons (keep this even if empty)
COPY ./addons /mnt/extra-addons

# Use shell form so environment variables expand if Render provides them.
# Substitute your database credentials directly here for testing.
CMD odoo -d odoo_db_f5y5 \
    --db_host=dpg-d49kctemcj7s73ehsk30-a \
    --db_port=5432 \
    --db_user=odoo_db_f5y5_user \
    --db_password=HMjMgBtwx3Opv4iAJerbwTRGgphvtzqZ \
    --http-port=8069 \
    --addons-path=/mnt/extra-addons
