enum FileFormat { csv, pdf }

class ExportOptions {
  DateTime fromDate;
  DateTime toDate;
  FileFormat format;

  ExportOptions({
    required this.fromDate,
    required this.toDate,
    required this.format,
  });
}
