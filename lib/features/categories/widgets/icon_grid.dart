import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_hisab/data/icons.dart';
import 'package:smart_hisab/providers/providers.dart';
import 'package:smart_hisab/theme/pallete.dart';

class IconGrid extends ConsumerWidget {
  const IconGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7, // 2 columns
          crossAxisSpacing: 2,
          mainAxisSpacing: 2, // 2 columns
        ),
        children: List.generate(icons.length, (index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onTap: () {
                ref
                    .read(iconProviderTemp.notifier)
                    .update((state) => icons[index]);
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Pallete.secondaryColor,
                ),

                child: Center(child: Icon(icons[index])),
              ),
            ),
          );
        }),
      ),
    );
  }
}
