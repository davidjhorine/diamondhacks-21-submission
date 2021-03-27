# API Reference Guide:
All requests are to be `application/json`


## USER/AUTHENTICATION

### POST $BASE_URL/auth/login
Request data: <br>
```{"username": "<username>", "password": "password"}``` <br>
Good response: 200 OK <br>
```{"token": "<loginToken>"}``` <br>
Bad response: 403 Unauthorized <br>
```{"reason": "<reason string>"}``` <br>

### POST $BASE_URL/auth/setPassword
Request data: <br> 
```{"token": "<loginToken>", "oldPassword" : "<current password>", "newPassword" : "<new password>"}``` <br>
Good response: 200 OK <br>
```{"success": true, "token": "<loginToken>"}``` <br>
Bad response: 403 Unauthorized <br>
```{"success": false, "reason": "<reason string>"}``` <br>
	
### GET $BASE_URL/user/getInfo
Request data: <br>
```{"token": "<loginToken>"}``` <br>
Good response: 200 OK <br>
```{"username": "<username>","nickname": "<nickname>"}``` <br>
Bad response: 403 Unauthorized <br>
```{"success": false, "reason": "<reason string>"}``` <br>
	
### POST $BASE_URL/user/setInfo
Request data: <br>
```{"token": "<loginToken>", "username": "<username>", "nickname": "<nickname>"}``` <br>
Good response: 200 OK <br>
```(No data returned)``` <br>
Bad response: 403 Unauthorized <br>
```{"reason":"<reason string>"}``` <br>
	
### POST $BASE_URL/user/delete
Request data: <br>
```{"token": "<loginToken>", "password" : "password>"}``` <br>
Good response: 200 OK <br>
```(No data returned)``` <br>
Bad response: 403 Unauthorized <br>
```{"reason":"<reason string>"}``` <br>

## DATA MANAGEMENT

### POST $BASE_URL/data/add
Request data: <br>
```{"token": "<loginToken>", "tripType" : "<one of car|public|bike>", "duration": <duration in minutes>}``` <br>
Good response: 200 OK <br>
```{"id":<trip ID>}``` <br>
Bad response: 403 Unauthorized <br>
```{"reason":"<reason string>"}```<br>

### GET $BASE_URL/data/get
Request data: <br>
```{"token": "<loginToken>"}``` <br>
Good response: 200 OK
```{"data":[{"id":<trip ID>,"tripTyle":<one of car|public|bike>", "duration": <duration in minutes>},{"id":<trip ID>,"tripTyle":<one of car|public|bike>", "duration": <duration in minutes>}]}``` <br>
Bad response: 403 Unauthorized <br>
```{"reason":"<reason string>"}``` <br>

### POST $BASE_URL/data/edit
Request data: <br>
```{"token": "<loginToken>", "id": <id of trip>, "tripType" : "<one of car|public|bike>", "duration": <duration in minutes>}``` <br>
Good response: 200 OK <br>
```(no data)``` <br>
Bad response: 403 Unauthorized <br>
```{"reason":"<reason string>"}``` <br>


### POST $BASE_URL/data/delete
Request data: <br>
```{"token": "<loginToken>", "id": <id of trip>}``` <br>
Good response: 200 OK <br>
```(no data)``` <br>
Bad response: 403 Unauthorized <br>
```{"reason":"<reason string>"}``` <br>

## COMPETITORS

### GET $BASE_URL/competitors/list
Request data: <br>
```{"token": "<loginToken>"}``` <br>
Good response: 200 OK <br>
```{"competitors":[{"username":"<competitor's username>","score":<score>,"carUsage":<% of time traveled by car>,"publicUsage":<% of time traveled by public transport>,"bikeUsage":<% of time traveled by bike>},{"username":"<competitor's username>","score":<score>,"carUsage":<% of time traveled by car>,"publicUsage":<% of time traveled by public transport>,"bikeUsage":<% of time traveled by bike>``` <br>
Bad response: 403 Forbidden <br>
```{"reason":"<reason string>"}``` <br>

### POST $BASE_URL/competitors/add
Request data: <br>
```{"token": "<loginToken>", "username": "<username of competitor>"}``` <br>
Good response: 200 OK <br>
```{"status":"<one of success|doesNotExist|alreadyOnList>"}``` <br>
Bad response: 403 Forbidden <br>
```{"reason":"<reason string>"}``` <br>

### POST $BASE_URL/competitors/remove
Request data: <br>
```{"token": "<loginToken>", "username": "<username of competitor>"}``` <br>
Good response: 200 OK <br>
```{"status":"<one of success|doesNotExist|notOnList>"}``` <br>
Bad response: 403 Forbidden <br>
```{"reason":"<reason string>"}``` <br>

## STATS

### GET $BASE_URL/stats
Request data: <br>
```{"token": "<loginToken>"}``` <br>
Good response: 200 OK <br>
```{"score":<score>,"carUsage":<% of time traveled by car>,"publicUsage":<% of time traveled by public transport>,"bikeUsage":<% of time traveled by bike>}``` <br>
Bad response: 403 Forbidden <br>
```{"reason":"<reason string>"}``` <br>
