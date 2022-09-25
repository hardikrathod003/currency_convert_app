import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/android.dart';
import 'screens/cupertino.dart';
import 'models/Global.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return (isIOS == true)
        ? const CupertinoApp(
            debugShowCheckedModeBanner: false,
            home: CupertinoScreen(),
            theme: CupertinoThemeData(
              brightness: Brightness.light,
            ),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => const AndroidScreen(),
            },
          );
  }
}
