import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/devices/get_localization_provider.dart';
import '../../categories/controller/create_category_controller.dart';
import '../../settings/controller/currency_provider.dart';
import '../controller/transaction_controller.dart';
import '../model/transaction_item.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {

  DateTime? _filterFromDate;
  DateTime? _filterToDate;

  bool get _isFilterApplied {
    return _filterFromDate != null && _filterToDate != null;
  }





  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      _loadDefaultTransactions();
    });
  }


  void _loadDefaultTransactions() {
    final controller =
    Provider.of<TransactionsController>(context, listen: false);

    final now = DateTime.now();
    final from = DateTime(now.year, now.month, 1)
        .toIso8601String()
        .split('T')
        .first;
    final to = DateTime(now.year, now.month + 1, 0)
        .toIso8601String()
        .split('T')
        .first;

    controller.fetchTransactions(from: from, to: to);
  }


  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TransactionsController>();
    final currency = context.watch<CurrencyProvider>();
    final symbol = currency.symbol;


    return Scaffold(
      body: controller.isScreenLoading
          ? const Center(child: CircularProgressIndicator())
          : controller.filteredTransactions.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined, // transaction-like icon
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              getLocalizationController(context, listen: false)
                  .getTextValue("TRANS_NO_DATA"), // Add this key in your localization JSON
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )
          : ListView(
        children: [
          // Add this floating button or any top button for filter


          _buildSummaryCard(controller),
          // _buildTabs(controller),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  _openFilterBottomSheet(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.filter_list,
                      color: _isFilterApplied
                          ? Colors.blue.shade900
                          : Colors.black,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Filter",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                        // color: _isFilterApplied
                        //     ? Colors.blue.shade900
                        //     : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          ..._buildGroupedTransactions(controller.filteredTransactions),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => ChangeNotifierProvider(
              create: (_) => CategoryController()..getCategories(),
              child: const TransactionInputSheet(),
            ),

            // builder: (context) => const TransactionInputSheet(),
          );
          if (result == true) {
            _loadDefaultTransactions();
          }
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildDateFilter(TransactionsController controller) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Filter by Date",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _filterFromDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) setState(() => _filterFromDate = picked);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: "Start Date",
                        border: OutlineInputBorder(),
                      ),
                      child: Text(
                        _filterFromDate == null
                            ? "Select date"
                            : _filterFromDate!.toIso8601String().split('T').first,
                        style: TextStyle(
                          color: _filterFromDate == null ? Colors.grey : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _filterToDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) setState(() => _filterToDate = picked);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: "End Date",
                        border: OutlineInputBorder(),
                      ),
                      child: Text(
                        _filterToDate == null
                            ? "Select date"
                            : _filterToDate!.toIso8601String().split('T').first,
                        style: TextStyle(
                          color: _filterToDate == null ? Colors.grey : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _filterFromDate = null;
                      _filterToDate = null;
                    });
                    // controller.fetchTransactions(); // reset filter
                  },
                  child: const Text("Clear"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: (_filterFromDate != null && _filterToDate != null)
                      ? () {
                    if (_filterToDate!.isBefore(_filterFromDate!)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("End date cannot be before start date"),
                        ),
                      );
                      return;
                    }

                    final from = _filterFromDate!.toIso8601String().split('T').first;
                    final to = _filterToDate!.toIso8601String().split('T').first;
                    controller.fetchTransactions(from: from, to: to);
                  }
                      : null,
                  child: const Text("Apply"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildSummaryCard(TransactionsController controller) {
    final localizationController = getLocalizationController(
      context,
      listen: false,
    );
    final currency = context.watch<CurrencyProvider>();
    final symbol = currency.symbol;


    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _summaryTile('$symbol${localizationController.getTextValue(
                "TRANS_INCOME",
              )}', controller.totalIncome, Colors.green),
              _summaryTile('$symbol${localizationController.getTextValue(
                "TRANS_EXPENSES",
              )}' ,controller.totalExpense, Colors.red),
              _summaryTile('$symbol${localizationController.getTextValue(
                "TRANS_NET",
              )}', controller.netTotal, Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryTile(String title, double amount, Color color) {
    final currency = context.watch<CurrencyProvider>();
    final symbol = currency.symbol;

    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        Text(
          "$symbol${amount.toStringAsFixed(2)}",
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ],
    );
  }


  Widget _buildTabs(TransactionsController controller) {
    final localizationController = getLocalizationController(
      context,
      listen: false,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTab(localizationController.getTextValue(
          "TRANS_TAB_ALL",
        ), controller),
        _buildTab(localizationController.getTextValue(
          "TRANS_TAB_INCOME",
        ), controller),
        _buildTab(localizationController.getTextValue(
          "TRANS_TAB_EXPENSES",
        ), controller),
      ],
    );
  }

  Widget _buildTab(String label, TransactionsController controller) {
    final isSelected = controller.selectedFilter == label;
    return GestureDetector(
      onTap: () => controller.changeFilter(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: isSelected ? Colors.blue : Colors.transparent, width: 2)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildGroupedTransactions(List<TransactionItem> transactions) {
    final grouped = <String, List<TransactionItem>>{};
    for (var t in transactions) {
      grouped.putIfAbsent(t.dateGroup, () => []).add(t);
    }

    return grouped.entries.map((entry) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          ...entry.value.map((t) => _buildTransactionTile(t)).toList(),
        ],
      );
    }).toList();
  }

  void _openFilterBottomSheet(BuildContext context) {
    final controller = context.read<TransactionsController>();
    final localizationController = getLocalizationController(
      context,
      listen: false,
    );


    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        DateTime? tempFrom = _filterFromDate;
        DateTime? tempTo = _filterToDate;

        // Use StatefulBuilder to rebuild bottom sheet
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                   Text(
                    localizationController.getTextValue(
                      "TRANS_FILTER_TRANSACTIONS",
                    ),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Start Date
                  InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: tempFrom ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        setModalState(() => tempFrom = picked);
                      }
                    },
                    child: InputDecorator(
                      decoration:  InputDecoration(
                        labelText: "${ localizationController.getTextValue(
                        "TRANS_START_DATE",
            )}",
                        border: OutlineInputBorder(),
                      ),
                      child: Text(
                        tempFrom == null
                            ? "${localizationController.getTextValue(
                          "TRANS_SELECT_DATE",
                        )}"
                            : tempFrom!.toIso8601String().split('T').first,
                        style: TextStyle(
                          color: tempFrom == null ? Colors.grey : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // End Date
                  InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: tempTo ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        setModalState(() => tempTo = picked);
                      }
                    },
                    child: InputDecorator(
                      decoration:  InputDecoration(
                        labelText: "${localizationController.getTextValue(
                          "TRANS_END_DATE",
                        )}",
                        border: OutlineInputBorder(),
                      ),
                      child: Text(
                        tempTo == null
                            ?  "${localizationController.getTextValue(
                          "TRANS_SELECT_DATE",
                        )}"
                            : tempTo!.toIso8601String().split('T').first,
                        style: TextStyle(
                          color: tempTo == null ? Colors.grey : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed:(tempFrom != null && tempTo != null) ? () {
                          final now = DateTime.now();
                          final currentMonthStart = DateTime(now.year, now.month, 1);
                          final currentMonthEnd = DateTime(now.year, now.month + 1, 0);
                          setModalState(() {
                            tempFrom = null;
                            tempTo = null;
                          });


                          setState(() {
                            _filterFromDate = currentMonthStart;
                            _filterToDate = currentMonthEnd;
                          });

                          // Apply filter with current month
                          _loadDefaultTransactions();

                          // controller.fetchTransactions();

                          Navigator.pop(context);
                        } : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade900, // Dark blue
                          foregroundColor: Colors.white, // White text
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child:  Text(
            "${localizationController.getTextValue(
            "TRANS_CLEAR",
            )}",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),

                      const SizedBox(width: 8),

                      ElevatedButton(
                        onPressed: (tempFrom != null && tempTo != null)
                            ? () {
                          if (tempTo!.isBefore(tempFrom!)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                content: Text(localizationController.getTextValue(
                                  "TRANS_END_DATE_ERROR",
                                )),
                              ),
                            );
                            return;
                          }
                          setState(() {
                            _filterFromDate = tempFrom;
                            _filterToDate = tempTo;
                          });
                          final from = tempFrom!.toIso8601String().split('T').first;
                          final to = tempTo!.toIso8601String().split('T').first;
                          controller.fetchTransactions(from: from, to: to);
                          Navigator.pop(context);
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade900, // Dark blue
                          foregroundColor: Colors.white, // White text
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child:  Text(
                          localizationController.getTextValue(
                            "TRANS_APPLY",
                          ),
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )


                ],
              ),
            );
          },
        );
      },
    );
  }


  Widget _buildTransactionTile(TransactionItem transaction) {
    final currency = context.watch<CurrencyProvider>();
    final symbol = currency.symbol;
    final isExpense = transaction.type == "expense";
    final localizationController = getLocalizationController(
      context,
      listen: false,
    );


    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: Icon(transaction.icon, color: Colors.blue),
        ),
        title: Text(transaction.title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(isExpense ? localizationController.getTextValue("TRANS_EXPENSE") : localizationController.getTextValue("TRANS_INCOME_SUB"), style: const TextStyle(color: Colors.grey)),
        trailing: Text(
          "${isExpense ? "-" : "+"}$symbol${transaction.amount.toStringAsFixed(2)}",
          style: TextStyle(
            color: isExpense ? Colors.red : Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}



class TransactionInputSheet extends StatefulWidget {
  const TransactionInputSheet({super.key});

  @override
  State<TransactionInputSheet> createState() => _TransactionInputSheetState();
}

class _TransactionInputSheetState extends State<TransactionInputSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedType = 'income';
  late final localizationController = getLocalizationController(
    context,
    listen: false,
  );
  bool _isFormFilled = false;
  String? _selectedCategoryId;
  String? _selectedCategoryName;


  // @override
  // void initState() {
  //   super.initState();
  //   Future.microtask(() {
  //     context.read<CategoryController>().getCategories();
  //   });
  // }


  void _checkFormFilled() {
    final isFilled =
        _amountController.text.isNotEmpty &&
            double.tryParse(_amountController.text) != null &&
            _selectedCategoryId != null &&
            _selectedDate != null &&
            _selectedType != null;

    if (_isFormFilled != isFilled) {
      setState(() {
        _isFormFilled = isFilled;
      });
    }
  }

  // void _checkFormFilled() {
  //   final isFilled =
  //       _amountController.text.isNotEmpty &&
  //           double.tryParse(_amountController.text) != null &&
  //           _categoryController.text.isNotEmpty &&
  //           _selectedDate != null &&
  //           _selectedType != null;
  //
  //   if (_isFormFilled != isFilled)   {
  //     setState(() {
  //       _isFormFilled = isFilled;
  //     });
  //   }
  // }

  // void _checkFormFilled() {
  //   final isFilled =
  //       _amountController.text.isNotEmpty &&
  //           double.tryParse(_amountController.text) != null &&
  //           _categoryController.text.isNotEmpty &&
  //           _selectedDate != null;
  //
  //   if (_isFormFilled != isFilled) {
  //     setState(() {
  //       _isFormFilled = isFilled;
  //     });
  //   }
  // }


  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final controller = context.read<TransactionsController>();

    await controller.createTransaction(
      expenseDate: _selectedDate!.toIso8601String().split('T').first,
      type: _selectedType!,
      category:  _selectedCategoryName!,
      // category: _categoryController.text.trim(),
      amount: double.parse(_amountController.text),
    );

    // await controller.createTransaction(
    //   expenseDate: _selectedDate?.toIso8601String().split('T').first ?? '',
    //   type: _selectedType,
    //   category: _categoryController.text.trim(),
    //   amount: double.parse(_amountController.text),
    // );

    if (!mounted) return;

    Navigator.pop(context, true);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transaction created successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
               Text(
                   "${localizationController.getTextValue(
                     "TRANS_ADD_TRANSACTION",
                   )}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Amount field
              // TextFormField(
              //   controller: _amountController,
              //   keyboardType: TextInputType.number,
              //   decoration:  InputDecoration(
              //     labelText: "${localizationController.getTextValue(
              //       "TRANS_AMOUNT",
              //     )}",
              //     border: OutlineInputBorder(),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) return "${localizationController.getTextValue(
              //       "TRANS_ENTER_AMOUNT",
              //     )}";
              //     if (double.tryParse(value) == null) return "${localizationController.getTextValue(
              //       "TRANS_ENTER_VALID_NUMBER",
              //     )}";
              //     return null;
              //   },
              // ),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                onChanged: (_) => _checkFormFilled(),
                decoration: InputDecoration(
                  labelText: localizationController.getTextValue("TRANS_AMOUNT"),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizationController.getTextValue("TRANS_ENTER_AMOUNT");
                  }
                  if (double.tryParse(value) == null) {
                    return localizationController.getTextValue("TRANS_ENTER_VALID_NUMBER");
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Category field
              Consumer<CategoryController>(
                builder: (context, categoryController, _) {
                  final isLoading = categoryController.isLoading;
                  final categories = categoryController.categories;

                  return DropdownButtonFormField<String>(
                    value: _selectedCategoryId,
                    items: categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category.id,
                        child: Row(
                          children: [
                            Icon(
                              categoryController.getIconById(category.icon),
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(category.name),
                          ],
                        ),
                      );
                    }).toList(),

                    onChanged: isLoading
                        ? null
                        : (value) {
                      setState(() {
                        _selectedCategoryId = value;
                        _selectedCategoryName = categories
                            .firstWhere((c) => c.id == value)
                            .name;
                      });
                      _checkFormFilled();
                    },

                    validator: (value) {
                      if (!isLoading && value == null) {
                        return localizationController.getTextValue(
                          "TRANS_ENTER_CATEGORY",
                        );
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                      labelText: localizationController.getTextValue("TRANS_CATEGORY"),
                      border: const OutlineInputBorder(),

                      // 👇 subtle loading hint
                      hintText: isLoading
                          ? localizationController.getTextValue("LOADING_CATEGORIES")
                          : localizationController.getTextValue("SELECT_CATEGORY"),

                      // 👇 spinner INSIDE field (small & clean)
                      suffixIcon: isLoading
                          ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                          : const Icon(Icons.arrow_drop_down),
                    ),
                  );
                },
              ),

              // Consumer<CategoryController>(
              //   builder: (context, categoryController, _) {
              //     // if (categoryController.categories.isEmpty) {
              //     //   return const Center(child: CircularProgressIndicator());
              //     // }
              //
              //     return DropdownButtonFormField<String>(
              //       value: _selectedCategoryId,
              //       items: categoryController.categories.map((category) {
              //         return DropdownMenuItem<String>(
              //           value: category.id,
              //           child: Row(
              //             children: [
              //               Icon(
              //                 categoryController.getIconById(category.icon),
              //                 size: 18,
              //               ),
              //               const SizedBox(width: 8),
              //               Text(category.name),
              //             ],
              //           ),
              //         );
              //       }).toList(),
              //       onChanged: (value) {
              //         setState(() {
              //           _selectedCategoryId = value;
              //           _selectedCategoryName = categoryController.categories
              //               .firstWhere((c) => c.id == value)
              //               .name;
              //         });
              //         _checkFormFilled();
              //       },
              //       validator: (value) {
              //         if (value == null) {
              //           return localizationController.getTextValue(
              //             "TRANS_ENTER_CATEGORY",
              //           );
              //         }
              //         return null;
              //       },
              //       decoration: InputDecoration(
              //         labelText: localizationController.getTextValue("TRANS_CATEGORY"),
              //         border: const OutlineInputBorder(),
              //       ),
              //     );
              //   },
              // ),

              // TextFormField(
              //   controller: _categoryController,
              //   onChanged: (_) => _checkFormFilled(),
              //   decoration: InputDecoration(
              //     labelText: localizationController.getTextValue("TRANS_CATEGORY"),
              //     border: const OutlineInputBorder(),
              //   ),
              //   validator: (value) =>
              //   value == null || value.isEmpty
              //       ? localizationController.getTextValue("TRANS_ENTER_CATEGORY")
              //       : null,
              // ),

              // TextFormField(
              //   controller: _categoryController,
              //   decoration:  InputDecoration(
              //     labelText: "${localizationController.getTextValue(
              //       "TRANS_CATEGORY",
              //     )}",
              //     border: OutlineInputBorder(),
              //   ),
              //   validator: (value) =>
              //   value == null || value.isEmpty ? "${localizationController.getTextValue(
              //     "TRANS_ENTER_CATEGORY",
              //   )}" : null,
              // ),
              const SizedBox(height: 16),

              // Transaction Type dropdown
              DropdownButtonFormField<String>(
                value: _selectedType,
                items: [
                  DropdownMenuItem(
                    value: "income",
                    child: Text(localizationController.getTextValue("TRANS_TYPE_INCOME")),
                  ),
                  DropdownMenuItem(
                    value: "expense",
                    child: Text(localizationController.getTextValue("TRANS_TYPE_EXPENSE")),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                  });
                  _checkFormFilled();
                },
                validator: (value) {
                  if (value == null) {
                    return localizationController.getTextValue(
                      "TRANS_SELECT_TRANSACTION_TYPE",
                    );
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: localizationController.getTextValue(
                    "TRANS_TRANSACTION_TYPE",
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),

              // DropdownButtonFormField<String>(
              //   value: _selectedType,
              //   items:  [
              //     DropdownMenuItem(value: "income", child: Text("${localizationController.getTextValue(
              //       "TRANS_TYPE_INCOME",
              //     )}")),
              //     DropdownMenuItem(value: "expense", child: Text("${localizationController.getTextValue(
              //       "TRANS_TYPE_EXPENSE",
              //     )}")),
              //   ],
              //   onChanged: (value) => setState(() => _selectedType = value!),
              //   decoration:  InputDecoration(
              //     labelText: "${localizationController.getTextValue(
              //       "TRANS_TRANSACTION_TYPE",
              //     )}",
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              const SizedBox(height: 16),

              // Date picker
              FormField<DateTime>(
                validator: (_) {
                  if (_selectedDate == null) {
                    return localizationController.getTextValue("TRANS_SELECT_DATE");
                  }
                  return null;
                },
                builder: (state) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (picked != null) {
                          setState(() => _selectedDate = picked);
                          _checkFormFilled();
                        }
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: localizationController.getTextValue("TRANS_DATE"),
                          border: const OutlineInputBorder(),
                          errorText: state.errorText,
                        ),
                        child: Text(
                          _selectedDate == null
                              ? localizationController.getTextValue("TRANS_SELECT_DATE")
                              : _selectedDate!.toIso8601String().split('T').first,
                          style: TextStyle(
                            color: _selectedDate == null ? Colors.grey : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // InkWell(
              //   onTap: () async {
              //     final picked = await showDatePicker(
              //       context: context,
              //       initialDate: DateTime.now(),
              //       firstDate: DateTime(2020),
              //       lastDate: DateTime(2030),
              //     );
              //     if (picked != null) {
              //       setState(() => _selectedDate = picked);
              //       _checkFormFilled();
              //     }
              //   },
              //   child: InputDecorator(
              //     decoration:  InputDecoration(
              //       labelText: "${localizationController.getTextValue(
              //     "TRANS_DATE",
              //     )}",
              //       border: OutlineInputBorder(),
              //     ),
              //     child: Text(
              //       _selectedDate == null
              //           ? "${localizationController.getTextValue(
              //         "TRANS_SELECT_DATE",
              //       )}"
              //           : _selectedDate!.toIso8601String().split('T').first,
              //       style: TextStyle(
              //           color: _selectedDate == null
              //               ? Colors.grey
              //               : Colors.black87),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 24),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isFormFilled ? _submit : null,

                  // onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900, // Dark blue
                    foregroundColor: Colors.white, // White text
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded rectangle
                    ),
                  ),
                  child:  Text(
                    "${localizationController.getTextValue(
                      "TRANS_CREATE_TRANSACTION",
                    )}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}