from json import dumps as pretty
from ..app import app


class glo:
    patient_id = []
    userid = ['1k313224', '60961d77a7090edb5b69c62c']
    report_id = []


g = glo()


def pprint(data):
    print(pretty(data, sort_keys=True, indent=4))


def test_get_all_patients():

    with app.test_client() as client:
        for id in g.userid:
            res = client.get('/patients/'+id)
            pprint(res.json)
            if type(res.json) == list:
                g.patient_id = [(d.get('id')) for d in res.json]
                g.patient_id.append({'$oid': g.userid[1]})
            assert res.status_code == 200


def test_diabetes_report():
    with app.test_client() as client:
        for uid in g.userid:
            for pid in g.patient_id:
                uri = 'reports/diabetes/'+uid+'/' + pid['$oid']
                res = client.get(uri)
                pprint(res.json)
                assert res.status_code == 200


def test_get_all_reports():
    with app.test_client() as client:
        for id in g.userid:
            res = client.get('reports/'+id)
            pprint(res.json)
            if type(res.json) == list:
                g.report_id = [(d.get('id')) for d in res.json]
                g.report_id.append({'$oid': g.userid[1]})
            assert res.status_code == 200


def test_get_recent_reports():
    with app.test_client() as client:
        for id in g.userid:
            res = client.get('reports/'+id+'/recent')
            pprint(res.json)
            assert res.status_code == 200


def test_report_get():
    with app.test_client() as client:
        for uid in g.userid:
            for rid in g.report_id:
                uri = 'reports/'+uid+'/'+rid['$oid']
                res = client.get(uri)
                pprint(res.json)
                assert res.status_code == 200


def test_report_delete():
    with app.test_client() as client:
        for uid in g.userid:
            for rid in g.report_id:
                uri = 'reports/'+uid+'/'+rid['$oid']
                res = client.delete(uri)
                pprint(res.json)
                assert res.status_code == 200
