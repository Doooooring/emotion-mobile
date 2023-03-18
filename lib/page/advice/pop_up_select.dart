import "package:aeye/controller/sizeController.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class PopUpSelect extends StatefulWidget {
  const PopUpSelect({
    Key? key,
  }) : super(key: key);

  @override
  State<PopUpSelect> createState() => _PopUpSelectState();
}

class _PopUpSelectState extends State<PopUpSelect> {
  TextEditingController nameController = TextEditingController();

  String dropDownValue = "Easy";
  void setDropDownValue(String newValue) {
    setState(() {
      dropDownValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PopUp(context, dropDownValue, setDropDownValue, nameController));
  }
}

GestureDetector PopUp(BuildContext context, String dropDownValue,
    Function(String) setDropDownValue, TextEditingController controller) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      FocusScope.of(context).requestFocus(new FocusNode());
    },
    child: Container(
        color: Color(0xffFAF8F8),
        width: double.infinity,
        padding: EdgeInsets.only(left: 30, right: 30, top: 100),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                TextButton(
                    onPressed: () {},
                    child: Text("Save",
                        style: TextStyle(color: Colors.black, fontSize: 22)))
              ])),
          SizedBox(height: 20),
          SizedBox(
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Add info", style: TextStyle(fontSize: 30))
                  ])),
          SizedBox(height: 100),
          SizedBox(
              width: double.infinity,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: scaleWidth(context, 140),
                        child: Text("Name",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 23))),
                    SizedBox(width: scaleWidth(context, 10)),
                    Container(
                      width: scaleWidth(context, 150),
                      color: Colors.white,
                      child: TextField(
                        style: TextStyle(fontSize: 25),
                        controller: controller,
                        decoration: InputDecoration(
                            hintText: "Write your child name",
                            hintStyle: TextStyle(fontSize: 15),
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(50, 50, 50, 0.4)),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 0, color: Colors.white))),
                      ),
                    )
                  ])),
          SizedBox(height: 20),
          SizedBox(
              width: double.infinity,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                    width: scaleWidth(context, 140),
                    child: Text("Temperament",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 23))),
                SizedBox(width: scaleWidth(context, 10)),
                Container(
                  width: scaleWidth(context, 150),
                  color: Colors.white,
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          focusedBorder: InputBorder.none,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      dropdownColor: Colors.white,
                      menuMaxHeight: 200,
                      value: dropDownValue,
                      items: ["Easy", "Difficult", "Slow to warm up"]
                          .map((temperament) {
                        return DropdownMenuItem(
                            value: temperament,
                            child: Container(child: Text(temperament)));
                      }).toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setDropDownValue(value);
                      }),
                )
              ]))
        ])),
  );
}
