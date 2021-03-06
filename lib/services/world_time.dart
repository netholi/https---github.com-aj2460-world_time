import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class WorldTime {
  String location;
  String time = "";
  String flag;
  String url = "";
  bool isDayTime = true;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      var urlLink = Uri.parse("http://worldtimeapi.org/api/timezone/$url");

      var response = await http.read(urlLink);
      //Map data = jsonDecode(response);
      var decodeRespose = jsonDecode(response) as Map;
      //print(decodeRespose);
      String dt = (decodeRespose["datetime"]).toString().substring(0, 19);

      var date = DateTime.parse(dt);
      var formatedDate = DateFormat.jm().format(date);
      //print(formatedDate);
      isDayTime = date.hour >= 6 && date.hour <= 18 ? true : false;
      print(date.hour);
      time = formatedDate.toString();
    } catch (e) {
      print('Error : $e');
      time = "Could not get time data";
    }
  }
}
