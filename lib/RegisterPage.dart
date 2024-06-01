
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ganderbal/Patrolling_Team_Dashboard.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:ntp/ntp.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:ganderbal/ApiHandler.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
class PhonenumberPage extends StatefulWidget {
  @override
  State<PhonenumberPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<PhonenumberPage> {
  bool otp_recieved=false;
  bool re_enter_phone=true;
  String otp="Send Otp";

  bool ovisible=false;
  TextEditingController Text1=TextEditingController(
  );

  FocusNode node=FocusNode();
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return
      PopScope(
        canPop: false,
        child: SafeArea(child:
        Scaffold(
            backgroundColor: Colors.white,
            extendBody: true,
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            body:
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                    alignment: Alignment.bottomCenter,
                    child:
                    Container(

                        child:
                        Column(children:[
                          SizedBox(height: 30,),
                          Container(
                            width: 0.8*width,
                            child:
                            TextField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              ],
                              maxLength: 10,
                              keyboardType: TextInputType.phone,
                              controller: Text1,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Enter Phonenumber",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                              ),
                              onChanged: (phone) {
                                if(phone.length<10){
                                  setState(() {
                                    ovisible=false;
                                  });
                                }
                                else{
                                  setState(() {
                                    ovisible=true;
                                  });
                                }
                              },
                            )
                          ),
                          SizedBox(height: 5,),
                          SizedBox(
                              height:0.08*height ,
                              width: 0.8*width,
                              child:
                                  Visibility(
                                    child:
                              CupertinoButton(
                                disabledColor: Colors.grey.shade400,
                                  color: Colors.green,
                                  onPressed: !ovisible?null:() async{
                                    showDialog(context: context, builder: (context)=>
                                        Center(
                                          child:
                                          Card(
                                            child: Container(
                                                width: 120,
                                                height: 120,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                child: Center(child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CupertinoActivityIndicator(
                                                      radius: 20,
                                                      color: Colors.purple,
                                                    ),
                                                    Text("Loading")
                                                  ],
                                                ))),
                                          ),
                                        )
                                    );
                                    Location nn=new Location();
                                    final position = await nn.getLocation();
                                    final otpmessage=await ApiHandler().sendOtp(Text1.text.toString(),position.latitude.toString(),position.longitude.toString());
                                      if(otpmessage.toString()=="Message:OTP sent to your registered mobile, please enter OTP"){
                                        Navigator.of(context).pop();
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context)=>phonenumberPage()));
                                        await Hive.openBox("local");
                                        var box = Hive.box("local");
                                        box.put("number",Text1.text.toString());
                                      }
                                      else{
                                        Navigator.of(context).pop();
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Alert!!!'),
                                              content: Text(otpmessage.toString()),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Close'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }

                                  },
                                  child: Text(otp)))),
                          SizedBox(
                            height: 10,
                          ),
                        ]),
                        height: 0.67*height,
                        width: width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xff064bb0),
                            Color.fromARGB(225, 197, 108, 228)]),
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            )
                        )
                    )
                ),
                Padding(padding: EdgeInsets.only(top:0.02*height,right: 0*width,left: 0*width,
                    bottom: 0.66*height),child:
                Align(
                    alignment: Alignment.topCenter,
                    child:
                    Container(
                        child: Container(
                            height: 0.26*height,
                            child: Image.asset("assets/logo.png",)))))
              ],

            )),
        ),
      );
  }
}


class phonenumberPage extends StatefulWidget {
  @override
  State<phonenumberPage> createState() => _registerPageState();
}

class _registerPageState extends State<phonenumberPage> {
  OtpFieldController otpc=OtpFieldController();
  TextEditingController Text2=TextEditingController(
  );
  String n="";
  bool fvisible=false;
  FocusNode node=FocusNode();
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return
      PopScope(
        canPop: false,
        child: SafeArea(child:
        Scaffold(
            backgroundColor: Colors.white,
            extendBody: true,
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            body:
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                    alignment: Alignment.bottomCenter,
                    child:
                    Container(
                        child:
                        Column(children:[
                          Spacer(flex: 1,),
                          Text("""
OTP sent to your registered mobile.
Please enter OTP below.""",style: TextStyle(color: Colors.white),),
                          SizedBox(height: 10,),
                          OTPTextField(
                            inputFormatter: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            keyboardType: TextInputType.phone,
                            otpFieldStyle: OtpFieldStyle(
                              borderColor: Colors.green,
                              enabledBorderColor: Colors.green,
                              focusBorderColor: Colors.greenAccent,
                              backgroundColor: Colors.white,
                            ),
                            controller: otpc,
                            length: 4,
                            width: MediaQuery.of(context).size.width,
                            contentPadding: EdgeInsets.all(10),
                            spaceBetween: 5,
                            textFieldAlignment: MainAxisAlignment.center,
                            fieldWidth:50,
                            outlineBorderRadius: 15,
                            style: TextStyle(fontSize: 17),
                            onChanged: (pin) {
                              if(pin.length<4){
                                setState(() {
                                  fvisible=false;
                                });
                              }
                              else{
                                setState(() {
                                  fvisible=true;
                                });
                              }
                            },
                            onCompleted: (pin) async{
                              if(pin.length==4){
                                setState(() {
                                  fvisible=true;
                                  n=pin.toString();
                                });
                              }

                            },

                          ),
                          SizedBox(height: 5,),
                          ElevatedButton(onPressed: ()async{
                            showDialog(context: context, builder: (context)=>
                                Center(
                                  child:
                                  Card(
                                    child: Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        child: Center(child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CupertinoActivityIndicator(
                                              radius: 20,
                                              color: Colors.purple,
                                            ),
                                            Text("Loading")
                                          ],
                                        ))),
                                  ),
                                )
                            );
                            Location nn=new Location();
                            final position = await nn.getLocation();
                            final login=await ApiHandler().verifyOtp(n,position.latitude.toString(),position.longitude.toString());
                            if(login.toString()=="Error: OTP is invalid"){
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Alert!!!'),
                                    content: Text('Error: OTP is invalid'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Close'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            if(login.toString()!="Error: OTP is invalid"){
                              await Hive.openBox("local");
                              var boxx= Hive.box("local");
                              final apiresult=await ApiHandler().deviceStatus(n,"NA");
                              final List m=apiresult.split(":");
                              final finalresult=await ApiHandler().deviceStatus(n,
                                  m.last.toString());
                              print("finalresult"+finalresult);
                              print("token"+m.last.toString());
                              boxx.put("token", m.last.toString());
                              if(finalresult.toString()=="2"){
                                boxx.put("SSP", false);
                                Map<String,dynamic> map= await ApiHandler().getProfile(boxx.get("number"), position.latitude.toString(),
                                    position.longitude.toString(), boxx.get("token"));
                                boxx.put("Name", map['Name'].toString());
                                boxx.put("Designation", map['Designation'].toString());
                                boxx.put("Station", map['Station'].toString());
                                boxx.put("Enrol_Code", map['Enrol_Code'].toString());
                                boxx.put("Thana_Code", map['Thana_Code'].toString());
                                boxx.put("Mobile", map['Mobile'].toString());
                                boxx.put("Parentage", map['Parentage'].toString());
                                boxx.put("Email", map['Email'].toString());
                                boxx.put("Address", map['Address'].toString());
                                boxx.put("Zone", map['Zone'].toString());
                                boxx.put("Enrolled_App", map['Enrolled_App'].toString());
                                boxx.put("Role", map['Role'].toString());
                                Navigator.of(context).pop();
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context)=>PatrollingTeam(
                                      map['Name'].toString(),map['Designation'],map['Station']
                                    )));
                                boxx.put("login",true);

                              }
                          //     {
                          //       "posts": [
                          // {
                          //   "Enrol_Code": "PATR1DPLG0002",
                          //   "Thana_Code": "DPLGPST001",
                          //   "Station": "Police Station Ganderbal",
                          //   "Name": "Sidhu",
                          //   "Designation": "SSP Ganderbal",
                          //   "Mobile": 8360971662,
                          //   "Parentage": "GG",
                          //   "Email": "siddharthgupta971@gmail.com",
                          //   "Address": "",
                          //   "Zone": "DPL",
                          //   "Enrolled_App": "25-May-2024",
                          //   "Role": "SSP Office"
                          // }
                          //   ]
                          // }
                              else if(finalresult=="1" ||finalresult=="0"){
                                boxx.put("SSP", true);
                                Map<String,dynamic> map= await ApiHandler().getProfile(boxx.get("number"), position.latitude.toString(),
                                    position.longitude.toString(), boxx.get("token"));
                                boxx.put("Name", map['Name'].toString());
                                boxx.put("Designation", map['Designation'].toString());
                                boxx.put("Station", map['Station'].toString());

                                boxx.put("Enrol_Code", map['Enrol_Code'].toString());
                                boxx.put("Thana_Code", map['Thana_Code'].toString());
                                boxx.put("Mobile", map['Mobile'].toString());
                                boxx.put("Parentage", map['Parentage'].toString());
                                boxx.put("Email", map['Email'].toString());
                                boxx.put("Address", map['Address'].toString());
                                boxx.put("Zone", map['Zone'].toString());
                                boxx.put("Enrolled_App", map['Enrolled_App'].toString());
                                boxx.put("Role", map['Role'].toString());
                                Navigator.of(context).pop();
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context)=>HigherOfficials( map['Name'].toString(),map['Designation'],map['Station'])),
                                );
                                boxx.put("login",true);
                              }
                            }
                          }, child:Text("Verify OTP")),
                          Spacer(flex: 7,)
                        ]),
                        height: 0.67*height,
                        width: width,
                        decoration: BoxDecoration(
                          gradient:
                          LinearGradient(colors: [Color(0xff064bb0),Color.fromARGB(225, 197, 108, 228)]),
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            )
                        ))),
                Padding(padding: EdgeInsets.only(top:0.02*height,right: 0*width,left: 0*width,
                    bottom: 0.66*height),child:
                Align(
                    alignment: Alignment.topCenter,
                    child:
                    Container(
                        height: 0.26*height,
                        child: Image.asset("assets/logo.png",))))
              ],

            ),
        ),
        ),
      );
  }
}