import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_hisab/commons/action-bar-icon-button.dart';
import 'package:smart_hisab/features/categories/controller/category_controller.dart';
import 'package:smart_hisab/features/transactions/controller/transaction_controller.dart';
import 'package:smart_hisab/features/transactions/views/add_transactions_view.dart';
import 'package:smart_hisab/features/transactions/widgets/month_picker.dart';
import 'package:smart_hisab/providers/providers.dart';
import 'package:smart_hisab/theme/pallete.dart';

class TransactionsView extends ConsumerWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const TransactionsView());
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catController = ref.watch(categoryControllerProvider);
    final pickedDate = ref.watch(dateProviderTemp);
    final transactions = ref.watch(transactionStreamProvider(pickedDate!));

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MonthPicker(pickedDate: pickedDate),
            ActionBarIconButton(
              onPressed: () async {
                await Navigator.push(context, AddTransactionsView.route());
              },
              icon: Icons.add,
            ),
          ],
        ),
        Expanded(
          child: transactions.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error:
                (error, trace) => Center(
                  child: Text(
                    error.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            data: (transactions) {
              if (transactions.isEmpty) {
                return Text("No data present");
              }
              // Filter by month
              final filteredTx =
                  transactions
                      .where(
                        (tx) =>
                            tx!.date.month == pickedDate.month &&
                            tx.date.year == pickedDate.year,
                      )
                      .toList();
              if (filteredTx.isEmpty) {
                return Text("No data present for this month");
              }

              return ListView.builder(
                itemCount: filteredTx.length,
                itemBuilder: (context, index) {
                  final tx = filteredTx[index];
                  // filter
                  return Dismissible(
                    key: Key(tx!.id.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(color: Colors.redAccent),
                    onDismissed: (direction) async {
                      await ref
                          .read(transactionControllerProvider)
                          .deleteTransaction(tx.id!);
                    },
                    confirmDismiss: (DismissDirection direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm"),
                            content: const Text(
                              "Are you sure you wish to delete?",
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed:
                                    () => Navigator.of(context).pop(true),
                                child: const Text(
                                  "DELETE",
                                  style: TextStyle(color: Pallete.accentColor),
                                ),
                              ),
                              TextButton(
                                onPressed:
                                    () => Navigator.of(context).pop(false),
                                child: const Text(
                                  "CANCEL",
                                  style: TextStyle(color: Pallete.whiteColor),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },

                    child: Card(
                      child: ListTile(
                        leading: FutureBuilder(
                          future: catController.getIconDataByCatId(
                            tx.categoryId,
                          ),
                          builder: (context, snapshot) {
                            return Icon(snapshot.data);
                          },
                        ),
                        title: Text(tx.amount.toStringAsFixed(2)),
                        subtitle: tx.note != null ? Text(tx.note!) : null,
                        trailing: Icon(Icons.navigate_before_outlined),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
