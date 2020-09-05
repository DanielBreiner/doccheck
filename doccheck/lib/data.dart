import 'package:json_annotation/json_annotation.dart';

abstract class Doctor {
  final String name;
  final String description;
  final Gender ignore = null;
  void setNextAppointment(UserData data);

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

  void setNextAppointment(UserData data) {
    if (data.nextAppointments[this] == null) {
      data.nextAppointments[this] = DateTime.now().add(new Duration(days: 365));
    } else {
      data.nextAppointments[this].add(new Duration(days: 730));
    }
  }
}

class DoctorGynecologist extends Doctor {
  DoctorGynecologist()
      : super("Gynecologist",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.");

  void setNextAppointment(UserData data) {
    if (data.nextAppointments[this] == null) {
      data.nextAppointments[this] = DateTime.now().add(new Duration(days: 182));
    } else {
      data.nextAppointments[this].add(new Duration(days: 365));
    }
  }
}

class DoctorUrologist extends Doctor {
  DoctorUrologist()
      : super("Urologist",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.");

  void setNextAppointment(UserData data) {
    if (DateTime.now().year - data.birthDate.year < 50) {
      return;
    } else {
      if (data.nextAppointments[this] == null) {
        data.nextAppointments[this] = DateTime.now().add(
            new Duration(days: ((365 * 3) / 2).round())); //one and a half year
      } else {
        data.nextAppointments[this].add(new Duration(days: 365 * 3));
      }
    }
  }
}

class DoctorGastro extends Doctor {
  DoctorGastro()
      : super("Gastroentrerererer",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.");

  void setNextAppointment(UserData data) {
    if (data.nextAppointments[this] == null) {
      data.nextAppointments[this] =
          DateTime.now().add(new Duration(days: 365 * 5));
    } else {
      data.nextAppointments[this].add(new Duration(days: 365 * 10));
    }
  }
}

class DoctorDentist extends Doctor {
  DoctorDentist()
      : super("Dent",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.");

  void setNextAppointment(UserData data) {
    if (data.nextAppointments[this] == null) {
      data.nextAppointments[this] = DateTime.now().add(new Duration(days: 180));
    } else {
      data.nextAppointments[this].add(new Duration(days: 365));
    }
  }
}

enum Gender { male, female, other }

@JsonSerializable()
class UserData {
  DateTime birthDate = DateTime.now();
  Gender gender = Gender.other;
  Map<Doctor, DateTime> nextAppointments;

  UserData();

  int toNextAppointment(Doctor doctor) {
    // print("here");
    // if (nextAppointments[doctor] == null) doctor.setNextAppointment(this);
    // Duration difference = DateTime.now().difference(nextAppointments[doctor]);
    // return difference.inDays;
    return 0;
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
