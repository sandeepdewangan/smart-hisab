import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_hisab/models/category.dart';
import 'package:smart_hisab/repo/category_repo.dart';

// provider
final categoryControllerProvider = Provider(
  (ref) => CategoryController(categoryRepo: ref.watch(categoryRepoProvider)),
);

class CategoryController {
  final CategoryRepo categoryRepo;
  CategoryController({required this.categoryRepo});

  Future<void> addCategory(Category category) async {
    await categoryRepo.insert(category);
  }

  Future<Category?> getCategoryById(int id) async {
    return await categoryRepo.getById(id);
  }

  Future<IconData> getIconDataByCatId(int id) async {
    final data = categoryRepo.getById(id).then((d) => d!.icon);
    return data;
  }

  Future<void> deleteCategory(int id) async {
    await categoryRepo.delete(id);
  }

  // Stream<List<Category>> getAllCategoriesStream(TrackerType trackerType) {
  //   return categoryRepo.get(trackerType);
  // }
}
