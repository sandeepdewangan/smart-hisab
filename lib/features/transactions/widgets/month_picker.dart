import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:smart_hisab/providers/providers.dart';
import 'package:smart_hisab/theme/pallete.dart';

class MonthPicker extends ConsumerStatefulWidget {
  final DateTime pickedDate;
  const MonthPicker({super.key, required this.pickedDate});

  @override
  ConsumerState<MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends ConsumerState<MonthPicker> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.pickedDate;
  }

  Future<DateTime?> monthPicker(BuildContext context) async {
    return showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5, 5),
      lastDate: DateTime(DateTime.now().year + 8, 9),
      initialDate: selectedDate,

      monthPickerDialogSettings: MonthPickerDialogSettings(
        // dialogSettings: const PickerDialogSettings(),
        dialogSettings: PickerDialogSettings(dismissible: true),
        headerSettings: const PickerHeaderSettings(
          headerCurrentPageTextStyle: TextStyle(fontSize: 14),
          headerSelectedIntervalTextStyle: TextStyle(fontSize: 16),
        ),
        actionBarSettings: PickerActionBarSettings(
          confirmWidget: Text(
            'Select',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          cancelWidget: Text(
            'Cancel',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
        ),
      ),
    ).then((DateTime? date) {
      if (date != null) {
        setState(() {
          ref.watch(dateProviderTemp.notifier).update((state) => date);
          selectedDate = date;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async => await monthPicker(context),
      // onPressed: () => MonthChooserPage(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${monthConvert(selectedDate?.month)} - ${selectedDate?.year}',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Icon(Icons.chevron_right, color: Pallete.accentColor, size: 30),
        ],
      ),
    );
  }
}

String monthConvert(int? month) {
  switch (month) {
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    case 12:
      return "December";
    default:
      return "None";
  }
}

class MonthChooserPage extends StatelessWidget {
  const MonthChooserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Hii')));
  }
}
