import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart'; // for mobile directory
import '../../../core/constants/api_constants.dart';
import '../../../core/utils/helpers/snackbar_utils.dart';
import '../model/export_options.dart';

class ExportController extends ChangeNotifier {
  DateTime fromDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime toDate = DateTime.now();
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

  Future<void> exportData(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      if (token == null) {
        showTopSnackBar(context, "Authorization token not found", success: false);
        return;
      }

      final String baseUrl = "${ApiConstants.prodBaseUrl}/api/export-expense";
      // final String baseUrl = "https://z0vx5pwf-5000.inc1.devtunnels.ms/api/export-expense";
      final String from = fromDate.toIso8601String().split('T').first;
      final String to = toDate.toIso8601String().split('T').first;
      final Uri url = Uri.parse("$baseUrl?from=$from&to=$to");

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        },
      );

      if (response.statusCode == 200) {
        // Save to mobile Downloads folder
        final directory = await getExternalStorageDirectory(); // Android
        // final directory = await getApplicationDocumentsDirectory(); // iOS
        final path = directory!.path;
        final String fileName = "expense_export_${from}_to_${to}.xlsx";
        final File file = File("$path/$fileName");

        final Uint8List bytes = Uint8List.fromList(response.bodyBytes);
        await file.writeAsBytes(bytes);

        showTopSnackBar(context, "Export successful — opening file...", success: true);

        // Open file automatically
        await OpenFilex.open(file.path);
      } else {
        showTopSnackBar(context, "Failed to export data", success: false);
      }
    } catch (e) {
      showTopSnackBar(context, "Error: ${e.toString()}", success: false);
      print(e.toString());
    }
  }
}



// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../core/utils/helpers/snackbar_utils.dart';
// import 'package:open_filex/open_filex.dart';
//
//
// import '../model/export_options.dart';
//
// class ExportController extends ChangeNotifier {
//   DateTime fromDate = DateTime.now().subtract(const Duration(days: 7));
//   DateTime toDate = DateTime.now();
//   FileFormat selectedFormat = FileFormat.csv;
//
//   void setFromDate(DateTime date) {
//     fromDate = date;
//     notifyListeners();
//   }
//
//   void setToDate(DateTime date) {
//     toDate = date;
//     notifyListeners();
//   }
//
//   void setFormat(FileFormat format) {
//     selectedFormat = format;
//     notifyListeners();
//   }
//
//   /// ✅ EXPORT DATA AND SAVE FILE LOCALLY
//   Future<void> exportData(BuildContext context) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('access_token');
//
//       if (token == null) {
//         showTopSnackBar(context, "Authorization token not found", success: false);
//         return;
//       }
//
//       final String baseUrl = "https://z0vx5pwf-5000.inc1.devtunnels.ms/api/export-expense";
//       final String from = fromDate.toIso8601String().split('T').first;
//       final String to = toDate.toIso8601String().split('T').first;
//
//       final Uri url = Uri.parse("$baseUrl?from=$from&to=$to");
//
//       final response = await http.get(
//         url,
//         headers: {
//           "Authorization": "Bearer $token",
//           "Accept": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
//         },
//       );
//
//       if (response.statusCode == 200) {
//         // ✅ Get directory to save the file
//         final directory = await getDownloadsDirectory() ?? await getApplicationDocumentsDirectory();
//         final filePath = "${directory.path}/expense_export_${DateTime.now().millisecondsSinceEpoch}.xlsx";
//
//         final file = File(filePath);
//         await file.writeAsBytes(response.bodyBytes);
//
//         showTopSnackBar(context, "Exported successfully: ${file.path}", success: true);
//
//         // Optional: open the file automatically
//         await OpenFile.open(file.path);
//       } else {
//         showTopSnackBar(context, "Failed to export data", success: false);
//       }
//     } catch (e) {
//       showTopSnackBar(context, "Error: ${e.toString()}", success: false);
//     }
//   }
// }
