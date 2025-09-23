class ReportData {
  final double spending;
  final double changePercentage;
  final bool isIncrease;
  final Map<String, double> breakdown;
  final List<double> monthlySpending;

  ReportData({
    required this.spending,
    required this.changePercentage,
    required this.isIncrease,
    required this.breakdown,
    required this.monthlySpending,
  });
}
