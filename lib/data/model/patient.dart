import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Patient {
  int id;
  int recordNumber;
  String name;
  String birth;
  dynamic age; // Field tidak ada di ERD
  String nik;
  int gender; // Improve
  String phone;
  String address;
  dynamic bloodType;
  String? weight;
  String? height;
  String createdAt;
  String updatedAt;

  Patient({
    required this.id,
    required this.recordNumber,
    required this.name,
    required this.birth,
    required this.age,
    required this.nik,
    required this.gender,
    required this.phone,
    required this.address,
    required this.bloodType,
    this.weight,
    this.height,
    required this.createdAt,
    required this.updatedAt,
  });

  Patient copyWith({
    int? id,
    int? recordNumber,
    String? name,
    String? birth,
    dynamic age,
    String? nik,
    int? gender,
    String? phone,
    String? address,
    dynamic bloodType,
    String? weight,
    String? height,
    String? createdAt,
    String? updatedAt,
  }) {
    return Patient(
      id: id ?? this.id,
      recordNumber: recordNumber ?? this.recordNumber,
      name: name ?? this.name,
      birth: birth ?? this.birth,
      age: age ?? this.age,
      nik: nik ?? this.nik,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      bloodType: bloodType ?? this.bloodType,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idPatient': id,
      'recordNumber': recordNumber,
      'namePatient': name,
      'birth': birth,
      'age': age,
      'nik': nik,
      'gender': gender,
      'phone': phone,
      'address': address,
      'bloodType': bloodType,
      'weight': weight,
      'height': height,
      'createdAtPatient': createdAt,
      'updatedAtPatient': updatedAt,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['idPatient'] as int,
      recordNumber: map['recordNumber'] as int,
      name: map['namePatient'] as String,
      birth: map['birth'] as String,
      age: map['age'] as dynamic,
      nik: map['nik'] as String,
      gender: map['gender'] as int,
      phone: map['phone'] as String,
      address: map['address'] as String,
      bloodType: map['bloodType'] as dynamic,
      weight: map['weight'] != null ? map['weight'] as String : null,
      height: map['height'] != null ? map['height'] as String : null,
      createdAt: map['createdAtPatient'] as String,
      updatedAt: map['updatedAtPatient'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Patient.fromJson(String source) =>
      Patient.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Patient(id: $id, recordNumber: $recordNumber, name: $name, birth: $birth, age: $age, nik: $nik, gender: $gender, phone: $phone, address: $address, bloodType: $bloodType, weight: $weight, height: $height, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Patient other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.recordNumber == recordNumber &&
        other.name == name &&
        other.birth == birth &&
        other.age == age &&
        other.nik == nik &&
        other.gender == gender &&
        other.phone == phone &&
        other.address == address &&
        other.bloodType == bloodType &&
        other.weight == weight &&
        other.height == height &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        recordNumber.hashCode ^
        name.hashCode ^
        birth.hashCode ^
        age.hashCode ^
        nik.hashCode ^
        gender.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        bloodType.hashCode ^
        weight.hashCode ^
        height.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
