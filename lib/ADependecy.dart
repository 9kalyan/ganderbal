import 'package:get/get.dart';
import 'ANetworkController.dart';
class DependecyInjection{
  static void init(){
    Get.put<NetworkController>(NetworkController(),permanent: true);
  }
}