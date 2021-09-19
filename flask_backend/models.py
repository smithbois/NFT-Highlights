from flask import current_app
from backend.factory import db


def create_all_model_db():
    db.create_all()


def drop_all_model_db():
    db.drop_all()


class Streamer(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(256), nullable=False, unique=True)
    public_address = db.Column(db.String(256), nullable=True, unique=True)
    clip_price = db.Column(db.Float, nullable=False, unique=False)

    @classmethod
    def lookup(cls, username):
        return cls.query.filter_by(username=username).first()