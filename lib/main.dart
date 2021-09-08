import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:My_Day_app/account/login.dart';
import 'package:My_Day_app/home/homeUpdate.dart';
import 'package:My_Day_app/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

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
      theme: ThemeData(
        primaryColor: Color(0xffF86D67), //主色
        primaryColorLight: Color(0xffFFAAA6), //次色
        primaryColorDark: Color(0xffFFF5F5), //超淡色
        accentColor: Color(0xffFFB5B5), //淡色
        bottomAppBarColor: Color(0xffFB8B86),
      ),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [routeObserver],
      home: HomeUpdate(child: Home()),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new LoginPage(),
      },
    );
  }
}
