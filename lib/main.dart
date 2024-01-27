import 'package:ff_setup_to_flutter/disease_reports_screen1.dart';
import 'package:ff_setup_to_flutter/home_page.dart';
import 'package:ff_setup_to_flutter/services/ApiService.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:ff_setup_to_flutter/login_screen.dart';
import 'package:flutter/material.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => HomeModel(),
//       child: MaterialApp(
//         title: 'AGRISmartPro - App',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 10, 187, 166)),
//           useMaterial3: true,
//         ),
//         home: const LoginScreenWidget(),
//         debugShowCheckedModeBanner: false,
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeModel()),
        Provider(create: (context) => ApiService()),
        // Adicione outros providers aqui, se necessário
      ],
      child: MaterialApp(
        title: 'AGRISmartPro - App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 10, 187, 166)),
          useMaterial3: true,
        ),
        home: const LoginScreenWidget(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}