import "package:flutter/material.dart";

class PopUpSelect extends StatefulWidget {
  const PopUpSelect({
    Key? key,
  }) : super(key: key);

  @override
  State<PopUpSelect> createState() => _PopUpSelectState();
}

class _PopUpSelectState extends State<PopUpSelect> {
  TextEditingController nameController = TextEditingController();

  String dropDownValue = "";
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

Container PopUp(BuildContext context, String dropDownValue,
    Function(String) setDropDownValue, TextEditingController controller) {
  return Container(
      color: Color(0xffFAF8F8),
      width: double.infinity,
      padding: EdgeInsets.only(left: 30, right: 30, top: 100),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
              TextButton(
                  onPressed: () {},
                  child: Text("Save", style: TextStyle(color: Colors.black)))
            ])),
        SizedBox(height: 20),
        SizedBox(
            width: double.infinity,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Add info", style: TextStyle(fontSize: 30))])),
        SizedBox(height: 60),
        SizedBox(
            width: double.infinity,
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              SizedBox(
                  width: 100,
                  child: Text(
                    "Name",
                    textAlign: TextAlign.center,
                  )),
              Expanded(
                  child: Container(
                width: double.infinity,
                color: Colors.white,
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: "Write your child name",
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(50, 50, 50, 0.4)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, color: Colors.white))),
                ),
              ))
            ])),
        SizedBox(
            width: double.infinity,
            child: Row(children: [
              SizedBox(
                  width: 100,
                  child: Text(
                    "Temperament",
                    textAlign: TextAlign.center,
                  )),
              DropdownButton(
                  menuMaxHeight: 150,
                  value: dropDownValue,
                  items: ["", "easy", "difficult", "slow to warm up"]
                      .map((temperament) {
                    return DropdownMenuItem(
                        value: temperament, child: Text(temperament));
                  }).toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setDropDownValue(value);
                  })
            ]))
      ]));
}
