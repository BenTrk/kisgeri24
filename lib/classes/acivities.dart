import 'package:flutter/foundation.dart';

class Activities {
  List<Category> categoryList;

  Activities({
    List<Category>? categoryList,
  }) : categoryList = categoryList ?? [];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Activities && listEquals(other.categoryList, categoryList);
  }

  @override
  int get hashCode => categoryList.hashCode;

  getCategoryName(int position) {
    return categoryList[position].name;
  }
}

class Category {
  String name;
  List<Activity> activityList;

  Category({
    required this.name,
    List<Activity>? activityList,
  }) : activityList = activityList ?? [];

  static Category fromSnapshot(String name, Map<dynamic, dynamic> value) {
    String categoryName = name;
    List<Activity> activityList = [];

    value.forEach((key, value) {
      final Activity activity = Activity.fromSnapshot(key as String, value);
      activityList.add(activity);
    });

    Category category =
        Category(name: categoryName, activityList: activityList);
    return category;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.name == name &&
        listEquals(other.activityList, activityList);
  }

  @override
  int get hashCode => Object.hash(name, activityList);
}

class Activity {
  String name;
  Map<String, int> points;

  Activity({
    required this.name,
    this.points = const {}, // Initialize with an empty map by default
  });

  static Activity fromSnapshot(String name, Map<dynamic, dynamic> value) {
    name = name;
    Map<String, int> points = {};
    value.forEach((key, value) {
      points[key] = value;
    });
    return Activity(name: name, points: points);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Activity && mapEquals(other.points, points);
  }

  @override
  int get hashCode => points.hashCode;
}
