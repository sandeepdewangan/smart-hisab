import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_hisab/features/categories/controller/category_controller.dart';
import 'package:smart_hisab/models/category.dart';
import 'package:smart_hisab/models/transaction.dart';

class SpendingController {
  final List<Transaction?> filteredTx;
  final WidgetRef ref;
  SpendingController({required this.filteredTx, required this.ref});

  Future initializeData() async {
    final summary = await summarizeByCategory(filteredTx, ref);
    final filteredSummary = await filterSummaryExIncome(summary);
    final totalIncome = await filterSummaryByTotalIncome(summary);
    final totalExpense = await filterSummaryByTotalExpense(summary);
    final summarisedDataToTile = convertSummarisedDataToTile(summary);

    return {
      // "filteredSummary": summary,
      "filteredSummary": filteredSummary,
      "totalIncome": totalIncome,
      "totalExpense": totalExpense,
      "summarisedDataAsTile": summarisedDataToTile,
    };
  }

  Future<Map<Category, double>> summarizeByCategory(
    List<Transaction?> transactions,
    WidgetRef ref,
  ) async {
    final Map<Category, double> summary = {};

    for (var transaction in transactions) {
      Category? category = await ref
          .read(categoryControllerProvider)
          .getCategoryById(transaction!.categoryId);

      summary.update(
        category!,
        (value) => value + transaction.amount,
        ifAbsent: () => transaction.amount,
      );
    }

    return summary;
    // {Instance of 'Category': 200.0, Instance of 'Category': 500.0,}
  }

  filterSummaryExIncome(Map<Category, double> summary) {
    Map<String, double> filteredSummary = {};

    summary.forEach((category, v) {
      if (category.trackerType != TrackerType.income) {
        filteredSummary = {...filteredSummary, category.name: v};
      }
    });
    return filteredSummary;
  }

  filterSummaryByTotalIncome(Map<Category, double> summary) {
    double total = 0;

    summary.forEach((category, v) {
      if (category.trackerType == TrackerType.income) {
        total = total + v;
      }
    });
    return total;
  }

  filterSummaryByTotalExpense(Map<Category, double> summary) {
    double total = 0;

    summary.forEach((category, v) {
      if (category.trackerType == TrackerType.expense) {
        total = total + v;
      }
    });
    return total;
  }

  List<Widget> convertSummarisedDataToTile(summary) {
    final List<Widget> summaryAsListTile = [];

    summary.forEach((category, value) {
      summaryAsListTile.add(
        ListTile(
          minTileHeight: 60,
          leading: Icon(category.icon),
          title: Text(category.name),
          trailing: Text(
            category.trackerType == TrackerType.expense
                ? '- ${value.toStringAsFixed(2)}'
                : '+ ${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    });

    return summaryAsListTile;
  }
}
