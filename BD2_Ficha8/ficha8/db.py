from django.conf import settings
from pymongo import MongoClient

_client = MongoClient(settings.MONGO_URI)

def get_db():
    return _client[settings.MONGO_DB_NAME]
