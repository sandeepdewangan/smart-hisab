import 'package:flutter/widgets.dart';

enum TrackerType { expense, income }

class Category {
  // this will be auto generated
  int? id;
  final String name;
  final IconData icon;
  final TrackerType trackerType;

  Category({
    required this.name,
    required this.icon,
    required this.trackerType,
    this.id,
  });

  Category copyWith({String? name, IconData? icon, TrackerType? trackerType}) {
    return Category(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      trackerType: trackerType ?? this.trackerType,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'name': name,
  //     'icon': icon.codePoint,
  //     'trackerType': trackerType.name,
  //   };
  // }

  // factory Category.fromMap(Map<String, dynamic> map) {
  //   return Category(
  //     id: map['id'] as int,
  //     name: map['name'] as String,
  //     icon: IconData(map['icon'] as int, fontFamily: 'MaterialIcons'),
  //     trackerType: TrackerType.fromMap(map['trackerType'] as Map<String,dynamic>),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory Category.fromJson(String source) => Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Category(id: $id, name: $name, icon: $icon, trackerType: $trackerType)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
