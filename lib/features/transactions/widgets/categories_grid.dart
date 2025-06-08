import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_hisab/features/categories/views/add_category_view.dart';
import 'package:smart_hisab/models/category.dart';
import 'package:smart_hisab/providers/providers.dart';
import 'package:smart_hisab/theme/pallete.dart';

class CategoriesGrid extends ConsumerWidget {
  final TrackerType trackerType;
  const CategoriesGrid({super.key, required this.trackerType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesStreamProvider(trackerType));

    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: categories.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, trace) => Center(
              child: Text(
                error.toString(),
                style: TextStyle(color: Colors.red),
              ),
            ),
        data: (categories) {
          return categories.isEmpty
              ? Column(
                children: [
                  Text("No category present, start adding!"),
                  TextButton(
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    AddCategoryView(trackerType: trackerType),
                          ),
                        ),
                    child: Text("Add Category"),
                  ),
                ],
              )
              : GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2, // 2 columns
                  childAspectRatio: 3,
                ),
                children: List.generate(categories.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: GestureDetector(
                      onTap: () {
                        ref
                            .read(categoryIconProviderTemp.notifier)
                            .update((state) => categories[index]);
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Pallete.secondaryColor,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(categories[index].icon),
                              Text(categories[index].name),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
        },
      ),
    );
  }
}
