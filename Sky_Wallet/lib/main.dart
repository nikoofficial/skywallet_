import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skywallet/Components/Navbar.dart';
import 'package:skywallet/Modules/Variables/Theme.dart';
import 'package:skywallet/Pages/SubMenus/LoginPage/index.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final pref = await SharedPreferences.getInstance();
  if (pref.containsKey('token_key')) {
    runApp(MyApp(
      back: true,
    ));
  } else {
    runApp(MyApp(back: false));
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key key, this.back}) : super(key: key);
  bool back;
  @override
  Widget build(BuildContext context) {
    //Lock device on portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    if (back) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            //primarySwatch: Colors.cyan,
            primaryColor: Colors.white,
            canvasColor: navbarBg),
        home: NavBar(),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            //primarySwatch: Colors.cyan,
            primaryColor: Colors.white,
            canvasColor: navbarBg),
        home: LoginPage(),
      );
    }
  }
}
