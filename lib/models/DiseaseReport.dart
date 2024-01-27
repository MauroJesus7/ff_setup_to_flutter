import 'dart:convert';

class DiseaseReport {
  String code;
  String description;
  String photo;
  String latitude;
  String longitude;
  int cropId;
  int diseaseId;
  bool isPrivate;
  DateTime createdAt;

  DiseaseReport({
    required this.code,
    required this.description,
    required this.photo,
    required this.latitude,
    required this.longitude,
    required this.cropId,
    required this.diseaseId,
    required this.isPrivate,
    required this.createdAt,
  });

  factory DiseaseReport.fromJson(Map<String, dynamic> json) {
    return DiseaseReport(
      code: json['Code'] as String,
      description: json['Description'] as String,
      photo: json['Photo'] as String? ?? '',
      latitude: json['Latitude'] as String,
      longitude: json['Longitude'] as String,
      cropId: json['CropId'] as int,
      diseaseId: json['DiseaseId'] as int,
      isPrivate: json['IsPrivite'] as bool,
      createdAt: DateTime.parse(json['Created_At']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Code': code,
      'Description': description,
      'Photo': photo,
      'Latitude': latitude,
      'Longitude': longitude,
      'CropId': cropId,
      'DiseaseId': diseaseId,
      'IsPrivite': isPrivate,
      'Created_At': createdAt.toIso8601String(),
    };
  }
}
