# from ..app import app, default_config
# import json


# def test_app():
#     app.config.update(default_config)
#     with app.test_client() as client:
#         res = client.get('/')
#         print(res.data)
#         res = json.loads(res.data)
#         assert res['result'] == []
