import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

   BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  final List<IconData> _icons = [
    Icons.list_alt_rounded,
    Icons.analytics_rounded,
    Icons.account_balance_wallet_rounded,
    Icons.account_balance_rounded,
    Icons.category_rounded,
  ];

  final List<String> _labels = [
    'Records',
    'Analysis',
    'Budgets',
    'Accounts',
    'Categories',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_icons.length, (index) {
            final isSelected = currentIndex == index;
            return Expanded(
              child: GestureDetector(
                onTap: () => onTabSelected(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white.withOpacity(0.12) : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _icons[index],
                        color: isSelected ? Colors.yellowAccent : Colors.white60,
                        size: isSelected ? 24 : 22,
                      ),
                      const SizedBox(height: 2),
                      FittedBox(
                        child: Text(
                          _labels[index],
                          style: TextStyle(
                            fontSize: 11,
                            color: isSelected ? Colors.yellowAccent : Colors.white54,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
