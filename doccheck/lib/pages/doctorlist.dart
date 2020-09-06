import 'package:flutter/material.dart';
import 'doctorinfo.dart';
import '../data.dart';

class DoctorListWidget extends StatelessWidget {
  DoctorListWidget(this.userData);
  final UserData userData;

  @override
  Widget build(BuildContext context) {
    return _buildDoctorList(context);
  }

  Widget _buildDoctorList(BuildContext context) => ListView.separated(
      itemCount: Doctor.all.length,
      padding: const EdgeInsets.all(20),
      separatorBuilder: (BuildContext context, int index) {
        if (Doctor.all[index].ignore(userData)) return SizedBox();
        return SizedBox(
          height: 15,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        if (Doctor.all[index].ignore(userData)) return SizedBox();
        return DoctorTileWidget(Doctor.all[index], userData);
      });
}

class DoctorTileWidget extends StatelessWidget {
  DoctorTileWidget(this.doctor, this.userData);
  final Doctor doctor;
  final UserData userData;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        child: Container(
          height: 150,
          color: Colors.amber[600],
          child: Row(
            children: [
              Container(
                child: Icon(Icons.pregnant_woman, size: (32)),
                padding: EdgeInsets.symmetric(horizontal: 30),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: TextStyle(fontSize: 24),
                  ),
                  Container(
                      child: Text(
                    "Viac info " +
                        userData.toNextAppointment(doctor).toString(),
                  )),
                ],
              )
            ],
          ),
        ),
        padding: EdgeInsets.all(0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoctorInfo(doctor, userData)),
          );
        });
  }
}
