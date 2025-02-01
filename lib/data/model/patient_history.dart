// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PatientHistory {
  int? idPatientHistory;
  int? idRecordNumber;
  int? idRegisteredBy;
  int? idConsultationBy;
  String dateVisit;
  String symptoms;
  String doctorDiagnose;
  String icd10Code;
  String icd10Name;
  bool isDone;

  PatientHistory({
    this.idPatientHistory,
    this.idRecordNumber,
    this.idRegisteredBy,
    this.idConsultationBy,
    required this.dateVisit,
    required this.symptoms,
    required this.doctorDiagnose,
    required this.icd10Code,
    required this.icd10Name,
    required this.isDone,
  });

  PatientHistory copyWith({
    int? idPatientHistory,
    int? idRecordNumber,
    int? idRegisteredBy,
    int? idConsultationBy,
    String? dateVisit,
    String? symptoms,
    String? doctorDiagnose,
    String? icd10Code,
    String? icd10Name,
    bool? isDone,
  }) {
    return PatientHistory(
      idPatientHistory: idPatientHistory ?? this.idPatientHistory,
      idRecordNumber: idRecordNumber ?? this.idRecordNumber,
      idRegisteredBy: idRegisteredBy ?? this.idRegisteredBy,
      idConsultationBy: idConsultationBy ?? this.idConsultationBy,
      dateVisit: dateVisit ?? this.dateVisit,
      symptoms: symptoms ?? this.symptoms,
      doctorDiagnose: doctorDiagnose ?? this.doctorDiagnose,
      icd10Code: icd10Code ?? this.icd10Code,
      icd10Name: icd10Name ?? this.icd10Name,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'idPatientHistory': idPatientHistory,
      'idRecordNumber': idRecordNumber,
      'registeredBy': idRegisteredBy,
      'consultationBy': idConsultationBy,
      'dateVisit': dateVisit,
      'symptoms': symptoms,
      'doctorDiagnose': doctorDiagnose,
      'icd10Code': icd10Code,
      'icd10Name': icd10Name,
      'isDone': isDone,
    };
  }

  factory PatientHistory.fromMap(Map<String, dynamic> map) {
    return PatientHistory(
      idPatientHistory: map['idPatientHistory'] != null
          ? map['idPatientHistory'] as int
          : null,
      idRecordNumber: map['idRecordNumber'] as int,
      idRegisteredBy: map['idRegisteredBy'] as int,
      idConsultationBy: map['idConsultationBy'] as int,
      dateVisit: map['dateVisit'] as String,
      symptoms: map['symptoms'] as String,
      doctorDiagnose: map['doctorDiagnose'] as String,
      icd10Code: map['icd10Code'] as String,
      icd10Name: map['icd10Name'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientHistory.fromJson(String source) =>
      PatientHistory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PatientHistory(idRecordNumber: $idRecordNumber, idRegisteredBy: $idRegisteredBy, idConsultationBy: $idConsultationBy, dateVisit: $dateVisit, symptoms: $symptoms, doctorDiagnose: $doctorDiagnose, icd10Code: $icd10Code, icd10Name: $icd10Name, isDone: $isDone)';
  }

  @override
  bool operator ==(covariant PatientHistory other) {
    if (identical(this, other)) return true;

    return other.idPatientHistory == idPatientHistory &&
        other.idRecordNumber == idRecordNumber &&
        other.idRegisteredBy == idRegisteredBy &&
        other.idConsultationBy == idConsultationBy &&
        other.dateVisit == dateVisit &&
        other.symptoms == symptoms &&
        other.doctorDiagnose == doctorDiagnose &&
        other.icd10Code == icd10Code &&
        other.icd10Name == icd10Name &&
        other.isDone == isDone;
  }

  @override
  int get hashCode {
    return idPatientHistory.hashCode ^
        idRecordNumber.hashCode ^
        idRegisteredBy.hashCode ^
        idConsultationBy.hashCode ^
        dateVisit.hashCode ^
        symptoms.hashCode ^
        doctorDiagnose.hashCode ^
        icd10Code.hashCode ^
        icd10Name.hashCode ^
        isDone.hashCode;
  }
}
