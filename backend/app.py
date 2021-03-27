from flask import Flask, request, jsonify

app = Flask(__name__)

# root
@app.route("/")
def index():
    return "placeholder"

@app.route('/users/<user>')
def userGreet(user):
    return "%s" % user

@app.route('/api/post', methods=['POST'])
def placeholder():
    

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)