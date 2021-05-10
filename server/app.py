import urllib
from flask import Flask
from dotenv import load_dotenv
from flask.helpers import url_for

# for heroku
try:
    from api.v1.col import bp_col
    from api.v1.auth import bp_auth
    from api.v1.patient import bp_patients
    from api.v1.reports import bp_reports
except:
    from .api.v1.col import bp_col
    from .api.v1.auth import bp_auth
    from .api.v1.patient import bp_patients
    from .api.v1.reports import bp_reports

load_dotenv()
app = Flask(__name__)

# routes blueprint
app.register_blueprint(bp_col)
app.register_blueprint(bp_auth)
app.register_blueprint(bp_patients)
app.register_blueprint(bp_reports)
