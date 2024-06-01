import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
class NetworkController extends GetxController{
  final Connectivity _connectivity=Connectivity();
  void _updateConnectionStatus(ConnectivityResult connectivityResult){
    if(connectivityResult==ConnectivityResult.none){
      Get.rawSnackbar(
        messageText: Text("Please Connect to Internet"),
        isDismissible: false,
        duration: Duration(days: 1),
        backgroundColor: Colors.red
      );
    }
    else{
      if(Get.isSnackbarOpen){
        Get.closeCurrentSnackbar();
        Get.rawSnackbar(
            messageText: Text("Connected to internet"),
            isDismissible: false,
            duration: Duration(seconds: 4),
            backgroundColor: Colors.cyan
        );
      }
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
}