import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:smart_hisab/core/failure.dart';
import 'package:smart_hisab/features/transactions/controller/transaction_controller.dart';
import 'package:smart_hisab/models/category.dart';
import 'package:smart_hisab/providers/providers.dart';
import 'package:fpdart/fpdart.dart';

// Provider
final categoryRepoProvider = Provider(
  (ref) => CategoryRepo(database: ref.watch(databaseProvider), ref: ref),
);

class CategoryRepo {
  final Database database;
  late final StoreRef<int, Map<String, dynamic>> _store;
  final Ref ref;

  CategoryRepo({required this.database, required this.ref}) {
    _store = intMapStoreFactory.store('category');
  }

  Future<Either<Failure, int>> insert(Category cat) async {
    try {
      final id = await _store.add(database, {
        // "id": cat.id,
        "name": cat.name,
        "icon": cat.icon.codePoint,
        "trackerType": cat.trackerType.name,
      });

      return right(id);
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  Future<Either<Failure, Null>> delete(int catId) async {
    try {
      // delete tx
      await ref
          .read(transactionControllerProvider)
          .deleteTransactionByCategoryId(catId);
      // delete category
      final finder = Finder(filter: Filter.byKey(catId));
      await _store.delete(database, finder: finder);
      return right(null);
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  // Future<List<Category>> get(TrackerType trackerType) async {
  //   var finder = Finder(filter: Filter.equals('trackerType', trackerType.name));
  //   final snapshots = await _store.find(database, finder: finder);

  //   final data =
  //       snapshots.map((category) {
  //         return Category(
  //           id: category.key,
  //           name: category.value["name"],
  //           icon: IconData(category.value["icon"], fontFamily: 'MaterialIcons'),
  //           trackerType: TrackerType.values.byName(
  //             category.value["trackerType"],
  //           ),
  //         );
  //       }).toList();

  //   return data;
  // }

  Future<Category?> getById(int id) async {
    final finder = Finder(filter: Filter.byKey(id));

    final category = (await _store.find(database, finder: finder)).firstOrNull;

    if (category == null) {
      return null;
    }
    return Category(
      id: category.key,
      name: category.value["name"],
      icon: IconData(category.value["icon"], fontFamily: 'MaterialIcons'),
      trackerType: TrackerType.values.byName(category.value["trackerType"]),
    );
  }

  Stream<List<Category>> get(TrackerType trackerType) => _store
      .query(
        finder: Finder(filter: Filter.equals('trackerType', trackerType.name)),
      )
      .onSnapshots(database)
      .map(
        (snapshot) => snapshot
            .map(
              (category) => Category(
                id: category.key,
                name: category.value["name"],
                icon: IconData(
                  category.value["icon"],
                  fontFamily: 'MaterialIcons',
                ),
                trackerType: TrackerType.values.byName(
                  category.value["trackerType"],
                ),
              ),
            )
            .toList(growable: false),
      );
}
