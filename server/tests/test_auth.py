from bson.json_util import dumps
from ..app import app
from ..api.v1.auth import mail_otp
data = [{'email': '9922'},
        {'email': 'ejowfffs2.com'},
        {'email': 'lsdi@gmail'},
        {'otp': ''},
        {'otp': None},
        {'otp': 3434},
        {'otp': '23933'},
        {'otp': '2232'},
        {'email': 'ashu1@gmail.com'},
        {'email': 'ashu1@gmail.com',
         'otp': None},
        {'email': 'ashu1@gmail.com',
         'otp': ''},
        {'email': 'ashu1@gmail.com',
         'otp': '29992'},
        {'email': 'ashu1@gmail.com',
         'otp': 29992},
        {'email': 'ashu1@gmail.com',
         'otp': 2992},
        {'email': 'ashu1@gmail.com',
         'otp': '4334'},
        {'email': 'ashu1@gmail.com',
         'otp': '7349'}
        ]


def test_login():
    with app.test_client() as client:
        for d in data:
            res = client.post('/auth', json=d)
            print(res.json)
            assert res.status_code == 200


def test_mail_otp():
    mail_otp('jingles12b@hi2.in', '9934')
