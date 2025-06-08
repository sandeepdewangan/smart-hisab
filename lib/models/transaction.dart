class Transaction {
  // this will be auto generated
  int? id;
  final int categoryId;
  final double amount;
  // while putting in db, we convert DT to msepoch. 
  // and while pulling from db we again do conversion from msepoch to DT.
  final DateTime date; 
  final String? note;

  Transaction({
    this.id,
    required this.categoryId,
    required this.amount,
    required this.date,
    this.note,
  });

  Transaction copyWith({
    int? categoryId,
    double? amount,
    DateTime? date,
    String? note,
  }) {
    return Transaction(
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }

  @override
  String toString() {
    return 'Transaction(id: $id, category: $categoryId, amount: $amount, date: $date, note: $note)';
  }
}
