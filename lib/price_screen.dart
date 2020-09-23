import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/constants.dart';
import 'package:bitcoin_ticker/dropdown_list.dart';
import 'package:bitcoin_ticker/networking.dart';
import 'package:bitcoin_ticker/picker_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'ZAR';
  int rate;

  //Cupertino Picker creator for iOS
  CupertinoPicker getIOSCupertinoPicker() {
    //DropDown List of items iOS
    PickerList picker = PickerList(currenciesList);
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 35,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        selectedCurrency = picker.picker[selectedIndex].data;
      },
      children: picker.picker,
    );
  }

  //DropDown menu for Android
  DropdownButton<String> getAndroidDropDownButton() {
    //DropDown List of items android
    DropDownList dropDownList = DropDownList(currenciesList);
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropDownList.dropDownlist,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            print(value);
          });
        });
  }

  void getExchangeRate(String coin, String currency) async {
    var url =
        'https://rest.coinapi.io/v1/exchangerate/$coin/$currency?apikey=$kApiKey';
    NetworkingHelper networkingHelper = NetworkingHelper(url);

    var coinData = await networkingHelper.getData();
    print((coinData['rate']).round());
    rate = (coinData['rate']).round();
  }

  Text updatePrice(String coin, String selectedCurrency) {
    //rate = null;
    getExchangeRate(coin, selectedCurrency);
    Text result;
    setState(() {
      if (rate == null) {
        print('Cannot connect to server at this time');
        result = Text(
          '1 $coin  = ??? $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        );
      } else {
        //int rate = (coinData['rate']).round();
        result = Text(
          //rate
          '1 $coin  = $rate $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        );
      }
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('🤑 Coin Ticker'),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Card(
                color: Colors.lightBlueAccent,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                  child: updatePrice('BTC', selectedCurrency),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Card(
                color: Colors.lightBlueAccent,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                  child: updatePrice('ETH', selectedCurrency),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Card(
                color: Colors.lightBlueAccent,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                  child: updatePrice('LTC', selectedCurrency),
                ),
              ),
            ),
            Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS
                  ? getIOSCupertinoPicker()
                  : getAndroidDropDownButton(),
            ),
          ],
        ),
      ),
    );
  }
}
