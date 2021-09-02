import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop App',
      theme: ThemeData(
          fontFamily: 'Raleway',
                    primarySwatch: Colors.orange,
          accentColor: Colors.pink,

          canvasColor: Color.fromRGBO(240, 240, 230, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
                // ignore: deprecated_member_use
                body1: TextStyle(color: Color.fromRGBO(50, 20, 55, 1)),
                // ignore: deprecated_member_use
                title: TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
      routes: {
        '/': (ctx) => ProductOverviewScreen(),
        ProductDetailScreen.routeName : (ctx) => ProductDetailScreen()
      },
    );
  }
}
