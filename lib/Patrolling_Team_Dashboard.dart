import 'dart:async';
import 'package:android_id/android_id.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ganderbal/DeviceTampering.dart';
import 'package:ganderbal/Milestone.dart';
import 'package:ganderbal/MyProfile.dart';
import 'package:ganderbal/PatrollingHIstory.dart';
import 'package:ganderbal/Stealth.dart';
import 'package:ganderbal/Violations.dart';
import 'maps.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter/material.dart';
import 'package:ganderbal/RegisterPage.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'ApiHandler.dart';
Timer? timer1;
class PatrollingTeam extends StatefulWidget {
  String? name;
  String? designation;
  String? station;
  PatrollingTeam(
      String? this.name,String? this.designation,String? this.station);
  @override
  State<PatrollingTeam> createState() => _PatrollingTeamState();
}
class _PatrollingTeamState extends State<PatrollingTeam> {
  bool absorb=false;
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return
      PopScope(
        canPop: false,
        child: SafeArea(child:
        AbsorbPointer(
          absorbing: absorb,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 30,
              leading: SizedBox(),
              backgroundColor: Color.fromARGB(255,203,220,221),
              actions: [
                IconButton(icon:Icon(Icons.power_settings_new,
                  color: Colors.black,),onPressed: (){
                  showDialog(
                  barrierDismissible: false,
                      context: context, builder: (context)
                  =>
                  Center(
                    child: Card(
                      child: Container(
                        height: 0.2*height,
                        width: 0.8*width,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Spacer(flex: 1,),
                              Text("Do you want to log out"),
                            Spacer(flex: 1,),
                            Row(
                              children: [
                                Spacer(flex: 1,),
                                ElevatedButton(onPressed: (){
                                  Navigator.of(context).pop();
                                },
                                    child: Text("Cancel")),
                                Spacer(flex: 1,),
                                ElevatedButton(onPressed: ()async{
                                  FlutterExitApp.exitApp();
                                },
                                    child: Text("Log Out")),
                                Spacer(flex: 1,)
                              ],
                            ),
                              Spacer(flex: 1,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  );
                },),
                SizedBox(width: 20,),
              ],
            ),
          backgroundColor: Colors.grey.shade300,
          extendBody: true,
          extendBodyBehindAppBar: false,
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: Container(

            padding: EdgeInsets.all(2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){
                    },
                      icon: Icon(Icons.home,size: 0.08*width,),color: Colors.white,),
                    Text("Home",style: TextStyle(color: Colors.white,fontSize:0.03*width,),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    IconButton(onPressed: ()async{
                      setState(() {
                        absorb=true;
                      });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Container(
              child: Text("Wait...."),
              )));
              await Hive.openBox("local");
              var box= Hive.box("local");
              final apiresult=await ApiHandler().deviceStatus(box.get("number"),box.get("token"));
              if(apiresult=="API_Android:Token mismatch, proxy attempt identified" || apiresult=="Android_API:Device Not Registered"){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PhonenumberPage()));
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content:Container(
              child: Text("Token expired!! Please login again!!"),
              ))
              );
              }else {
                await Hive.openBox("local");
                var boxx = Hive.box("local");
                Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                MyProfile(Name: boxx.get('Name'),
                    Designation: boxx.get('Designation'),
                    Station: boxx.get('Station'),
                    Enrol_Code: boxx.get('Enrol_Code'),
                    Thana_Code: boxx.get('Thana_Code'),
                    Mobile: boxx.get('Mobile'),
                    Parentage: boxx.get('Parentage'),
                    Email: boxx.get('Email'),
                    Address: boxx.get('Address'),
                    Zone: boxx.get('Zone'),
                    Enrolled_App: boxx.get('Enrolled_App'),
                    Role: boxx.get('Role'))
                ));
              }
                      setState(() {
                        absorb=false;
                      });
              },
                      icon: Icon(Icons.account_circle_sharp,size: 0.08*width,),
                      color: Colors.white,),
                    Text("Profile",style: TextStyle(color: Colors.white,fontSize:0.03*width,),)
                  ],
                ),


              ],
            ),
            margin: EdgeInsets.only(right: 0.24*width,
                left: 0.24*width,bottom: 4,top: 10),
            decoration: BoxDecoration(
              color: Color(0xff020527),
              borderRadius: BorderRadius.circular(40),
            ),
            height: 0.095*height,
          ),
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(

                ),
                child: Image.asset("assets/header.png",height: 0.2*height,fit: BoxFit.fill,),
                width: width,
              ),
              Container(
                child:
                Center(child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Welcome:${this.widget.name}(${this.widget.designation})",style: TextStyle(color: Colors.white),),
                    Text("(${this.widget.station})",style: TextStyle(color: Colors.white),),
                    // Text("Welcome:${this.widget.name}(${this.widget.designation})",style: TextStyle(color: Colors.white),),
                    // Text("(${this.widget.station})",style: TextStyle(color: Colors.white),),
                  ],
                )),
                height: 0.1*height,
                width: width,
              decoration: BoxDecoration(
                gradient:
                LinearGradient(colors: [Colors.blueAccent,Colors.green]),
              ),
              ),
                  Container(
                    height: 0.5*height,
                    color: Colors.grey.shade300,
                    child: Column(
                      children: [
                        Spacer(flex: 1,),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              InkWell(
                            onTap: ()async{
                              setState(() {
                                absorb=true;
                              });
                              await Hive.openBox("local");
                              var boxx= Hive.box("local");
                              final apiresult=await ApiHandler().deviceStatus(boxx.get("number"),boxx.get("token"));
                              if(apiresult=="API_Android:Token mismatch, proxy attempt identified" || apiresult=="Android_API:Device Not Registered"){
                                await ApiHandler().resetNumber(boxx.get("number"));
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>PhonenumberPage()));
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content:Container(
                                      child: Text("Token expired!! PLease login again!!"),
                                    ))
                                );
                              }
                              else{
                              if(boxx.get("patrolling")=="started")
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context)=>PausePatrolling(boxx.get("id"),timer1)));
                                else if(boxx.get("patrolling")=="paused")
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context)=>RestartPatrolling(boxx.get("id"),timer1)));
                                  else
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context)=>StartPatrolling()));
                              }
                              setState(() {
                                absorb=false;
                              });
                            }
                            ,
                                child: Card(
                                  elevation: 20,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white
                                      ),
                                  height: 0.1*height,
                                  width: 0.2*width,
                                  padding: EdgeInsets.all(4),
                                    child: Image.asset(
                                      "assets/polic.png",fit: BoxFit.contain,),
                                  )),
                              ),
                              Text("Patrolling")
                            ],
                          ),
                          Column(
                            children: [
                              Card(
                                elevation: 20,
                                  child: Container(
                                    height: 0.1*height,
                                    width: 0.2*width,

                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    padding: EdgeInsets.all(5),
                                    child: Image.asset(
                                      "assets/file.png",fit: BoxFit.contain,),
                                  ),),
                              Text("Compliance")
                            ],
                          ),
                          Column(
                            children: [
                              Card(elevation: 20,
                                  child: Container(
                                    height: 0.1*height,
                                    width: 0.2*width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    padding: EdgeInsets.all(5),
                                    child: Image.asset(
                                                    "assets/cases.png",fit: BoxFit.contain,),
                                  )),
                              Text("Cases")
                            ],
                          ),]),
                        Spacer(flex: 1,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: ()async{
                                      setState(() {
                                        absorb=true;
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Container(
                                        child: Text("Wait...."),
                                      )));
                                      await Hive.openBox("local");
                                      var boxx= Hive.box("local");
                                      final apiresult=await ApiHandler().deviceStatus(boxx.get("number"),boxx.get("token"));
                                      if(apiresult=="API_Android:Token mismatch, proxy attempt identified" || apiresult=="Android_API:Device Not Registered"){
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>PhonenumberPage()));
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content:Container(
                                              child: Text("Token expired!! PLease login again!!"),
                                            ))
                                        );
                                      }
                                      else{
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(
                                        child: Text("Wait maps is opening"),
                                      )));
                                      await Hive.openBox("local");
                                      var box= Hive.box("local");
                                      final apiresult=await ApiHandler().deviceStatus(box.get("number"),box.get("token"));
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                                          Container(
                                              color: Colors.black,
                                              child:
                                          Mapp())));
                                      }
                                      setState(() {
                                        absorb=false;
                                      });
                                    }
                                    ,
                                    child: Card(
                                        elevation: 20, child: Container(
                                      height: 0.1*height,
                                      width: 0.2*width,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      padding: EdgeInsets.all(4),
                                      child: Image.asset(
                                        "assets/maps.png",fit: BoxFit.contain,),
                                    )),
                                  ),
                                  Text("Maps")
                                ],
                              ),
                              Column(
                                children: [
                                  Card(
                                    elevation: 20,
                                    child: Container(
                                      height: 0.1*height,
                                      width: 0.2*width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: Image.asset(
                                        "assets/activitylog.png",color: Colors.blue,fit: BoxFit.contain,),
                                    ),),
                                  Text("Report")
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                onTap: ()async{
                                  setState(() {
                                    absorb=true;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Container(
                                    child: Text("Wait...."),
                                  )));
                                  await Hive.openBox("local");
                                  var boxx= Hive.box("local");
                                  final apiresult=await ApiHandler().deviceStatus(boxx.get("number"),boxx.get("token"));
                                  if(apiresult=="API_Android:Token mismatch, proxy attempt identified" || apiresult=="Android_API:Device Not Registered"){
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>PhonenumberPage()));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content:Container(
                                          child: Text("Token expired!! Please login again!!"),
                                        ))
                                    );
                                  }else{
                                  await Hive.openBox("local");
                                  var box= Hive.box("local");
                                  await Hive.openBox("local");
                                  var boxx= Hive.box("local");
                                  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                                 final number= await ApiHandler().support(boxx.get("number"), position.latitude.toString(),position.longitude.toString(), boxx.get("token"));
                                  launchUrlString("https://api.whatsapp.com/send?phone=$number&text=Hello I need support on DPL app1");
                                }
                                  setState(() {
                                    absorb=false;
                                  });
                                  }
                                ,
                                    child:
                                    Card(
                                      elevation: 10,
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            height: 0.1*height,
                                            width: 0.2*width,
                                            child: Image.asset(
                                              "assets/support9.png",fit: BoxFit.fill,),
                                          )),
                                    ),
                                  Text("Support")
                                ],
                              ),]),
                      Spacer(flex: 1,),
                      Column(
                        children: [
                          InkWell(
                        onTap: ()async{
                          setState(() {
                            absorb=true;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Container(
                            child: Text("Wait...."),
                          )));
                          await Hive.openBox("local");
                          var box= Hive.box("local");
                          final apiresult=await ApiHandler().deviceStatus(box.get("number"),box.get("token"));
                          if(apiresult=="API_Android:Token mismatch, proxy attempt identified" || apiresult=="Android_API:Device Not Registered"){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PhonenumberPage()));
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content:Container(
                                  child: Text("Token expired!! Please login again!!"),
                                ))
                            );
                          }
                          else{
                          showDialog(
                          barrierDismissible: false
                          ,
                              context: context, builder: (context)=>
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
                                          Text("Refreshing")
                                        ],
                                      ))),
                                ),
                              )
                          );
                          await Hive.openBox("local");
                          var box= Hive.box("local");
                          var boxx= Hive.box("local");
                          boxx.put("patrolling", "started");
                          Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                          await ApiHandler().refresh(boxx.get("number"), position.latitude.toString(), position.longitude.toString(), boxx.get("token"));
                          Navigator.of(context).pop();
                        }
                          setState(() {
                            absorb=false;
                          });
                          }
                        ,
                            child: Card(
                                elevation: 20, child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              height: 0.1*height,
                              width: 0.2*width,
                              padding: EdgeInsets.all(15),
                                  child: Image.asset(
                                                  "assets/refresh.png",color: Colors.cyan,
                                    fit: BoxFit.contain,),
                                )),
                          ),
                          Text("Refresh")
                        ],
                      ),
                        Spacer(flex: 1,)

                  ],
              )
                  )
            ],
          ),),
        )
            ),
      );
  }
}
// class PatrollingTeam extends StatefulWidget {
//   String? name;
//   String? designation;
//   String? station;
//   PatrollingTeam(
//       String? this.name,String? this.designation,String? this.station);
//   @override
//   State<PatrollingTeam> createState() => _PatrollingTeamState();
// }
class HigherOfficials extends StatefulWidget {
  String? name;
  String? designation;
  String? station;
  HigherOfficials(
      String? this.name,String? this.designation,String? this.station);
  @override
  State<HigherOfficials> createState() => _HigherOfficialsState();
}

class _HigherOfficialsState extends State<HigherOfficials> {
 bool absorb=false;
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return
      PopScope(
          canPop: false,
          child: SafeArea(child:
          AbsorbPointer(
              absorbing: absorb,child:
          Scaffold(
            appBar: AppBar(
              toolbarHeight: 30,
              leading: SizedBox(),
              backgroundColor: Color.fromARGB(255,203,220,221),
              actions: [
                IconButton(icon:Icon(Icons.notifications,color: Colors.black,),
                  onPressed: (){},),
                IconButton(icon:Icon(Icons.power_settings_new,
                  color: Colors.black,),onPressed: (){
                  showDialog(
                  barrierDismissible: false
                  ,
                      context: context, builder: (context)
                  =>
                      Center(
                        child: Card(
                          child: Container(
                            height: 0.2*height,
                            width: 0.8*width,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Spacer(flex: 1,),
                                  Text("Do you want to log out"),
                                  Spacer(flex: 1,),
                                  Row(
                                    children: [
                                      Spacer(flex: 1,),
                                      ElevatedButton(onPressed: (){
                                        Navigator.of(context).pop();
                                      },
                                          child: Text("Cancel")),
                                      Spacer(flex: 1,),
                                      ElevatedButton(onPressed: ()async{
                                        FlutterExitApp.exitApp();
                                      },
                                          child: Text("Log Out")),
                                      Spacer(flex: 1,)
                                    ],
                                  ),
                                  Spacer(flex: 1,)
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                  );
                },),
                SizedBox(width: 20,),
              ],
            ),
            backgroundColor: Colors.grey.shade300,
            extendBody: true,
            extendBodyBehindAppBar: false,
            resizeToAvoidBottomInset: false,
            bottomNavigationBar:Container(

              padding: EdgeInsets.all(2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: (){
                      },
                        icon: Icon(Icons.home,size: 0.08*width,),color: Colors.white,),
                      Text("Home",style: TextStyle(color: Colors.white,fontSize:0.03*width,),),
                    ],
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     IconButton(onPressed: (){},
                  //       icon: Icon(Icons.explore_rounded,size: 0.08*width,),color: Colors.white,),
                  //     Text("Explore",style: TextStyle(color: Colors.white,fontSize:0.03*width,),)
                  //   ],
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: ()async{ setState(() {
                         absorb=true;
                      });

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Container(
                          child: Text("Wait...."),
                        )));
                        await Hive.openBox("local");
                        var box= Hive.box("local");
                        final apiresult=await ApiHandler().deviceStatus(box.get("number"),box.get("token"));
                        if(apiresult=="API_Android:Token mismatch, proxy attempt identified" || apiresult=="Android_API:Device Not Registered"){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PhonenumberPage()));
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content:Container(
                                child: Text("Token expired!! Please login again!!"),
                              ))
                          );
                        }else{
                        await Hive.openBox("local");
                        var boxx= Hive.box("local");
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context)=>
                                MyProfile(Name: boxx.get('Name'),
                                    Designation: boxx.get('Designation'),
                                    Station: boxx.get('Station'),
                                    Enrol_Code: boxx.get('Enrol_Code'),
                                    Thana_Code: boxx.get('Thana_Code'),
                                    Mobile: boxx.get('Mobile'),
                                    Parentage: boxx.get('Parentage'),
                                    Email: boxx.get('Email'),
                                    Address: boxx.get('Address'),
                                    Zone: boxx.get('Zone'),
                                    Enrolled_App: boxx.get('Enrolled_App'),
                                    Role: boxx.get('Role'))
                        ));
                        }
                      setState(() {
                        absorb=false;
                      });

                      },
                        icon: Icon(Icons.account_circle_sharp,size: 0.08*width,),
                        color: Colors.white,),
                      Text("Profile",style: TextStyle(color: Colors.white,fontSize:0.03*width,),)
                    ],
                  ),


                ],
              ),
              margin: EdgeInsets.only(right: 0.27*width,
                  left: 0.27*width,bottom: 4,top: 10),
              decoration: BoxDecoration(
                color: Color(0xff020527),
                borderRadius: BorderRadius.circular(40),
              ),
              height: 0.095*height,
            ),
            body: Column(
              children: [
                Stack(children:[Container(
                  decoration: BoxDecoration(

                  ),
                  child: Image.asset("assets/header.png",height: 0.2*height,fit: BoxFit.fill,),
                  width: width,
                ),
                ]),
                Container(
                  child:
                  Center(child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Welcome:${this.widget.name}(${this.widget.designation})",style: TextStyle(color: Colors.white),),
                      Text("(${this.widget.station})",style: TextStyle(color: Colors.white),),
                    ],
                  )),
                  height: 0.1*height,
                  width: width,
                  decoration: BoxDecoration(
                      gradient:
                      LinearGradient(colors: [Colors.blueAccent,Colors.green]),
                  ),
                ),
                Container(
                    height: 0.5*height,
                    color: Colors.grey.shade300,
                    child: Column(
                      children: [
                        Spacer(flex: 1,),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () async {
                                  setState(() {
                                    absorb=true;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(
                                  child: Text("Wait ....."),
                                )));
                                  await Hive.openBox("local");
                                  var boxx= Hive.box("local");
                                  final apiresult=await ApiHandler().deviceStatus(boxx.get("number"),boxx.get("token"));
                                  if(apiresult=="API_Android:Token mismatch, proxy attempt identified" || apiresult=="Android_API:Device Not Registered"){
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>PhonenumberPage()));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content:Container(
                                          child: Text("Token expired!! Please login again!!"),
                                        ))
                                    );
                                  }
                                  else{
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DeviceTampering()));
                                  }
                                  setState(() {
                                    absorb=false;
                                  });

                                },
                                child: Column(
                                  children: [
                                    Card(
                                        elevation: 20,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10)
                                          ),
                                      height: 0.1*height,
                                      width: 0.2*width,
                                      padding: EdgeInsets.all(4),
                                      child: Image.asset(
                                        "assets/img_1.png",fit: BoxFit.fill,),
                                    )),
                                    Text("DeviceTampering",style: TextStyle(fontSize: 10),)
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  setState(() {
                                    absorb=true;
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(
                                    child: Text("Wait ....."),
                                  )));
                                  await Hive.openBox("local");
                                  var boxx= Hive.box("local");
                                  final apiresult=await ApiHandler().deviceStatus(boxx.get("number"),boxx.get("token"));
                                  if(apiresult=="API_Android:Token mismatch, proxy attempt identified" || apiresult=="Android_API:Device Not Registered"){
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>PhonenumberPage()));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content:Container(
                                          child: Text("Token expired!! Please login again!!"),
                                        ))
                                    );
                                  }
                                  else{
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Violations()));
                                  }
                                  setState(() {
                                    absorb=false;
                                  });

                                },
                                child: Column(
                                  children: [
                                    Card(
                                      elevation: 20,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        height: 0.1*height,
                                        width: 0.2*width,
                                        padding: EdgeInsets.all(5),
                                        child: Image.asset(
                                          "assets/hand.png",fit: BoxFit.contain,),
                                      )),
                                    Text("Violations")
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: ()async{
                                      setState(() {
                                        absorb=true;
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(
                                        child: Text("Wait ....."),
                                      )));
                                      await Hive.openBox("local");
                                      var boxx= Hive.box("local");
                                      final apiresult=await ApiHandler().deviceStatus(boxx.get("number"),boxx.get("token"));
                                      if(apiresult=="API_Android:Token mismatch, proxy attempt identified" || apiresult=="Android_API:Device Not Registered"){
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>PhonenumberPage()));
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content:Container(
                                              child: Text("Token expired!! Please login again!!"),
                                            ))
                                        );
                                      }
                                      else{
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder:
                                              (context)
                                          =>Stealth()
                                          ));
                                      }
                                      setState(() {
                                        absorb=false;
                                      });

                                    },
                                    child: Card(elevation: 20,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10)
                                          ),
                                          height: 0.1*height,
                                          width: 0.2*width,
                                          padding: EdgeInsets.all(5),
                                          child: Image.asset(
                                            "assets/hidden.jpeg",fit: BoxFit.contain,),
                                        )),
                                  ),
                                  Text("StealthMode")
                                ],
                              ),]),
                        Spacer(flex: 1,),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: ()async{
                                      setState(() {
                                        absorb=true;
                                      });

                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(
                                        child: Text("Wait ....."),
                                      )));
                                      await Hive.openBox("local");
                                      var boxx= Hive.box("local");
                                      final apiresult=await ApiHandler().deviceStatus(boxx.get("number"),boxx.get("token"));
                                      if(apiresult=="API_Android:Token mismatch, proxy attempt identified" || apiresult=="Android_API:Device Not Registered"){
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>PhonenumberPage()));
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content:Container(
                                              child: Text("Token expired!! Please login again!!"),
                                            ))
                                        );
                                      }
                                      else{
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder:
                                            (context)
                                        =>Patrollinghistory()
                                      ));
                                      }
                                      setState(() {
                                        absorb=false;
                                      });

                                    }
                                    ,
                                    child: Card(
                                        elevation: 10,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10)
                                          ),
                                      height: 0.1*height,
                                      width: 0.2*width,
                                      padding: EdgeInsets.all(4),
                                      child: Image.asset(
                                        "assets/history.png",fit: BoxFit.contain,),
                                    )),
                                  ),
                                  Text("Patrolling History",style: TextStyle(
                                    fontSize: 10
                                  ),)
                                ],
                              ),
                              InkWell(
                                onTap: ()async{
                                  setState(() {
                                    absorb=true;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(
                                    child: Text("Wait ....."),
                                  )));
                                  await Hive.openBox("local");
                                  var boxx= Hive.box("local");
                                  final apiresult=await ApiHandler().deviceStatus(boxx.get("number"),boxx.get("token"));
                                  if(apiresult=="API_Android:Token mismatch, proxy attempt identified" || apiresult=="Android_API:Device Not Registered"){
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>PhonenumberPage()));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content:Container(
                                          child: Text("Token expired!! Please login again!!"),
                                        ))
                                    );
                                  }
                                  else{
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder:
                                          (context)
                                      =>Mapp()
                                      ));
                                  }
                                  setState(() {
                                    absorb=false;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Card(
                                  color: Colors.white,
                                      elevation: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        height: 0.1*height,
                                        width: 0.2*width,
                                        padding: EdgeInsets.all(5),
                                        child: Image.asset(
                                          "assets/livelocation.png",fit: BoxFit.fill,),
                                      )),
                                    Text("LiveTracking",style: TextStyle(
                                      fontSize: 13
                                    ),)
                                  ],
                                ),
                              ),

                              Column(
                                children: [
                                  ClipRRect(
                                    borderRadius:   BorderRadius.circular(20),
                                    child: InkWell(
                                      onTap: ()async{
                                        setState(() {
                                          absorb=true;
                                        });
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(
                                          child: Text("Wait ....."),
                                        )));
                                        await Hive.openBox("local");
                                        var boxx= Hive.box("local");
                                        final apiresult=await ApiHandler().deviceStatus(boxx.get("number"),boxx.get("token"));
                                        if(apiresult=="API_Android:Token mismatch, proxy attempt identified" || apiresult=="Android_API:Device Not Registered"){
                                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>PhonenumberPage()));
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content:Container(
                                                child: Text("Token expired!! Please login again!!"),
                                              ))
                                          );
                                        }else{
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (context)
                                            =>MileStone()
                                            ));
                                        }
                                        setState(() {
                                          absorb=false;
                                        });
                                      },
                                      child: Card(
                                        elevation: 5,
                                        color: Colors.white,
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                               borderRadius: BorderRadius.circular(10)
                                            ),
                                            height: 0.1*height,
                                            width: 0.2*width,
                                            child: Image.asset(
                                              "assets/milestones.png",fit: BoxFit.fill,),
                                          )),
                                    ),
                                  ),
                                  Text("Milestones")
                                ],
                              ),]),
                        Spacer(flex: 1,),
                        Row(
                          children: [
                            Spacer(flex: 1,),
                            Column(
                              children: [
                                InkWell(
                                  onTap: ()async{
                                    setState(() {
                                      absorb=true;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(
                                      child: Text("Wait ....."),
                                    )));
                                    await Hive.openBox("local");
                                    var boxx= Hive.box("local");
                                    final apiresult=await ApiHandler().deviceStatus(boxx.get("number"),boxx.get("token"));
                                    if(apiresult=="API_Android:Token mismatch, proxy attempt identified" || apiresult=="Android_API:Device Not Registered"){
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>PhonenumberPage()));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content:Container(
                                            child: Text("Token expired!! Please login again!!"),
                                          ))
                                      );
                                    }else{
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) =>
                                              Container(
                                                  color: Colors.black,
                                                  child:
                                                  Mapp())));
                                    }
                                    setState(() {
                                      absorb=false;
                                    });
                                    }
                                  ,
                                  child: Card(
                                      elevation: 20, child: Container(
                                    height: 0.1*height,
                                    width: 0.2*width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    padding: EdgeInsets.all(4),
                                    child: Image.asset(
                                      "assets/maps.png",fit: BoxFit.contain,),
                                  )),
                                ),
                                Text("Maps")
                              ],
                            ),
                            Spacer(flex: 2,),
                            Column(

                              children: [
                                InkWell(
                                  onTap: ()async{
                                    setState(() {
                                      absorb=true;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Container(
                                      child: Text("Wait...."),
                                    )));
                                    await Hive.openBox("local");
                                    var box= Hive.box("local");
                                    final apiresult=await ApiHandler().deviceStatus(box.get("number"),box.get("token"));
                                    if(apiresult=="API_Android:Token mismatch, proxy attempt identified" || apiresult=="Android_API:Device Not Registered"){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PhonenumberPage()));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content:Container(
                                            child: Text("Token expired!! Please login again!!"),
                                          ))
                                      );
                                    }
                                    else {
                                      await Hive.openBox("local");
                                      var boxx = Hive.box("local");
                                      Position position = await Geolocator
                                          .getCurrentPosition(
                                          desiredAccuracy: LocationAccuracy.high);
                                      final number = await ApiHandler().support(
                                          boxx.get("number"),
                                          position.latitude.toString(),
                                          position.longitude.toString(),
                                          boxx.get("token"));
                                      launchUrlString(
                                          "https://api.whatsapp.com/send?phone=$number&text=Hello I need support on DPL app1");
                                    }
                                    setState(() {
                                      absorb=false;
                                    });
                                    },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Card(child: Container(
                                      height: 0.1*height,
                                      width: 0.2*width,
                                      padding: EdgeInsets.all(5),
                                      child: Image.asset(
                                        "assets/support9.png",fit: BoxFit.fill,),
                                    )),
                                  ),
                                ),
                                Text("Support")
                              ],
                            ),
                            Spacer(flex: 6,)
                          ],
                        ),
                        Spacer(flex: 1,)

                      ],
                    )
                )
              ],
            ),

          )
          ),
        ),
      );
  }
}
/*
{
"posts": [
{
"ID": 1,
"param": "end_time",
"value": "23:00"
},
{
"ID": 2,
"param": "frequency",
"value": "30"
},
{
"ID": 3,
"param": "method",
"value": "Internet"
},
{
"ID": 4,
"param": "start_time",
"value": "15:00"
}
]
}*/

class StartPatrolling extends StatefulWidget {
  const StartPatrolling();
  @override
  State<StartPatrolling> createState() => _StartPatrollingState();
}

class _StartPatrollingState extends State<StartPatrolling> with WidgetsBindingObserver{
  Timer? timer;
  String kalyan="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);

  }


  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
        return
        Scaffold(

          backgroundColor: Colors.white,
          body:Column(
            children: [
              Container(height: 0.6*height,width: width,
              child: Mapss(),
              ),
   Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Color(0xff064bb0),Color.fromARGB(225, 197, 108, 228)]),
                        color: Colors.white,
                    ),
                  padding: EdgeInsets.all(40),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: ()async{
                          showDialog(
                              barrierDismissible: false,
                              context: context, builder: (context)=>
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

                          //
                          await Hive.openBox("local");
                          var boxx= Hive.box("local");
                          boxx.put("patrolling", "started");
                          Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                          final dateFormatter = DateFormat('yyyy-MM-dd');
                          final timeFormatter = DateFormat('HH:mm:ss');
                          final DateTime now = DateTime.now();

                          final formattedDate = dateFormatter.format(now);
                          final formattedTime = timeFormatter.format(now);
                          final finalresult=await ApiHandler().startPatrolling(boxx.get("number"), position.latitude.toString(),position.longitude.toString(),
                              boxx.get("token"),formattedTime,formattedDate);
                          print("patrol start");
                          print(finalresult);
                          Map<String,dynamic> status=await ApiHandler().check_status(boxx.get("number"),
                              position.latitude.toString(), position.longitude.toString(),
                              boxx.get("token").toString());
                          var method=await ApiHandler().getGpsInternet(boxx.get("number"),
                              position.latitude.toString(),position.longitude.toString(),
                              boxx.get("token"));
                          var frequency=ApiHandler().getFrequency(boxx.get("number"),
                              position.latitude.toString(),position.longitude.toString(),
                              boxx.get("token"));
                          const _androidIdPlugin = AndroidId();
                          final String? androidId = await _androidIdPlugin.getId();
                          boxx.put("id",status['sessionID'].toString());
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context)=>PausePatrolling(status['sessionID'].toString(),this.timer))
                          );

                          print(finalresult);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: AwesomeSnackbarContent(
                            title: 'Started Patrolling!',
                            inMaterialBanner: true,
                            color: Colors.blue,
                            message:
                            'Patrolling!',
                            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                            contentType: ContentType.success,
                          ),
                          ));
                          print("Frequency we got"+frequency.toString());
                          await Hive.openBox("local");
                          print("kalyannivi");
                          ///here ra bey


                        },
                            child:Text("Start Patrolling"))
                      ],
                    ),
                  height: 0.4*height,
                  width: width,
                ),
            ],
          ),
          bottomNavigationBar:Container(

            padding: EdgeInsets.all(2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    },
                      icon: Icon(Icons.home,size: 0.04*height,),color: Colors.white,),
                    Text("Home",style: TextStyle(color: Colors.white,fontSize:0.015*height,),),
                  ],
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     IconButton(onPressed: (){},
                //       icon: Icon(Icons.explore_rounded,size: 0.04*height,),color: Colors.white,),
                //     Text("Explore",style: TextStyle(color: Colors.white,fontSize:0.015*height,),)
                //   ],
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: ()async{

                      await Hive.openBox("local");
                      var boxx= Hive.box("local");
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context)=>
                            MyProfile(Name: boxx.get('Name'),
                                Designation: boxx.get('Designation'),
                                Station: boxx.get('Station'),
                                Enrol_Code: boxx.get('Enrol_Code'),
                                Thana_Code: boxx.get('Thana_Code'),
                                Mobile: boxx.get('Mobile'),
                                Parentage: boxx.get('Parentage'),
                                Email: boxx.get('Email'),
                                Address: boxx.get('Address'),
                                Zone: boxx.get('Zone'),
                                Enrolled_App: boxx.get('Enrolled_App'),
                                Role: boxx.get('Role'))
                      ));
                    },
                      icon: Icon(Icons.account_circle_sharp,size: 0.04*height,),
                      color: Colors.white,),
                    Text("Profile",style: TextStyle(color: Colors.white,fontSize:0.015*height,),)
                  ],
                ),


              ],
            ),
            margin: EdgeInsets.only(right: 0.17*width,
                left: 0.17*width,bottom: 4,),
            decoration: BoxDecoration(
              color: Color(0xff020527),
              borderRadius: BorderRadius.circular(40),
            ),
            height: 0.095*height,
          ) ,
          extendBody: true,
          extendBodyBehindAppBar: false,
        );
  }
}
class RestartPatrolling extends StatefulWidget {
  String? id;
  Timer? timer;
  RestartPatrolling(String? this.id,Timer? this.timer);
  @override
  State<RestartPatrolling> createState() => _RestartPatrollingState();
}

class _RestartPatrollingState extends State<RestartPatrolling> {
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return   Scaffold(
      backgroundColor: Colors.white,
      body:Column(
        children: [
          Container(
            height: 0.5*height,
            width: width,
            child: Mapss(),
          ),
          Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xff064bb0),Color.fromARGB(225, 197, 108, 228)]),
                    color: Colors.white,
                ),
              padding: EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(flex: 1,),
                  Text("Session ID ${this.widget.id}"),
                  Spacer(flex: 1,),
                  ElevatedButton(
                      onPressed: ()async{
                        showDialog(
                        barrierDismissible: false
                        ,
                            context: context, builder: (context)=>
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
                        await Hive.openBox("local");
                        var boxx= Hive.box("local");
                        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                        final dateFormatter = DateFormat('yyyy-MM-dd');
                        final timeFormatter = DateFormat('HH:mm:ss');
                        final DateTime now = DateTime.now();
                        final formattedDate = dateFormatter.format(now);
                        final formattedTime = timeFormatter.format(now);
                        final finalresult=await ApiHandler().startPatrolling(boxx.get("number"), position.latitude.toString(),position.longitude.toString(),
                            boxx.get("token"),formattedTime,formattedDate);
                        setState(() {
                        });
                        boxx.put("patrolling", "restarted");
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: AwesomeSnackbarContent(
                          inMaterialBanner: true,
                          title:  'Patrolling Restarted!',
                          color: Colors.red,
                          titleFontSize: 13,
                          message:
                          'Patrolling Restarted!',
                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                          contentType: ContentType.success,

                        ),
                        ));
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context)=>PausePatrolling(this.widget.id,this.widget.timer))
                        );
                      },
                      child:Text("Restart Patrolling")),
                  Spacer(flex: 1,),
                  ElevatedButton(onPressed: ()async{
                    showDialog(
                    barrierDismissible: false
                    ,
                        context: context, builder: (context)=>
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
                    await Hive.openBox("local");
                    var boxx= Hive.box("local");
                    boxx.put("patrolling", "completed");
                    print("aklayn");
                    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                    print("godav");
                    final dateFormatter = DateFormat('yyyy-MM-dd');
                    final timeFormatter = DateFormat('HH:mm:ss');
                    final DateTime now = DateTime.now();
                    final formattedDate = dateFormatter.format(now);
                    final formattedTime = timeFormatter.format(now);
                    boxx.put("kalyan","stop");
                    print("kalyan ram is 789");
                    final finalresult=await ApiHandler().completePatrolling(boxx.get("number"), position.latitude.toString(),position.longitude.toString(),
                        boxx.get("token"),formattedTime,formattedDate);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    print(finalresult);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: AwesomeSnackbarContent(
                      inMaterialBanner: true,
                      title:  'Patrolling Accomplished!',
                      color: Colors.green,
                      titleFontSize: 13,
                      message:
                      'Patrolling Accomplished!',
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                    ));

                  },
                      child:Text("Complete Patrolling")),
                  Spacer(flex: 6,),
                ],
              ),
              height: 0.5*height,
              width: width,
            ),
        ],
      ),
      bottomNavigationBar: Container(

        padding: EdgeInsets.all(2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: (){
                  Navigator.of(context).pop();
                },
                  icon: Icon(Icons.home,size: 0.04*height,),color: Colors.white,),
                Text("Home",style: TextStyle(color: Colors.white,fontSize:0.015*height,),),
              ],
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     IconButton(onPressed: (){},
            //       icon: Icon(Icons.explore_rounded,size: 0.04*height,),color: Colors.white,),
            //     Text("Explore",style: TextStyle(color: Colors.white,fontSize:0.015*height,),)
            //   ],
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: ()async{
                  await Hive.openBox("local");
                  var boxx= Hive.box("local");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>
                          MyProfile(Name: boxx.get('Name'),
                              Designation: boxx.get('Designation'),
                              Station: boxx.get('Station'),
                              Enrol_Code: boxx.get('Enrol_Code'),
                              Thana_Code: boxx.get('Thana_Code'),
                              Mobile: boxx.get('Mobile'),
                              Parentage: boxx.get('Parentage'),
                              Email: boxx.get('Email'),
                              Address: boxx.get('Address'),
                              Zone: boxx.get('Zone'),
                              Enrolled_App: boxx.get('Enrolled_App'),
                              Role: boxx.get('Role'))
                  ));
                },
                  icon: Icon(Icons.account_circle_sharp,size: 0.04*height,),
                  color: Colors.white,),
                Text("Profile",style: TextStyle(color: Colors.white,fontSize:0.015*height,),)
              ],
            ),


          ],
        ),
        margin: EdgeInsets.only(right: 0.17*width,
            left: 0.17*width,bottom: 4,top: 10),
        decoration: BoxDecoration(
          color: Color(0xff020527),
          borderRadius: BorderRadius.circular(40),
        ),
        height: 0.095*height,
      ),
      extendBody: true,

      extendBodyBehindAppBar: false,
    );
  }
}

class PausePatrolling extends StatefulWidget {
  String? id;
  Timer? timer;
  PausePatrolling(String? this.id,Timer? this.timer);
  @override
  State<PausePatrolling> createState() => _PausePatrollingState();
}

class _PausePatrollingState extends State<PausePatrolling> {
 bool pause=true;
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return   Scaffold(

      extendBody: true,
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      body:Column(
        children: [
          Container(
            height: 0.5*height,
            width: width,
            child: Mapss(),
          ),
          Container(                        decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xff064bb0),Color.fromARGB(225, 197, 108, 228)]),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(flex: 1,),
                  Text("Session ID ${this.widget.id}"),
                  Spacer(flex: 1,),
                  ElevatedButton(
                      onPressed: ()async{
                        showDialog(
                        barrierDismissible: false
                        ,
                            context: context, builder: (context)=>
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
                        await Hive.openBox("local");
                        var boxx= Hive.box("local");
                        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                        final dateFormatter = DateFormat('yyyy-MM-dd');
                        final timeFormatter = DateFormat('HH:mm:ss');
                        final DateTime now = DateTime.now();
                        final formattedDate = dateFormatter.format(now);
                        final formattedTime = timeFormatter.format(now);
                        final finalresult=await ApiHandler().pausePatrolling(boxx.get("number"), position.latitude.toString(),position.longitude.toString(),
                            boxx.get("token"),formattedTime,formattedDate);
                        setState(() {
                          pause=false;
                        });
                        Navigator.of(context).pop();
                        boxx.put("patrolling", "paused");
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: AwesomeSnackbarContent(
                          inMaterialBanner: true,
                          title:  'Patrolling Paused!',
                          color: Colors.red,
                          titleFontSize: 13,
                          message:
                          'Patrolling Paused!',
                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                          contentType: ContentType.success,

                        ),
                        ));
                        Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context)=>RestartPatrolling(this.widget.id,this.widget.timer)
                    ));
                  },
                      child:Text("Pause Patrolling")),
                  Spacer(flex: 1,),
                  ElevatedButton(onPressed: ()async{
                    showDialog(
                    barrierDismissible: false
                    ,
                        context: context, builder: (context)=>
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
                    print("kalyan ram called here");
                    await Hive.openBox("local");
                    var boxx= Hive.box("local");
                    boxx.put("patrolling","completed");
                    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                    final dateFormatter = DateFormat('yyyy-MM-dd');
                    final timeFormatter = DateFormat('HH:mm:ss');
                    final DateTime now = DateTime.now();
                    final a="";
                    final formattedDate = dateFormatter.format(now);
                    final formattedTime = timeFormatter.format(now);
                    print("kalyan ram called here");
                    final finalresult=await ApiHandler().completePatrolling(boxx.get("number"), position.latitude.toString(),position.longitude.toString(),
                        boxx.get("token"),formattedTime,formattedDate);
                    print("maneesh teja");
                    Navigator.of(context).pop();
                    print(finalresult);
                    Navigator.of(context).pop();
                    timer1!.cancel();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: AwesomeSnackbarContent(
                      inMaterialBanner: true,

                      title:  'Patrolling Accomplished!',
                      color: Colors.green,
                      titleFontSize: 13,
                      message:
                      'Patrolling Accomplished!',
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                    ));
                  },
                      child:Text("Complete Patrolling")),
                  Spacer(flex: 3,),
                ],
              ),
              height: 0.5*height,
              width: width,
            ),
        ],

      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: (){
                  Navigator.of(context).pop();
                },
                  icon: Icon(Icons.home,size: 0.04*height,),color: Colors.white,),
                Text("Home",style: TextStyle(color: Colors.white,fontSize:0.015*height,),),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: (){},
                  icon: Icon(Icons.explore_rounded,size: 0.04*height,),color: Colors.white,),
                Text("Explore",style: TextStyle(color: Colors.white,fontSize:0.015*height,),)
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: ()async{
                  await Hive.openBox("local");
                  var boxx= Hive.box("local");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>
                          MyProfile(Name: boxx.get('Name'),
                              Designation: boxx.get('Designation'),
                              Station: boxx.get('Station'),
                              Enrol_Code: boxx.get('Enrol_Code'),
                              Thana_Code: boxx.get('Thana_Code'),
                              Mobile: boxx.get('Mobile'),
                              Parentage: boxx.get('Parentage'),
                              Email: boxx.get('Email'),
                              Address: boxx.get('Address'),
                              Zone: boxx.get('Zone'),
                              Enrolled_App: boxx.get('Enrolled_App'),
                              Role: boxx.get('Role'))
                  ));
                },
                  icon: Icon(Icons.account_circle_sharp,size: 0.04*height,),
                  color: Colors.white,),
                Text("Profile",style: TextStyle(color: Colors.white,fontSize:0.015*height,),)
              ],
            ),


          ],
        ),
        margin: EdgeInsets.only(right: 0.17*width,
            left: 0.17*width,bottom: 4,top: 10),
        decoration: BoxDecoration(
          color: Color(0xff020527),
          borderRadius: BorderRadius.circular(40),
        ),
        height: 0.095*height,
      ),

    );
  }
}
