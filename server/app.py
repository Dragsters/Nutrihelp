import urllib
from flask import Flask
from dotenv import load_dotenv
from flask.helpers import url_for

# for heroku
try:
    from api.v1.col import bp_col
    from api.v1.auth import bp_auth
    from api.v1.patient import bp_patients
except:
    from .api.v1.col import bp_col
    from .api.v1.auth import bp_auth
    from .api.v1.patient import bp_patients

load_dotenv()
app = Flask(__name__)

# routes
app.register_blueprint(bp_col)
app.register_blueprint(bp_auth)
app.register_blueprint(bp_patients)


@app.cli.command()
def routes():
    'Display registered routes'
    rules = []
    for rule in app.url_map.iter_rules():
        methods = ','.join(sorted(rule.methods))
        rules.append((rule.endpoint, methods, str(rule)))

    for endpoint, methods, rule in sorted(rules):
        route = '{:50s} {:25s} {}'.format(endpoint, methods, rule)
        print(route)
