import 'package:flutter/material.dart';

import '../model/export_options.dart';


class ExportController extends ChangeNotifier {
  DateTime fromDate = DateTime(2024, 1, 1);
  DateTime toDate = DateTime(2024, 7, 25);
  FileFormat selectedFormat = FileFormat.csv;

  void setFromDate(DateTime date) {
    fromDate = date;
    notifyListeners();
  }

  void setToDate(DateTime date) {
    toDate = date;
    notifyListeners();
  }

  void setFormat(FileFormat format) {
    selectedFormat = format;
    notifyListeners();
  }

  void exportData() {
    // TODO: Implement real export logic
    debugPrint("Exporting data from $fromDate to $toDate as $selectedFormat");
  }
}
