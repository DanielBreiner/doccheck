import 'package:json_annotation/json_annotation.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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
            "You are entitled to a preventive examination by a general practitioner once every two years. Registered donors of blood, organs or tissues should complete it every year. The preventive examination should last 30 minutes. The doctor will start the examination with an interview focusing on the risks arising from the family history, workload and lifestyle, and check the vaccination status (eg tetanus).");

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
            "The first preventive examination in a gynecological outpatient clinic awaits women after the age of eighteen. They then go to the doctor for a regular examination every year. During the examination, the doctor thoroughly examines the patient's medical history, provides her with expert advice on contraception, hormone replacement therapy, prevention of sexually transmitted diseases and instructions on the increased risk of gynecological malignancies with a positive family history and the presence of other risk factors in women.");

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
            "The preventive examination at the urologist concerns only men. It focuses on the search for oncological diseases of the male genitals and prostate.During the preventive examination, blood is collected for laboratory examination of prostate specific antigen and creatinine, and urine and urinary sediment are chemically examined. The examination is performed on men from the age of 50 or on men from the age of 40 if they have a prostate cancer disease in their first-degree kinship.");

  bool ignore(UserData data) {
    return DateTime.now().year - data.birthDate.year < 50 ||
        data.gender == Gender.female;
  }

  Duration betweenAppointments(UserData data) {
    return Duration(days: 365 * 3);
  }
}

class DoctorGastro extends Doctor {
  DoctorGastro()
      : super("Gastroenterologist",
            "Preventive examination in a gastroenterological outpatient clinic is extremely important. It is an examination of the rectum and colon with a colonoscope, which can detect pre-cancerous stages of colorectal cancer and save your life. The examination is aimed at finding polyps and early stages of colorectal cancer. During a colonoscopy examination for a tumor or polyp, a tissue sample is taken from its surface and sent for histological examination and, if possible, the polyp is endoscopically removed.");

  bool ignore(UserData data) {
    return false;
  }

  Duration betweenAppointments(UserData data) {
    return Duration(days: 365 * 10);
  }
}

class DoctorDentist extends Doctor {
  DoctorDentist()
      : super("Dentist",
            "An adult is entitled to a preventive check-up at the dentist once a year. Pregnant women should undergo the examination twice during the same pregnancy, at the beginning of the first and at the beginning of the third trimester. Do not postpone a preventive visit to the dental clinic. Dental caries treatment is fully reimbursed from public health insurance only if the insured person was on a preventive check-up at the dentist in the previous calendar year.");

  bool ignore(UserData data) {
    return false;
  }

  Duration betweenAppointments(UserData data) {
    return Duration(days: 365);
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
    saveToFile();
  }

  UserData() {
    setData(DateTime.now(), Gender.other);
  }

  int toNextAppointment(Doctor doctor) {
    Duration difference = nextAppointments[doctor].difference(DateTime.now());
    return difference.inDays;
  }

  // factory UserData.loadFromFile() {
  //   getApplicationDocumentsDirectory().then((dir) => {
  //     File('${dir.path}/save.json').readAsStringSync();
  //     jsonDecode();
  //     return UserData.fromJson(json);
  //   });
  // }

  void saveToFile() async {
    Directory dir = await getApplicationDocumentsDirectory();
    File('${dir.path}/save.json').writeAsString(toJson().toString());
    print("Saved to " + dir.path);
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData();
  }

  Map<String, dynamic> toJson() {
    Map<String, String> json = {
      "birthDate": birthDate.millisecondsSinceEpoch.toString(),
      "gender": gender.toString(),
    };
    for (Doctor doctor in Doctor.all)
      json[doctor.name] =
          nextAppointments[doctor]?.millisecondsSinceEpoch.toString();
    return json;
  }
}
