import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../controller/report_controller.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ReportsController>();
    final data = controller.currentData;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Reports", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      //   centerTitle: true,
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () {}),
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Toggle Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildToggle(context, "Week", ReportType.week, controller),
                _buildToggle(context, "Month", ReportType.month, controller),
                _buildToggle(context, "Year", ReportType.year, controller),
              ],
            ),
            const SizedBox(height: 20),

            // Spending Breakdown Card
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Spending Breakdown", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text("\$${data.spending.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Text(
                        controller.selected == ReportType.month
                            ? "This Month"
                            : controller.selected == ReportType.week
                            ? "This Week"
                            : "This Year",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${data.isIncrease ? "+" : "-"}${data.changePercentage}%",
                        style: TextStyle(
                          color: data.isIncrease ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 150,
                    child: PieChart(
                      PieChartData(
                        centerSpaceRadius: 40,
                        sections: data.breakdown.entries.map((entry) {
                          return PieChartSectionData(
                            title: "",
                            value: entry.value,
                            color: _getColor(entry.key),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    children: data.breakdown.keys.map((cat) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(radius: 6, backgroundColor: _getColor(cat)),
                          const SizedBox(width: 4),
                          Text(cat),
                        ],
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Monthly Spending Card
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Monthly Spending", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text("\$${data.spending.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Text(
                        controller.selected == ReportType.year ? "This Year" : "This Month",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${data.isIncrease ? "+" : "-"}${data.changePercentage}%",
                        style: TextStyle(
                          color: data.isIncrease ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 180,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"];
                                if (value.toInt() >= 0 && value.toInt() < months.length) {
                                  return Text(months[value.toInt()],
                                      style: const TextStyle(color: Colors.grey, fontSize: 12));
                                }
                                return const SizedBox();
                              },
                            ),
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            isCurved: true,
                            spots: List.generate(data.monthlySpending.length,
                                    (i) => FlSpot(i.toDouble(), data.monthlySpending[i])),
                            barWidth: 3,
                            color: Colors.blue,
                            dotData: FlDotData(show: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 2,
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: Colors.blue,
      //   unselectedItemColor: Colors.grey,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //     BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
      //     BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Reports"),
      //     BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "Budget"),
      //     BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      //   ],
      // ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
      ),
      child: child,
    );
  }

  Widget _buildToggle(BuildContext context, String label, ReportType type, ReportsController controller) {
    final isSelected = controller.selected == type;
    return GestureDetector(
      onTap: () => controller.changeReport(type),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Color _getColor(String category) {
    switch (category) {
      case "Food":
        return Colors.blue;
      case "Transport":
        return Colors.lightBlueAccent;
      case "Entertainment":
        return Colors.purpleAccent;
      case "Utilities":
        return Colors.orangeAccent;
      default:
        return Colors.grey;
    }
  }
}
