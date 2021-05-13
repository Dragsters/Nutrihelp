import bson
from bson.objectid import ObjectId
from flask import request, jsonify
from bson.json_util import dumps
from flask.wrappers import Response
from flask.blueprints import Blueprint
from pymongo.collection import ReturnDocument
import requests
try:
    from ML.predict.diabetes_predict import Diabetes
    from config import testcol
except:
    from ...ML.predict.diabetes_predict import Diabetes
    from ...config import testcol

col = testcol
bp_reports = Blueprint('report', __name__, url_prefix='/reports')


@bp_reports.route('/diabetes/<userid>/<patientid>')
def diabetes_report(userid, patientid):
    res = requests.get(
        url='https://nutrihelpb.herokuapp.com/patients/'+userid+'/'+patientid)
    print(res)
    patient = res.json()
    print(patient)
    if(patient.get('ok') != None):
        return jsonify(msg='no such patient found', ok=False)
    report = dict(patient_id=patient['id']
                  ['$oid'], patient_name=patient['name'])
    report['id'] = ObjectId()
    report['type'] = 'diabetes'
    report['probability'] = Diabetes(patient=patient).probability()

    try:
        col.find_one_and_update({'_id': ObjectId(userid)},
                                {'$push': {'reports': report}})
    except bson.errors.InvalidId as e:
        return jsonify(ok=False, msg=f'invalid userid provided\n\n{e}')
    return Response(response=dumps(report), mimetype='application/json')


@bp_reports.route('/<userid>')
def get_all_reports(userid):
    try:
        data = col.find_one({'_id': ObjectId(userid)},
                            {'_id': 0,
                             'patients': 0,
                             'reports.tips': 0,
                             })
    except bson.errors.InvalidId as e:
        return jsonify(ok=False, msg=f'invalid userid provided\n\n{e}')

    if(data == None):
        return jsonify(reports=[])
    return Response(response=dumps(data.get('reports')), mimetype='application/json')


@bp_reports.route('/<userid>/recent')
def get_recent_reports(userid):
    try:
        data = col.find({'_id': ObjectId(userid)},
                        {'_id': 0,
                         'patients': 0,
                         'reports.tips': 0}, limit=5).sort([('reports.id', -1)])
    except bson.errors.InvalidId as e:
        return jsonify(ok=False, msg=f'invalid userid provided\n\n{e}')

    if(data == None):
        return jsonify(reports=[])
    return Response(response=dumps(data[0].get('reports')), mimetype='application/json')


@bp_reports.route('/<userid>/<reportid>', methods=['GET', 'DELETE'])
def report(userid, reportid):
    try:
        query = {'_id': ObjectId(userid),
                 'reports': {'$elemMatch': {'id': ObjectId(reportid)}}}
    except bson.errors.InvalidId as e:
        return jsonify(ok=False, msg=f'invalid userid provided\n\n{e}')

    if request.method == 'GET':
        data = col.find_one({**query}, {'_id': 0, 'reports.$': 1})
        if data == None:
            return jsonify(ok=False, msg='no such report found')
        return Response(response=dumps(data['reports'][0]), mimetype='application/json')

    elif request.method == 'DELETE':
        data = col.find_one_and_update({'_id': ObjectId(userid)},
                                       {'$pull': {'reports': {
                                           'id': ObjectId(reportid)}}},
                                       return_document=ReturnDocument.AFTER)
        if data == None:
            return jsonify(ok=False, msg='no such report found')
        return jsonify(ok=True, msg='report deleted')
