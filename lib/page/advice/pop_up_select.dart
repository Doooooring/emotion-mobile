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
    return Container();
  }
}

Container PopUp(String dropDownValue, Function(String) setDropDownValue,
    TextEditingController controller) {
  return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
            child: Row(children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
          TextButton(onPressed: () {}, child: Text("Save"))
        ])),
        SizedBox(
            width: double.infinity, child: Row(children: [Text("Add info")])),
        SizedBox(height: 60),
        SizedBox(
            width: double.infinity,
            child: Row(children: [
              Text("Name"),
              SizedBox(
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
                        borderSide: BorderSide(width: 0, color: Colors.white))),
              ))
            ])),
        SizedBox(
            width: double.infinity,
            child: Row(children: [
              Text("Temperament"),
              DropdownButton(
                  menuMaxHeight: 150,
                  value: dropDownValue,
                  items: ["easy", "difficult", "slow to warm up"]
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
