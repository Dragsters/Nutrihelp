from flask import Flask
from dotenv import load_dotenv

# for heroku
try:
    from api.v1.col import main, test
    from api.v1.auth import login
except:
    from .api.v1.col import main, test
    from .api.v1.auth import login

load_dotenv()
app = Flask(__name__)

# routes

app.route('/test')(test)
app.route('/main')(main)
app.route('/auth', methods=['POST'])(login)
