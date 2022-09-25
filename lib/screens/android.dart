import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/Global.dart';

class AndroidScreen extends StatefulWidget {
  const AndroidScreen({Key? key}) : super(key: key);

  @override
  State<AndroidScreen> createState() => _AndroidScreenState();
}

class _AndroidScreenState extends State<AndroidScreen> {
  TextStyle subStyle = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  List<DropdownMenuItem<String>> get CurrencyDropdownItems {
    List<DropdownMenuItem<String>> CurrencyMenuItems = [
      CurrencyItems("AUD"),
      CurrencyItems("USD"),
      CurrencyItems("CAD"),
      CurrencyItems("EUR"),
      CurrencyItems("GBP"),
      CurrencyItems("HKD"),
      CurrencyItems("INR"),
      CurrencyItems("JPY"),
      CurrencyItems("NOK"),
      CurrencyItems("NZD"),
    ];
    return CurrencyMenuItems;
  }

  DropdownMenuItem<String> CurrencyItems(String items) {
    return DropdownMenuItem(value: items, child: Text(items, style: subStyle));
  }

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Crypto Converter"),
        centerTitle: true,
        actions: [
          Switch(
            value: isIOS,
            onChanged: (val) {
              setState(() {
                isIOS = val;
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
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
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.purple,
                          ),
                          child: Text(
                            "1 BTC = ${data.INR} $currency",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.purple,
                          ),
                          child: Text(
                            "1 ETH = ${data.INR} $currency",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.purple,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Current Currency",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            DropdownButton(
                              value: currency,
                              items: CurrencyDropdownItems,
                              onChanged: (String? newValue) {
                                currency = newValue!;
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            super.widget));
                                setState(() {});
                              },
                              dropdownColor: Colors.purple,
                              underline: Container(),
                            ),
                          ],
                        ),
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
