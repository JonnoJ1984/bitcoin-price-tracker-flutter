import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PickerList {
  List<Text> picker = [];

  PickerList(currenciesList) {
    this.picker = createPickerList(currenciesList);
  }

  List<Text> createPickerList(currenciesList) {
    List<Text> result = [];
    for (String c in currenciesList) {
      result.add(
        Text(c),
      );
    }
    return result;
  }

  // CupertinoPicker getCupertinoPicker(PickerList picker) {
  //   //DropDown List of items iOS
  //   return CupertinoPicker(
  //     backgroundColor: Colors.lightBlue,
  //     itemExtent: 35,
  //     onSelectedItemChanged: (selectedIndex) {
  //       print(selectedIndex);
  //     },
  //     children: picker.picker,
  //   );
  // }
}
