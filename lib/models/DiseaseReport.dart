// import 'dart:convert';
// import 'dart:io';

// class DiseaseReport {
//   String code;
//   String description;
//   File? photo;
//   String latitude;
//   String longitude;
//   int cropId;
//   int diseaseId;
//   bool isPrivate;
//   DateTime createdAt;

//   DiseaseReport({
//     required this.code,
//     required this.description,
//     required this.photo,
//     required this.latitude,
//     required this.longitude,
//     required this.cropId,
//     required this.diseaseId,
//     required this.isPrivate,
//     required this.createdAt,
//   });

//   factory DiseaseReport.fromJson(Map<String, dynamic> json) {
//     return DiseaseReport(
//       code: json['Code'] as String,
//       description: json['Description'] as String,
//       photo: json['Photo'] as String? ?? '',
//       latitude: json['Latitude'] as String,
//       longitude: json['Longitude'] as String,
//       cropId: json['CropId'] as int,
//       diseaseId: json['DiseaseId'] as int,
//       isPrivate: json['IsPrivite'] as bool,
//       createdAt: DateTime.parse(json['Created_At']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'Code': code,
//       'Description': description,
//       'Photo': photo,
//       'Latitude': latitude,
//       'Longitude': longitude,
//       'CropId': cropId,
//       'DiseaseId': diseaseId,
//       'IsPrivite': isPrivate,
//       'Created_At': createdAt.toIso8601String(),
//     };
//   }
// }

import 'dart:convert';
import 'dart:io';

class DiseaseReport {
  String code;
  String description;
  String? photoPath; // Representação do caminho da foto como String
  File? photo; // Representação do arquivo da foto
  String latitude;
  String longitude;
  int cropId;
  int diseaseId;
  bool isPrivate;
  DateTime createdAt;

  DiseaseReport({
    required this.code,
    required this.description,
    this.photoPath,
    this.photo,
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
      photoPath: json['Photo'] as String?, // Atribui o caminho da foto
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
      'Photo': photoPath, // Usa photoPath para representar o caminho da foto
      'Latitude': latitude,
      'Longitude': longitude,
      'CropId': cropId,
      'DiseaseId': diseaseId,
      'IsPrivite': isPrivate,
      'Created_At': createdAt.toIso8601String(),
    };
  }
}
