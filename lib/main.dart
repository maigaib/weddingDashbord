import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weddingadministration/connexion.dart';
import 'package:weddingadministration/firebase_options.dart';
import 'package:weddingadministration/responsive/desktop_body.dart';
import 'package:weddingadministration/responsive/tablet_body.dart';

import 'responsive/mobile_body.dart';
import 'responsive/responsive_layout.dart';
import 'package:intl/date_symbol_data_local.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
initializeDateFormatting('fr_FR');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: ConnexionPage(),
      routes: {
      '/dashboard': (context) =>  ResponsiveLayout(
        mobileBody: const MobileScaffold(),
        tabletBody: const TabletScaffold(),
        desktopBody: const DesktopScaffold(),
      ),
    },
     
    );
  }
}
