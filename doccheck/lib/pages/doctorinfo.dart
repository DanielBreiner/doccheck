import 'package:flutter/material.dart';
import '../data.dart';

class DoctorInfo extends StatefulWidget {
  final Doctor doctor;
  DoctorInfo(this.doctor, {Key key}) : super(key: key);

  @override
  _DoctorInfoState createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.doctor.name),
        ),
        body: Column(children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
              child: Text(
                  widget.doctor.toNextAppointment(UserData()).toString() +
                      " Days to next appointment")),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(widget.doctor.description)),
          Container()
        ]));
  }
}

// class DoctorInfo extends StatelessWidget {
//   final Doctor doctor;
//   DoctorInfo(this.doctor);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(doctor.name),
//         ),
//         body: Column(children: [
//           Container(
//               margin: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
//               child: Text(doctor.toNextAppointment(UserData()).toString() +
//                   " Days to next appointment")),
//           Container(
//               margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//               child: Text(doctor.description)),
//           Container()
//         ]));
//   }
// }
