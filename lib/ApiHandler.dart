import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:android_id/android_id.dart';
class ApiHandler {

  Future<String> sendOtp(String number, String lat, String long) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    const _androidIdPlugin = AndroidId();
    final String? androidId = await _androidIdPlugin.getId();
    //response contains a response body, a response status etc,
    //we are going to access the response body only
    //reponse body contains the actual data sent across network
    Uri uri = await Uri.parse(
        "https://api1.aksasoft.net/patr_dplganderbal/webservices/registerstatus.php?id=$androidId&lat=$lat&long1=$long&token=NA&passcode=97786068765874&fingerprint=biometric123&mobile=$number&accuracy=${position.accuracy}");
    http.Response response = await http.get(uri);
    //response contains a response body, a response status etc,
    //we are going to access the response body only
    //reponse body contains the actual data sent across network
    return response.body.toString();
  }

  Future<String> verifyOtp(String otp, String lat, String long) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    const _androidIdPlugin = AndroidId();

    final String? androidId = await _androidIdPlugin.getId();
    Uri uri = await Uri.parse(
        "https://api1.aksasoft.net/patr_dplganderbal/webservices/registerstatus.php?id=$androidId&lat=$lat&long1=$long&token=NA&passcode=97786068765874&fingerprint=biometric123&otp=$otp&accuracy=${position.accuracy}");
    http.Response response = await http.get(uri);

    //response contains a response body, a response status etc,
    //we are going to access the response body only
    //reponse body contains the actual data sent across network
    return response.body.toString();
  }

  Future<void> resetNumber(String number) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    const _androidIdPlugin = AndroidId();

    final String? androidId = await _androidIdPlugin.getId();
    Uri uri = await Uri.parse(
        "https://api1.aksasoft.net/patr_dplganderbal/webservices/reset.php?id=$androidId&lat=${position.latitude}&long1=${position.longitude}&token=NA&passcode=97786068765874&fingerprint=biometric123&mobile=$number");
    http.Response response = await http.get(uri);
  }
  Future<String> deviceStatus(String number, String token) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    const _androidIdPlugin = AndroidId();
    final String? androidId = await _androidIdPlugin.getId();
    Uri uri = await Uri.parse(
        "https://api1.aksasoft.net/patr_dplganderbal/webservices/devicestatus.php?id=$androidId&lat=${position.latitude.toString()}&long1=${position.longitude.toString()}&token=$token&passcode=97786068765874&fingerprint=biometric123&mobile=$number&accuracy=${position.accuracy}");
    http.Response response = await http.get(uri);
    return response.body.toString();
  }

  Future<String> startPatrolling(String number, String lat, String long,String token,String time,String date) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    const _androidIdPlugin = AndroidId();
    print("time:"+time);
    final String? androidId = await _androidIdPlugin.getId();
    final method=await getGpsInternet(number, lat, long, token);
    print("valuerishi "+method['value']);
    Uri uri = await Uri.parse(
        "https://api1.aksasoft.net/patr_dplganderbal/webservices/tracker.php?id=$androidId&lat=$lat&long1=$long&token=$token&passcode=97786068765874&fingerprint=biometric123&mobile=$number&accuracy=${position.accuracy}&switch=Start&method=${method['value']}&device_time=$time&device_date=$date");
    print(method['value']);
    https://api1.aksasoft.net/patr_dplganderbal/webservices/tracker.php?id=device123&lat=90&long1=7&token=KsWKSnlxSvHn0pd3&passcode=97786068765874&fingerprint=biometric123&number=8923944033&accuracy=10&switch=Start&method=Internet&device_time=12:22:46&device_date=2024-05-15
    http.Response response = await http.get(uri);
    print(response.body.toString());
    return response.body.toString();
  }

  Future<String> pausePatrolling(String number, String lat, String long,String token,String time,String date) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    const _androidIdPlugin = AndroidId();
    final String? androidId = await _androidIdPlugin.getId();
    final method=await getGpsInternet(number, lat, long, token);
    Uri uri = await Uri.parse(
        "https://api1.aksasoft.net/patr_dplganderbal/webservices/tracker.php?id=$androidId&lat=$lat&long1=$long&token=$token&passcode=97786068765874&fingerprint=biometric123&mobile=$number&accuracy=${position.accuracy}&switch=Pause&method=GPS&device_time=$time&device_date=$date");
    https://api1.aksasoft.net/patr_dplganderbal/webservices/tracker.php?id=device123&lat=90&long1=7&token=KsWKSnlxSvHn0pd3&passcode=97786068765874&fingerprint=biometric123&number=8923944033&accuracy=10&switch=Start&method=Internet&device_time=12:22:46&device_date=2024-05-15
    http.Response response = await http.get(uri);
    return response.body.toString();
  }
  Future<String> completePatrolling(String number, String lat, String long,String token,String time,String date) async {
    final method=await getGpsInternet(number, lat, long, token);
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    const _androidIdPlugin = AndroidId();

    final String? androidId = await _androidIdPlugin.getId();
    print(method);
    Uri uri = await Uri.parse(
        "https://api1.aksasoft.net/patr_dplganderbal/webservices/tracker.php?id=$androidId&lat=$lat&long1=$long&token=$token&passcode=97786068765874&fingerprint=biometric123&mobile=$number&accuracy=${position.accuracy}&switch=Complete&method=${method['value']}&device_time=$time&device_date=$date");
    https://api1.aksasoft.net/patr_dplganderbal/webservices/tracker.php?id=device123&lat=90&long1=7&token=KsWKSnlxSvHn0pd3&passcode=97786068765874&fingerprint=biometric123&number=8923944033&accuracy=10&switch=Start&method=Internet&device_time=12:22:46&device_date=2024-05-15
    http.Response response = await http.get(uri);
    return response.body.toString();
  }
  Future<void> refresh(String number, String lat, String long,String token) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    const _androidIdPlugin = AndroidId();
    final String? androidId = await _androidIdPlugin.getId();https://api1.aksasoft.net/patr_dplganderbal/webservices/myprofile.php?id=$androidId&lat=$lat&long1=$long&token=$token&passcode=97786068765874&fingerprint=biometric123&mobile=$number&accuracy=10
    Uri uri = await Uri.parse(
        "https://api1.aksasoft.net/patr_dplganderbal/webservices/validation.php?id=$androidId&lat=$lat&long1=$long&token=$token&passcode=97786068765874&fingerprint=biometric123&mobile=$number&accuracy=${position.accuracy}");
    https://api1.aksasoft.net/patr_dplganderbal/webservices/tracker.php?id=device123&lat=90&long1=7&token=KsWKSnlxSvHn0pd3&passcode=97786068765874&fingerprint=biometric123&number=8923944033&accuracy=10&switch=Start&method=Internet&device_time=12:22:46&device_date=2024-05-15
    http.Response response = await http.get(uri);
  }
  Future<Map<String,dynamic>> getProfile(String number, String lat, String long,String token) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    const _androidIdPlugin = AndroidId();
    final String? androidId = await _androidIdPlugin.getId();
    Uri uri = await Uri.parse(
        "https://api1.aksasoft.net/patr_dplganderbal/webservices/myprofile.php?id=$androidId&lat=$lat&long1=$long&token=$token&passcode=97786068765874&fingerprint=biometric123&mobile=$number&accuracy=${position.accuracy}");
    https://api1.aksasoft.net/patr_dplganderbal/webservices/tracker.php?id=device123&lat=90&long1=7&token=KsWKSnlxSvHn0pd3&passcode=97786068765874&fingerprint=biometric123&number=8923944033&accuracy=10&switch=Start&method=Internet&device_time=12:22:46&device_date=2024-05-15
    http.Response response = await http.get(uri);
    return jsonDecode(response.body)['posts'][0];
  }
  Future<Map<String,dynamic>> check_status(String number, String lat, String long,String token) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    const _androidIdPlugin = AndroidId();
    final String? androidId = await _androidIdPlugin.getId();
    Uri uri = await Uri.parse(
        "https://api1.aksasoft.net/patr_dplganderbal/webservices/status_check.php?id=$androidId&lat=$lat&long1=$long&token=$token&passcode=97786068765874&fingerprint=biometric123&mobile=$number&accuracy=${position.accuracy}");
    https://api1.aksasoft.net/patr_dplganderbal/webservices/tracker.php?id=device123&lat=90&long1=7&token=KsWKSnlxSvHn0pd3&passcode=97786068765874&fingerprint=biometric123&number=8923944033&accuracy=10&switch=Start&method=Internet&device_time=12:22:46&device_date=2024-05-15
    http.Response response = await http.get(uri);
    return jsonDecode(response.body)['posts'][0];
  }
  Future<Map<String,dynamic>> config_tracker(String number, String lat, String long,String token) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    const _androidIdPlugin = AndroidId();
    final String? androidId = await _androidIdPlugin.getId();
    Uri uri = await Uri.parse(
        "https://api1.aksasoft.net/patr_dplganderbal/webservices/config_tracker.php?id=$androidId&lat=$lat&long1=$long&token=$token&passcode=97786068765874&fingerprint=biometric123&mobile=$number&accuracy=${position.accuracy}");
    https://api1.aksasoft.net/patr_dplganderbal/webservices/tracker.php?id=device123&lat=90&long1=7&token=KsWKSnlxSvHn0pd3&passcode=97786068765874&fingerprint=biometric123&number=8923944033&accuracy=10&switch=Start&method=Internet&device_time=12:22:46&device_date=2024-05-15
    http.Response response = await http.get(uri);
    return jsonDecode(response.body)['posts'][1];
  }
  Future<Map<String,dynamic>> getGpsInternet(String number, String lat, String long,String token) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    const _androidIdPlugin = AndroidId();
    final String? androidId = await _androidIdPlugin.getId();
    Uri uri = await Uri.parse(
        "https://api1.aksasoft.net/patr_dplganderbal/webservices/config_tracker.php?id=$androidId&lat=$lat&long1=$long&token=$token&passcode=97786068765874&fingerprint=biometric123&mobile=$number&accuracy=${position.accuracy}");
    https://api1.aksasoft.net/patr_dplganderbal/webservices/tracker.php?id=device123&lat=90&long1=7&token=KsWKSnlxSvHn0pd3&passcode=97786068765874&fingerprint=biometric123&number=8923944033&accuracy=10&switch=Start&method=Internet&device_time=12:22:46&device_date=2024-05-15
    http.Response response = await http.get(uri);
    return jsonDecode(response.body)['posts'][2];
  }
  Future<String> support(String number, String lat, String long,String token) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    const _androidIdPlugin = AndroidId();
    final String? androidId = await _androidIdPlugin.getId();
    Uri uri = await Uri.parse(
        "https://api1.aksasoft.net/patr_dplganderbal/webservices/view_support.php?id=$androidId&lat=$lat&long1=$long&token=$token&passcode=97786068765874&fingerprint=biometric123&mobile=$number&accuracy=${position.accuracy}");
    https://api1.aksasoft.net/patr_dplganderbal/webservices/tracker.php?id=device123&lat=90&long1=7&token=KsWKSnlxSvHn0pd3&passcode=97786068765874&fingerprint=biometric123&number=8923944033&accuracy=10&switch=Start&method=Internet&device_time=12:22:46&device_date=2024-05-15
    http.Response response = await http.get(uri);
    return response.body.toString();
  }
  Future<Map<String,dynamic>> getFrequency(String number, String lat, String long,String token) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    const _androidIdPlugin = AndroidId();
    final String? androidId = await _androidIdPlugin.getId();
    Uri uri = await Uri.parse(
        "https://api1.aksasoft.net/patr_dplganderbal/webservices/config_tracker.php?id=$androidId&lat=$lat&long1=$long&token=$token&passcode=97786068765874&fingerprint=biometric123&mobile=$number&accuracy=${position.accuracy}");
    https://api1.aksasoft.net/patr_dplganderbal/webservices/tracker.php?id=device123&lat=90&long1=7&token=KsWKSnlxSvHn0pd3&passcode=97786068765874&fingerprint=biometric123&number=8923944033&accuracy=10&switch=Start&method=Internet&device_time=12:22:46&device_date=2024-05-15
    http.Response response = await http.get(uri);
    return jsonDecode(response.body)['posts'][1];
  }
}
