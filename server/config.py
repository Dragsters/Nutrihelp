from pymongo import MongoClient
import os
from dotenv import load_dotenv


load_dotenv()
client = MongoClient(os.environ.get('DB_URI', None))
db = client.nutrihelp
maincol = db.main
testcol = db.test
EMAIL = os.environ.get('EMAIL', None)
MAIL_PASS = os.environ.get('MAIL_PASS', None)
