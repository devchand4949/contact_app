import 'package:contactapp/screens/home_sceen.dart';
import 'package:contactapp/screens/plash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final colorscheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 198, 226, 56));

final theme = ThemeData().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: colorscheme,
    textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
      titleSmall:GoogleFonts.ubuntuCondensed(
        // fontWeight: FontWeight.bold
      ),
      titleMedium:GoogleFonts.ubuntuCondensed(
          // fontWeight: FontWeight.bold
      ),
      titleLarge: GoogleFonts.ubuntuCondensed(
          fontWeight: FontWeight.bold
      ),
    ),


);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: SplashScreen(),
    );
  }
}
