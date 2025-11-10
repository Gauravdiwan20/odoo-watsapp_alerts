# Use official Odoo 16 image
FROM odoo:16.0

# Set environment variables
ENV TWILIO_ACCOUNT_SID=$TWILIO_ACCOUNT_SID
ENV TWILIO_AUTH_TOKEN=$TWILIO_AUTH_TOKEN
ENV TWILIO_WHATSAPP_FROM=$TWILIO_WHATSAPP_FROM

# Install Python dependencies (Twilio SDK)
USER root
RUN pip3 install twilio

# Copy custom addons (if any)
COPY ./addons /mnt/extra-addons

# Expose Odoo default port
EXPOSE 8069

# Start Odoo
CMD ["odoo", "-d", "odoo", "--addons-path=/mnt/extra-addons", "--http-port=8069", "--without-demo=all"]
