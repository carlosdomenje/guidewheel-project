import 'dart:convert';

MeasureModel measureFromJson(String str) =>
    MeasureModel.fromJson(json.decode(str));

String measureToJson(MeasureModel data) => json.encode(data.toJson());

class MeasureModel {
  MeasureModel({
    required this.deviceid,
    required this.fromts,
    required this.tots,
    required this.metrics,
  });

  String deviceid;
  String fromts;
  String tots;
  Map<String, Metric> metrics;

  factory MeasureModel.fromJson(Map<String, dynamic> json) => MeasureModel(
        deviceid: json["deviceid"],
        fromts: json["fromts"],
        tots: json["tots"],
        metrics: Map.from(json["metrics"])
            .map((k, v) => MapEntry<String, Metric>(k, Metric.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "deviceid": deviceid,
        "fromts": fromts,
        "tots": tots,
        "metrics": Map.from(metrics)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Metric {
  Metric({
    required this.avgvalue,
    required this.maxvalue,
    required this.minvalue,
  });

  double avgvalue;
  double maxvalue;
  double minvalue;

  factory Metric.fromJson(Map<String, dynamic> json) => Metric(
        avgvalue: json["avgvalue"].toDouble(),
        maxvalue: json["maxvalue"].toDouble(),
        minvalue: json["minvalue"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "avgvalue": avgvalue,
        "maxvalue": maxvalue,
        "minvalue": minvalue,
      };
}
