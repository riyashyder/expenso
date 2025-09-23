import 'package:flutter/material.dart';
import '../model/account_model.dart';

class AccountForm extends StatefulWidget {
  final Function(AccountModel) onSubmit;
  final AccountModel? existing;

  const AccountForm({
    Key? key,
    required this.onSubmit,
    this.existing,
  }) : super(key: key);

  @override
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();

  // List of predefined icons and colors
  final List<IconData> _iconList = [
    Icons.credit_card,
    Icons.attach_money,
    Icons.savings,
    Icons.account_balance_wallet,
  ];

  final List<Color> _colorList = [
    Colors.redAccent,
    Colors.green,
    Colors.pinkAccent,
    Colors.blue,
  ];

  late IconData _selectedIcon;
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();

    if (widget.existing != null) {
      final existing = widget.existing!;
      _nameController.text = existing.name;
      _balanceController.text = existing.balance.toString();

      _selectedIcon = _iconList.firstWhere(
            (icon) => icon.codePoint.toString() == existing.icon,
        orElse: () => Icons.account_balance_wallet,
      );

      _selectedColor = _colorList.firstWhere(
            (color) => color.value.toString() == existing.colorHex,
        orElse: () => Colors.blue,
      );
    } else {
      _selectedIcon = _iconList.first;
      _selectedColor = _colorList.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF3F3D39),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        'Add new account',
        style: TextStyle(color: Color(0xFFEFE39A), fontWeight: FontWeight.bold),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _balanceController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Initial amount',
                labelStyle: const TextStyle(color: Color(0xFFDCD3A4)),
                fillColor: const Color(0xFF2B2A28),
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              validator: (value) => value == null || value.isEmpty ? "Enter amount" : null,
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "*Initial amount will not be reflected in analysis",
                style: TextStyle(color: Colors.white38, fontSize: 12),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: const TextStyle(color: Color(0xFFDCD3A4)),
                fillColor: const Color(0xFF2B2A28),
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              validator: (value) => value == null || value.isEmpty ? "Enter name" : null,
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Icon", style: TextStyle(color: Colors.white70)),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              children: List.generate(_iconList.length, (index) {
                final icon = _iconList[index];
                final color = _colorList[index];
                final isSelected = _selectedIcon == icon;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIcon = icon;
                      _selectedColor = color;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: isSelected ? Colors.yellowAccent : Colors.transparent, width: 2),
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFF2B2A28),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Icon(icon, color: color, size: 30),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL', style: TextStyle(color: Colors.white70)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEFE39A),
            foregroundColor: Colors.black,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newAccount = AccountModel(
                name: _nameController.text,
                balance: double.tryParse(_balanceController.text) ?? 0.0,
                icon: _selectedIcon.codePoint.toString(),
                colorHex: _selectedColor.value.toString(),
              );
              widget.onSubmit(newAccount);
              Navigator.pop(context);
            }
          },
          child: const Text("SAVE"),
        ),
      ],
    );
  }

}
