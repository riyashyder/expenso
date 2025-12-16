import 'package:expense_tracker/features/report/controller/dashboard_api_service.dart';
import 'package:flutter/material.dart';
import '../model/report_data.dart';

enum ReportType { week, month, year }

class ReportsController extends ChangeNotifier {
  final DashboardApiService api = DashboardApiService();

  bool isScreenReady = false;

  ReportType selected = ReportType.month;

  // NEW — chart type (expense or income)
  String selectedChartType = "expense";

  ReportData _data = ReportData.empty();
  ReportData get currentData => _data;

  bool isLoading = false;

  DateTime startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime endDate = DateTime.now();

  Map<String, dynamic> dashboardCards = {
    "totalIncome": 0.0,
    "totalExpense": 0.0,
    "thisMonthExpense": 0.0,
  };

  ReportsController() {
    loadReportData();
  }

  void reset() {
    isScreenReady = false;
    selected = ReportType.month;
    selectedChartType = "expense";
    _data = ReportData.empty();
    dashboardCards = {
      "totalIncome": 0.0,
      "totalExpense": 0.0,
      "thisMonthExpense": 0.0,
    };
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchDashboardData() async {
    await loadReportData();
  }

  /// Ensure list is always fixed size (12 months)
  List<double> fixedLength(List<double> list, int required) {
    if (list.length >= required) return list.sublist(0, required);
    return [...list, ...List.filled(required - list.length, 0)];
  }

  String get startDateString =>
      "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}";

  String get endDateString =>
      "${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}";

  Future<void> pickStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      startDate = picked;
      loadReportData();
    }
  }

  Future<void> pickEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      endDate = picked;
      loadReportData();
    }
  }

  /// -------------------------
  /// MAIN API CALL
  /// -------------------------
  Future<void> loadReportData() async {
    isLoading = true;
    notifyListeners();

    try {
      String from = startDate.toIso8601String();
      String to = endDate.toIso8601String();

      // ----- CARDS API -----
      final cardRes = await api.getCards(from, to);
      final cardData = cardRes["data"];

      dashboardCards = {
        "totalIncome": (cardData["totalIncome"] ?? 0).toDouble(),
        "totalExpense": (cardData["totalExpense"] ?? 0).toDouble(),
        "thisMonthExpense": (cardData["thisMonthExpense"] ?? 0).toDouble(),
      };

      double spending = dashboardCards["thisMonthExpense"];

      // ----- CATEGORY PIE CHART -----
      final categoryList =
      await api.getCategoryChart(from, to, selectedChartType);

      Map<String, double> breakdown = {
        for (var e in categoryList)
          e["category"].toString(): (e["total"] ?? 0).toDouble()
      };

      // ----- MONTHLY CHART (Jan–Dec) -----
      // ----- MONTHLY CHART -----
      final monthlyList = await api.getMonthlyChart(DateTime.now().year);

// Prepare 12 months list (default 0)
      List<double> monthlyIncome = List.filled(12, 0);
      List<double> monthlyExpense = List.filled(12, 0);

      for (var e in monthlyList) {
        int monthIndex = (e["month"] ?? 1) - 1;

        if (monthIndex >= 0 && monthIndex < 12) {
          monthlyIncome[monthIndex] = (e["income"] ?? 0).toDouble();
          monthlyExpense[monthIndex] = (e["expense"] ?? 0).toDouble();
        }
      }

      _data = ReportData(
        spending: spending,
        changePercentage: 10,
        isIncrease: true,
        breakdown: breakdown,
        monthlyIncome: monthlyIncome,
        monthlyExpense: monthlyExpense,
      );
      isScreenReady = true;

    } catch (e) {
      print("ERROR REPORT CONTROLLER: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  /// Week / Month / Year toggle
  void changeReport(ReportType type) {
    selected = type;
    loadReportData();
  }

  /// NEW — user changes chart type
  void changeChartType(String type) {
    selectedChartType = type;
    loadReportData();
  }
}






// import 'package:expense_tracker/features/report/controller/dashboard_api_service.dart';
// import 'package:flutter/material.dart';
// import '../model/report_data.dart';
//
// enum ReportType { week, month, year }
//
// class ReportsController extends ChangeNotifier {
//   final DashboardApiService api = DashboardApiService();
//
//   ReportType selected = ReportType.month;
//
//   ReportData _data = ReportData.empty();
//   ReportData get currentData => _data;
//
//   bool isLoading = false;
//
//   DateTime startDate = DateTime.now().subtract(const Duration(days: 7));
//   DateTime endDate = DateTime.now();
//
// // Stores totalIncome, totalExpense, thisMonthExpense
//   Map<String, dynamic> dashboardCards = {
//     "totalIncome": 0.0,
//     "totalExpense": 0.0,
//     "thisMonthExpense": 0.0,
//   };
//
//
//   String get startDateString =>
//       "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}";
//
//   String get endDateString =>
//       "${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}";
//
//   Future<void> pickStartDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: startDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//     );
//
//     if (picked != null) {
//       startDate = picked;
//       loadReportData();
//     }
//   }
//
//   Future<void> pickEndDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: endDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//     );
//
//     if (picked != null) {
//       endDate = picked;
//       loadReportData();
//     }
//   }
//
//
//   ReportsController() {
//     loadReportData();
//   }
//
//   Future<void> loadReportData() async {
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       String from = startDate.toIso8601String();
//       String to = endDate.toIso8601String();
//
//       // ----- CARDS API -----
//       final cardRes = await api.getCards(from, to);
//       final cardData = cardRes["data"];
//
//       dashboardCards = {
//         "totalIncome": (cardData["totalIncome"] ?? 0).toDouble(),
//         "totalExpense": (cardData["totalExpense"] ?? 0).toDouble(),
//         "thisMonthExpense": (cardData["thisMonthExpense"] ?? 0).toDouble(),
//       };
//
//       double spending = dashboardCards["thisMonthExpense"];
//
//       // ----- CATEGORY CHART API -----
//       final categoryList = await api.getCategoryChart(from, to, "expense");
//
//       Map<String, double> breakdown = {
//         for (var e in categoryList)
//           e["category"].toString(): (e["total"] ?? 0).toDouble()
//       };
//
//       // ----- MONTHLY CHART -----
//       final monthlyList = await api.getMonthlyChart(DateTime.now().year);
//
//       List<double> monthlySpending = monthlyList
//           .map<double>((e) => (e["expense"] ?? 0).toDouble())
//           .toList();
//
//       // BUILD FINAL REPORT DATA
//       _data = ReportData(
//         spending: spending,
//         changePercentage: 10,
//         isIncrease: true,
//         breakdown: breakdown,
//         monthlySpending: monthlySpending,
//       );
//     } catch (e) {
//       print("ERROR: $e");
//     }
//
//     isLoading = false;
//     notifyListeners();
//   }
//
//   void changeReport(ReportType type) {
//     selected = type;
//     loadReportData();
//   }
//
// }
