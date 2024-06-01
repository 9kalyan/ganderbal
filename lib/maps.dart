import 'package:android_id/android_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class Mapp extends StatefulWidget {
  const Mapp({Key? key}) : super(key: key);

  @override
  _MappState createState() => _MappState();
}

class _MappState extends State<Mapp> {
  String link = "";

  Future<void> fetchData() async {
      await Hive.openBox("local");
      var box = Hive.box("local");
      Location location=new Location();
      final position = await location.getLocation();
      print("mapsssssssssssss");
      print("mapsssssssssssss");
      const _androidIdPlugin = AndroidId();
      final String? androidId = await _androidIdPlugin.getId();
      Uri uri = await Uri.parse(
          "https://api1.aksasoft.net/patr_dplganderbal/webservices/mymaps.php?id=${androidId}&lat=${position.latitude}&long1=${position.longitude}&token=${box.get("token")}&passcode=97786068765874&fingerprint=biometric123&number=${box.get("number")}&accuracy=${position.accuracy}");
      http.Response response = await http.get(uri);
      print("hi ka"+response.statusCode.toString());
      print("device"+androidId.toString());
      print("token"+box.get("token"));
        setState(() {
          link = response.body;
          print("response is"+response.body);
        });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Container(
        child: link.isNotEmpty
            ? InAppWebView(
          initialSettings: InAppWebViewSettings(displayZoomControls: true),
          initialUrlRequest: URLRequest(url: WebUri(link)),
          onLoadError: (controller, url, code, message) {

            print("Error loading $url: $message");

          },
        )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
////////////////////
class Mapss extends StatefulWidget {
  Mapss({Key? key}) : super(key: key);

  @override
  _MapppState createState() => _MapppState();
}
class _MapppState extends State<Mapss> {
  Future<String> fetchData() async {
    await Hive.openBox("local");
    var box = Hive.box("local");
    Location location = Location();
    final position = await location.getLocation();
    print("mapsssssssssssss");
    print("mapsssssssssssss");
    const _androidIdPlugin = AndroidId();
    final String? androidId = await _androidIdPlugin.getId();
    Uri uri = Uri.parse(
        "https://api1.aksasoft.net/patr_dplganderbal/webservices/track_me_live.php?id=${androidId}&lat=${position.latitude}&long1=${position.longitude}&token=${box.get("token")}&passcode=97786068765874&fingerprint=biometric123&number=${box.get("number")}&accuracy=${position.accuracy}");
    http.Response response = await http.get(uri);
    print("kal" + "https://api1.aksasoft.net/patr_dplganderbal/webservices/track_me_live.php?id=${androidId}&lat=${position.latitude}&long1=${position.longitude}&token=${box.get("token")}&passcode=97786068765874&fingerprint=biometric123&number=${box.get("number")}&accuracy=${position.accuracy}");
    print("hi ka" + response.statusCode.toString());
    print("device" + androidId.toString());
    print("token" + box.get("token"));
    String link =
        "https://api1.aksasoft.net/patr_dplganderbal/webservices/track_me_live.php?id=${androidId}&lat=${position.latitude}&long1=${position.longitude}&token=${box.get("token")}&passcode=97786068765874&fingerprint=biometric123&number=${box.get("number")}&accuracy=${position.accuracy}";
    print("response is" + response.body);
    return link;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return InAppWebView(
              initialSettings:
              InAppWebViewSettings(displayZoomControls: true),
              initialUrlRequest: URLRequest(url: WebUri(snapshot.data!)),
              onLoadError: (controller, url, code, message) {
                print("Error loading $url: $message");
              },
            );
          }
        },
      ),
    );
  }
}

class Map3 extends StatefulWidget {
  final String url;
  Map3({required this.url});
  @override
  _Map3State createState() => _Map3State();
}
class _Map3State extends State<Map3> {
  Future<String> fetchData() async {
    await Future.delayed(Duration(seconds: 1));
    return this.widget.url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return InAppWebView(
              initialSettings:
              InAppWebViewSettings(displayZoomControls: true),
              initialUrlRequest: URLRequest(url: WebUri(snapshot.data!)),
              onLoadError: (controller, url, code, message) {
                print("Error loading $url: $message");
              },
            );
          }
        },
      ),
    );
  }
}
