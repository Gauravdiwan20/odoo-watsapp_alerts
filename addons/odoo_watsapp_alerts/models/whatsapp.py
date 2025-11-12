from odoo import models, fields, api
from twilio.rest import Client

class WhatsAppAlert(models.Model):
    _name = 'whatsapp.alert'
    _description = 'Send WhatsApp Alert using Twilio'

    name = fields.Char(string='Message')
    phone_number = fields.Char(string='Phone Number')

    def send_whatsapp_message(self):
        account_sid = "your_twilio_sid"
        auth_token = "your_twilio_auth_token"
        client = Client(account_sid, auth_token)
        message = client.messages.create(
            from_='whatsapp:+14155238886',  # Twilio Sandbox number
            body=self.name,
            to=f'whatsapp:{self.phone_number}'
        )
        return message.sid
