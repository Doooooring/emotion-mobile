import "package:aeye/controller/childController.dart";
import "package:aeye/repositories/bard.dart";
import "package:aeye/repositories/child.dart";
import "package:aeye/utils/interface/child.dart";

class AdviceServices {
  ChildRepositories childRepositories = ChildRepositories();
  BardRepositories bardRepositories = BardRepositories();

  Future<List<Child>> getChildren() async {
    Map response = await childRepositories.getTemperament();
    List<Map> children = List<Map>.from(response["children"]);
    List<Child> childList = children.map((comp) {
      Child child = Child.fromJson(comp);
      return child;
    }).toList();
    return childList;
  }

  Future<bool> addChild(String name, String temperament, int age,
      ChildController controller) async {
    Map childInfo =
        await childRepositories.postTemperament(name, temperament, age);
    String id = childInfo["id"];
    Child newChild = Child.fromJson(
        {"id": id, "name": name, "temperament": temperament, "age": age});
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

  Future<Map<String, dynamic>> getAdvice(String id, String name, int age,
      String temperament, String content) async {
    try {
      Map<String, dynamic> result =
          await bardRepositories.getAdvice(id, name, age, temperament, content);
      return result;
    } catch (e) {
      print(e);
    } finally {
      return {"result": null};
    }
  }
}
