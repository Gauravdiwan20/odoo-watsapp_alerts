import os
from odoo import models, fields, api
from twilio.rest import Client


class WhatsappAlert(models.Model):
    _name = 'whatsapp.alert'
    _description = 'Send WhatsApp alerts using Twilio'

    name = fields.Char(string="Name", required=True)
    phone = fields.Char(string="WhatsApp Number", required=True)
    message = fields.Text(string="Message", required=True)

    @api.model
    def send_whatsapp_message(self, phone=None, message=None):
        """
        Send a WhatsApp message using Twilio API.
        """
        # 🔒 Load environment variables from Render (set in Render Dashboard)
        account_sid = os.getenv('TWILIO_ACCOUNT_SID')
        auth_token = os.getenv('TWILIO_AUTH_TOKEN')
        from_whatsapp_number = f"whatsapp:{os.getenv('TWILIO_WHATSAPP_NUMBER')}"

        if not all([account_sid, auth_token, from_whatsapp_number]):
            raise ValueError("Twilio credentials are missing. Please check your Render environment variables.")

        # Initialize Twilio client
        client = Client(account_sid, auth_token)

        # Ensure number is in WhatsApp format
        if not phone.startswith('whatsapp:'):
            phone = f'whatsapp:{phone}'

        # Send message
        message_sent = client.messages.create(
            body=message,
            from_=from_whatsapp_number,
            to=phone
        )

        # Log in Odoo chatter
        self.env['mail.message'].create({
            'body': f"✅ WhatsApp message sent to {phone}: {message}",
            'model': self._name,
            'res_id': self.id,
        })

        return message_sent.sid
