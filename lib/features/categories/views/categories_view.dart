import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_hisab/commons/action-bar-icon-button.dart';
import 'package:smart_hisab/features/categories/views/add_category_view.dart';
import 'package:smart_hisab/features/categories/widgets/category_list.dart';
import 'package:smart_hisab/models/category.dart';

class CategoriesView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => CategoriesView());

  const CategoriesView([Key? key]) : super(key: key);

  @override
  ConsumerState<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends ConsumerState<CategoriesView> {
  TrackerType trackerType = TrackerType.expense;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Categories", style: TextStyle(fontSize: 20)),
              ActionBarIconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              AddCategoryView(trackerType: trackerType),
                    ),
                  );
                  // setState(() {});
                },
                icon: Icons.add,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Expense and Income Toggle
        SegmentedButton(
          segments: [
            ButtonSegment(
              value: TrackerType.expense,
              label: Text("Expense"),
              icon: Icon(Icons.payment),
            ),
            ButtonSegment(
              value: TrackerType.income,
              label: Text("Income"),
              icon: Icon(Icons.attach_money),
            ),
          ],
          selected: {trackerType},
          onSelectionChanged: (newSelection) {
            setState(() {
              trackerType = newSelection.first;
            });
          },
        ),
        const SizedBox(height: 10),
        // List of Category Expenses
        Expanded(
          child: IndexedStack(
            index: trackerType.index,
            children: [
              CategoryList(trackerType: TrackerType.expense),
              CategoryList(trackerType: TrackerType.income),
            ],
          ),
        ),
      ],
    );
  }
}
