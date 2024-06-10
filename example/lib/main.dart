import 'package:flutter/material.dart';
import 'package:flutter_nuvei_simply_connect_test_example/routes/app_pages.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      defaultTransition: Transition.cupertino,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.pages,
      builder: (context, child) {
        return child ?? const SizedBox();
      },
    );
  }
}
