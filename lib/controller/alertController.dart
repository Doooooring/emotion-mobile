import "package:get/get.dart";

class AlertController extends GetxController {
  var isAlert = false.obs;

  void isON() {
    isAlert = true.obs;
  }

  void isOff() {
    isAlert = true.obs;
  }
}
