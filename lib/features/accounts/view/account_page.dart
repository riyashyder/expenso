import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/account_controller.dart';
import 'account_form.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C2C2C),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          const Text(
            '[ All Accounts ₹0.00 ]',
            style: TextStyle(color: Color(0xFFE9E362), fontSize: 18),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('EXPENSE SO FAR\n₹0.00', style: TextStyle(color: Colors.redAccent, fontSize: 14)),
                Text('INCOME SO FAR\n₹0.00', style: TextStyle(color: Colors.greenAccent, fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildAccountTile('Card', '₹0.00', Icons.credit_card, Colors.redAccent),
                _buildAccountTile('Cash', '₹0.00', Icons.money, Colors.green),
                _buildAccountTile('Savings', '₹0.00', Icons.savings, Colors.pink),
                const SizedBox(height: 20),
                Center(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFE9E362),
                      side: const BorderSide(color: Color(0xFFE9E362)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AccountForm(
                          onSubmit: (account) {
                            // You'll need to add this to your controller or state
                            final controller = Provider.of<AccountController>(context, listen: false);
                            controller.addOrEditAccount(account);
                          },
                        ),
                      );
                    },

                    icon: const Icon(Icons.add),
                    label: const Text('ADD NEW ACCOUNT'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountTile(String title, String balance, IconData iconData, Color iconColor) {
    return Card(
      color: const Color(0xFF3D3A34),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(iconData, color: iconColor, size: 26),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Balance: $balance',
          style: const TextStyle(color: Colors.greenAccent),
        ),
        trailing: const Icon(Icons.more_horiz, color: Colors.white),
        onTap: () {},
      ),
    );
  }

}
