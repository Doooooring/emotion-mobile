import "package:aeye/controller/childController.dart";
import "package:aeye/repositories/child.dart";
import "package:aeye/utils/interface/child.dart";

class AdviceServices {
  ChildRepositories childRepositories = ChildRepositories();

  Future<List<Child>> getChildren(ChildController controller) async {
    Map response = await childRepositories.getTemperament();
    List<Map> children = response["children"];
    List<Child> childList = children.map((comp) {
      Child child = Child.fromJson(comp);
      return child;
    }).toList();
    return childList;
  }

  Future<bool> addChild(
      String name, String temperament, ChildController controller) async {
    Map childInfo = await childRepositories.postTemperament(name, temperament);
    String id = childInfo["id"];
    Child newChild =
        Child.fromJson({"id": id, "name": name, "temperament": temperament});
    controller.addChild(newChild);
    return true;
  }

  void reviseChild(String id, String name, String temperament,
      ChildController controller) async {
    await childRepositories.patchTemperament(id, name, temperament);
    Child newInfo =
        Child.fromJson({id: id, name: name, temperament: temperament});
    controller.reviseChild(id, newInfo);
  }
}
