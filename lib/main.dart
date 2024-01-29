import 'package:ff_setup_to_flutter/data_view_screen.dart';
import 'package:ff_setup_to_flutter/disease_reports_screen1.dart';
import 'package:ff_setup_to_flutter/home_page.dart';
import 'package:ff_setup_to_flutter/models/DiseaseReport.dart';
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
        // A rota inicial
        home: const LoginScreenWidget(),
        // Mapa de rotas
        routes: {
          '/login': (context) => const LoginScreenWidget(), // Substitua LoginScreenWidget pelo widget correto para a tela de login
          // Adicione outras rotas aqui
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class NavBarApp extends StatefulWidget {
  const NavBarApp({Key? key}) : super(key: key);

  @override
  _NavBarAppState createState() => _NavBarAppState();
}

class _NavBarAppState extends State<NavBarApp> {
  int _selectedIndex = 0;

  // Lista vazia de DiseaseReport
  final List<DiseaseReport> _emptyReports = [];

  late List<Widget> _pages;

  // static const List<Widget> _pages = <Widget>[
  //   HomeWidget(),
  //   DataViewScreenWidget(reports: _emptyReports), 
  // ];

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      const HomeWidget(),
      DataViewScreenWidget(),//reports: _emptyReports), // Usando a lista vazia
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
         BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Data Visualization',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 10, 187, 166),
        onTap: _onItemTapped,
      ),
    );
  }
}
