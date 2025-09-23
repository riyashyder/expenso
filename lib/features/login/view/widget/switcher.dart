import 'package:flutter/material.dart';

class TabSwitcher extends StatelessWidget {
  final int selectedTab;
  final Function(int) onTabSelected;
  final String leftTabText;
  final String rightTabText;

  const TabSwitcher({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
    required this.leftTabText,
    required this.rightTabText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE6ECF4), // Light bluish background
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          // Left Tab
          Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(0),
              child: Container(
                decoration: BoxDecoration(
                  color: selectedTab == 0 ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                child: Text(
                  leftTabText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: selectedTab == 0 ? Colors.black87 : Colors.grey,
                  ),
                ),
              ),
            ),
          ),

          // Right Tab
          Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(1),
              child: Container(
                decoration: BoxDecoration(
                  color: selectedTab == 1 ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                child: Text(
                  rightTabText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: selectedTab == 1 ? Colors.black87 : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
