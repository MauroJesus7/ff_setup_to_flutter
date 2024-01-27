
import 'package:ff_setup_to_flutter/main.dart';

import 'home_page.dart' show HomeWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeModel(),
      child: MyApp(),
    ),
  );
}

class HomeModel with ChangeNotifier {
  String _fullName = '';
  String _userId = '';

  String get fullName => _fullName;
  String get userId => _userId;

  setUserData(String fullName, String userId) {
    _fullName = fullName;
    _userId = userId;
    notifyListeners();
  }
}
