import 'package:flutter/material.dart';

import '../model/report_data.dart';


enum ReportType { week, month, year }

class ReportsController extends ChangeNotifier {
  ReportType selected = ReportType.month;

  final Map<ReportType, ReportData> _data = {
    ReportType.week: ReportData(
      spending: 456.78,
      changePercentage: 5,
      isIncrease: true,
      breakdown: {
        "Food": 150,
        "Transport": 100,
        "Entertainment": 120,
        "Utilities": 86,
      },
      monthlySpending: [50, 80, 100, 120, 90, 60, 70],
    ),
    ReportType.month: ReportData(
      spending: 1234.56,
      changePercentage: 12,
      isIncrease: true,
      breakdown: {
        "Food": 400,
        "Transport": 300,
        "Entertainment": 200,
        "Utilities": 334,
      },
      monthlySpending: [800, 950, 1000, 1100, 1234, 900],
    ),
    ReportType.year: ReportData(
      spending: 5678.90,
      changePercentage: 5,
      isIncrease: false,
      breakdown: {
        "Food": 2000,
        "Transport": 1500,
        "Entertainment": 1200,
        "Utilities": 978,
      },
      monthlySpending: [4000, 4200, 4500, 4900, 5200, 5678],
    ),
  };

  ReportData get currentData => _data[selected]!;

  void changeReport(ReportType type) {
    selected = type;
    notifyListeners();
  }
}
