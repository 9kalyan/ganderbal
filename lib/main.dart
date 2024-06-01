import 'dart:async';

import 'package:android_id/android_id.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ganderbal/ADependecy.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ganderbal/ApiHandler.dart';
import 'package:ganderbal/Patrolling_Team_Dashboard.dart';
import 'package:ganderbal/RegisterPage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pusher_beams/pusher_beams.dart';
import 'package:wakelock/wakelock.dart';
import 'package:intl/intl.dart';
void main() async{
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  const instanceID = '192b031c-ef56-49a0-8368-cd3bce5305b1';
  await PusherBeams.instance.start(instanceID);
  await PusherBeams.instance.setDeviceInterests(['hello']);
  runApp(const MyApp());
  DependecyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return
      GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(),

    );
  }
}
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin{
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(milliseconds: 500),()async{
      // Request background location permission
      Location location = new Location();
      bool _serviceEnabled;
      LocationData _locationData;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }
      await Hive.openBox("local");
      var box = Hive.box("local");
      final position = await location.getLocation();
      location.enableBackgroundMode(enable: true);
      box.put("accuracy", position.accuracy.toString());
      const _androidIdPlugin = AndroidId();
      final String? androidId = await _androidIdPlugin.getId();
      if(!box.containsKey("number")){
        await box.put("number","");
      }
      if(!box.containsKey("token")){
        await box.put("token","");
      }
      //////////////////////////////////////////
      final apiresult=await ApiHandler().deviceStatus(box.get("number"),box.get("token"));
      if(apiresult=="API_Android:Token mismatch, proxy attempt identified" || apiresult=="Android_API:Device Not Registered"){
        await ApiHandler().resetNumber(box.get("number"));
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PhonenumberPage()));
      }
      /////////////////////////////////////////
      if(!box.containsKey("login")){
        await box.put("login",false);
      }
      if(!box.containsKey("token")){
        await box.put("token","");
      }
      final device_registered=await ApiHandler().deviceStatus(box.get("number"),box.get("token"));
      box.put("otprecieved", false);
      print(device_registered);
      print("here device status checked ");
      if(box.get("login") && device_registered.toString()!="Android_API:Device Not Registered"){
        await Hive.openBox("local");
        var boxx= Hive.box("local");
        boxx.put("patrolling", "");
        await ApiHandler().refresh(boxx.get("number"), position.latitude.toString(), position.longitude.toString(), boxx.get("token"));
        await ApiHandler().deviceStatus(boxx.get("number"), boxx.get("token"));
        if(!box.get("SSP")){
      Navigator.of(context).pushReplacement
        (
        //kalfyan chnages made here are from Patrollinf to Higher
          MaterialPageRoute(builder:(context)=>PatrollingTeam(box.get("Name"),box.get("Designation"),
              box.get("Station"))
          ));
        if(box.get("patrolling")=="started"){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
            PausePatrolling(box.get("id"),timer1)
          ));
        }
        if(box.get("patrolling")=="paused"){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>
              RestartPatrolling(box.get("id"),timer1)
          ));
        }
        }
      else {
          Navigator.of(context).pushReplacement
            (
              MaterialPageRoute(builder: (context) =>
                  HigherOfficials(
                      box.get("Name"), box.get("Designation"),
                      box.get("Station")
                  )));
        }
      }
    else {
        if (box.get("number") == null){
          box.put("number", "");
          print("kalyan");
      }
      else {
        print("ram");
        final number=box.get("number");
      }
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder:(context)=>PhonenumberPage()));
        // MaterialPageRoute(builder:(context)=>StartPatrolling()));
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.only(top:50),
          height: 0.8*MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset("assets/splash.png",fit: BoxFit.fill,),
        ),
      ),
    );
  }
}
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
    );
  }
}


