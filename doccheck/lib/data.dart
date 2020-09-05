import 'package:json_annotation/json_annotation.dart';

enum DoctorType { gp, gynecologist, urologist, gastro, dentist }

class Doctor {
  final String name;
  final String description;
  final int Function(UserData) toNextAppointment;

  Doctor(this.name, this.description, this.toNextAppointment);

  static final Map<DoctorType, Doctor> all = {
    DoctorType.gp: Doctor("Všeobecný lekár",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        (data) {
      return 0;
    }),
    DoctorType.gynecologist: Doctor("Gynekológ",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        (data) {
      return 0;
    }),
    DoctorType.urologist: Doctor("Urológ",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        (data) {
      return 0;
    }),
    DoctorType.gastro: Doctor("Gastroenterológ",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        (data) {
      return 0;
    }),
    DoctorType.dentist: Doctor("Zubný lekár",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        (data) {
      return 0;
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
