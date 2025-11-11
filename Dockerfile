# Use Odoo 16 image
FROM odoo:16

USER root
RUN pip3 install twilio

USER odoo
COPY ./addons /mnt/extra-addons

# Start Odoo with your Render database credentials
CMD ["odoo", 
     "-d", "odoo_db_f5y5", 
     "--db_host=dpg-d49kctemcj7s73ehsk30-a", 
     "--db_port=5432", 
     "--db_user=odoo_db_f5y5_user", 
     "--db_password=HMjMgBtwx3Opv4iAJerbwTRGgphvtzqZ", 
     "--http-port=8069", 
     "--addons-path=/mnt/extra-addons"]
