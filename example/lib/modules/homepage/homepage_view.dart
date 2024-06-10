import 'package:flutter/material.dart';
import 'package:flutter_nuvei_simply_connect_test_example/modules/homepage/homepage_controller.dart';
import 'package:get/get.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuvei Payment example app'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => controller.checkout(),
              child: Container(
                color: Colors.amber,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: const Text('checkout()'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
