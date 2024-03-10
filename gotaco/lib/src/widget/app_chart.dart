import 'package:flutter/material.dart';

import '../ui/theme/app_color.dart';
import 'chart/fl_chart.dart';

class AppLineChart extends StatefulWidget {
  final List<dynamic> dataList;
  final String? direction;
  final double? maxY;
  final Color backgroundColor;
  final String type;

  const AppLineChart(
      {Key? key,
      required this.dataList,
      this.direction,
      this.maxY,
      required this.backgroundColor,
      required this.type})
      : super(key: key);

  @override
  State<AppLineChart> createState() => _AppLineChartState();
}

class _AppLineChartState extends State<AppLineChart> {
  List<FlSpot> flSpots = [];
  bool isAvg = true;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.dataList.length; i++) {
      flSpots.add(
        FlSpot(i.toDouble(), widget.dataList[i]),
      );
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isAvg = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
          color: AppColor.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            right: 20,
            left: 20,
            top: 20,
            bottom: 20,
          ),
          child: LineChart(isAvg ? avgData() : mainData()),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppColor.gray565,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );

    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('00', style: style);
        break;
      case 6:
        text = const Text('06', style: style);
        break;
      case 12:
        text = const Text('12', style: style);
        break;
      case 18:
        text = const Text('18', style: style);
        break;
      case 23:
        text = const Text('24', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppColor.gray565,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );

    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 20:
        text = '20';
        break;
      case 40:
        text = '40';
        break;
      case 60:
        text = '60';
        break;
      case 80:
        text = '80';
        break;
      case 100:
        text = '100';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    var showIndexes = [DateTime.now().hour];

    var tooltipsOnBar = LineChartBarData(
      showingIndicators: showIndexes,
      spots: flSpots,
      isCurved: true,
      barWidth: 10,
      shadow: const Shadow(
        blurRadius: 8,
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: [
            widget.backgroundColor.withOpacity(0.1),
            widget.backgroundColor,
            widget.backgroundColor.withOpacity(0.1),
          ],
        ),
      ),
      dotData: FlDotData(show: false),
      gradient: LinearGradient(
        colors: [
          widget.backgroundColor.withOpacity(0.1),
          widget.backgroundColor,
          widget.backgroundColor.withOpacity(0.1),
        ],
        stops: const [0.1, 0.4, 0.9],
      ),
    );

    return LineChartData(
      gridData: FlGridData(
        show: true,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 24,
      minY: -3,
      maxY: widget.maxY == null ? 42 : widget.maxY!,
      showingTooltipIndicators: showIndexes.map((index) {
        return ShowingTooltipIndicators([
          LineBarSpot(
            tooltipsOnBar,
            0,
            tooltipsOnBar.spots[index],
          ),
        ]);
      }).toList(),
      lineTouchData: LineTouchData(
        enabled: true,
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: widget.backgroundColor,
              ),
              FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 4,
                  color: lerpGradient(
                    barData.gradient!.colors,
                    barData.gradient!.stops!,
                    percent / 50,
                  ),
                  strokeWidth: 2,
                  strokeColor: widget.backgroundColor,
                ),
              ),
            );
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: const Color(0xFF363636),
          tooltipRoundedRadius: 50,
          fitInsideHorizontally: true,
          getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
            return lineBarsSpot.map((lineBarSpot) {
              return LineTooltipItem(
                "${lineBarSpot.y.toString()} ${widget.type}",
                const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SVN-Gilroy'),
              );
            }).toList();
          },
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          // showingIndicators: showIndexes,
          spots: flSpots,
          isCurved: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              if (index == DateTime.now().hour) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: widget.backgroundColor,
                  strokeWidth: 1,
                  strokeColor: widget.backgroundColor,
                );
              } else {
                return FlDotCirclePainter(
                  radius: 0,
                  color: widget.backgroundColor,
                  strokeWidth: 2,
                  strokeColor: Colors.transparent,
                );
              }
            },
          ),
          gradient: LinearGradient(
              colors: [
                widget.backgroundColor.withOpacity(0.1),
                widget.backgroundColor,
                widget.backgroundColor.withOpacity(0.1),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: const [0.01, 0.5, 1]),
          barWidth: 1.5,
          isStrokeCapRound: false,
          // dotData: FlDotData(
          //   show: false,
          // ),
          belowBarData: BarAreaData(
            show: false,
          ),
        ),
      ],
      backgroundColor: Colors.transparent,
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 24,
      minY: 0,
      maxY: widget.maxY == null ? 42 : widget.maxY!,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 5),
            FlSpot(1, 5),
            FlSpot(2, 5),
            FlSpot(3, 5),
            FlSpot(4, 5),
            FlSpot(5, 5),
            FlSpot(6, 5),
            FlSpot(7, 5),
            FlSpot(8, 5),
            FlSpot(9, 5),
            FlSpot(10, 5),
            FlSpot(11, 5),
            FlSpot(12, 5),
            FlSpot(13, 5),
            FlSpot(14, 5),
            FlSpot(15, 5),
            FlSpot(16, 5),
            FlSpot(17, 5),
            FlSpot(18, 5),
            FlSpot(19, 5),
            FlSpot(20, 5),
            FlSpot(21, 5),
            FlSpot(22, 5),
            FlSpot(23, 5),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: widget.backgroundColor, end: Colors.black)
                  .lerp(0.2)!,
              ColorTween(begin: widget.backgroundColor, end: Colors.black)
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 1.5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
          ),
        ),
      ],
    );
  }
}

/// Lerps between a [LinearGradient] colors, based on [t]
Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (colors.isEmpty) {
    throw ArgumentError('"colors" is empty.');
  } else if (colors.length == 1) {
    return colors[0];
  }

  if (stops.length != colors.length) {
    stops = [];

    /// provided gradientColorStops is invalid and we calculate it here
    colors.asMap().forEach((index, color) {
      final percent = 1.0 / (colors.length - 1);
      stops.add(percent * index);
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s];
    final rightStop = stops[s + 1];
    final leftColor = colors[s];
    final rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT)!;
    }
  }
  return colors.last;
}
