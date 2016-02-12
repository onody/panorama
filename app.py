#coding:utf-8
from flask import Flask
from views import main, pie

application = Flask(__name__)

modules_define = [main.app, pie.app]
for app in modules_define:
	application.register_blueprint(app)

if __name__ == '__main__':
	application.run(host='127.0.0.1', port=5000, debug=True)
