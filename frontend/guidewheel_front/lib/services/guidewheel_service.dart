import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guidewheel_front/models/measure_model.dart';
import 'package:guidewheel_front/models/total_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Service to get data from api.
class GuidewheelService extends ChangeNotifier {
  final String _baseUrl = 'localhost:3002';
  List<MeasureModel> measures = [];
  List<TotalDataModel> totalMeasures = [];

  /// Get all data from api.
  /// Returns object with info.
  Future getAllMeasures() async {
    var url = Uri.http(_baseUrl, '/api/v1/panel/all-data');
    await initializeDateFormatting();
    var resp = await http.get(url);

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp['total'] > 0) {
      measures = List<MeasureModel>.from(
          decodedResp['data'].map((measure) => MeasureModel.fromJson(measure)));

      Map<String, dynamic> objMeasure = {
        "total": decodedResp['total'],
        "idleTime": decodedResp['idleTime'],
        "idleThreshold": decodedResp['idleThreshold'],
        "unloadTime": decodedResp['unloadTime'],
        "unloadThreshold": decodedResp['unloadThreshold'],
        "measures": measures
      };
      return objMeasure;
    } else {
      return false;
    }
  }
}
