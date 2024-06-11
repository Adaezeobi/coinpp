import 'dart:convert';
import 'dart:math';

import 'package:coinpp/Pages/details_page.dart';
import 'package:coinpp/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smartech_base/smartech_base.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  double? _deviceHeight, _deviceWidth;
  HTTPService? _http;
  String? _menuItem = "bitcoin";

  @override
  void initState() {
    super.initState();
    _http = GetIt.instance.get<HTTPService>();
    print(_http);
  }

  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_selectedCoinDropdown(), _dataWidgets()],
        ),
      )),
    );
  }

  Widget _dataWidgets() {
    return FutureBuilder(
      future: _http!.get("/coins/$_menuItem"),
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (_snapshot.hasData) {
          Map _data = jsonDecode(_snapshot.data.toString());
          // print(jsonDecode(_snapshot.data));
          num _usdPrice = _data["market_data"]["current_price"]["usd"];
          print(_usdPrice);
          num _change24h = _data["market_data"]["price_change_percentage_24h"];
          Map _exchanges = _data["market_data"]["current_price"];
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onDoubleTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext _context) {
                          return DetailsPage(data: _menuItem,exchanges: _exchanges,);
                        },
                      ),
                    );
                  },
                  child: _coinImageWidget(_data['image']['large'])),
              _currentPriceWidget(_usdPrice),
              _percentageChangeWidget(_change24h),
              _descriptionCard(_data["description"]["en"])
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _selectedCoinDropdown() {
    List<String> _coins = ["bitcoin", "ethereum", 'tether'];
    List<DropdownMenuItem<String>> _items = _coins
        .map(
          (e) => DropdownMenuItem(
            onTap: () {
              //print(e);
            },
            value: e,
            child: Text(
              e,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600),
            ),
          ),
        )
        .toList();
    return DropdownButton(
      value: _menuItem,
      items: _items,
      onChanged: ( _value) {
        setState(() {
          _menuItem = _value;
          print("menu item, ${_menuItem}");
        });
      },
      onTap: () {
        Smartech().setUserIdentity("a.obiokoye@yahoo.com");
        var map = {
          "DOB": "2024-04-15",
          "MOBILE": "09081692129",
          "EMAIL": "a.obiokoye@yahoo.com",
        };
//Smartech().updateUserProfile(map);

        var payload = {"email": "a.obiokoye@yahoo.com"};

        Smartech().trackEvent("Xplo_loginsuccess", payload);
      },
      dropdownColor: const Color.fromRGBO(83, 88, 206, 1.0),
      iconSize: 30,
      icon: const Icon(
        Icons.arrow_drop_down_sharp,
        color: Colors.white,
      ),
      underline: Container(),
    );
  }

  Widget _currentPriceWidget(num _rate) {
    return Text(
      "${_rate.toStringAsFixed(2)} USD",
      style: TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.w300),
    );
  }

  Widget _percentageChangeWidget(num _rate) {
    return Text(
      "${_rate.toStringAsFixed(2)} USD",
      style: TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300),
    );
  }

  Widget _coinImageWidget(String _imageUrl) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.02),
      height: _deviceHeight! * 0.15,
      width: _deviceWidth! * 0.15,
      decoration:
          BoxDecoration(image: DecorationImage(image: NetworkImage(_imageUrl))),
    );
  }

  Widget _descriptionCard(String _description) {
    return Container(
      height: _deviceHeight! * 0.45,
      width: _deviceWidth! * 0.90,
      margin: EdgeInsets.symmetric(
        vertical: _deviceHeight! * 0.055,
      ),
      padding: EdgeInsets.symmetric(
          vertical: _deviceHeight! * 0.05, horizontal: _deviceWidth! * 0.01),
      child: Text(
        _description,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
