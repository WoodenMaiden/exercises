from quart import Quart, jsonify, request, send_from_directory
import asyncio
import os
from motor.motor_asyncio import AsyncIOMotorClient
from pymongo.server_api import ServerApi
from marshmallow import Schema, fields


class Article(object):
    def __init__(self, id, name, description, amount, price):
        self._id = id
        self.name = name
        self.description = description
        self.amount = amount
        self.price = price

    def __repr__(self) -> str:
        return '<Article(id={self._id}, name={self.name!r}, description={self.description!r}, amount={self.amount!r}, price={self.price!r})>'.format(self=self)


uri = os.getenv('MONGO_URI')
client = AsyncIOMotorClient(uri, server_api=ServerApi('1'))

db = client.shop 

if db is None:
    print("No database found!")
    raise Exception("No database found")

if db.articles is None:
    print("No articles collection found!")
    raise Exception("No articles collection found")


app = Quart(__name__)

@app.route("/article", methods=["GET"])
async def get_articles():
    result = []

    async for doc in db.articles.find().sort("name", 1):
        doc["_id"] = str(doc["_id"])
        result.append(doc)

    return jsonify(result)

@app.route("/article/<id>", methods=["GET"])
async def get_article(id):
    doc = await db.articles.find_one({"_id": id})

    if not doc is None:
        doc["_id"] = str(doc["_id"])
        return jsonify(doc) 

    return "", 404

@app.route("/article", methods=["POST"])
async def create_article():
    json = await request.get_json()
    result = await db.articles.insert_one(json)
    return jsonify({ "id": str(result.inserted_id) })


@app.route("/secret")
async def serve_secret():
    return open("./secret", "r").read(), 200 

@app.route("/")
async def index():
    return await send_from_directory('.', "index.html")
