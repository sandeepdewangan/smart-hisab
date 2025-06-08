import 'package:flutter/material.dart';
import 'package:smart_hisab/features/categories/views/categories_view.dart';
import 'package:smart_hisab/features/home/widgets/home_bottom_navigation.dart';
import 'package:smart_hisab/features/spending/views/spending_view.dart';
import 'package:smart_hisab/features/transactions/views/transactions_view.dart';

class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomeView());
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentPageIndex = 0;

  onPageChange(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child:
              [
                // Category wise summary for a month
                SpendingView(),
                // Listing and adding of transaction
                TransactionsView(),
                // Listing and adding of category
                CategoriesView(),
              ][currentPageIndex],
        ),
      ),

      bottomNavigationBar: HomeBottomNavigation(
        onPageChange: onPageChange,
        currPage: currentPageIndex,
      ),
    );
  }
}


 // child: IndexedStack(
          //   index: page,
          //   children: [
          //     // Category wise summary for a month
          //     SpendingView(),
          //     // Listing and adding of transaction
          //     TransactionsView(),
          //     // Listing and adding of category
          //     CategoriesView(),
          //   ],
          // ),