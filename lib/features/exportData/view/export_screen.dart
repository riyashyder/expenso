import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/styles/styles.dart';
import '../../../shared/widgets/styles/styles.dart';
import '../../../utils/devices/get_localization_provider.dart';
import '../controller/export_controller.dart';
import '../model/export_options.dart';

class ExportScreen extends StatelessWidget {
  const ExportScreen({super.key});

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final controller = context.read<ExportController>();
    final initialDate = isFromDate ? controller.fromDate : controller.toDate;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      if (isFromDate) {
        controller.setFromDate(picked);
      } else {
        controller.setToDate(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ExportController>();
    final localizationController = getLocalizationController(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title:  Text(localizationController.getTextValue(
          "EXPORT_DATA_TITLE",
        ), style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(localizationController.getTextValue(
               "DATE_RANGE_EXPORT",
             ), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),

            // From Date
            _buildDateField(context, localizationController.getTextValue(
              "FROM_DATE",
            ), controller.fromDate, () => _selectDate(context, true)),
            const SizedBox(height: 12),

            // To Date
            _buildDateField(context,localizationController.getTextValue(
              "TO_DATE",
            ), controller.toDate, () => _selectDate(context, false)),
            // const SizedBox(height: 24),
            //
            //  Text(localizationController.getTextValue(
            //   "FILE_FORMAT",
            // ), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            // const SizedBox(height: 12),
            //
            // Row(
            //   children: [
            //     _buildFormatButton(context, localizationController.getTextValue(
            //       "CSV",
            //     ), FileFormat.csv, controller.selectedFormat == FileFormat.csv),
            //     const SizedBox(width: 12),
            //     _buildFormatButton(context, localizationController.getTextValue(
            //       "PDF",
            //     ), FileFormat.pdf, controller.selectedFormat == FileFormat.pdf),
            //   ],
            // ),

            const Spacer(),

            // Export Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.exportData(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppthemeData.primaryBackground,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child:  Text(localizationController.getTextValue(
                  "EXPORT_BTN",
                ), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 3,
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: Colors.blue,
      //   unselectedItemColor: Colors.grey,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //     BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
      //     BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: "Transactions"),
      //     BottomNavigationBarItem(icon: Icon(Icons.download), label: "Export"),
      //   ],
      // ),
    );
  }

  Widget _buildDateField(BuildContext context, String label, DateTime date, VoidCallback onTap) {
    return TextField(
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        hintText: "${date.month}/${date.day}/${date.year}",
        suffixIcon: const Icon(Icons.calendar_today),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      controller: TextEditingController(text: "${date.month}/${date.day}/${date.year}"),
    );
  }

  Widget _buildFormatButton(BuildContext context, String label, FileFormat format, bool isSelected) {
    final controller = context.read<ExportController>();
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setFormat(format),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ?  AppthemeData.primaryBackground  : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
