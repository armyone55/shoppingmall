import 'package:flutter/material.dart';

class MyConstant {
//Genernal
  static String appName = 'Smartglyph';

  //Route
  static String routeAuthen = '/auten';
  static String routeCreateAccount = '/createAcconut';
  static String routeBuyerService = '/buyerSevice';
  static String routeSalerService = '/salerSevice';
  static String routeRiderSevice = '/riderSevice';

  //Image
  static String image1 = 'images/image1.png';
  static String image2 = 'images/image2.png';
  static String image3 = 'images/image3.png';
  static String image4 = 'images/image4.png';
  static String avatar = 'images/avatar.png';

//color
  static Color primary = new Color(0xff33691e);
  static Color dart = new Color(0xff629749);
  static Color light = new Color(0xff003d00);

  //style
  TextStyle h1Style() =>
      TextStyle(fontSize: 24, color: dart, fontWeight: FontWeight.bold);
  TextStyle h2Style() =>
      TextStyle(fontSize: 18, color: dart, fontWeight: FontWeight.w700);
  TextStyle h3Style() =>
      TextStyle(fontSize: 14, color: dart, fontWeight: FontWeight.normal);

  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        primary: MyConstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
}
