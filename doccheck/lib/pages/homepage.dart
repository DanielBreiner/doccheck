import 'package:flutter/material.dart';
import 'doctorinfo.dart';
import 'doctorlist.dart';
import '../data.dart';

class HomePage extends StatefulWidget {
  HomePage(this.userData, {Key key, this.title}) : super(key: key);
  final String title;
  final UserData userData;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int doctorIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Text(
            "Upcoming visits",
            style: TextStyle(fontSize: 24),
          ),
        ),
        DoctorTileWidget(
          Doctor.all[0],
          widget.userData,
        )
      ]),
    );
  }
}
