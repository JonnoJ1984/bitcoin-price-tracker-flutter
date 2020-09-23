import 'package:flutter/material.dart';

class DropDownList {
  List<DropdownMenuItem<String>> dropDownlist;
  String selectedCurrency = 'ZAR';

  DropDownList(List<String> currenciesList) {
    this.dropDownlist = createDropDownList(currenciesList);
  }

  List<DropdownMenuItem<String>> createDropDownList(
      List<String> currenciesList) {
    List<DropdownMenuItem<String>> result = [];
    for (String c in currenciesList) {
      result.add(
        DropdownMenuItem(
          child: Text(c),
          value: c,
        ),
      );
    }
    return result;
  }

  //DropDown menu for Android
  // DropdownButton<String> getDropDownButton(DropDownList dropDownList) {
  //   //DropDown List of items android
  //   return DropdownButton<String>(
  //       value: selectedCurrency,
  //       items: dropDownList.dropDownlist,
  //       onChanged: (value) {
  //         setState(() {
  //           selectedCurrency = value;
  //           print(value);
  //         });
  //       });
  // }
}
