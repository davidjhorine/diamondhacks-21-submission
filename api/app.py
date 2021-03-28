from flask import Flask, render_template, redirect, request, jsonify, make_response
from models import UserModel, db, login
from flask_security import login_required
from flask_login import current_user, login_user, logout_user
import json
import base64
from werkzeug.security import generate_password_hash, check_password_hash
from flask_pymongo import PyMongo


app = Flask(__name__)

app.config["MONGO_URI"] = "mongodb://localhost:27017/users"
mongo = PyMongo(app)
collection_users = mongo.db['users']
collection_data = mongo.db['data']
collection_competitors = mongo.db['competitors']

login.init_app(app)
login.login_view = 'login'
app.secret_key = b'&t4@Q'

def makeToken(username, password):
    # Get the hashes for the passwords
    firstHash = password
    secondHash = generate_password_hash(firstHash, "sha256")

    # Encode the username into Base64
    encodedUserB = base64.b64encode(username.encode("utf-8"))
    encodedUserS = str(encodedUserB, "utf-8")
    token = secondHash + "." + encodedUserS
    return token



# Root directory
@app.route('/')
def index():
  return jsonify({"test data": "true"})

# Test template
@app.route('/blogs')
@login_required
def blog():
    return render_template('test.html')

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
    mongo.db.data.insert_one({
        'username':reqdict['username'],
        'parentToken':token
        })
    mongo.db.competitors.insert_one({
        'username':reqdict['username'], 
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
        

@app.route('/users/getInfo')
@app.route('/users/getInfo/<token>')
def getInfo(username=None):
    if not username:
      error = jsonify(Error='403 Unauthorized')
      return make_response(error, 403)
    
    return jsonify(
      id=username,
      name="Placeholder",
    )

# Get info on authed User 
@app.route('/user/getInfo', methods=['GET'])
def api_getInfo():
    request.get_data()
    reqdict = json.loads(request.data.decode('utf-8'))
    token = reqdict['token']
    users = mongo.db.users.find_one({"token": token})
    return jsonify({"username" : users['username']})

# TODO API to Change Username
'''
# Set info on authed User 
@app.route('/user/setInfo', methods=['POST'])
def api_setInfo():
    pass
'''

# Delete authed User 
@app.route('/user/delete', methods=['POST'])
def api_deleteUser():
    request.get_data()
    reqdict = json.loads(request.data.decode('utf-8'))
    token = reqdict['token']
    users = mongo.db.users.find_one({"token": token})
    collection_users.delete_one({"token": token})
    collection_data.delete_one({"parentToken": token})
    collection_competitors.delete_one({"parentToken": token})
    return '', 200

# DATA MANAGEMENT Requests
# All of these requests involve managing the database as a whole

# Add data from trip for authed user
@app.route('/data/add', methods=['POST'])
def api_addData():
    request.get_data()
    reqdict = json.loads(request.data.decode('utf-8'))
    col = mongo.db.users['data']
    
    token = reqdict['token']
    tripType = reqdict['tripType']
    duration = reqdict['duration']
    newID = mongo.db.col.count_documents({})
    print(newID)
    insertDict = {"tripID": newID}

    return make_response(jsonify({"tripID": newID}))

# Gets authed users trips 
@app.route('/data/get', methods=['GET'])
def api_getData():
    pass

# Edit data from trip for authed user
@app.route('/data/edit', methods=['POST'])
def api_editData():
    pass

# Delete data from trip for authed user
#@app.route('/data/delete', methods=['POST'])
#def api_deleteData():
#    pass

# COMPETITORS Requests
# Get info on competitors to compare locally

# List competitors for authed user
@app.route('/competitors/listd', methods=['GET'])
def api_listCompetitors():
    pass

# Add competitor for authed user
@app.route('/competitors/add', methods=['POST'])
def api_addCompetitor():
    pass

# Remove competitor for authed user
@app.route('/competitors/remove', methods=['POST'])
def api_removeCompetitor():
    pass

# MISCELLANEOUS Requests
# This is for all requests that didn't fit into a certain category

# STATS Request
@app.route('/stats', methods=['GET'])
def api_stats():
    return True



if __name__ == "__main__":
    app.run(host="0.0.0.0", port=25565, debug = True)

