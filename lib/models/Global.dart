import 'dart:io';

import 'package:flutter/material.dart';

String currency = "INR";

bool isIOS = false;

late Future<BTCConvertor?> fetchBTCConvertor;

int index = 0;

class BTCConvertor {
  final double INR;

  BTCConvertor({
    required this.INR,
  });

  factory BTCConvertor.fromJson(Map<String, dynamic> json) {
    return BTCConvertor(INR: json["BTC_$currency"]);
  }
}

class APIHelper {
  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();
}
