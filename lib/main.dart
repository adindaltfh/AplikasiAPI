import 'package:flutter/material.dart';
import 'package:myapp/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Makeup API App',
      theme: ThemeData(
        brightness: Brightness.light, // Mode terang
        primarySwatch: Colors.pink, // Warna utama
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
        ).copyWith(
          secondary: Colors.pinkAccent, // Warna aksen
        ),
        scaffoldBackgroundColor: Colors.white, // Warna background aplikasi
        appBarTheme: AppBarTheme(
          color: Colors.pink, // Warna AppBar
          titleTextStyle: TextStyle( // Warna teks di AppBar
            color: Colors.white, 
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.pink, // Warna tombol
          textTheme: ButtonTextTheme.primary,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.pink, // Warna FAB
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle( // Mengganti headline6 dengan titleLarge
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}
