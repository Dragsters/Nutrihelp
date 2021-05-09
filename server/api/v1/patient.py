
import bson
from bson.objectid import ObjectId
from flask import json, request, jsonify
from bson.json_util import dumps
from flask.globals import g
from flask.wrappers import Response
from flask.blueprints import Blueprint
from pymongo.collection import ReturnDocument
try:
    from config import testcol
except:
    from ...config import testcol

col = testcol
bp_patients = Blueprint('patient', __name__, url_prefix='/patients')


@bp_patients.route('', methods=['POST'])
def add_patient():
    data: dict = request.json
    data['patient']['id'] = ObjectId()
    ans = ''
    try:
        ans = col.find_one_and_update({'_id': ObjectId(data.pop('userid', None))}, {
            '$push': {'patients': data.get('patient')}})
    except bson.errors.InvalidId as e:
        return jsonify(ok=False, msg=f'invalid userid provided\n\n{e}')
    if ans == None:
        return jsonify(ok=False, msg='user not found')
    return jsonify(ok=True, msg='patient added')


@bp_patients.route('/<userid>', methods=['GET'])
def get_all_patient(userid):
    try:
        data = col.find_one({'_id': ObjectId(userid)},
                            {'_id': 0,
                             'patients.stats': 0,
                             })
    except bson.errors.InvalidId as e:
        return jsonify(ok=False, msg=f'invalid userid provided\n\n{e}')

    if(data == None):
        return jsonify(patients=[])
    return Response(response=dumps(data.get('patients')), mimetype='application/json')


@bp_patients.route('/<userid>/<patientid>', methods=['GET', 'PUT', 'DELETE'])
def patient(userid, patientid):
    try:
        query = {'_id': ObjectId(userid),
                 'patients': {'$elemMatch': {'id': ObjectId(patientid)}}}
    except bson.errors.InvalidId as e:
        return jsonify(ok=False, msg=f'invalid userid provided\n\n{e}')

    if request.method == 'GET':
        data = col.find_one({**query}, {'_id': 0, 'patients.$': 1})
        if data == None:
            return jsonify(ok=False, msg='no such patient found')
        return Response(response=dumps(data['patients']), mimetype='application/json')

    elif request.method == 'DELETE':
        data = col.find_one_and_update({'_id': ObjectId(userid)},
                                       {'$pull': {'patients': {
                                           'id': ObjectId(patientid)}}},
                                       return_document=ReturnDocument.AFTER)
        return jsonify(ok=True, msg='patient deleted')

    elif request.method == 'PUT':
        data = request.json
        update_fields = {}
        for key in data:
            update_fields[f'patients.$.{key}'] = data.get(key)
        data = col.find_one_and_update(
            {**query}, {'$set': {**update_fields}}, return_document=ReturnDocument.AFTER)
        return jsonify(ok=True, msg='patient details updated')


# @ bp_patients.route('/<userid>/delete')
# def delete_all(userid):
#     col.update_one({'_id': ObjectId(userid)}, {'$set': {'patients': []}})
#     data = col.find_one({'_id': ObjectId(userid)})
#     return jsonify(dumps(data))
