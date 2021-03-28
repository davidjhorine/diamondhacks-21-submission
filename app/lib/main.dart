import 'package:app/leaderboardPerson.dart';
import 'package:flutter/material.dart'; // This library provides all the material design styled widgets
import './mainHeaderWidget.dart';
import './leaderboardPerson.dart';
import './addNewCompetitor.dart';
import './ourColors.dart' as ourColors;
import 'testData.dart' as testData;

void main() {
  // Because there's so little that has to go into MaterialApp, the code is cleaner just keeping it here instead of putting it in a new class
  runApp(MaterialApp(
    title: 'App title here', //TODO: Add app title
    home: HomePage(),
    theme: ThemeData(
      primarySwatch: Colors.brown,
      scaffoldBackgroundColor: ourColors.bgLight,
    ),
  ));
}

class HomePage extends StatefulWidget {
  // This homepage needs to be stateful because it has animations and changing data
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _navState = 'home';
  var _returnedNavState;
  int bottomTabIndex = 0;

  void _goHome() {
    setState(() {
      _navState = 'home';
    });
  }

  void _viewTrips() {
    setState(() {
      _navState = 'trips';
    });
  }

  void _viewSettings() {
    setState(() {
      _navState = 'settings';
    });
  }

  void _addNew() {
    setState(() {
      _navState = 'addNew';
    });
  }

  void _bottomTabChangeHandler(int index) {
    if (index == 0) {
      _goHome();
    } else if (index == 1) {
      _viewTrips();
    } else if (index == 2) {
      _viewSettings();
    }
    bottomTabIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    // This bit of logic handles switching screen in the context of the original scaffold
    if (_navState == 'home') {
      _returnedNavState = MainPage(addNew: _addNew);
    } else if (_navState == 'addNew') {
      _returnedNavState = AddNewCompetitor(
        goHome: _goHome,
      );
    }

    return (Scaffold(
      appBar: AppBar(title: Text('Carbon Points')),
      body: _returnedNavState,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Trips'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
        ],
        backgroundColor: ourColors.bgDark,
        fixedColor: ourColors.textLight,
        unselectedItemColor: ourColors.bgLight,
        currentIndex: bottomTabIndex,
        onTap: _bottomTabChangeHandler,
      ),
    ));
  }
}

class MainPage extends StatefulWidget {
  Function addNew;
  MainPage({this.addNew});
  _addNew() => addNew();
  // The function here is required to be named because positional arguments are always required, breaking createState
  @override
  _MainPageState createState() => _MainPageState(_addNew);
}

class _MainPageState extends State<MainPage> {
  Function addNew;
  _MainPageState(final this.addNew);
  @override
  Widget build(BuildContext context) {
    print(testData.fakeCompetitors['competitors'].length);
    (widget.addNew == null) ? print('null!') : print('not null');
    return Column(
      children: [
        HeaderWidget(),
        Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your competitors',
                  style: ourColors.headerText,
                ),
                IconButton(onPressed: addNew, icon: Icon(Icons.add)),
              ],
            )),
        Expanded(
            child: ListView.builder(
                itemCount: testData.fakeCompetitors['competitors'].length,
                itemBuilder: (BuildContext context, int index) {
                  return LeaderboardPerson(
                    username: testData.fakeCompetitors['competitors'][index]
                            ['username'] +
                        ' - ' +
                        testData.fakeCompetitors['competitors'][index]['score']
                            .toString(),
                    place: index,
                    bike: testData.fakeCompetitors['competitors'][index]
                        ['bikeUsage'],
                    car: testData.fakeCompetitors['competitors'][index]
                        ['carUsage'],
                    public: testData.fakeCompetitors['competitors'][index]
                        ['publicUsage'],
                  );
                }))
      ],
    );
  }
}
