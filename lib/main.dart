import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/home.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.orangeAccent,
        primarySwatch: Colors.red,
      ),
      home: MainApp(),
    ));
