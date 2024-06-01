import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyProfile extends StatelessWidget {
  final String Name;
  final String Designation;
  final String Station;
  final String Enrol_Code;
  final String Thana_Code;
  final String Mobile;
  final String Parentage;
  final String Email;
  final String Address;
  final String Zone;
  final String Enrolled_App;
  final String Role;


  MyProfile({
    required this.Name,
    required this.Designation,
    required this.Station,
    required this.Enrol_Code,
    required this.Thana_Code,
    required this.Mobile,
    required this.Parentage,
    required this.Email,
    required this.Address,
    required this.Zone,
    required this.Enrolled_App,
    required this.Role,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
       body:Container(
         width: double.infinity,
         margin: EdgeInsets.all(3),
         padding: EdgeInsets.all(10),
         decoration: BoxDecoration(
           border: Border.all(
             color: Colors.black, // Border color
             width: 1, // Border width
           ),
         ),
         child:
         Center(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Wrap(
                 children: [
                   Text("Enrol_Code: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                   Text(this.Enrol_Code,style: TextStyle(fontSize: 20),),
                 ],
               ),
               Wrap(
                 children: [
                   Text("Thana_Code: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                   Text(this.Thana_Code,style: TextStyle(fontSize: 20),),
                 ],
               ),
               Wrap(
                 children: [
                   Text("Station:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                   Text(this.Station.toString(),style: TextStyle(fontSize: 20),),
                 ],
               ),
               Wrap(
                 children: [
                   Text("Name: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                   Text(this.Name.toString(),style: TextStyle(fontSize: 20),),
                 ],
               ),
               Wrap(
                 children: [
                   Text("Designation:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                   Text(this.Designation.toString(),style: TextStyle(fontSize: 20),),
                 ],
               ),
               Wrap(
                 children: [
                   Text("Mobile:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                   Text(this.Mobile.toString(),style: TextStyle(fontSize: 20),),
                 ],
               ),
               Wrap(
                 children: [
                   Text("Parentage:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                   Text(this.Parentage,style: TextStyle(fontSize: 20),),
                 ],
               ),
               Wrap(
                 children: [
                   Text("Email:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                   Text(this.Email.toString(),style: TextStyle(fontSize: 20),),
                 ],
               ),
               Wrap(
                 children: [
                   Text("Address:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                   Text(this.Address.toString(),style: TextStyle(fontSize: 20),),
                 ],
               ),
               Wrap(
                 children: [
                   Text("Zone:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                   Text(this.Zone.toString(),style: TextStyle(fontSize: 20),),
                 ],
               ),
               Wrap(
                 children: [
                   Text("Enrolled_App:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                   Text(this.Enrolled_App.toString(),style: TextStyle(fontSize: 20),),
                 ],
               ),
               Wrap(
                 children: [
                   Text("Role:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                   Text(this.Role.toString(),style: TextStyle(fontSize: 20),),
                 ],
               ),
             ],
           ),
         ),
      //
      // Container(
      //   child:Column(
      //     children: [
      //
      //     ],
      //     // columns: <DataColumn>[
      //     //   DataColumn(label: Text('')),
      //     //   DataColumn(label: Text('')),
      //     // ],
      //     // rows: <DataRow>[
      //     //   DataRow(cells: <DataCell>[
      //     //     DataCell(Text('Enrol_Code')),
      //     //     DataCell(Text(this.Enrol_Code)),
      //     //   ]),
      //     //   DataRow(cells: <DataCell>[
      //     //     DataCell(Text('Thana_Code')),
      //     //     DataCell(Text(this.Thana_Code)),
      //     //   ]),
      //     //   DataRow(cells: <DataCell>[
      //     //     DataCell(Text('Station')),
      //     //     DataCell(Text(this.Station)),
      //     //   ]),
      //     //   DataRow(cells: <DataCell>[
      //     //     DataCell(Text('Name')),
      //     //     DataCell(Text(this.Name)),
      //     //   ]),
      //     //   DataRow(cells: <DataCell>[
      //     //     DataCell(Text('Designation')),
      //     //     DataCell(Text(this.Designation)),
      //     //   ]),
      //     //   DataRow(cells: <DataCell>[
      //     //     DataCell(Text('Mobile')),
      //     //     DataCell(Text(this.Mobile)),
      //     //   ]),
      //     //   DataRow(cells: <DataCell>[
      //     //     DataCell(Text('Parentage')),
      //     //     DataCell(Text(this.Parentage)),
      //     //   ]),
      //     //   DataRow(cells: <DataCell>[
      //     //     DataCell(Text('Email')),
      //     //     DataCell(Wrap(children:[Text(this.Email)])
      //     //   ]),
      //     //   DataRow(cells: <DataCell>[
      //     //     DataCell(Text('Address')),
      //     //     DataCell(Text(this.Address)),
      //     //   ]),
      //     //   DataRow(cells: <DataCell>[
      //     //     DataCell(Text('Zone')),
      //     //     DataCell(Text(this.Zone)),
      //     //   ]),
      //     //   DataRow(cells: <DataCell>[
      //     //     DataCell(Text('Enrolled_App')),
      //     //     DataCell(Text(this.Enrolled_App)),
      //     //   ]),
      //     //   DataRow(cells: <DataCell>[
      //     //     DataCell(Text('Role')),
      //     //     DataCell(Text(this.Role)),
      //     //   ]),
      //     // ],
      //   ),
      // ),
       ));
  }
}

