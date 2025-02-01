class PatientHistoryJoin {
  int? idPatient;
  int? recordNumber;
  String? namePatient;
  String? birth;
  int? age;
  int? nik;
  int? gender;
  String? phone;
  String? address;
  int? bloodType;
  int? weight;
  int? height;
  String? createdAtPatient;
  String? updatedAtPatient;
  int? idPatientHistory;
  int? idRecordNumber;
  String? dateVisit;
  int? registeredBy;
  int? consultationBy;
  String? symptoms;
  String? doctorDiagnose;
  String? icd10Code;
  String? icd10Name;
  int? isDone;

  PatientHistoryJoin(
      {this.idPatient,
      this.recordNumber,
      this.namePatient,
      this.birth,
      this.age,
      this.nik,
      this.gender,
      this.phone,
      this.address,
      this.bloodType,
      this.weight,
      this.height,
      this.createdAtPatient,
      this.updatedAtPatient,
      this.idPatientHistory,
      this.idRecordNumber,
      this.dateVisit,
      this.registeredBy,
      this.consultationBy,
      this.symptoms,
      this.doctorDiagnose,
      this.icd10Code,
      this.icd10Name,
      this.isDone});

  PatientHistoryJoin.fromJson(Map<String, dynamic> json) {
    idPatient = json['idPatient'];
    recordNumber = json['recordNumber'];
    namePatient = json['namePatient'];
    birth = json['birth'];
    age = json['age'];
    nik = json['nik'];
    gender = json['gender'];
    phone = json['phone'];
    address = json['address'];
    bloodType = json['bloodType'];
    weight = json['weight'];
    height = json['height'];
    createdAtPatient = json['createdAtPatient'];
    updatedAtPatient = json['updatedAtPatient'];
    idPatientHistory = json['idPatientHistory'];
    idRecordNumber = json['idRecordNumber'];
    dateVisit = json['dateVisit'];
    registeredBy = json['registeredBy'];
    consultationBy = json['consultationBy'];
    symptoms = json['symptoms'];
    doctorDiagnose = json['doctorDiagnose'];
    icd10Code = json['icd10Code'];
    icd10Name = json['icd10Name'];
    isDone = json['isDone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idPatient'] = idPatient;
    data['recordNumber'] = recordNumber;
    data['namePatient'] = namePatient;
    data['birth'] = birth;
    data['age'] = age;
    data['nik'] = nik;
    data['gender'] = gender;
    data['phone'] = phone;
    data['address'] = address;
    data['bloodType'] = bloodType;
    data['weight'] = weight;
    data['height'] = height;
    data['createdAtPatient'] = createdAtPatient;
    data['updatedAtPatient'] = updatedAtPatient;
    data['idPatientHistory'] = idPatientHistory;
    data['idRecordNumber'] = idRecordNumber;
    data['dateVisit'] = dateVisit;
    data['registeredBy'] = registeredBy;
    data['consultationBy'] = consultationBy;
    data['symptoms'] = symptoms;
    data['doctorDiagnose'] = doctorDiagnose;
    data['icd10Code'] = icd10Code;
    data['icd10Name'] = icd10Name;
    data['isDone'] = isDone;
    return data;
  }
}
