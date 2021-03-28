from flask import Flask, render_template, redirect, request, jsonify
from models import UserModel, db, login
from flask_security import login_required
from flask_login import current_user, login_user, logout_user

app = Flask(__name__)

app.secret_key = b'&t4@Q'

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///app.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db.init_app(app)

login.init_app(app)
login.login_view = 'login'

@app.before_first_request
def create_table():
    db.create_all()


# root
@app.route("/")
def index():
    return "placeholder"

# Test template
@app.route('/blogs')
@login_required
def blog():
    return render_template('test.html')

# Register route
@app.route('/register', methods=['POST', 'GET'])
def register():
    if current_user.is_authenticated:
        return redirect('/blogs')
    
    if request.method == 'POST':
        email = request.form['email']
        username = request.form['username']
        password = request.form['password']

        if UserModel.query.filter_by(email=email).first():
            return ('Email already present')
        
        user = UserModel(email=email, username=username)
        user.set_password(password)
        db.session.add(user)
        db.session.commit()
        return redirect('/login')
    
    return render_template('register.html')


# USER / AUTH API Requests
# These are requests that retain directly to administering users

# Login 
@app.route('/login', methods = ['POST', 'GET'])
def login():
    # Checks for if the user is already authenticated
    if current_user.is_authenticated:
        return redirect('/blogs')
    
    # Checks for if the method of request is a POST
    if request.method == "POST":
        email = request.form['email']
        user = UserModel.query.filter_by(email = email).first()
        if user is not None and user.check_password(request.form['password']):
            login_user(user)
            return redirect('/blogs')
    return render_template('login.html')

# Logout route
@app.route('/logout')
def logout():
    logout_user()
    return redirect('/blogs')

# Set Password for authed user
@app.route('/auth/setPassword', methods=['POST'])
def api_setPassword():
    pass

@app.route('/users/<user>')
def userGreet(user):
    return "%s" % user

# Get info on authed User 
@app.route('/user/getInfo', methods=['GET'])
def api_getInfo():
    pass

# Set info on authed User 
@app.route('/user/getInfo', methods=['POST'])
def api_setInfo():
    pass

# Create User 
@app.route('/user/create', methods=['POST'])
def api_createUser():
    pass

# Delete authed User 
@app.route('/user/delete', methods=['POST'])
def api_deleteUser():
    pass

# DATA MANAGEMENT Requests
# All of these requests involve managing the database as a whole

# Add data from trip for authed user
@app.route('/data/add', methods=['POST'])
def api_addData():
    pass

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
    app.run(host="0.0.0.0", port=5000)

