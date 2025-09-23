// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import '../features/dashboard/model/transaction_model.dart';
//
//
// class ApiService {
//   static const String baseUrl = 'http://192.168.1.5:3000/api'; // Replace <your-ip>
//
//   static Future<List<TransactionModel>> fetchTransactions() async {
//     final response = await http.get(Uri.parse('$baseUrl/expenses'));
//
//     if (response.statusCode == 200) {
//       final List data = jsonDecode(response.body);
//       return data.map((e) => TransactionModel.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to load transactions');
//     }
//   }
//
//   static Future<void> createTransaction(TransactionModel transaction) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/expenses'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(transaction.toJson()),
//     );
//
//     print("Create Transaction");
//     print(response.body);
//
//     if (response.statusCode != 201) {
//       throw Exception('Failed to create transaction');
//     }
//   }
// }
