import re
from flask import request, jsonify
import random
from bson.json_util import dumps
from flask.blueprints import Blueprint
from mailer import Mailer, Message

try:
    from config import testcol, EMAIL, MAIL_PASS
except:
    from ...config import testcol, EMAIL, MAIL_PASS


col = testcol
bp_auth = Blueprint('auth', __name__, url_prefix='/auth')


def validate_email(email):
    regex = '^(([^<>()[\\]\\.,;:\\s@\"]+(\\.[^<>()[\\]\\.,;:\\s@\"]+)*)|(\".+\"))@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\])|(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))$'
    if(re.search(regex, email)):
        return True
    return False


@bp_auth.route('', methods=['POST'])
def login():
    data: dict = request.json
    email = data.get('email')
    otp = data.get('otp')
    if email is None:
        return jsonify(ok=False, msg='Email not provided')
    if not validate_email(email):
        return jsonify(ok=False, msg='Invalid Email')

    if otp is None:
        otp = str(random.randint(1234, 9876))
        col.update_one({'email': email},
                       {'$set': {'email': email, 'otp': otp}},
                       upsert=True)
        mail_otp(email, otp)
        return jsonify(ok=True, msg='Check Mail for OTP')

    elif type(otp) == str and len(otp) == 4:
        user = col.find_one({'email': email})
        db_otp = user.get('otp')
        print(db_otp, type(db_otp), otp, '\n\n')
        if db_otp == otp:
            return jsonify(ok=True, msg='login success', userid=str(user.get('_id')))
        else:
            return jsonify(ok=False, msg='Wrong OTP')

    else:
        return jsonify(ok=False, msg='Invalid OTP\nOr\nBad Request')


def mail_otp(email_add, otp):
    msg = Message(From=EMAIL,
                  To=email_add,
                  charset='utf-8')
    msg.Subject = 'Your OTP for Nutrihelp'
    msg.Html = f'''<h3> Welcome to Nutrihelp {email_add}</h3>
                    <br>Your OTP for login is<br>
                    <h1>{otp}</h1>
                '''
    sender = Mailer(host='smtp.gmail.com', usr=EMAIL,
                    pwd=MAIL_PASS, port=587, use_tls=True)

    sender.send(msg)
