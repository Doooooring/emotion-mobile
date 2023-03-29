import "package:get/get.dart";

class UserController extends GetxController {
  var id = null;
  var name = null;
  var access = null;
  var code = null;
  RxString role = "main".obs;

  void getId(String newId) {
    id = newId.obs;
    update();
  }

  void getName(String newName) {
    name = newName.obs;
    update();
  }

  void getAccess(String token) {
    access = token.obs;
    update();
  }

  void getCode(String log) {
    code = log.obs;
    update();
  }

  void getRole(String log) {
    role = log.obs;
    update();
  }
}
