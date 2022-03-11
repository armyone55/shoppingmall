import 'package:flutter/material.dart';
import 'package:shoppingmall/states/authen.dart';
import 'package:shoppingmall/states/buyer_service.dart';
import 'package:shoppingmall/states/create_account.dart';
import 'package:shoppingmall/states/rider_sevice.dart';
import 'package:shoppingmall/states/saler_service.dart';
import 'package:shoppingmall/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/auten': (BuildContext context) => Authen(),
  '/createAcconut': (BuildContext context) => CreateAccount(),
  '/buyerSevice': (BuildContext context) => BuyerService(),
  '/salerSevice': (BuildContext context) => SalerSevice(),
  '/riderSevice': (BuildContext context) => RiderSevice(),
};

String? initlalRoule;

void main() {
  initlalRoule = MyConstant.routeAuthen;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initlalRoule,
    );
  }
}
