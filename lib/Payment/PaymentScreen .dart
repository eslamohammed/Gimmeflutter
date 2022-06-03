
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gimme/Payment/payment_controller.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentController = Get.put(PaymentController());
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: ElevatedButton(
                  onPressed: () => paymentController.makePayment(
                      amount: '5',  // comment price will be put instead of 5
                      currency:'USD'//Concurncy
                    ),
                  child: Text("Make a Payment")))
        ],
      ),
    );
  }
}
