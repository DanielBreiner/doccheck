import 'package:flutter/material.dart';
import 'pages/homepage.dart';
import 'pages/doctorlist.dart';
import 'pages/settings.dart';
import 'data.dart';
import 'push_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthEasy',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Home page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key) {}

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int doctorIndex = 0;
  int selectedIndex = 0;
  UserData userData = UserData();

  _MyHomePageState() {
    PushNotificationsManager().init(_showItemDialog);
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> widgetOptions = <Widget>[
    // set titles of main pages
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Doctors',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = <Widget>[
      HomePage(userData),
      DoctorListWidget(userData),
      Settings(userData)
    ];
    return Scaffold(
      appBar: AppBar(
        title: widgetOptions[selectedIndex],
        backgroundColor: Colors.red,
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            title: Text('Doctors'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void _showItemDialog(Map<String, dynamic> message) {
    showDialog<bool>(
        context: context,
        builder: (_) => _buildDialog(context, message["notification"]));
  }

  Widget _buildDialog(BuildContext context, Map<String, String> message) {
    return AlertDialog(
      title: Text(message["title"]),
      content: Text(message["body"]),
      actions: <Widget>[
        FlatButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
}
