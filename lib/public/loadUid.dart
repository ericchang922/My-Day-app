import 'package:shared_preferences/shared_preferences.dart';

Future<String> loadUid() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('uid');
}