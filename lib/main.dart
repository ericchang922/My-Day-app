import 'package:My_Day_app/account/login.dart';
import 'package:My_Day_app/home/home_Update.dart';
import 'package:My_Day_app/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  var id = prefs.getString('TestString_Key');
  print(id);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(id == null ? MyApp() : HomeWidget());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Day',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [const Locale('zh', 'TW')],
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xffF86D67), //主色
          primaryColorLight: Color(0xffFFAAA6), //次色
          primaryColorDark: Color(0xffFFF5F5), //超淡色
          accentColor: Color(0xffFFB5B5), //淡色
          bottomAppBarColor: Color(0xffFB8B86),
        ),
        home: HomeUpdate(child: Home()));
  }
}
