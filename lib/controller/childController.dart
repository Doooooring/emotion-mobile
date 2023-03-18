import "package:aeye/utils/interface/child.dart";
import "package:get/get.dart";

class ChildController extends GetxController {
  RxList<Child>? childList = null;

  void setChildList(List<Child> newChildList) {
    childList = newChildList.obs;
    update();
  }
}
