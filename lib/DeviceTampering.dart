// {
// "posts": [
// {
// "Session_ID": 157,
// "Patrolling_IO": "Khursheed Ah  SHO Police Station Lar",
// "Timestamp": "30-May-2024 17:44:10",
// "Status": "test",
// "Violation": "Milestone",
// "Violation_Param": "Session Initiated: May 30 2024 17:44:10"
// },
import 'dart:convert';
import 'package:android_id/android_id.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class DeviceTampering extends StatefulWidget {
  const DeviceTampering({Key? key}) : super(key: key);
  @override
  State<DeviceTampering> createState() => _DeviceTamperingState();
}

class _DeviceTamperingState extends State<DeviceTampering> {
  Future<List<Map<String, dynamic>>> fetchPatrollingHistory() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      const _androidIdPlugin = AndroidId();
      final String? androidId = await _androidIdPlugin.getId();
      await Hive.openBox("local");
      var boxx = Hive.box("local");
      final uri = Uri.parse(
          "https://api1.aksasoft.net/patr_dplganderbal/webservices/view_trails.php?id=${androidId.toString()}&lat=${position.latitude}&long1=${position.longitude}&token=${boxx.get("token")}&passcode=97786068765874&fingerprint=biometric123&mobile=${boxx.get("number")}&accuracy=${position.accuracy}&&violation=tampering");
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);
        if (responseData is Map && responseData.containsKey('posts')) {
          return List<Map<String, dynamic>>.from(responseData['posts']);
        } else {
          print('Invalid response format or missing "posts" key.');
          return [];
        }
      } else {
        print('HTTP request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error decoding JSON: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DeviceTampering"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchPatrollingHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return
              Container(
                height: double.infinity,
                child:
                ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return
                      Container(
                        margin: EdgeInsets.all(3),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 2, // Border width
                          ),
                        ),
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              children: [
                                Text("Session_ID: ",style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(data[index]['Session_ID'].toString()),
                              ],
                            ),
                            Wrap(
                              children: [
                                Text("Patrolling_IO: ",style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(data[index]['Patrolling_IO'].toString()),
                              ],
                            ),
                            Wrap(
                              children: [
                                Text("Timestamp:",style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(data[index]['Timestamp'].toString()),
                              ],
                            ),
                            Wrap(
                              children: [
                                Text("Status: ",style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(data[index]['Status'].toString()),
                              ],
                            ),
                            Wrap(
                              children: [
                                Text("Violation:",style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(data[index]['Violation'].toString()),
                              ],
                            ),
                            Wrap(
                              children: [
                                Text("Violation_Param:",style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(data[index]['Violation_Param'].toString()),
                              ],
                            ),
                          ],
                        ),
                      );
                  },
                ),
              );
          } else {
            return Center(child: Text("Empty"));
          }
        },
      ),
    );
  }
}
