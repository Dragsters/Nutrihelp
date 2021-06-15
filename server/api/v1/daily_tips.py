from flask import jsonify
from flask.blueprints import Blueprint
from bs4 import BeautifulSoup

import random
import requests


def web_scrapping():
    url = "https://www.highonsms.com/tips-sms/health-tips-sms"

    req = requests.get(url)
    beautiful_soup_object = BeautifulSoup(req.text, "html.parser")
    data = beautiful_soup_object.find_all("div", class_="entry-content blockquote-4")
    return data


bp_daily_tips = Blueprint('daily_tips', __name__, url_prefix='/daily_tips')


@bp_daily_tips.route("", methods=["Get"])
def get_tip():
    tips = web_scrapping()
    tip_of_day = tips[random.randint(1, len(tips))].text.strip()
    return jsonify(ok=True, msg=tip_of_day)
