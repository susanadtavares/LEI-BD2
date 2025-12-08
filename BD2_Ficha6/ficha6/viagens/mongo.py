import pymongo
from pymongo import ReturnDocument

# ligação ao MongoDB local 
conexaomongo = pymongo.MongoClient("mongodb://localhost:27017/")["ficha6"]

# cria uma sequência numérica para gerar IDs automáticos
def nextval(nome):
    seq_doc = conexaomongo.sequencias.find_one_and_update(
        {"_id": nome},
        {"$inc": {"seq": 1}},
        upsert=True,
        return_document=ReturnDocument.AFTER
    )
    return seq_doc["seq"]

# insere um documento na coleção indicada
def insere_doc(colecao, campos, valores):
    campos = ["_id"] + list(campos)
    valores = [nextval(colecao)] + list(valores)
    doc = dict(zip(campos, valores))
    conexaomongo[colecao].insert_one(doc)
    return doc["_id"]
