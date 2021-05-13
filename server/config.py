from pymongo import MongoClient
import os
from dotenv import load_dotenv


load_dotenv()
client = MongoClient(os.environ.get('DB_URI', None))
db = client.nutrihelp
maincol = db.user
testcol = db.test_user
EMAIL = os.environ.get('EMAIL', None)
MAIL_PASS = os.environ.get('MAIL_PASS', None)
