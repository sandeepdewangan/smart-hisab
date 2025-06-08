import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_hisab/commons/text_field.dart';
import 'package:smart_hisab/core/utils.dart';
import 'package:smart_hisab/features/categories/controller/category_controller.dart';
import 'package:smart_hisab/features/categories/widgets/icon_grid.dart';
import 'package:smart_hisab/models/category.dart';
import 'package:smart_hisab/providers/providers.dart';

class AddCategoryView extends ConsumerStatefulWidget {
  final TrackerType trackerType;
  const AddCategoryView({super.key, required this.trackerType});

  @override
  ConsumerState<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends ConsumerState<AddCategoryView> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  onSave() async {
    // Manage State form here
    final icon =
        ref.watch(iconProviderTemp) ??
        const IconData(0xf03e8, fontFamily: 'MaterialIcons');

    final name = nameController.text.trim();
    if (name.isEmpty) return;

    // Sembast Database
    final categoryController = ref.watch(categoryControllerProvider);
    await categoryController.addCategory(
      Category(
        name: capitalizeString(name),
        icon: icon,
        trackerType: widget.trackerType,
      ),
    );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final icon =
        ref.watch(iconProviderTemp) ??
        const IconData(0xf03e8, fontFamily: 'MaterialIcons');

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.navigate_before, size: 35),
                  ),
                  Text("Add Category", style: TextStyle(fontSize: 20)),
                  IconButton(
                    onPressed: onSave,
                    icon: Icon(Icons.save, size: 35),
                  ),
                ],
              ),
            ),

            // Form
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppTextField(
                controller: nameController,
                hintText: 'Enter a new category name',
                maxLength: 20,
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => IconGrid(),
                );
              },
              child: SizedBox(
                height: 50,
                width: 50,
                child: Icon(icon, size: 35),
              ),
            ),
            Text("Change Icon", style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
