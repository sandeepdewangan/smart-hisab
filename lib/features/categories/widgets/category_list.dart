import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_hisab/features/categories/controller/category_controller.dart';
import 'package:smart_hisab/models/category.dart';
import 'package:smart_hisab/providers/providers.dart';
import 'package:smart_hisab/theme/pallete.dart';

class CategoryList extends ConsumerWidget {
  final TrackerType trackerType;
  const CategoryList({super.key, required this.trackerType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesStreamProvider(trackerType));

    return categories.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error:
          (error, trace) => Center(
            child: Text(error.toString(), style: TextStyle(color: Colors.red)),
          ),
      data: (categories) {
        return categories.isEmpty
            ? Align(
              alignment: Alignment.topCenter,
              child: Text("Start adding category"),
            )
            : ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Dismissible(
                  key: Key(category.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(color: Colors.redAccent),
                  onDismissed: (direction) async {
                    await ref
                        .read(categoryControllerProvider)
                        .deleteCategory(category.id!);
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
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text(
                                "DELETE",
                                style: TextStyle(color: Pallete.accentColor),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
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
                      leading: Icon(category.icon),
                      title: Text(category.name),
                      trailing: Icon(Icons.navigate_before_outlined),
                    ),
                  ),
                );
              },
            );
      },
    );
  }
}
