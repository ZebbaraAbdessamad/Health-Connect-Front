class Patient {
  final String? id;
  final String firstname;
  final String email;
  final String? phone;
  final String image;

  Patient({
    required this.id,
    required this.firstname,
    required this.email,
    required this.phone,
    required this.image,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      firstname: json['firstname'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'] as String, // Handle null value by using 'as String?'
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'email': email,
      'phone': phone,
      'image': image,
    };
  }
}
