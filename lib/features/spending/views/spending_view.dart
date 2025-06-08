import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_hisab/features/spending/controller/spending_controller.dart';
import 'package:smart_hisab/features/spending/widgets/tx_pie_chart.dart';
import 'package:smart_hisab/features/transactions/widgets/month_picker.dart';
import 'package:smart_hisab/models/transaction.dart';
import 'package:smart_hisab/providers/providers.dart';

class SpendingView extends ConsumerWidget {
  const SpendingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickedDate = ref.watch(dateProviderTemp);
    final transactions = ref.watch(transactionStreamProvider(pickedDate!));

    return transactions.when(
      data: (data) {
        List<Transaction?> filteredTx =
            data
                .where(
                  (tx) =>
                      tx!.date.month == pickedDate.month &&
                      tx.date.year == pickedDate.year,
                )
                .toList();

        return Column(
          children: [
            MonthPicker(pickedDate: pickedDate),
            Expanded(
              child: FutureBuilder(
                future:
                    SpendingController(
                      ref: ref,
                      filteredTx: filteredTx,
                    ).initializeData(),

                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    // chart data loaded:
                    return Column(
                      children: [
                        // Chart
                        snapshot.data["filteredSummary"].toString() != '{}'
                            ? TxPieChart(
                              summary: snapshot.data["filteredSummary"],
                              totalExpenses: snapshot.data["totalExpense"],
                              totalIncome: snapshot.data["totalIncome"],
                            )
                            : Text("No data present to display chart"),
                        // Tx Summary
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: snapshot.data["summarisedDataAsTile"],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
      error: (error, st) {
        return Text(error.toString());
      },
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
