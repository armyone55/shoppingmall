import 'package:flutter/material.dart';

class MyConstant {
//Genernal
  static String appName ='Shoppping Mall';

  //Route
  static String routeAuthen = '/auten';
  static String routeCreateAccount = '/createAcconut';
  static String routeBuyerService = 'buyerSevice';
  static String routeSalerService = 'salerSevice';
  static String routeRiderSevice = 'riderSevice';

  //Image
  static String image1 = 'images/image1.png';
  static String image2 = 'images/image2.png';
  static String image3 = 'images/image3.png';
  static String image4 = 'images/image4.png';

//color
  static Color primary = Color.fromARGB(0, 202, 11, 11);
  static Color dart = Color.fromARGB(0, 18, 133, 18);
  static Color light = Color.fromARGB(0, 37, 65, 26);

  //style
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        color: dart,
        fontWeight: FontWeight.bold
      );
      TextStyle h2Style() => TextStyle(
        fontSize: 24,
        color: dart,
        fontWeight: FontWeight.w700
      );
      TextStyle h3Style() => TextStyle(
        fontSize: 24,
        color: dart,
        fontWeight: FontWeight.normal
      );
}
