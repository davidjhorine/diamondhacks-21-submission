from flask import Flask, render_template, redirect, request, jsonify, make_response
import json
import base64
from werkzeug.security import generate_password_hash, check_password_hash
from flask_pymongo import PyMongo
from bson.objectid import ObjectId



app = Flask(__name__)

app.config["MONGO_URI"] = "mongodb://localhost:27017/users"
mongo = PyMongo(app)
collection_users = mongo.db['users']
collection_data = mongo.db['data']
collection_competitors = mongo.db['competitors']

app.secret_key = b'&t4@Q' # This is not an API key leak, it is just a temporary thing we use to run the backend, in production it will be moved to a .env

def makeToken(username, password):
    # Get the hashes for the passwords
    firstHash = password
    secondHash = generate_password_hash(firstHash, "sha256")

    # Encode the username into Base64
    encodedUserB = base64.b64encode(username.encode("utf-8"))
    encodedUserS = str(encodedUserB, "utf-8")
    token = secondHash + "." + encodedUserS
    return token

hashpass = None

# Register route
@app.route('/user/create', methods=['POST'])
def register():    
    global hashpass
    request.get_data()
    reqdict = json.loads(request.data.decode('utf-8'))
    token = makeToken(reqdict['username'], reqdict['password'])
    print(f"Your token is {token}")
    mongo.db.users.insert_one({
        'username':reqdict['username'], 
        'password':(reqdict['password']),
        'token':token
        })
    mongo.db.competitors.insert_one({ 
        'parentToken':token
        })
    return jsonify({
        'username':reqdict['username'],
        'token':token
        })


# USER / AUTH API Requests
# These are requests that retain directly to administering users

# Login 
@app.route('/auth/login', methods = ['GET', 'POST'])
def login():
    global hashpass
    request.get_data()
    reqdict = json.loads(request.data.decode('utf-8'))
    username = reqdict['username']
    users = collection_users.find_one({"username":username})
    print(reqdict['username'])
    print(users['username'])
    print(hashpass)
    print(users['password'])
    if reqdict['username'] == users['username'] and reqdict['password'] == users['password']:
        try:
            username = users['username']
            password = users['password']
            token = makeToken(username, password)
            filter = { 'username': username }
            newValues = { "$set": {"token": token }}

            collection = mongo.db.users
            
            collection.update_one(filter, newValues)
            cursor = collection.find()
            for record in cursor:
                print(record)
            print("Token added successfully")
            return make_response(jsonify({'token': token}), 200)
        except:
            print(f'An Error has occurred when logging in')
            return make_response(jsonify({"reason": "An Unknown error has occurred"}), 403)
        else:
            print("login successful")

    return make_response(jsonify({"reason": "Forbidden"}), 403)

# Change Password for authed user
@app.route('/auth/setPassword', methods=['POST'])
def api_setPassword():
    request.get_data()
    reqdict = json.loads(request.data.decode('utf-8'))
    token = reqdict['token']
    users = mongo.db.users.find_one({"token":token})
    print(users)
    try:
        if users['password'] == reqdict['oldPassword']:
            newPass = { "$set": { "password": reqdict['newPassword'] } }
            mongo.db.users.update_one(users, newPass)
            return make_response(jsonify({'token': reqdict['token']}), 200)
        else:
            return make_response(jsonify({"reason": "Forbidden"}), 403)
    except SyntaxError:
        print(f"{reqdict['token']} \n ")
        return make_response(jsonify({"reason": "Token not recognized"}), 403)
        

# Get info on authed User 
@app.route('/user/getInfo', methods=['GET'])
def api_getInfo():
    request.get_data()
    reqdict = json.loads(request.data.decode('utf-8'))
    token = reqdict['token']
    users = mongo.db.users.find_one({"token": token})
    return jsonify({"username" : users['username']})


# Delete authed User 
@app.route('/user/delete', methods=['POST'])
def api_deleteUser():
    request.get_data()
    reqdict = json.loads(request.data.decode('utf-8'))
    token = reqdict['token']
    users = mongo.db.users.find_one({"token": token})
    collection_users.delete_one({"token": token})
    collection_data.delete_many({"parentToken": token})
    collection_competitors.delete_one({"parentToken": token})
    return '', 200

# DATA MANAGEMENT Requests
# All of these requests involve managing the database as a whole

# Add data from trip for authed user
@app.route('/data/add', methods=['POST'])
def api_addData():
    request.get_data()
    reqdict = json.loads(request.data.decode('utf-8'))
    token = reqdict['token']
    tripType = reqdict['tripType']
    duration = reqdict['duration']
    collection_data.insert_one({
        "parentToken":token,
        "tripType":tripType,
        "duration":duration
    })
    if tripType == 'bike':
        collection_users.update_one(
            {'token':token},
            {'$inc': {'totalBike': 20}}
        )
    if tripType == 'car':
        collection_users.update_one(
            {'token':token},
            {'$inc': {'totalCar': 20}}
        )
    if tripType == 'public':
        collection_users.update_one(
            {'token':token},
            {'$inc': {'totalPublic': 20}}
        )
    targetTrip = collection_data.find_one({
        "parentToken":token,
        "tripType":tripType,
        "duration":duration
    })
    return make_response(jsonify({"id":str(targetTrip['_id'])}))

# Gets authed users trips 
@app.route('/data/get', methods=['GET'])
def api_getData():
    request.get_data()
    reqdict = json.loads(request.data.decode('utf-8'))
    token = reqdict['token']

    entries = collection_data.find({'parentToken':token})
    result = []
    for entry in entries:
        result.append(entry)
    return jsonify({'data':(str(result))})

# Edit data from trip for authed user
@app.route('/data/edit', methods=['POST'])
def api_editData():
    request.get_data()
    reqdict = json.loads(request.data.decode('utf-8'))
    token = reqdict['token']
    if token == None:
        return jsonify({'reason':'Forbidden'}), 403 
    trip = collection_data.find({'parentToken':token, '_id':reqdict['id']})
    collection_data.update_one(trip, {'tripType':reqdict['tripType'], 'duration':reqdict['duration']})

# Delete data from trip for authed user
@app.route('/data/delete', methods=['POST'])
def api_deleteData():
    request.get_data()
    reqdict = json.loads(request.data.decode('utf-8'))
    token = reqdict['token']
    print(token)
    if token == None:
        return jsonify({'reason':'Forbidden'}), 403 
    targetObj = ObjectId(reqdict['id'])
    print(targetObj)
    print(type(targetObj))
    collection_data.delete_one({'_id':targetObj})
    return {}, 200

# COMPETITORS Requests
# Get info on competitors to compare locally



# List competitors for authed user
@app.route('/competitors/list', methods=['GET'])
def api_listCompetitors():
    pass

# Add competitor for authed user
@app.route('/competitors/add', methods=['POST'])
def api_addCompetitor():
    request.get_data()
    reqdict = json.loads(request.data.decode('utf-8'))
    token = reqdict['token']
    collection_competitors.update_one(
        {"parentToken":token}, 
        {"$set": {"username":reqdict['username']}})
    return {}, 200

# Remove competitor for authed user
@app.route('/competitors/remove', methods=['POST'])
def api_removeCompetitor():
    request.get_data()
    reqdict = json.loads(request.data.decode('utf-8'))
    token = reqdict['token']
    collection_competitors.update_one(
        {"parentToken":token}, 
        {"$unset": {"username":reqdict['username']}})
    return {}, 200


# MISCELLANEOUS Requests
# This is for all requests that didn't fit into a certain category

# STATS Request
@app.route('/stats', methods=['GET'])
def api_stats():
    request.get_data()
    reqdict = json.loads(request.data.decode('utf-8'))
    token = reqdict['token']
    return str(collection_users.find_one({'token':token}))




if __name__ == "__main__":
    app.run(host="0.0.0.0", port=25565, debug = True)

