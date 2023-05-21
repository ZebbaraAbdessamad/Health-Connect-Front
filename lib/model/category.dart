import 'doctor.dart';

class Category {
  String  id;
  String ? name;
  String ?  src;
  String ?  color;
  int?  numberOfDoctors;
  List<Doctor> doctors;

  Category({
    required this.id,
    required this.name,
    required this.src,
    required this.color,
    required this.numberOfDoctors,
    required this.doctors,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    List<Doctor> doctorsList = [];
    if (json['doctors'] != null) {
      doctorsList = List<Doctor>.from(
        json['doctors'].map((doctor) => Doctor.fromJson(doctor)),
      );
    }
    return Category(
      id: json["id"] == null ? null : json['id'],
      name:  json["name"] == null ? null : json['name'],
      src: json["src"] == null ? null : json['src'],
      color: json["color"] == null ? null : json['color'],
      numberOfDoctors:  json["numberOfDoctors"] == null ? null :json['numberOfDoctors'],
      doctors: doctorsList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['src'] = this.src;
    data['color'] = this.color;
    data['numberOfDoctors'] = this.numberOfDoctors;
    data['doctors'] = this.doctors.map((doctor) => doctor.toJson()).toList();
    return data;
  }
}
