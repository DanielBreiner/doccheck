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
        ])
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: <Widget>[
        //     Container(
        //       width: MediaQuery.of(context).size.width * 0.95,
        //       margin: const EdgeInsets.all(10.0),
        //       padding: EdgeInsets.all(20),
        //       color: Colors.blue[300],
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: <Widget>[
        //           Text(
        //             'Upcoming visit',
        //             style: TextStyle(fontSize: 20, color: Colors.white),
        //           ),
        //           FlatButton(
        //               child: Text(
        //                 Doctor.all[doctorIndex].name,
        //                 style: TextStyle(
        //                     fontFamily: 'Arial',
        //                     fontSize: 40,
        //                     color: Colors.white),
        //               ),
        //               padding: EdgeInsets.all(0.0),
        //               textColor: Colors.black,
        //               disabledTextColor: Colors.black,
        //               onPressed: () {
        //                 Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) => DoctorInfo(
        //                           Doctor.all[doctorIndex], widget.userData)),
        //                 );
        //               })
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        );
  }
}
