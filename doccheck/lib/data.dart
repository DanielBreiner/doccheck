import 'package:json_annotation/json_annotation.dart';

enum DoctorType { gp, gynecologist, urologist, gastro, dentist }

class Doctor {
  final String name;
  final String description;
  final void Function(UserData) setNextAppointment;

  Doctor(this.name, this.description, this.setNextAppointment);

  static final Map<DoctorType, Doctor> All = {
    DoctorType.gp: Doctor("General Practitioner",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        (data) {
      if (data.nextAppointments[DoctorType.gp] == null) {
        data.nextAppointments[DoctorType.gp] =
            DateTime.now().add(new Duration(days: 365));
      } else {
        data.nextAppointments[DoctorType.gp].add(new Duration(days: 730));
      }
    }),
    DoctorType.gynecologist: Doctor("Gynecologist",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        (data) {
      if (data.nextAppointments[DoctorType.gynecologist] == null) {
        data.nextAppointments[DoctorType.gynecologist] =
            DateTime.now().add(new Duration(days: 182));
      } else {
        data.nextAppointments[DoctorType.gynecologist]
            .add(new Duration(days: 365));
      }
    }),
    DoctorType.urologist: Doctor("Urologist",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        (data) {
      if (DateTime.now().year - data.birthDate.year < 50) {
        return;
      } else {
        if (data.nextAppointments[DoctorType.urologist] == null) {
          data.nextAppointments[DoctorType.urologist] = DateTime.now().add(
              new Duration(
                  days: ((365 * 3) / 2).round())); //one and a half year
        } else {
          data.nextAppointments[DoctorType.urologist]
              .add(new Duration(days: 365 * 3));
        }
      }
    }),
    DoctorType.gastro: Doctor("Gastro",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        (data) {
      if (data.nextAppointments[DoctorType.gastro] == null) {
        data.nextAppointments[DoctorType.gastro] =
            DateTime.now().add(new Duration(days: 365 * 5));
      } else {
        data.nextAppointments[DoctorType.gastro]
            .add(new Duration(days: 365 * 10));
      }
    }),
    DoctorType.dentist: Doctor("Dentist",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        (data) {
      if (data.nextAppointments[DoctorType.dentist] == null) {
        data.nextAppointments[DoctorType.dentist] =
            DateTime.now().add(new Duration(days: 180));
      } else {
        data.nextAppointments[DoctorType.dentist].add(new Duration(days: 365));
      }
    }),
  };
}

enum Gender { male, female, other }

@JsonSerializable()
class UserData {
  DateTime birthDate = DateTime.now();
  Gender gender = Gender.other;
  Map<DoctorType, DateTime> nextAppointments;

  UserData();

  int toNextAppointment(DoctorType doctor) {
    Duration difference = DateTime.now().difference(nextAppointments[doctor]);
    return difference.inDays;
  }

  static final Map<Gender, DoctorType> ignoreDoctorTypes = {
    Gender.male: DoctorType.gynecologist,
    Gender.female: DoctorType.urologist,
  };

  void loadFromFile() {}
  void saveToFile() {
    print(toJson().toString());
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData();
  }

  Map<String, dynamic> toJson() {
    return {
      "birthDate": birthDate.toUtc(),
      "gender": gender.toString(),
      "nextAppointments": nextAppointments.toString()
    };
  }
}
