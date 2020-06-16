import 'package:HyperBeam/auth_widget_builder.dart';
import 'package:HyperBeam/homePage.dart';
import 'package:flutter/material.dart';
import 'package:HyperBeam/authPage.dart';
import 'package:HyperBeam/main.dart';
import 'package:HyperBeam/createQuiz.dart';
import 'package:HyperBeam/routing_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeRoute:
      return MaterialPageRoute(builder: (context) => HomePage());
    case CreateQuizRoute:
      return MaterialPageRoute(builder: (context) => CreateQuiz());
    default:
      return MaterialPageRoute(builder: (context) => AuthPage());
  }
}