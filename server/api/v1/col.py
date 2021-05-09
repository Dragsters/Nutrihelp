from bson.json_util import dumps
from flask.blueprints import Blueprint, BlueprintSetupState
from flask.wrappers import Response
from flask import jsonify
# for heroku
try:
    from config import testcol, maincol
except:
    from ...config import testcol, maincol

bp_col = Blueprint('col', __name__, url_prefix='/col')


@bp_col.route('/test')
def test():
    res = Response(
        response=dumps(testcol.find()),
        mimetype='application/json')
    return res


@bp_col.route('/main')
def main():
    return Response(response=dumps(maincol.find()),
                    mimetype='application/json')
