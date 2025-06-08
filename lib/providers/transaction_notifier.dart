import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_hisab/models/transaction.dart';

final transactionNotifierProvider =
    StateNotifierProvider<TransactionNotifier, List<Transaction>>(
      (ref) => TransactionNotifier(),
    );

class TransactionNotifier extends StateNotifier<List<Transaction>> {
  TransactionNotifier() : super([]);

  void addTransaction(Transaction transaction) {
    state = [...state, transaction];
  }
}
