import 'dart:core';

import 'package:covid_stats/ui/shared/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartsWidget extends StatefulWidget {

  final double confirmed;
  final double recovered;
  final double deaths;


  ChartsWidget({this.confirmed, this.recovered, this.deaths});

  @override
  _ChartsWidgetState createState() => _ChartsWidgetState();
}

class _ChartsWidgetState extends State<ChartsWidget> {
  int touchedIndex;
  bool isLight = true;



  @override
  void initState() {
    super.initState();;
  }

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> showingSections(
        {double confirmed, double recovered, double deaths}) {
      return List.generate(3, (i) {
        final isTouched = i == touchedIndex;
        final double fontSize = isTouched ? 25 : 16;
        final double radius = isTouched ? 60 : 50;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: confirmedColor,
              value: confirmed,
              title: '$confirmed Confirmed',
              titlePositionPercentageOffset: 1.5,
              showTitle: false,
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
//                  color: normal
              ),
            );
          case 1:
            return PieChartSectionData(
              color: deathColor,
              value: deaths,
              title: '$deaths Death',
              titlePositionPercentageOffset: 1.5,showTitle: false,
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
//                  color: normal
              ),
            );
          case 2:
            return PieChartSectionData(
              color: recoverdColor,
              value: recovered,
              title: '$recovered Recovered',
              titlePositionPercentageOffset: 1.5,
              showTitle: false,
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
//                  color: normal
              ),
            );
          default:
            return null;
        }
      });
    }


    return PieChart(
      PieChartData(
          startDegreeOffset: 100,
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 0,
          centerSpaceRadius: 40,
          sections: showingSections(
              confirmed:
              widget.confirmed,
              deaths: widget.deaths,
              recovered:
              widget.recovered)),
    );
  }
}
