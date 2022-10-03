// To parse this JSON data, do
//
//     final totalDataModel = totalDataModelFromJson(jsonString);

import 'dart:convert';

TotalDataModel totalDataModelFromJson(String str) =>
    TotalDataModel.fromJson(json.decode(str));

String totalDataModelToJson(TotalDataModel data) => json.encode(data.toJson());

class TotalDataModel {
  TotalDataModel({
    required this.deviceid,
    required this.fromts,
    required this.tots,
    required this.idleTime,
    required this.idleThreshold,
    required this.unloadTime,
    required this.unloadThreshold,
    required this.metrics,
  });

  final String deviceid;
  final DateTime fromts;
  final DateTime tots;
  final int idleTime;
  final double idleThreshold;
  final int unloadTime;
  final double unloadThreshold;
  final Map<String, Metric> metrics;

  factory TotalDataModel.fromJson(Map<String, dynamic> json) => TotalDataModel(
        deviceid: json["deviceid"],
        fromts: DateTime.parse(json["fromts"]),
        tots: DateTime.parse(json["tots"]),
        idleTime: json["idleTime"],
        idleThreshold: json["idleThreshold"].toDouble(),
        unloadTime: json["unloadTime"],
        unloadThreshold: json["unloadThreshold"].toDouble(),
        metrics: Map.from(json["metrics"])
            .map((k, v) => MapEntry<String, Metric>(k, Metric.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "deviceid": deviceid,
        "fromts": fromts.toIso8601String(),
        "tots": tots.toIso8601String(),
        "idleTime": idleTime,
        "idleThreshold": idleThreshold,
        "unloadTime": unloadTime,
        "unloadThreshold": unloadThreshold,
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

  final double avgvalue;
  final double maxvalue;
  final double minvalue;

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
