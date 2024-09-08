// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_language_translator/pages/home.dart';
import 'package:flutter_language_translator/themes/theme.dart';

void main() {
  runApp(MaterialApp(
    theme: darkTheme,
    initialRoute: '/home',
    routes: {
      '/home': (contex) => Home(),
    },
  ));
}
