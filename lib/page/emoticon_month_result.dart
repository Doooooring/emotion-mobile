import "package:flutter/material.dart";
import "package:syncfusion_flutter_charts/charts.dart";

Map monthToStr = {
  1: "January",
  2: "February",
  3: "March",
  4: "April",
  5: "May",
  6: "June",
  7: "July",
  8: "August",
  9: "September",
  10: "October",
  11: "November",
  12: "December"
};

class EmoticonMonthResult extends StatelessWidget {
  const EmoticonMonthResult({Key? key, required this.year, required this.month})
      : super(key: key);

  final int year;
  final int month;

  @override
  Widget build(BuildContext context) {
    String mon = monthToStr[month];

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xffFFF7DF),
            elevation: 0.0,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                  color: Colors.black)
            ]),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
                width: double.infinity,
                color: Color(0xffFFF7DF),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child: Column(children: [
                        Text("${mon} ${year}",
                            style: TextStyle(fontSize: 20, color: Colors.grey)),
                        SizedBox(height: 10),
                        Text("Monthly Report", style: TextStyle(fontSize: 30)),
                        SizedBox(height: 20)
                      ])),
                      Container(
                          width: 360,
                          height: 600,
                          padding: EdgeInsets.only(left: 0, right: 20, top: 30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Text("Sentiment Level",
                                        style: TextStyle(fontSize: 23)),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Container(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                      Container(
                                        width: 230,
                                        height: 230,
                                        child: CircularChart(curData: [
                                          _CircularData("positive", 12,
                                              Color(0xff4FB600)),
                                          _CircularData(
                                              "neutral", 12, Color(0xffFFB600)),
                                          _CircularData(
                                              "negative", 6, Color(0xffEC5313))
                                        ]),
                                      ),
                                      ChartLegend(curData: [
                                        _CircularData(
                                            "positive", 12, Color(0xff4FB600)),
                                        _CircularData(
                                            "neutral", 12, Color(0xffFFB600)),
                                        _CircularData(
                                            "negative", 6, Color(0xffEC5313))
                                      ])
                                    ]))
                              ]))
                    ]))));
  }
}

class CircularChart extends StatefulWidget {
  const CircularChart({Key? key, required this.curData}) : super(key: key);

  final List<_CircularData> curData;

  @override
  State<CircularChart> createState() => _CircularChartState();
}

class _CircularChartState extends State<CircularChart> {
  @override
  Widget build(BuildContext context) {
    return SfCircularChart(series: <DoughnutSeries<_CircularData, String>>[
      DoughnutSeries<_CircularData, String>(
        radius: "65%",
        innerRadius: "75%",
        dataSource: widget.curData,
        xValueMapper: (_CircularData data, _) => data.emotion,
        yValueMapper: (_CircularData data, _) => data.data,
        dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.outside,
            overflowMode: OverflowMode.none,
            labelIntersectAction: LabelIntersectAction.none,
            builder: (data, point, series, pointIndex, seriesIndex) {
              return Container(
                  height: 13,
                  width: 15,
                  child: Text(data.data.toString(),
                      style: TextStyle(color: data.pointColor)));
            }),
        dataLabelMapper: (_CircularData data, _) => data.data.toString(),
        pointColorMapper: (data, _) => data.pointColor,
        startAngle: -40,
        endAngle: 320,
      )
    ]);
  }
}

class _CircularData {
  _CircularData(this.emotion, this.data, this.pointColor);

  final String emotion;
  final int data;
  final Color pointColor;
}

class ChartLegend extends StatelessWidget {
  const ChartLegend({Key? key, required this.curData}) : super(key: key);

  final List<_CircularData> curData;

  @override
  Widget build(BuildContext context) {
    int total = curData.fold(0, (vTotal, element) {
      return vTotal + element.data;
    });

    return Container(
        child: Column(
            children: curData.map<SizedBox>((element) {
      int curRate = (element.data / total * 100).floor();
      return LegendContent(element.emotion, curRate, element.pointColor);
    }).toList()));
  }
}

SizedBox LegendContent(String title, int rate, Color color) {
  return SizedBox(
      width: 105,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          Icon(Icons.circle, size: 5, color: color),
          SizedBox(width: 5),
          Text("${title}", style: TextStyle(color: color))
        ]),
        Text("${rate}%", style: TextStyle(color: color))
      ]));
}
