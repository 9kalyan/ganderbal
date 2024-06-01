// "Session_ID": 165,
// "Patrolling_IO": "Liyakat Khan SHO Police Post Shadipora",
// "Timestamp": "31-May-2024 19:33:10",
// "Status": "Taking a Break",
// "Event": "Milestone",
// "Event_Type": "Session Initiated: May 31 2024 19:33:10"
import 'dart:convert';
import 'package:android_id/android_id.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class MileStone extends StatefulWidget {
  const MileStone({Key? key}) : super(key: key);

  @override
  State<MileStone> createState() => _MileStoneState();
}

class _MileStoneState extends State<MileStone> {
  Future<List<Map<String, dynamic>>> fetchPatrollingHistory() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      const _androidIdPlugin = AndroidId();
      final String? androidId = await _androidIdPlugin.getId();
      await Hive.openBox("local");
      var boxx = Hive.box("local");
      final uri = Uri.parse(
          "https://api1.aksasoft.net/patr_dplganderbal/webservices/view_trails.php?id=${androidId.toString()}&lat=${position.latitude}&long1=${position.longitude}&token=${boxx.get("token")}&passcode=97786068765874&fingerprint=biometric123&mobile=${boxx.get("number")}&accuracy=${position.accuracy}&&violation=milestone");
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
        title: const Text("Milestones"),
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
                                Text("Event:",style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(data[index]['Event'].toString()),
                              ],
                            ),
                            Wrap(
                              children: [
                                Text("Event_Type:",style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(data[index]['Event_Type'].toString()),
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
