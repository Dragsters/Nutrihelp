from bson.json_util import dumps
from flask.wrappers import Response
from flask import jsonify
# for heroku
try:
    from config import testcol, maincol
except:
    from ...config import testcol, maincol


def test():
    res = Response(
        response=dumps(testcol.find()),
        mimetype='application/json')
    return res


def main():
    return Response(response=dumps(maincol.find()),
                    mimetype='application/json')
