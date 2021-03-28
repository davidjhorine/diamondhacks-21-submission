import requests
import json
'''
x = requests.get('http://localhost:25565/data/get', json.dumps({'token':'sha256$ZtVUXc0t$756a0dabd4b6499ca9af608e2f66753bb676c0180f0b9c7727adc76127b67974.bWFyc2h0ZXN0'}))
print(x)
'''
testStats = {
  "data": "[{'_id': ObjectId('6060594c4ae8d9f26d1828a8'), 'parentToken': 'sha256$ZtVUXc0t$756a0dabd4b6499ca9af608e2f66753bb676c0180f0b9c7727adc76127b67974.bWFyc2h0ZXN0', 'tripType': 'bike', 'duration': '20'}, {'_id': ObjectId('60605a7862e0c177413adedf'), 'parentToken': 'sha256$ZtVUXc0t$756a0dabd4b6499ca9af608e2f66753bb676c0180f0b9c7727adc76127b67974.bWFyc2h0ZXN0', 'tripType': 'bike', 'duration': '20'}]"
}


def get_stats(request):
    data = json.loads(str(request))
    return data





print(get_stats(testStats))