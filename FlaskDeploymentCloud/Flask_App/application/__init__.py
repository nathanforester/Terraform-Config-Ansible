from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
db = SQLAlchemy(app)

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:root@35.189.100.49/flask_db'
#app.config['SECRET_KEY'] = '123456789'

db = SQLAlchemy(app)

from application import routes
