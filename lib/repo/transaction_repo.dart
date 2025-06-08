import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:smart_hisab/core/failure.dart';
import 'package:smart_hisab/providers/providers.dart';
import 'package:fpdart/fpdart.dart';
import 'package:smart_hisab/models/transaction.dart' as model;

// Provider
final transactionRepoProvider = Provider(
  (ref) => TransactionRepo(database: ref.watch(databaseProvider)),
);

class TransactionRepo {
  final Database database;
  late final StoreRef<int, Map<String, dynamic>> _store;

  TransactionRepo({required this.database}) {
    _store = intMapStoreFactory.store('transaction');
  }

  Future<Either<Failure, int>> insert(model.Transaction tx) async {
    try {
      final id = await _store.add(database, {
        "categoryId": tx.categoryId,
        "amount": tx.amount,
        "date": tx.date.millisecondsSinceEpoch,
        "note": tx.note,
      });

      return right(id);
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  Future<Either<Failure, Null>> delete(int txId) async {
    try {
      final finder = Finder(filter: Filter.byKey(txId));
      await _store.delete(database, finder: finder);
      return right(null);
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  Future<Either<Failure, Null>> deleteByCategoryId(int catId) async {
    try {
      final finder = Finder(filter: Filter.equals('categoryId', catId));
      await _store.delete(database, finder: finder);
      return right(null);
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  // Stream<List<model.Transaction>> get(DateTime date) {
  //   final selectedMonth = date.month;
  //   final List<model.Transaction> filteredTrasactions = [];
  //   final transactionStreamController =
  //       StreamController<List<model.Transaction>>();

  //   return _store.query().onSnapshots(database).map((snapshot) {
  //     snapshot.map((tx) {
  //       final dateFromDb = DateTime.fromMillisecondsSinceEpoch(
  //         tx.value["date"],
  //       );
  //       final dateMonth = dateFromDb.month;
  //       if (dateMonth == selectedMonth) {
  //         filteredTrasactions.add(
  //           model.Transaction(
  //             id: tx.key,
  //             categoryId: tx.value["categoryId"],
  //             amount: tx.value["amount"],
  //             date: dateFromDb,
  //             note: tx.value["note"],
  //           ),
  //         );
  //       }
  //     });
  //     transactionStreamController.sink.add(filteredTrasactions);
  //     return transactionStreamController.stream;
  //   });
  // }

  // Stream<List<model.Transaction?>> get(DateTime date) {
  //   var selectedMonth = date.month;

  //   return _store
  //       .query()
  //       .onSnapshots(database)
  //       .map(
  //         (snapshot) => snapshot
  //             .map((tx) {
  //               final dateFromDb = DateTime.fromMillisecondsSinceEpoch(
  //                 tx.value["date"],
  //               );
  //               final dateMonth = dateFromDb.month;
  //               if (dateMonth == selectedMonth) {
  //                 return model.Transaction(
  //                   id: tx.key,
  //                   categoryId: tx.value["categoryId"],
  //                   amount: tx.value["amount"],
  //                   date: dateFromDb,
  //                   note: tx.value["note"],
  //                 );
  //               }
  //             })
  //             .toList(growable: false),
  //       );
  // }
  Stream<List<model.Transaction?>> get() {
    return _store
        .query()
        .onSnapshots(database)
        .map(
          (snapshot) => snapshot
              .map(
                (tx) => model.Transaction(
                  id: tx.key,
                  categoryId: tx.value["categoryId"],
                  amount: tx.value["amount"],
                  date: DateTime.fromMillisecondsSinceEpoch(tx.value["date"]),
                  note: tx.value["note"],
                ),
              )
              .toList(growable: false),
        );
  }
}
