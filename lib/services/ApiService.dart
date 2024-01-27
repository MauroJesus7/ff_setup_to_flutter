import 'package:ff_setup_to_flutter/home_model.dart';
import 'package:ff_setup_to_flutter/models/DiseaseReport.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class ApiService {

  final String baseUrl = "https://10.0.2.2:44384";

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
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['Success']) {    

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
            "fullName": responseData['FullName']
          };
        } else {
          // Se o login não for bem-sucedido, retorna um mapa com o status e a mensagem de erro
          return {"status": "Error", "message": "Credenciais inválidas"};
        }
      } else {
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');
        return {"status": "Error", "message": "Erro no servidor"};
      }
    } catch (e) {
      print(e);
      return {"status": "Error", "message": "Erro na conexão"};
    }
  }

  Future<String?> getSavedCookie() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('cookie');
  }

  Future<void> createDiseaseReport(DiseaseReport report) async {
    final prefs = await SharedPreferences.getInstance();
    final cookie = prefs.getString('cookie');
    
    final response = await http.post(
      Uri.parse('$baseUrl/api/APIDiseaseReports/Create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': cookie ?? '',
      },
      body: jsonEncode(report.toJson()),
    );

    if (response.statusCode == 200) {
      print('Report successfully created.');
    } else {
      throw Exception('Error. Status code: ${response.statusCode}');
    }
  }

  Future<List<DiseaseReport>> getUserReports() async {
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
      return List<DiseaseReport>.from(json.map((model) => DiseaseReport.fromJson(model)));
    } else {
      throw Exception('Failed to load reports');
    }
  }

 
}
