from smtplib import SMTP
from datetime import datetime

email = "EMAIL" # replace this 
password = "PASSWORD" # replace this
smtp_client = SMTP("smtp.gmail.com", int(587))
smtp_client.ehlo()
smtp_client.starttls()
smtp_client.login(email, password)
subj = "hello"
date = datetime.now().strftime("%d/%m/%Y %H:%M")

message_text = "Hello\nThis is a mail from your server\n\nBye\n"


smtp_client.sendmail("asiasupport@texadasoftware.com", "amitc005@gmail.com", message_text)
smtp_client.quit()
