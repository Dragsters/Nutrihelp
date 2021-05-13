from bson.json_util import dumps
from ..app import app
from json import dumps as pretty


class glo:
    patient_id = []


g = glo()

userid = ['1k33224', '60961d77a7090edb5b69c62c']
patient = {
    'name': 'Abhishek shrivastava',
    'age': 19,
    'gender': 'M',
    'mobile': '9022930339'
}

patient2 = {
    'name': 'Avinash',
    'age': 39,
    'gender': 'M',
    'mobile': '2992123212',
    'stats': {
        'bp': 223,
        'glucose': 213,
        'weight': 922
    }
}
data = [{
    'userid': userid[0],
    'patient':patient,
},
    {
    'userid': userid[1],
    'patient':patient,
}]


def pprint(data):
    print(pretty(data, sort_keys=True, indent=4))


def test_add_patient():
    with app.test_client() as client:
        for item in data:
            uri = '/patients'
            res = client.post(uri, json=item)
            pprint(res.json)
            assert res.status_code == 200


def test_get_all_patients():

    with app.test_client() as client:
        for id in userid:
            res = client.get('/patients/'+id)
            pprint(res.json)
            if type(res.json) == list:
                g.patient_id = [(d.get('id')) for d in res.json]
                g.patient_id.append({'$oid': userid[1]})
            assert res.status_code == 200


def test_patient_get():
    with app.test_client() as client:
        for uid in userid:
            for pid in g.patient_id:
                uri = '/patients/' + uid+'/'+pid['$oid']
                res = client.get(uri)
                pprint(res.json)
                assert res.status_code == 200


def test_patient_update():
    with app.test_client() as client:
        for uid in userid:
            for pid in g.patient_id:
                uri = '/patients/'+uid+'/'+pid['$oid']
                res = client.put(uri, json=patient2)
                pprint(res.json)
                assert res.status_code == 200


def test_patient_delete():
    with app.test_client() as client:
        for uid in userid:
            for pid in g.patient_id:
                uri = '/patients/'+uid+'/'+pid['$oid']
                res = client.delete(uri)
                pprint(res.json)
                assert res.status_code == 200


def test_patient_get_after_delete():
    test_patient_get()
