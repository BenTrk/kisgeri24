import 'package:flutter/foundation.dart';
import 'package:kisgeri24/classes/place.dart';

class Places {
  List<Place> placeList;

  Places({
    List<Place>? placeList,
  }) : placeList = placeList ?? [];


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Places && listEquals(other.placeList, placeList);
  }

  @override
  int get hashCode => placeList.hashCode;

  getPlaceName(int position){
    return placeList[position].name;
  }
}