import 'package:json_annotation/json_annotation.dart';

abstract class Doctor {
  final String name;
  final String description;
  bool ignore(UserData data);
  Duration betweenAppointments(UserData data);

  Doctor(this.name, this.description);

  static final List<Doctor> all = [
    DoctorGp(),
    DoctorGynecologist(),
    DoctorUrologist(),
    DoctorGastro(),
    DoctorDentist(),
  ];
}

class DoctorGp extends Doctor {
  DoctorGp()
      : super("General Practitioner",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.");

  bool ignore(UserData data) {
    return false;
  }

  Duration betweenAppointments(UserData data) {
    return Duration(days: 365 * 2);
  }
}

class DoctorGynecologist extends Doctor {
  DoctorGynecologist()
      : super("Gynecologist",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.");

  bool ignore(UserData data) {
    return data.gender == Gender.male;
  }

  Duration betweenAppointments(UserData data) {
    return Duration(days: 365);
  }
}

class DoctorUrologist extends Doctor {
  DoctorUrologist()
      : super("Urologist",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.");

  bool ignore(UserData data) {
    return DateTime.now().year - data.birthDate.year < 50 ||
        data.gender == Gender.female;
  }

  Duration betweenAppointments(UserData data) {
    return Duration(days: ((365 * 3) / 2).round());
  }
}

class DoctorGastro extends Doctor {
  DoctorGastro()
      : super("Gastroentrerererer",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.");

  bool ignore(UserData data) {
    return false;
  }

  Duration betweenAppointments(UserData data) {
    return Duration(days: 365 * 5);
  }
}

class DoctorDentist extends Doctor {
  DoctorDentist()
      : super("Dent",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.");

  bool ignore(UserData data) {
    return false;
  }

  Duration betweenAppointments(UserData data) {
    return Duration(days: 180);
  }
}

enum Gender { male, female, other }

@JsonSerializable()
class UserData {
  DateTime birthDate;
  Gender gender;
  Map<Doctor, DateTime> nextAppointments = {};

  void setData(DateTime birthDate, Gender gender) {
    this.birthDate = birthDate;
    this.gender = gender;
    for (Doctor doctor in Doctor.all) {
      if (!doctor.ignore(this))
        nextAppointments.putIfAbsent(
          doctor,
          () => DateTime.now().add(doctor.betweenAppointments(this) * 0.5),
        );
    }
  }

  UserData() {
    setData(DateTime.now(), Gender.other);
  }

  int toNextAppointment(Doctor doctor) {
    Duration difference = nextAppointments[doctor].difference(DateTime.now());
    return difference.inDays;
  }

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
