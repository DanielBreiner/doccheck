import 'package:flutter/material.dart';
import '../data.dart';

class DoctorListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildDoctorList();
  }

  Widget _buildDoctorList() => ListView.separated(
      itemCount: Doctor.All.length,
      padding: const EdgeInsets.all(20),
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 15,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return _buildDoctorTile(Doctor.All[index]);
      });

  Widget _buildDoctorTile(Doctor doctor) => Container(
        height: 150,
        color: Colors.amber[600],
        child: Row(children: [
          Container(
            child: Icon(Icons.pregnant_woman, size: (32)),
            padding: EdgeInsets.symmetric(horizontal: 30),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(doctor.name, style: TextStyle(fontSize: 32)),
              FlatButton(
                onPressed: () {},
                child: Text(
                  "Viac info" + doctor.toNextAppointment(UserData()).toString(),
                ),
              ),
            ],
          )
        ]),
      );
}
