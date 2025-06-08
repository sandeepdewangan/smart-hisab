import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_hisab/models/transaction.dart';
import 'package:smart_hisab/repo/transaction_repo.dart';

// provider
final transactionControllerProvider = Provider(
  (ref) => TransactionController(
    transactionRepo: ref.watch(transactionRepoProvider),
  ),
);

class TransactionController {
  final TransactionRepo transactionRepo;
  TransactionController({required this.transactionRepo});

  Future<void> addTransaction(Transaction tx) async {
    await transactionRepo.insert(tx);
  }

  Future<void> deleteTransaction(int id) async {
    await transactionRepo.delete(id);
  }

  Future<void> deleteTransactionByCategoryId(int catId) async {
    await transactionRepo.deleteByCategoryId(catId);
  }
}
