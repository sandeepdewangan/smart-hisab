import 'package:flutter/material.dart';
import 'package:smart_hisab/theme/pallete.dart';

class HomeBottomNavigation extends StatelessWidget {
  final void Function(int)? onPageChange;
  final int currPage;
  const HomeBottomNavigation({
    super.key,
    required this.onPageChange,
    required this.currPage,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onPageChange,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.receipt_long,
            color: currPage == 0 ? Pallete.accentColor : Colors.white,
          ),
          label: 'Spending',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.receipt,
            color: currPage == 1 ? Pallete.accentColor : Colors.white,
          ),
          label: 'Transactions',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.category,
            color: currPage == 2 ? Pallete.accentColor : Colors.white,
          ),
          label: 'Categories',
        ),
      ],
    );
  }
}
