from flask import Flask, Response
from flask_pymongo import pymongo
from bson.json_util import dumps

app = Flask(__name__)

client = pymongo.MongoClient(
    "mongodb+srv://ashu:ashu@cluster0.bcxfw.mongodb.net/nutrihelp?retryWrites=true&w=majority")
db = client.get_database('nutrihelp')
nutricol = pymongo.collection.Collection(db, 'nutrihelp')
testcol = pymongo.collection.Collection(db, 'test')


@app.route('/')
def index():
    return "flask runs here- Nutrihelp"


@app.route("/test")
def test():
    cursor = testcol.find()
    list_cur = list(cursor)
    json_data = dumps(list_cur)
    return Response(json_data, mimetype='application/json')
