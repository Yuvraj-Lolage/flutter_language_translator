import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 17, 17, 17),
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        titleSpacing: 40),
    scaffoldBackgroundColor: const Color.fromARGB(255, 17, 17, 17),
    dropdownMenuTheme: const DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(),
            labelStyle: TextStyle(wordSpacing: 1, color: Colors.white)),
        textStyle: TextStyle(color: Colors.amber),
        menuStyle: MenuStyle()),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedIconTheme: IconThemeData(color: Colors.grey[700]),
        unselectedItemColor: Colors.grey[700],
        unselectedLabelStyle: TextStyle(color: Colors.grey[700]),
        selectedIconTheme:
            const IconThemeData(color: Color.fromRGBO(6, 214, 158, 1)),
        selectedItemColor: const Color.fromRGBO(6, 214, 158, 1),
        selectedLabelStyle: const TextStyle(
            color: Color.fromRGBO(6, 214, 158, 1), fontWeight: FontWeight.bold),
        backgroundColor: Colors.black));
