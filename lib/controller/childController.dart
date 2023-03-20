import "package:aeye/utils/interface/child.dart";
import "package:get/get.dart";

class ChildController extends GetxController {
  RxList<Child> childList = <Child>[].obs;

  void setChildList(List<Child> newChildList) {
    childList = newChildList.obs;
    update();
  }

  void addChild(Child newChild) {
    childList.add(newChild);
    update();
  }

  void reviseChild(String id, Child newInfo) {
    List<Child> newList = childList.map((child) {
      if (child.id == id) {
        return newInfo;
      } else {
        return child;
      }
    }).toList();
    setChildList(newList);
  }
}
