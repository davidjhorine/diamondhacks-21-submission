import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int state = 0;
  void _setState(int added) {
    setState(() {
      state += added;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (state == 0) {
      return (Scaffold(
        appBar: AppBar(
          title: Text('Carbon Points'),
        ),
        body: Center(
            child: Column(
          children: [
            ElevatedButton(
                onPressed: () => _setState(1), child: Text('Register')),
            ElevatedButton(
                onPressed: () => _setState(2), child: Text('Sign In'))
          ],
        )),
      ));
    } else if (state == 1) {
      /*void _sendRegister() async {
        final storage = FlutterSecureStorage();
        var response = await http.get(Uri.parse(ourColors.baseURL + ""))
      }*/ //Unfortunately, due to limited time requirements and extra requirements for how requests are made compared to most frameworks, this app will stay offline for the duration of the hackathon

      final unController = TextEditingController();
      final pwController = TextEditingController();
      return (Scaffold(
        appBar: AppBar(
          title: Text('Carbon Points'),
        ),
        body: Center(
            child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Username'),
              controller: unController,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Password'),
              controller: pwController,
            ),
            ElevatedButton(onPressed: null, child: Text('Sign Up')),
          ],
        )),
      ));
    } else if (state == 2) {
      return (Scaffold(
        appBar: AppBar(
          title: Text('Carbon Points'),
        ),
        body: Center(
            child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Username'),
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Password'),
            ),
            ElevatedButton(onPressed: null, child: Text('Sign In')),
          ],
        )),
      ));
    }
  }
}
