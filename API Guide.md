# API Reference Guide:

## USER/AUTHENTICATION

### POST $BASE_URL/auth/login - application/json
Request data:
```{"username": "<username>", "password": "password"}```
Good response: 200 OK
```{"token": "<loginToken>"}```
Bad response: 403 Unauthorized
```{"reason": "<reason string>"}```

### POST $BASE_URL/auth/setPassword - application/json
Request data:
```{"token": "<loginToken>", "oldPassword" : "<current password>", "newPassword" : "<new password>"}```
Good response: 200 OK
```{"success": true, "token": "<loginToken>"}```
Bad response: 403 Unauthorized
```{"success": false, "reason": "<reason string>"}```
	
### GET $BASE_URL/user/getInfo - application/json
Request data:
```{"token": "<loginToken>"}```
Good response: 200 OK
```{"username": "<username>","nickname": "<nickname>"}```
Bad response: 403 Unauthorized
```{"success": false, "reason": "<reason string>"}```
	
### POST $BASE_URL/user/setInfo - application/json
Request data: 
```{"token": "<loginToken>", "username": "<username>", "nickname": "<nickname>"}```
Good response: 200 OK
```(No data returned)```
Bad response: 403 Unauthorized
```{"reason":"<reason string>"}```
	
### POST $BASE_URL/user/delete - application/json
Request data:
```{"token": "<loginToken>", "password" : "password>"}```
Good response: 200 OK
```(No data returned)```
Bad response: 403 Unauthorized
```{"reason":"<reason string>"}```

## DATA MANAGEMENT

### POST $BASE_URL/data/add
Request data:
```{"token": "<loginToken>", "tripType" : "<one of car|public|bike>", "duration": <duration in minutes>}```
Good response: 200 OK
```{"id":<trip ID>}```
Bad response: 403 Unauthorized
```{"reason":"<reason string>"}```

### GET $BASE_URL/data/get
Request data:
```{"token": "<loginToken>"}```
Good response: 200 OK
```{"data":[{"id":<trip ID>,"tripTyle":<one of car|public|bike>", "duration": <duration in minutes>},{"id":<trip ID>,"tripTyle":<one of car|public|bike>", "duration": <duration in minutes>}]}```
Bad response: 403 Unauthorized
```{"reason":"<reason string>"}```

### POST $BASE_URL/data/edit
Request data:
```{"token": "<loginToken>", "id": <id of trip>, "tripType" : "<one of car|public|bike>", "duration": <duration in minutes>}```
Good response: 200 OK
```(no data)```
Bad response: 403 Unauthorized
```{"reason":"<reason string>"}```


### POST $BASE_URL/data/delete
Request data:
```{"token": "<loginToken>", "id": <id of trip>}```
Good response: 200 OK
```(no data)```
Bad response: 403 Unauthorized
```{"reason":"<reason string>"}```

## COMPETITORS

### GET $BASE_URL/competitors/list
Request data:
```{"token": "<loginToken>"}```
Good response: 200 OK
```{"competitors":[{"username":"<competitor's username>","score":<score>,"carUsage":<% of time traveled by car>,"publicUsage":<% of time traveled by public transport>,"bikeUsage":<% of time traveled by bike>},{"username":"<competitor's username>","score":<score>,"carUsage":<% of time traveled by car>,"publicUsage":<% of time traveled by public transport>,"bikeUsage":<% of time traveled by bike>```
Bad response: 403 Forbidden
```{"reason":"<reason string>"}```

### POST $BASE_URL/competitors/add
Request data:
```{"token": "<loginToken>", "username": "<username of competitor>"}```
Good response: 200 OK
```{"status":"<one of success|doesNotExist|alreadyOnList>"}```
Bad response: 403 Forbidden
```{"reason":"<reason string>"}```

### POST $BASE_URL/competitors/remove
Request data:
```{"token": "<loginToken>", "username": "<username of competitor>"}```
Good response: 200 OK
```{"status":"<one of success|doesNotExist|notOnList>"}```
Bad response: 403 Forbidden
```{"reason":"<reason string>"}```

## STATS

### GET $BASE_URL/stats
Request data:
```{"token": "<loginToken>"}```
Good response: 200 OK
```{"score":<score>,"carUsage":<% of time traveled by car>,"publicUsage":<% of time traveled by public transport>,"bikeUsage":<% of time traveled by bike>}```
Bad response: 403 Forbidden
```{"reason":"<reason string>"}```
