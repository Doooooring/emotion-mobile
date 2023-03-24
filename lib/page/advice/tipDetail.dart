import "package:aeye/component/common/bottom_bar.dart";
import "package:aeye/controller/sizeController.dart";
import "package:flutter/material.dart";

Map<String, Map> DetailBody = {
  "Changing environment": {
    "Easy":
        "They <adapt well> to the new environment and are <emotionally stable>, so they have less difficulty raising them.#Children with easy temperament often <can't express themselves well> even if they are stressed out, so be careful.#In the case of multiple children, it is important to respond well to their children's emotions because it is relatively easy for parents to pay less attention due to their easy temperament.#In general, don't let them get pushed out of the way just because they laugh and play well, but <take care to show more special interest every day!>",
    "Difficult":
        "It <takes a long time> for children with difficult temperament to adapt to the new environment and children with difficult temperament are prone to <strong rejection>#Children with difficult temperament are sensitive to parents' reactions, so it is necessary to take a good look at their children's reactions and behaviors and <provide them with a sense of stability>.",
    "Slow to warm up":
        "Slow-tempered children respond slowly to unfamiliar environments, but exhibit slow-adaptive <behavior patterns>.#As they show a negative reaction in the new environment, parents of a slow-tempered child sometimes feel that their child is similar to a difficult temperament.#Since children with slow temperament are slow to adapt, conflicts with parents who are impatient can be caused, so parents' <patience is needed>."
  },
  "During conflict": {
    "Easy":
        "It is <important not to force> a child of a easy temperament <to yield in the event of a conflict> because he or she can obey what he or she does not like.#It can increase your child's sadness and anger, which can be detrimental to healthy development.",
    "Difficult":
        "It${"'"}s better to <offer more than one alternative>, rather than control or prohibition, such as ${'"'}No!${'"'} and ${"${'"'}Don${"'"}t!"} so that the child can make his or her own choices.",
    "Slow to warm up":
        "The more pressing or urging, the more negatively children reject or act.#It also takes longer to adapt, so be careful.#It's better to help your child try <to change slowly> instead of trying to change suddenly."
  }
};

class TipDetail extends StatelessWidget {
  const TipDetail(
      {Key? key,
      required this.temperament,
      required this.title,
      required this.name})
      : super(key: key);

  final String temperament;
  final String title;
  final String name;

  @override
  Widget build(BuildContext context) {
    String detailBody = DetailBody[title]![temperament];

    return Scaffold(
      appBar: TipDetailHeader(title),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            padding: EdgeInsets.only(
              top: 50,
              left: 40,
              right: 40,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              BodyHeader(title, temperament, name, scaleWidth(context, 240)),
              SizedBox(height: 50),
              BodyContent(temperament, title, detailBody)
            ])),
      ),
      bottomNavigationBar: BottomNavBar(state: true, curPath: "advice"),
    );
  }

  AppBar TipDetailHeader(String title) {
    return AppBar(
      leadingWidth: 50,
      titleSpacing: 0,
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          padding: EdgeInsets.all(0),
          constraints: BoxConstraints(),
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
            return;
          },
        );
      }),
      backgroundColor: Color(0xffFFF7DF),
      elevation: 0.1,
      centerTitle: false,
      title: Container(
        child: Row(
          children: [
            Text(title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                )),
          ],
        ),
      ),
    );
  }

  SizedBox BodyHeader(
      String tip, String temperament, String name, double width) {
    String title = "";

    if (tip == "Changing environment") {
      if (temperament == "Easy") {
        title = "${name} enjoys new environment!";
      } else if (temperament == "Difficult") {
        title = "How to help ${name} adapt to the new environment?";
      } else {
        title = "Be more patient for ${name} to adopt to the new environment!";
      }
    } else if (tip == "During conflict") {
      title = "How to handle conflicts with ${name}";
    } else {
      return SizedBox();
    }
    return SizedBox(
        width: width,
        child: Text(title,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500)));
  }
}

SizedBox BodyContent(String temperament, String title, String body) {
  List<String> bodySplited = body.split("#").toList();

  String imageLink = "";
  if (title == "Changing environment") {
    switch (temperament) {
      case ("Easy"):
        imageLink = "assets/images/changing_environment_easy.png";
        break;
      case ("Difficult"):
        imageLink = "assets/images/changing_environment_difficult.png";
        break;
      default:
        imageLink = "assets/images/changing_environment_slow.png";
        break;
    }
  } else {
    switch (temperament) {
      case ("Easy"):
        imageLink = "assets/images/conflict_easy.png";
        break;
      case ("Difficult"):
        imageLink = "assets/images/conflict_difficult.png";
        break;
      default:
        imageLink = "assets/images/conflict_slow.png";
        break;
    }
  }

  return SizedBox(
      child: Column(children: [
    Image.asset(imageLink),
    SizedBox(height: 50),
    ...bodySplited.map((comp) {
      return BodyComp(comp);
    }).toList()
  ]));
}

Container BodyComp(String comp) {
  List<String> compSplited = comp.split(RegExp("<|>"));

  return Container(
      padding: EdgeInsets.only(bottom: 30),
      child: RichText(
          text: TextSpan(
              style: TextStyle(fontSize: 20),
              children: List.generate(compSplited.length, (idx) {
                if (idx % 2 == 0) {
                  return TextSpan(
                      text: compSplited[idx],
                      style: TextStyle(color: Colors.black));
                } else {
                  return TextSpan(
                      text: compSplited[idx],
                      style: TextStyle(color: Color(0xffFF717F)));
                }
              }))));
}
