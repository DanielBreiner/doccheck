import 'package:flutter/material.dart';
import 'doctorinfo.dart';
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
    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            margin: const EdgeInsets.all(10.0),
            padding: EdgeInsets.all(20),
            color: Colors.blue[300],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Upcoming visits',
                  style: TextStyle(fontSize: 20),
                ),
                FlatButton(
                    child: Text(Doctor.all[DoctorType.values[doctorIndex]].name,
                        style: TextStyle(fontFamily: 'Arial', fontSize: 50)),
                    padding: EdgeInsets.all(0.0),
                    textColor: Colors.black,
                    disabledTextColor: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorInfo(
                                Doctor.all[doctorIndex], widget.userData)),
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
