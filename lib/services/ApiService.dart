import 'package:ff_setup_to_flutter/home_model.dart';
import 'package:ff_setup_to_flutter/models/DiseaseReport.dart';
import 'package:ff_setup_to_flutter/models/PestReport.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io';

class ApiService {
  static const String baseUrl = "https://10.0.2.2:44384";
  //static const String baseUrl = "https://192.168.1.75:44384";

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/Account/Login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'Email': email,
          'Password': password,
          'RememberMe': true,
        }),
      ).timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['Success']) {
          if (responseData['TeamCode'] == null) {
            return {
              "status": "Error",
              "message":
                  "Your account is not assigned to any team. Please contact administration.",
            };
          }

          String? rawCookieHeader = response.headers['set-cookie'];
          if (rawCookieHeader != null) {
            String cookieValue = rawCookieHeader.split(',').firstWhere(
                  (c) => c.trim().startsWith('.AspNet.ApplicationCookie'),
                  orElse: () => '', // Retorna string vazia se não encontrar
                );

            if (cookieValue.isNotEmpty) {
              int index = cookieValue.indexOf(';');
              if (index != -1) {
                cookieValue = cookieValue.substring(0, index);
              }
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('cookie', cookieValue);

              // Imprimir o cookie na console
              print("Cookie received after login: $cookieValue");
            }
          }
          // Se o login for bem-sucedido, retorna um mapa com o status, UserId e FullName
          return {
            "status": "Success",
            "userId": responseData['UserId'],
            "fullName": responseData['FullName'],
            "teamCode": responseData['TeamCode'],
          };
        } else {
          // Se o login não for bem-sucedido, retorna um mapa com o status e a mensagem de erro
          return {"status": "Error", "message": responseData['Message']};
        }
      } else if (response.statusCode == 400) {
        final responseData = json.decode(response.body);
        String errorMessage = "Wrong email or password! Try again.";

        if (responseData['Message'] == "The request is invalid.") {
          errorMessage = "The Email field is not a valid email address.";
        }

        return {"status": "Error", "message": errorMessage};
      } else {
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');
        return {"status": "Error", "server-error": "Server error"};
      }
    } catch (e) {
      print(e);
      return {"status": "Error", "message": "Connection error"};
    }
  }

  Future<String?> getSavedCookie() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('cookie');
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cookieValue = prefs.getString('cookie');

      if (cookieValue != null) {
        final response = await http.post(
          Uri.parse('$baseUrl/api/Account/Logout'),
          headers: {
            'Content-Type': 'application/json',
            'Cookie': cookieValue, // Envia o cookie de autenticação no header
          },
        );

        if (response.statusCode == 200) {
          // Remova o cookie de autenticação após o logout
          await prefs.remove('cookie');
          print('Logout successful');
        } else {
          print('Logout failed. Response Status: ${response.statusCode}');
          print('Response Body: ${response.body}');
        }
      }
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  Future<void> createDiseaseReport(
      DiseaseReport report, File? imageFile) async {
    final prefs = await SharedPreferences.getInstance();
    final cookie = prefs.getString('cookie');

    // Cria um URI a partir do seu baseUrl
    var uri = Uri.parse('$baseUrl/api/APIDiseaseReports/Create');

    // Cria um request multipart
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll({
        'Cookie': cookie ?? '',
      });

    // Adiciona os campos de texto
    request.fields['Code'] = report.code;
    request.fields['Description'] = report.description;
    request.fields['Latitude'] = report.latitude.toString();
    request.fields['Longitude'] = report.longitude.toString();
    request.fields['CropId'] = report.cropId.toString();
    request.fields['DiseaseId'] = report.diseaseId.toString();
    request.fields['IsPrivite'] = report.isPrivate.toString();

    // Adiciona o arquivo, se presente
    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'Photo',
        imageFile.path,
        filename: basename(imageFile.path), // O nome do arquivo
      ));
    }

    // Envia o request
    var streamedResponse = await request.send();

    // Obtém a resposta
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print('Report successfully created.');
    } else if (response.statusCode == 400) {
      final errors = json.decode(response.body) as Map<String, dynamic>;
      if (errors.containsKey("ReportCode")) {
        final errorMessage = errors["ReportCode"][0];
        print('Error: $errorMessage');
      } else {
        print('Error creating report. Status code: ${response.statusCode}');
      }
    } else {
      print('Error. Status code: ${response.statusCode}');
    }
  }

  Future<void> createPestReport(PestReport report, File? imageFile) async {
    final prefs = await SharedPreferences.getInstance();
    final cookie = prefs.getString('cookie');

    // Cria um URI a partir do seu baseUrl
    var uri = Uri.parse('$baseUrl/api/APIPestReports/Create');

    // Cria um request multipart
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll({
        'Cookie': cookie ?? '',
      });

    // Adiciona os campos de texto
    request.fields['Code'] = report.code;
    request.fields['Description'] = report.description;
    request.fields['Latitude'] = report.latitude.toString();
    request.fields['Longitude'] = report.longitude.toString();
    request.fields['CropId'] = report.cropId.toString();
    request.fields['PestId'] = report.pestId.toString();
    request.fields['IsPrivite'] = report.isPrivate.toString();

    // Adiciona o arquivo, se presente
    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'Photo',
        imageFile.path,
        filename: basename(imageFile.path), // O nome do arquivo
      ));
    }

    // Envia o request
    var streamedResponse = await request.send();

    // Obtém a resposta
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print('Report successfully created.');
    } else if (response.statusCode == 400) {
      final errors = json.decode(response.body) as Map<String, dynamic>;
      if (errors.containsKey("ReportCode")) {
        final errorMessage = errors["ReportCode"][0];
        print('Error: $errorMessage');
      } else {
        print('Error creating report. Status code: ${response.statusCode}');
      }
    } else {
      print('Error. Status code: ${response.statusCode}');
    }
  }

  Future<ReportsResponse> getUserReports() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/APIDiseaseReports/UserReports'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': await getSavedCookie() ?? '',
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        Iterable json = jsonDecode(response.body);
        List<DiseaseReport> reports = List<DiseaseReport>.from(
            json.map((model) => DiseaseReport.fromJson(model)));
        return ReportsResponse(reports: reports);
      } else if (response.statusCode == 404 &&
          response.body == "No disease reports found for current user.") {
        return ReportsResponse(
            errorMessage: "No disease reports found for current user.");
      } else {
        return ReportsResponse(errorMessage: 'Failed to load reports');
      }
    } catch (e) {
      return ReportsResponse(errorMessage: 'An error occurred');
    }
  }

  Future<PestReportsResponse> getUserPestReports() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/APIPestReports/UserReports'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': await getSavedCookie() ?? '',
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        Iterable json = jsonDecode(response.body);
        List<PestReport> reports = List<PestReport>.from(
            json.map((model) => PestReport.fromJson(model)));
        return PestReportsResponse(pestReports: reports);
      } else if (response.statusCode == 404 &&
          response.body == "No pest reports found for current user.") {
        return PestReportsResponse(
            errorMessage: "No pest reports found for current user.");
      } else {
        return PestReportsResponse(errorMessage: 'Failed to load reports');
      }
    } catch (e) {
      return PestReportsResponse(errorMessage: 'An error occurred');
    }
  }

  static Future<String> getCropNameById(int cropId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/api/Items/Crops/$cropId'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['Name'];
    } else {
      throw Exception('Failed to load crop name');
    }
  }

  static Future<String> getDiseaseNameById(int diseaseId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/api/Items/Diseases/$diseaseId'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['Name'];
    } else {
      throw Exception('Failed to load disease name');
    }
  }

  static Future<String> getPhotoUrlByReportCode(String reportCode) async {
    final photoUrl =
        '$baseUrl/api/APIDiseaseReports/PhotoByReportCode/$reportCode';
    final response = await http.get(Uri.parse(photoUrl));
    if (response.statusCode == 200) {
      return photoUrl; // Sucesso, a foto existe no servidor
    } else {
      return 'URL_da_imagem_padrao'; // URL de fallback
    }
  }

  static Future<List<dynamic>> getCrops() async {
    final response = await http.get(Uri.parse('$baseUrl/api/Items/Crops'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load crops');
    }
  }

  static Future<List<dynamic>> getDiseasesByCrop(int cropId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/api/Items/DiseasesByCrop/$cropId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load diseases for cropId $cropId');
    }
  }

  static Future<List<dynamic>> getPestsByCrop(int cropId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/api/Items/PestsByCrop/$cropId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load pests for cropId $cropId');
    }
  }
}

class ReportsResponse {
  final List<DiseaseReport>? reports;
  final String? errorMessage;

  ReportsResponse({this.reports, this.errorMessage});
}

class PestReportsResponse {
  final List<PestReport>? pestReports;
  final String? errorMessage;

  PestReportsResponse({this.pestReports, this.errorMessage});
}
