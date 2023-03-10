import "package:get/get.dart";

class RouteController extends GetxController {
  var curPath = "init".obs;

  void toInit() {
    curPath = "init".obs;
  }

  void toBabyMonitor() {
    curPath = "babyMonitor".obs;
  }

  void toEmotionDiary() {
    curPath = "emotionDiary".obs;
  }

  void toAdvice() {
    curPath = "advice".obs;
  }
}
