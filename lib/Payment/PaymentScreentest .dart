
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;


class PaymentScreentest extends StatefulWidget {
  const PaymentScreentest({Key? key}) : super(key: key);
  _PaymentScreentestState createState() => _PaymentScreentestState();
  
}
class _PaymentScreentestState extends State<PaymentScreentest>{
  @override
  Widget build(BuildContext context) {
    //final paymentController = Get.put(PaymentController());
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await makePayment(
                  amount: '5',  // comment price will be put instead of 5
                  currency:'USD'//Concurncy
                );
              },
            child: Text("Make a Payment"),
            ),
          ),
        ],
      ),
    );
  }
  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment(
      {required String amount, required String currency}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
      print("$paymentIntentData ++++++++++++++++++++++++++++++++++++");
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            applePay: true,
            googlePay: true,
            style: ThemeMode.dark,
            testEnv: true,
            merchantCountryCode: 'US',
            merchantDisplayName: 'Prospects',
            ///customerId: paymentIntentData!['customer'],
            ///customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
        ));
        displayPaymentSheet();
      }
    } catch (e, s) {
      print('exception:$e--$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet(
        parameters: PresentPaymentSheetParameters(clientSecret: paymentIntentData!['clientSecret'],
        confirmPayment: true
        )
      );

        setState((){
          paymentIntentData = null;
        });
    
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Payment Successful : paid")));
    }on StripeException catch(err){
      print("exception:${err.toString()}");
      showDialog(
        context: context,
        builder:(_) => AlertDialog(
          content: Text("Cancelled"),
        ));
    }    

      /*Get.snackbar('Payment', 'Payment Successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }*/
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer sk_test_51KtClKF14f2L8WTnbR4LACaIN9BGNI9U1InkBNDFXXxxOV3qIO0zqP63BY3peiU7s0SMHfomGiIqqueNjbLt7PKZ00z9Y2GhNj',  //Your Stripe Secret Key
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body());
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final price = (int.parse(amount)) * 100;
    return price.toString();
  }
}
