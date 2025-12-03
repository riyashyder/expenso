class ReportData {
  final double spending;
  final double changePercentage;
  final bool isIncrease;

  final Map<String, double> breakdown;

  final List<double> monthlyIncome;   // NEW
  final List<double> monthlyExpense;  // NEW

  ReportData({
    required this.spending,
    required this.changePercentage,
    required this.isIncrease,
    required this.breakdown,
    required this.monthlyIncome,
    required this.monthlyExpense,
  });

  factory ReportData.empty() => ReportData(
    spending: 0,
    changePercentage: 0,
    isIncrease: true,
    breakdown: {},
    monthlyIncome: List.filled(12, 0),
    monthlyExpense: List.filled(12, 0),
  );
}
