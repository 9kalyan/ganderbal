import 'dart:convert';
import 'package:android_id/android_id.dart';
import 'package:flutter/material.dart';
import 'package:ganderbal/maps.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class Patrollinghistory extends StatefulWidget {
  const Patrollinghistory({Key? key}) : super(key: key);

  @override
  State<Patrollinghistory> createState() => _PatrollinghistoryState();
}

class _PatrollinghistoryState extends State<Patrollinghistory> {
  Future<List<Map<String, dynamic>>> fetchPatrollingHistory() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      const _androidIdPlugin = AndroidId();
      final String? androidId = await _androidIdPlugin.getId();
      await Hive.openBox("local");
      var boxx = Hive.box("local");
      final uri = Uri.parse(
          "https://api1.aksasoft.net/patr_dplganderbal/webservices/view_patr_histoty.php?id=${androidId.toString()}&lat=${position.latitude}&long1=${position.longitude}&token=${boxx.get("token")}&passcode=97786068765874&fingerprint=biometric123&mobile=${boxx.get("number")}&accuracy=${position.accuracy}&type=all");
      final response = await http.get(uri);
      print("response"+jsonDecode(response.body).toString());
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
        title: const Text("PatrollingHistory"),
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
                Stack(
                  children: [
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
                                  Align(
                                    alignment: Alignment.topRight,
                                        child: InkWell(
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Map3(
                                                  url:data[index]['link'])));
                                            },
                                            child: Icon( Icons.search))),
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
                                  Text("Started:",style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text(data[index]['Started'].toString()),
                                ],
                              ),
                              Wrap(
                                children: [
                                  Text("Concluded:",style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text(data[index]['Concluded"'].toString()),
                                ],
                              ),
                              Wrap(
                                children: [
                                  Text("Status:",style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text(data[index]['Status'].toString()),
                                ],
                              ),
                            ],
                          ),
                        );
                    },
                  ),

                  ]
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


// class Patrollinghistory extends StatefulWidget {
//   const Patrollinghistory({super.key});
//
//   @override
//   State<Patrollinghistory> createState() => _PatrollinghistoryState();
// }
//
// class _PatrollinghistoryState extends State<Patrollinghistory> {
//   Future<List<Map<String,dynamic>>> returnn()async{
//
//     List<Map<String,dynamic>> listt=[{"kalyan":9},{"kalyan":9},{"kalyan":9},{"kalyan":9},];
//     await Future.delayed(Duration(seconds: 2));
//     return listt;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Patrolling history"),
//       ),
//       body: Center(
//         child: Container(
//           margin: EdgeInsets.all(10),
//           child: FutureBuilder(
//               future: returnn(),
//               builder: (c,s){
//                 if(s.hasData){
//                   return
//                     ListView.builder(
//                       itemCount: s.data!.length,
//                       itemBuilder: (context,index)=> Container(padding: EdgeInsets.all(10),
//                         child: DataTable(
//                           columns: [DataColumn(label:Text( "")),DataColumn(label:Text(""))],
//                           rows: [DataRow(cells: [
//                             DataCell(Text("Session_ID")),
//                             DataCell(Text(s.data![index]['kalyan'].toString()))]),
//                             DataRow(cells: [
//                               DataCell(Text("Patrolling_IO")),
//                               DataCell(Text(s.data![index]['kalyan'].toString()))]),
//                             DataRow(cells: [
//                               DataCell(Text("Timestamp")),
//                               DataCell(Text(s.data![index]['kalyan'].toString()))]),
//                             DataRow(cells: [
//                               DataCell(Text("Status")),
//                               DataCell(Text(s.data![index]['kalyan'].toString()))]),
//                             DataRow(cells: [
//                               DataCell(Text("Violation")),
//                               DataCell(Text(s.data![index]['kalyan'].toString()))]),
//                             DataRow(cells: [
//                               DataCell(Text("Violation_Param")),
//                               DataCell(Text(s.data![index]['kalyan'].toString()))]),
//                           ],
//                           decoration: BoxDecoration(
//                               color: Colors.yellow,
//                               border: BorderDirectional(
//                                 bottom: BorderSide(
//                                     color: Colors.black
//                                 ),
//                                 top: BorderSide(
//                                     color: Colors.black
//                                 ),
//                                 start : BorderSide(
//                                     color: Colors.black
//                                 ),
//                                 end: BorderSide(
//                                     color: Colors.black
//                                 ),
//
//                               )
//                           ),
//                         ),
//                       ),
//                     );}
//                 else return CircularProgressIndicator();
//               }
//           ),
//         ),
//       ),
//     );
//   }
// }
