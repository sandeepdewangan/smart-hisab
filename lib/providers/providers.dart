import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:smart_hisab/models/category.dart';
import 'package:smart_hisab/repo/category_repo.dart';
import 'package:smart_hisab/repo/transaction_repo.dart';

final iconProviderTemp = StateProvider<IconData?>((ref) => null);

final categoryIconProviderTemp = StateProvider<Category?>((ref) => null);

final dateProviderTemp = StateProvider<DateTime?>((ref) => DateTime.now());

// sembast nosql DB Provider
final databaseProvider = Provider<Database>(
  (_) => throw Exception('Database not initialized'),
);

// Stream of categories
final categoriesStreamProvider = StreamProvider.family(
  (ref, TrackerType trackerType) =>
      ref.watch(categoryRepoProvider).get(trackerType),
);

// Stream of transactions
final transactionStreamProvider = StreamProvider.family(
  (ref, DateTime date) => ref.watch(transactionRepoProvider).get(),
);
