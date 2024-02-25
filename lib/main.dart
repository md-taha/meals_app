import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals_appp/screens/tabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main(){
  runApp(ProviderScope(child:App()));
}

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const TabsScreen(), theme: theme,);
  }
}