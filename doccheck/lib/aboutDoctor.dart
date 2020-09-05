import 'package:flutter/material.dart';
import 'data.dart';

class AboutDoctor extends StatelessWidget {
  final Doctor doctor;
  AboutDoctor(this.doctor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(doctor.name),
        ),
        body: Column(children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
              child: Text(doctor.toNextAppointment(UserData()).toString() +
                  " Days to next appointment")),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(doctor.description)),
          Container()
        ]));
  }
}
