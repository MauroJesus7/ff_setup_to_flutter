import 'dart:convert';
import 'dart:io';

class PestReport {
  String code;
  String description;
  String? photoPath; // Representação do caminho da foto como String
  File? photo; // Representação do arquivo da foto
  String latitude;
  String longitude;
  int cropId;
  int pestId;
  bool isPrivate;
  DateTime createdAt;

  PestReport({
    required this.code,
    required this.description,
    this.photoPath, // Adicione photoPath como um parâmetro opcional
    this.photo, // Adicione photo como um parâmetro opcional
    required this.latitude,
    required this.longitude,
    required this.cropId,
    required this.pestId,
    required this.isPrivate,
    required this.createdAt,
  });

  factory PestReport.fromJson(Map<String, dynamic> json) {
    return PestReport(
      code: json['Code'] as String,
      description: json['Description'] as String,
      photoPath: json['Photo'] as String?, // Atribui o caminho da foto
      latitude: json['Latitude'] as String,
      longitude: json['Longitude'] as String,
      cropId: json['CropId'] as int,
      pestId: json['PestId'] as int,
      isPrivate: json['IsPrivite'] as bool,
      createdAt: DateTime.parse(json['Created_At']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Code': code,
      'Description': description,
      'Photo': photoPath,
      'Latitude': latitude,
      'Longitude': longitude,
      'CropId': cropId,
      'PestId': pestId,
      'IsPrivite': isPrivate,
      'Created_At': createdAt.toIso8601String(),
    };
  }
}
