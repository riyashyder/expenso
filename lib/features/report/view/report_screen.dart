import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../utils/devices/get_localization_provider.dart';
import '../../settings/controller/currency_provider.dart';
import '../controller/report_controller.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currency = context.watch<CurrencyProvider>();
    final symbol = currency.symbol;

    final controller = context.watch<ReportsController>();

    if (controller.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final localizationController = getLocalizationController(
      context,
      listen: false,
    );

    final data = controller.currentData;

    final List<Color> pieColors = [
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.teal,
      Colors.cyan,
      Colors.amber,
      Colors.indigo,
    ];

    Color getCategoryColor(int index) => pieColors[index % pieColors.length];

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// -----------------------------------
            /// DATE PICKERS
            /// -----------------------------------
            Row(
              children: [
                Expanded(
                  child: _dateBox(
                    "${localizationController.getTextValue(
                      "REPORTS_FROM",
                    )} ${controller.startDateString}",
                    () => controller.pickStartDate(context),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _dateBox(
                    "${localizationController.getTextValue(
                      "REPORTS_TO",
                    )} ${controller.endDateString}",
                    () => controller.pickEndDate(context),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// -----------------------------------
            /// TOP CARDS
            /// -----------------------------------
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch, //  IMPORTANT
                children: [
                  Expanded(
                    child: _valueCard(
                      title:
                          localizationController.getTextValue("TOTAL_INCOME"),
                      value: controller.dashboardCards["totalIncome"],
                      color: Colors.green,
                      symbol: symbol,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _valueCard(
                      title:
                          localizationController.getTextValue("TOTAL_EXPENSE"),
                      value: controller.dashboardCards["totalExpense"],
                      color: Colors.red,
                      symbol: symbol,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _valueCard(
                      title: localizationController
                          .getTextValue("THIS_MONTH_REPORT"),
                      value: controller.dashboardCards["thisMonthExpense"],
                      color: Colors.blue,
                      symbol: symbol,
                    ),
                  ),
                ],
              ),
            ),

            // const SizedBox(height: 20),
            //
            // /// -----------------------------------
            // /// Week / Month / Year Toggle
            // /// -----------------------------------
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     _buildToggle("Week", ReportType.week, controller),
            //     _buildToggle("Month", ReportType.month, controller),
            //     _buildToggle("Year", ReportType.year, controller),
            //   ],
            // ),

            const SizedBox(height: 20),

            /// -----------------------------------
            /// Pie Chart Type Toggle (NEW)
            /// -----------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildChartTypeToggle(
                    localizationController.getTextValue(
                      "EXPENSE",
                    ),
                    "expense",
                    controller),
                const SizedBox(width: 12),
                _buildChartTypeToggle(
                    localizationController.getTextValue(
                      "INCOME",
                    ),
                    "income",
                    controller),
              ],
            ),

            const SizedBox(height: 20),

            /// -----------------------------------
            /// PIE CHART — BREAKDOWN
            /// -----------------------------------
            _buildCard(
              child: data.breakdown.isEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${controller.selectedChartType == 'expense' ? '${localizationController.getTextValue(
                              "EXPENSE",
                            )}' : '${localizationController.getTextValue(
                              "INCOME",
                            )}'} Breakdown",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              localizationController.getTextValue("NO_DATA"),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${controller.selectedChartType == 'expense' ? '${localizationController.getTextValue(
                              "EXPENSE",
                            )}' : '${localizationController.getTextValue(
                              "INCOME",
                            )}'} Breakdown",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          height: 160,
                          child: PieChart(
                            PieChartData(
                              centerSpaceRadius: 40,
                              sections: [
                                for (int i = 0; i < data.breakdown.length; i++)
                                  PieChartSectionData(
                                    title: "",
                                    value: data.breakdown.values.elementAt(i),
                                    color: getCategoryColor(i),
                                    radius: 50,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),
                        Wrap(
                          spacing: 12,
                          children: [
                            for (int i = 0; i < data.breakdown.length; i++)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 6,
                                    backgroundColor: getCategoryColor(i),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(data.breakdown.keys.elementAt(i)),
                                ],
                              ),
                          ],
                        )
                      ],
                    ),
            ),

            const SizedBox(height: 20),

            /// -----------------------------------
            /// MONTHLY SPENDING (Bars)
            /// -----------------------------------
            /// -----------------------------------
            /// MONTHLY EXPENSE (Bars)
            /// -----------------------------------
            _buildCard(
              child: (data.monthlyIncome.isEmpty &&
                          data.monthlyExpense.isEmpty) ||
                      (data.monthlyIncome.every((e) => e == 0) &&
                          data.monthlyExpense.every((e) => e == 0))
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizationController
                            .getTextValue("MONTHLY_INCOME_EXPENSE"),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 16),
                      Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              localizationController.getTextValue("NO_DATA"),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localizationController
                              .getTextValue("MONTHLY_INCOME_EXPENSE"),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 16),

                        /// ---------- TOTALS ROW ----------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${localizationController.getTextValue("TOTAL_INCOME_AMOUNT")} $symbol${data.monthlyIncome.fold(0.0, (a, b) => a + b).toStringAsFixed(0)}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              "${localizationController.getTextValue("TOTAL_EXPENSE_AMOUNT")} $symbol${data.monthlyExpense.fold(0.0, (a, b) => a + b).toStringAsFixed(0)}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        /// ---------- MONTHLY BARS ----------
                        Column(
                          children: List.generate(12, (i) {
                            final months = [
                              "Jan",
                              "Feb",
                              "Mar",
                              "Apr",
                              "May",
                              "Jun",
                              "Jul",
                              "Aug",
                              "Sep",
                              "Oct",
                              "Nov",
                              "Dec"
                            ];

                            final income = data.monthlyIncome[i];
                            final expense = data.monthlyExpense[i];

                            final maxValue = [
                              ...data.monthlyIncome,
                              ...data.monthlyExpense
                            ].reduce((a, b) => a > b ? a : b);

                            double incomePercent =
                                maxValue == 0 ? 0 : income / maxValue;
                            double expensePercent =
                                maxValue == 0 ? 0 : expense / maxValue;

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Month Title
                                  Text(
                                    months[i],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 6),

                                  /// ---------- INCOME BAR ----------
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        child: Text(
                                          localizationController
                                              .getTextValue("LABEL_INCOME"),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: FractionallySizedBox(
                                            alignment: Alignment.centerLeft,
                                            widthFactor: incomePercent,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        width: 60,
                                        child: Text(
                                          "$symbol${income.toStringAsFixed(0)}",
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 6),

                                  /// ---------- EXPENSE BAR ----------
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        child: Text(
                                          localizationController
                                              .getTextValue("LABEL_EXPENSE"),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: FractionallySizedBox(
                                            alignment: Alignment.centerLeft,
                                            widthFactor: expensePercent,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        width: 60,
                                        child: Text(
                                          "$symbol${expense.toStringAsFixed(0)}",
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
            ),

            // _buildCard(
            // child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // children: [
            //  Text(
            // localizationController.getTextValue(
            //   "MONTHLY_INCOME_EXPENSE",
            // ),
            // style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            // ),
            //
            // const SizedBox(height: 16),
            //
            // /// ---------- TOTALS ROW ----------
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "${localizationController.getTextValue(
            // "TOTAL_INCOME_AMOUNT",
            // )} $symbol${data.monthlyIncome.fold(0.0, (a, b) => a + b).toStringAsFixed(0)}",
            //         style: const TextStyle(
            //           fontSize: 14,
            //           fontWeight: FontWeight.w700,
            //           color: Colors.green,
            //         ),
            //       ),
            //       Text(
            //         "${localizationController.getTextValue(
            // "TOTAL_EXPENSE_AMOUNT",
            // )} $symbol${data.monthlyExpense.fold(0.0, (a, b) => a + b).toStringAsFixed(0)}",
            //         style: const TextStyle(
            //           fontSize: 14,
            //           fontWeight: FontWeight.w700,
            //           color: Colors.red,
            //         ),
            //       ),
            //     ],
            //   ),
            //
            //
            //   const SizedBox(height: 16),
            // /// ---------------------------------
            //
            // Column(
            // children: List.generate(12, (i) {
            // final months = [
            // "Jan","Feb","Mar","Apr","May","Jun",
            // "Jul","Aug","Sep","Oct","Nov","Dec"
            // ];
            //
            // final income = data.monthlyIncome[i];
            // final expense = data.monthlyExpense[i];
            //
            // // Find the max for scaling bars
            // final maxValue = [
            // ...data.monthlyIncome,
            // ...data.monthlyExpense
            // ].reduce((a, b) => a > b ? a : b);
            //
            // double incomePercent = maxValue == 0 ? 0 : income / maxValue;
            // double expensePercent = maxValue == 0 ? 0 : expense / maxValue;
            //
            // return Padding(
            // padding: const EdgeInsets.symmetric(vertical: 10),
            // child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // children: [
            // /// Month Title
            // Text(
            // months[i],
            // style: const TextStyle(
            // fontSize: 14, fontWeight: FontWeight.w600),
            // ),
            // const SizedBox(height: 6),
            //
            // /// ---------- INCOME BAR ----------
            // Row(
            // children: [
            //  SizedBox(
            // width: 60,
            // child: Text(
            // "${localizationController.getTextValue(
            //   "LABEL_INCOME",
            // )}",
            // style: TextStyle(
            // fontSize: 12, fontWeight: FontWeight.w500),
            // ),
            // ),
            // Expanded(
            // child: Container(
            // height: 10,
            // decoration: BoxDecoration(
            // color: Colors.grey.shade300,
            // borderRadius: BorderRadius.circular(20),
            // ),
            // child: FractionallySizedBox(
            // alignment: Alignment.centerLeft,
            // widthFactor: incomePercent,
            // child: Container(
            // decoration: BoxDecoration(
            // color: Colors.green,
            // borderRadius: BorderRadius.circular(20),
            // ),
            // ),
            // ),
            // ),
            // ),
            // const SizedBox(width: 10),
            // SizedBox(
            // width: 60,
            // child: Text(
            // "$symbol${income.toStringAsFixed(0)}",
            // textAlign: TextAlign.right,
            // style: const TextStyle(
            // fontSize: 12, fontWeight: FontWeight.w600),
            // ),
            // ),
            // ],
            // ),
            //
            // const SizedBox(height: 6),
            //
            // /// ---------- EXPENSE BAR ----------
            // Row(
            // children: [
            //  SizedBox(
            // width: 60,
            // child: Text(
            //   localizationController.getTextValue(
            //     "LABEL_EXPENSE",
            //   ),
            // style: TextStyle(
            // fontSize: 12, fontWeight: FontWeight.w500),
            // ),
            // ),
            // Expanded(
            // child: Container(
            // height: 10,
            // decoration: BoxDecoration(
            // color: Colors.grey.shade300,
            // borderRadius: BorderRadius.circular(20),
            // ),
            // child: FractionallySizedBox(
            // alignment: Alignment.centerLeft,
            // widthFactor: expensePercent,
            // child: Container(
            // decoration: BoxDecoration(
            // color: Colors.red,
            // borderRadius: BorderRadius.circular(20),
            // ),
            // ),
            // ),
            // ),
            // ),
            // const SizedBox(width: 10),
            // SizedBox(
            // width: 60,
            // child: Text(
            // "$symbol${expense.toStringAsFixed(0)}",
            // textAlign: TextAlign.right,
            // style: const TextStyle(
            // fontSize: 12, fontWeight: FontWeight.w600),
            // ),
            // ),
            // ],
            // ),
            // ],
            // ),
            // );
            // }),
            // ),
            // ],
            // ),
            // ),
          ],
        ),
      ),
    );
  }

  /// -----------------------------------------
  /// UI HELPERS
  /// -----------------------------------------

  Widget _dateBox(String text, VoidCallback tap) {
    return InkWell(
      onTap: tap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: Text(text),
      ),
    );
  }

  Widget _valueCard({
    required String title,
    required num value,
    required Color color,
    required String symbol,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(
            "$symbol$value",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: child,
    );
  }

  Widget _buildToggle(
    String label,
    ReportType type,
    ReportsController controller,
  ) {
    final isSelected = controller.selected == type;
    return GestureDetector(
      onTap: () => controller.changeReport(type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  /// NEW — chart type toggle
  Widget _buildChartTypeToggle(
      String label, String type, ReportsController controller) {
    final isSelected = controller.selectedChartType == type;

    return GestureDetector(
      onTap: () => controller.changeChartType(type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:fl_chart/fl_chart.dart';
//
// import '../controller/report_controller.dart';
//
// class ReportsScreen extends StatelessWidget {
//   const ReportsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = context.watch<ReportsController>();
//     if (controller.isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     final List<Color> pieColors = [
//       Colors.blue,
//       Colors.green,
//       Colors.red,
//       Colors.orange,
//       Colors.purple,
//       Colors.pink,
//       Colors.teal,
//       Colors.cyan,
//       Colors.amber,
//       Colors.indigo,
//     ];
//
//     Color getCategoryColor(String category, int index) {
//       return pieColors[index % pieColors.length];
//     }
//
//
//     final data = controller.currentData;
//
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text("Reports", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//       //   centerTitle: true,
//       //   elevation: 0,
//       //   backgroundColor: Colors.white,
//       //   leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () {}),
//       // ),
//       body: controller.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           :SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Toggle Buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _buildToggle(context, "Week", ReportType.week, controller),
//                 _buildToggle(context, "Month", ReportType.month, controller),
//                 _buildToggle(context, "Year", ReportType.year, controller),
//               ],
//             ),
//             const SizedBox(height: 20),
//
//             // Spending Breakdown Card
//             _buildCard(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text("Spending Breakdown", style: TextStyle(fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 12),
//                   Text("\$${data.spending.toStringAsFixed(2)}",
//                       style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                   Row(
//                     children: [
//                       Text(
//                         controller.selected == ReportType.month
//                             ? "This Month"
//                             : controller.selected == ReportType.week
//                             ? "This Week"
//                             : "This Year",
//                         style: const TextStyle(color: Colors.grey),
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         "${data.isIncrease ? "+" : "-"}${data.changePercentage}%",
//                         style: TextStyle(
//                           color: data.isIncrease ? Colors.green : Colors.red,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     height: 150,
//                     child: PieChart(
//                       PieChartData(
//                         centerSpaceRadius: 40,
//                         sections: [
//                           for (int i = 0; i < data.breakdown.length; i++)
//                             PieChartSectionData(
//                               title: "",
//                               value: data.breakdown.values.elementAt(i),
//                               color: getCategoryColor(
//                                 data.breakdown.keys.elementAt(i),
//                                 i,
//                               ),
//                               radius: 50,
//                             )
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Wrap(
//                     spacing: 12,
//                     children: data.breakdown.keys.map((cat) {
//                       return Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           CircleAvatar(
//                             radius: 6,
//                             backgroundColor: getCategoryColor(
//                               cat,
//                               data.breakdown.keys.toList().indexOf(cat),
//                             ),
//                           ),
//                           const SizedBox(width: 4),
//                           Text(cat),
//                         ],
//                       );
//                     }).toList(),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             // Monthly Spending Card
//             _buildCard(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text("Monthly Spending", style: TextStyle(fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 12),
//                   Text("\$${data.spending.toStringAsFixed(2)}",
//                       style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                   Row(
//                     children: [
//                       Text(
//                         controller.selected == ReportType.year ? "This Year" : "This Month",
//                         style: const TextStyle(color: Colors.grey),
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         "${data.isIncrease ? "+" : "-"}${data.changePercentage}%",
//                         style: TextStyle(
//                           color: data.isIncrease ? Colors.green : Colors.red,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     height: 180,
//                     child: LineChart(
//                       LineChartData(
//                         gridData: FlGridData(show: false),
//                         borderData: FlBorderData(show: false),
//                         titlesData: FlTitlesData(
//                           leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                           topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                           rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                           bottomTitles: AxisTitles(
//                             sideTitles: SideTitles(
//                               showTitles: true,
//                               getTitlesWidget: (value, meta) {
//                                 final months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"];
//                                 if (value.toInt() >= 0 && value.toInt() < months.length) {
//                                   return Text(months[value.toInt()],
//                                       style: const TextStyle(color: Colors.grey, fontSize: 12));
//                                 }
//                                 return const SizedBox();
//                               },
//                             ),
//                           ),
//                         ),
//                         lineBarsData: [
//                           LineChartBarData(
//                             isCurved: true,
//                             spots: List.generate(data.monthlySpending.length,
//                                     (i) => FlSpot(i.toDouble(), data.monthlySpending[i])),
//                             barWidth: 3,
//                             color: Colors.blue,
//                             dotData: FlDotData(show: false),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       // bottomNavigationBar: BottomNavigationBar(
//       //   currentIndex: 2,
//       //   type: BottomNavigationBarType.fixed,
//       //   selectedItemColor: Colors.blue,
//       //   unselectedItemColor: Colors.grey,
//       //   items: const [
//       //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//       //     BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
//       //     BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Reports"),
//       //     BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "Budget"),
//       //     BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
//       //   ],
//       // ),
//     );
//   }
//
//   Widget _buildCard({required Widget child}) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
//       ),
//       child: child,
//     );
//   }
//
//   Widget _buildToggle(BuildContext context, String label, ReportType type, ReportsController controller) {
//     final isSelected = controller.selected == type;
//     return GestureDetector(
//       onTap: () => controller.changeReport(type),
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 6),
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.blue : Colors.grey[200],
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: Text(
//           label,
//           style: TextStyle(color: isSelected ? Colors.white : Colors.black),
//         ),
//       ),
//     );
//   }
//
//   Color _getColor(String category) {
//     switch (category) {
//       case "Food":
//         return Colors.blue;
//       case "Transport":
//         return Colors.lightBlueAccent;
//       case "Entertainment":
//         return Colors.purpleAccent;
//       case "Utilities":
//         return Colors.orangeAccent;
//       default:
//         return Colors.grey;
//     }
//   }
// }
