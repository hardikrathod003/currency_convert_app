import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/Global.dart';

class CupertinoScreen extends StatefulWidget {
  const CupertinoScreen({Key? key}) : super(key: key);

  @override
  State<CupertinoScreen> createState() => _CupertinoScreenState();
}

class _CupertinoScreenState extends State<CupertinoScreen> {
  List<Widget> cur = const [
    Text(
      "AUD",
      style: TextStyle(color: Colors.white),
    ),
    Text(
      "USD",
      style: TextStyle(color: Colors.white),
    ),
    Text(
      "CAD",
      style: TextStyle(color: Colors.white),
    ),
    Text(
      "CNY",
      style: TextStyle(color: Colors.white),
    ),
    Text(
      "EUR",
      style: TextStyle(color: Colors.white),
    ),
    Text(
      "GBP",
      style: TextStyle(color: Colors.white),
    ),
    Text(
      "HKD",
      style: TextStyle(color: Colors.white),
    ),
    Text(
      "IDR",
      style: TextStyle(color: Colors.white),
    ),
    Text(
      "ILS",
      style: TextStyle(color: Colors.white),
    ),
    Text(
      "INR",
      style: TextStyle(color: Colors.white),
    ),
    Text(
      "JPY",
      style: TextStyle(color: Colors.white),
    ),
    Text(
      "MXN",
      style: TextStyle(color: Colors.white),
    ),
    Text(
      "NOK",
      style: TextStyle(color: Colors.white),
    ),
    Text(
      "NZD",
      style: TextStyle(color: Colors.white),
    ),
  ];
  List<Text> curs = const [
    Text("AUD"),
    Text("USD"),
    Text("CAD"),
    Text("CNY"),
    Text("EUR"),
    Text("GBP"),
    Text("HKD"),
    Text("IDR"),
    Text("ILS"),
    Text("INR"),
    Text("JPY"),
    Text("MXN"),
    Text("NOK"),
    Text("NZD"),
  ];

  String BASE_URL = "https://free.currconv.com/api/v7/convert?";
  String ENDPOINT1 = "q=BTC_";
  String ENDPOINT2 = currency;
  String ENDPOINT3 = "&compact=ultra&apiKey=";
  String API_KEY = "a82b02e316fe3c0b9374";

  Future<BTCConvertor?> fetchbtcConvertor() async {
    Uri API = Uri.parse(BASE_URL + ENDPOINT1 + currency + ENDPOINT3 + API_KEY);

    http.Response response = await http.get(API);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      BTCConvertor btc = BTCConvertor.fromJson(data);

      return btc;
    } else {
      return null;
    }
  }

  @override
  initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
    fetchBTCConvertor = fetchbtcConvertor();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          'Crypto Convertor',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
        trailing: CupertinoSwitch(
          value: isIOS,
          onChanged: (val) {
            setState(() {
              isIOS = val;
            });
          },
        ),
      ),
      child: FutureBuilder(
        future: fetchBTCConvertor,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error : ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            BTCConvertor data = snapshot.data as BTCConvertor;

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        CupertinoButton(
                          onPressed: () {},
                          color: Colors.purple,
                          child: Text(
                            "1 BTC = ${data.INR} $currency",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CupertinoButton(
                          onPressed: () {},
                          color: Colors.purple,
                          child: Text(
                            "1 ETH = ${data.INR} $currency",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 200,
                      child: CupertinoPicker(
                        backgroundColor: Colors.purple,
                        onSelectedItemChanged: (value) {
                          setState(() {
                            index = value;
                            currency = curs[index].data.toString();
                          });
                          Timer(const Duration(seconds: 2), () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        super.widget));
                          });
                        },
                        itemExtent: 25,
                        children: cur,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
                child: Stack(
              alignment: Alignment.center,
              children: const [
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                ),
                CircularProgressIndicator(
                  color: Colors.purple,
                ),
              ],
            ));
          }
        },
      ),
    );
  }
}
