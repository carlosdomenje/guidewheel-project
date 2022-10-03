import 'package:flutter/material.dart';
import 'package:guidewheel_front/models/measure_model.dart';

import 'package:guidewheel_front/shared/info_card.dart';
import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class GraphHistory extends StatelessWidget {
  const GraphHistory({
    Key? key,
    required this.historyList,
    required this.total,
    required this.idleTime,
    required this.unloadTime,
    required this.max,
    required this.min,
    required this.type,
  }) : super(key: key);

  final List<MeasureModel> historyList;
  final num max;
  final num min;
  final num total;
  final num idleTime;
  final num unloadTime;
  final String type;

  @override
  Widget build(BuildContext context) {
    List values = [];
    values = historyList;
    List<TimeSeriesValues> seriesList = [];

    for (var i = 0; i < values.length; i++) {
      DateTime time = DateTime.fromMillisecondsSinceEpoch(
        int.parse(historyList[i].tots),
      ).toLocal();
      TimeSeriesValues aux = TimeSeriesValues(time, historyList[i]);
      seriesList.add(aux);
    }
    num minAxisValue = 0;

    return CustomTimeChart(
      list: seriesList,
      min: min,
      max: max,
      minAxis: minAxisValue,
      type: type,
      idleTime: idleTime,
      total: total,
      unloadTime: unloadTime,
    );
  }
}

/// Time - value for model data.
class TimeSeriesValues {
  final DateTime time;
  final MeasureModel value;
  TimeSeriesValues(this.time, this.value);
}

class CustomTimeChart extends StatefulWidget {
  const CustomTimeChart(
      {Key? key,
      required this.list,
      required this.max,
      required this.min,
      required this.total,
      required this.idleTime,
      required this.unloadTime,
      required this.minAxis,
      required this.type})
      : super(key: key);
  final List<TimeSeriesValues> list;
  final String type;
  final num max;
  final num min;
  final num total;
  final num idleTime;
  final num unloadTime;
  final num minAxis;
  @override
  _CustomTimeChartState createState() => _CustomTimeChartState();
}

class ChartData {
  ChartData(this.x, this.y, this.label, this.color);
  final String x;
  final double? y;
  final String label;
  final Color color;
}

class _CustomTimeChartState extends State<CustomTimeChart> {
  DateFormat dateFormat() {
    if (widget.type == 'day') {
      return DateFormat.Hms();
    } else if (widget.type == 'week') {
      return DateFormat.Md('es_ES').add_Hm();
    } else {
      return DateFormat.Md('es_ES').add_Hm();
    }
  }

  List<bool> _barSelected = List.filled(6, true);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final totalIdlePercent = double.parse(
        ((widget.idleTime * 100) / widget.total).toStringAsFixed(1));
    final totalUnloadPercent = double.parse(
        ((widget.unloadTime * 100) / widget.total).toStringAsFixed(1));
    final totalActivePercent = 100 - totalIdlePercent - totalUnloadPercent;

    final List<ChartData> chartData = [
      ChartData('Active', totalActivePercent, 'ACTIVE  $totalActivePercent %',
          const Color.fromRGBO(0, 230, 118, 1)),
      ChartData('Unload', totalUnloadPercent, 'UNLOAD  $totalUnloadPercent %',
          const Color.fromRGBO(255, 87, 51, 1)),
      ChartData('Idle', totalIdlePercent, 'IDLE   $totalIdlePercent %',
          const Color.fromRGBO(255, 189, 57, 1))
    ];

    return Column(
      children: [
        Wrap(children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InfoCardWidget(
                      size: size,
                      title:
                          'ACTIVE: ${totalActivePercent.toStringAsFixed(1)} %',
                      value: '',
                      iconSize: 60,
                      icon: Icons.work_history_outlined,
                      iconColor: Colors.green),
                  const SizedBox(
                    width: 25,
                  ),
                  InfoCardWidget(
                      size: size,
                      iconSize: 60,
                      title: 'IDLE: ${totalIdlePercent.toStringAsFixed(1)} %',
                      value: '',
                      icon: Icons.incomplete_circle_rounded,
                      iconColor: Colors.yellow),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InfoCardWidget(
                      size: size,
                      iconSize: 60,
                      title:
                          'UNLOAD: ${totalUnloadPercent.toStringAsFixed(1)} %',
                      value: '',
                      icon: Icons.hourglass_empty_rounded,
                      iconColor: Colors.red),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 600,
            height: 400,
            child: SfCircularChart(series: <CircularSeries>[
              // Render pie chart
              PieSeries<ChartData, String>(
                  dataLabelSettings: const DataLabelSettings(
                      labelPosition: ChartDataLabelPosition.outside,
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      isVisible: true),
                  dataSource: chartData,
                  pointColorMapper: (ChartData data, _) => data.color,
                  dataLabelMapper: (ChartData data, _) => data.label,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y)
            ]),
          ),
        ]),
        const SizedBox(
          height: 20,
        ),
        const ListTile(
          leading: Icon(
            Icons.power_outlined,
            size: 40,
            //  color: Colors.orange,
          ),
          title: Text(
            'Psum - Ssum Graphic Analisys',
            style: TextStyle(fontSize: 24),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        SfCartesianChart(
          primaryXAxis: DateTimeAxis(
              enableAutoIntervalOnZooming: true,
              dateFormat: dateFormat(),
              intervalType: DateTimeIntervalType.auto),
          primaryYAxis: NumericAxis(
              desiredIntervals: 25,
              decimalPlaces: 0,
              minimum: 0,
              plotBands: [
                PlotBand(
                  start:
                      0, // y-point for with the horizontal line needs to be drawn.
                  end: widget.min,
                  borderColor: Colors.red,
                  borderWidth: 2,
                  isVisible: true,
                  color: Colors.red,
                ),
                PlotBand(
                  start: widget
                      .min, // y-point for with the horizontal line needs to be drawn.
                  end: widget.max,
                  borderColor: Colors.yellow,
                  borderWidth: 2,
                  isVisible: true,
                ),
                PlotBand(
                  start: (widget.max +
                      3), // y-point for with the horizontal line needs to be drawn.
                  end: 420,
                  borderColor: Colors.lightGreen,
                  color: Colors.lightGreen,
                  opacity: 0.3,
                  borderWidth: 2,
                  isVisible: true,
                ),
              ]),
          zoomPanBehavior: ZoomPanBehavior(
              enableDoubleTapZooming: true,
              enableMouseWheelZooming: true,
              enablePanning: true,
              enablePinching: true,
              zoomMode: ZoomMode.x,
              enableSelectionZooming: true),
          tooltipBehavior: TooltipBehavior(
              enable: true, canShowMarker: true, format: 'point.x - point.y'),
          series: <ChartSeries<TimeSeriesValues, DateTime>>[
            FastLineSeries<TimeSeriesValues, DateTime>(
                dataSource: widget.list,
                isVisible: _barSelected[0],
                xValueMapper: (TimeSeriesValues measure, _) {
                  return measure.time;
                },
                yValueMapper: (TimeSeriesValues measure, _) {
                  return measure.value.metrics['Psum']?.avgvalue;
                },
                name: 'Ssum',
                color: Colors.blueAccent),
            FastLineSeries<TimeSeriesValues, DateTime>(
                dataSource: widget.list,
                isVisible: _barSelected[0],
                xValueMapper: (TimeSeriesValues measure, _) {
                  return measure.time;
                },
                yValueMapper: (TimeSeriesValues measure, _) {
                  return measure.value.metrics['Ssum']?.avgvalue;
                },
                name: 'Psum',
                color: Colors.redAccent),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Wrap(
          spacing: 10,
          alignment: WrapAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  color: Colors.lightGreen,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'ON - ACTIVE',
                  style: TextStyle(fontSize: 14),
                )
              ],
            ),
            const SizedBox(
              width: 30,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  color: Colors.yellow,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'ON - IDLE',
                  style: TextStyle(fontSize: 14),
                )
              ],
            ),
            const SizedBox(
              width: 30,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'ON - UNLOAD',
                  style: TextStyle(fontSize: 14),
                )
              ],
            ),
            const SizedBox(
              width: 30,
            ),
          ],
        ),
        const SizedBox(
          height: 130,
        ),
      ],
    );
  }
}
