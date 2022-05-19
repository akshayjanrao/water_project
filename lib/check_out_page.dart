import 'package:flutter_svg/flutter_svg.dart';
import 'package:pay/pay.dart';

import 'package:flutter_paypal/flutter_paypal.dart';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as strip;

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:watersupply/payment_successful.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  Map<String, dynamic>? paymentIntentData;
  final _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];

  bool waitForPayment = false;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  var _formKey = GlobalKey<FormState>();

  void onGooglePayResult(paymentResult) {
    print("on Google Pay Result" + paymentResult.toString());
  }

  void onApplePayResult(paymentResult) {
    // Send the resulting Apple Pay token to your server / PSP
  }

  Future<void> makePayment() async {
    try {
      paymentIntentData =
          await createPaymentIntent('20', 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await strip.Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: strip.SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'ANNIE'))
          .then((value) {});

      ///now finally display payment sheeet

      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await strip.Stripe.instance
          .presentPaymentSheet(
              parameters: strip.PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on strip.StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount('20'),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51KbPPaSIZVUrr77Om8mWZzHMV8AF9nEwNimVGGHJGLQvCzml5x56TfcJvvoxSP62g4UeqdaMGieGfjclRsgQ4Z3f002DYtPHM1',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  void initPublishKey() async {
    strip.Stripe.publishableKey =
        'pk_test_51KbPPaSIZVUrr77OzMIzJnu6tQTlMqv6t34zH9lmClOn7iXQDf9wO62Uoi3VNwPwYvVB7vdoKRLpjcb4jEKNusQs00eyEqLxnp';
    await strip.Stripe.instance.applySettings();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // initPublishKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Check Out Page"),
        
        elevation: 0,
      ),
      body: waitForPayment
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(children: [
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 15, bottom: 10),
                child: Text(
                   "Payment Method",
                  style: TextStyle(fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,),
                ),
              ),
              ExpansionTile(
                leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    radius: 25,
                    backgroundImage: NetworkImage(
                        "https://img.freepik.com/free-vector/illustration-credit-card-icon_53876-5915.jpg?w=740")),
                title: Text(
                   "Debit Card",
                  style: TextStyle(fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,),
                ),
                children: <Widget>[
                  Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: double.infinity,
                    child: Card(
                      elevation: 2,
                      child: ListTile(
                        onTap: () async {
                          print("Debit Card");
                          await makePayment();
                        },
                        leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            backgroundImage: NetworkImage(
                              "https://stripe.com/img/v3/newsroom/social.png",
                            )),
                        title: Text(
                           "Pay Via Stripe",
                          style: TextStyle(fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                expandedAlignment: Alignment.topLeft,
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  radius: 25,
                  child: SvgPicture.asset("assets/mobile-payment.svg"),

                  // NetworkImage(
                  //     "https://www.kindpng.com/picc/m/279-2797776_pay-transparent-png-mobile-payment-icon-png-png.png"),
                ),
                title: Text(
                   "Mobile Payment",
                  style: TextStyle(
                    fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      
                          "select a payment app to proceed with your transaction",
                      style: TextStyle(
                        fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Center(
                        child: GooglePayButton(
                          paymentConfigurationAsset: 'gpay.json',
                          paymentItems: _paymentItems,
                          style: GooglePayButtonStyle.white,
                          type: GooglePayButtonType.pay,
                          onPaymentResult: onGooglePayResult,
                          loadingIndicator: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: double.infinity,
                        ),
                      ),
                      Positioned.fill(
                        top: 5,
                        left: 13,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25,
                              backgroundImage: NetworkImage(
                                "https://akm-img-a-in.tosshub.com/indiatoday/images/story/202011/Screenshot_2020-11-05_at_5.14._1200x768.png?qbPeEkmH2KWK1YfUw65UmVr8EjYDRPgb&size=770:433",
                              )),
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: double.infinity,
                    child: Card(
                      elevation: 2,
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => UsePaypal(
                                  sandboxMode: true,
                                  clientId:
                                      "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
                                  secretKey:
                                      "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
                                  returnURL: "https://samplesite.com/return",
                                  cancelURL: "https://samplesite.com/cancel",
                                  transactions: const [
                                    {
                                      "amount": {
                                        "total": '10.12',
                                        "currency": "USD",
                                        "details": {
                                          "subtotal": '10.12',
                                          "shipping": '0',
                                          "shipping_discount": 0
                                        }
                                      },
                                      "description":
                                          "The payment transaction description.",
                                      // "payment_options": {
                                      //   "allowed_payment_method":
                                      //       "INSTANT_FUNDING_SOURCE"
                                      // },
                                      "item_list": {
                                        "items": [
                                          {
                                            "name": "A demo product",
                                            "quantity": 1,
                                            "price": '10.12',
                                            "currency": "USD"
                                          }
                                        ],

                                        // shipping address is not required though
                                        "shipping_address": {
                                          "recipient_name": "Jane Foster",
                                          "line1": "Travis County",
                                          "line2": "",
                                          "city": "Austin",
                                          "country_code": "US",
                                          "postal_code": "73301",
                                          "phone": "+00000000",
                                          "state": "Texas"
                                        },
                                      }
                                    }
                                  ],
                                  note:
                                      "Contact us for any questions on your order.",
                                  onSuccess: (Map params) async {
                                    print("onSuccess: $params");
                                  },
                                  onError: (error) {
                                    print("onError: $error");
                                  },
                                  onCancel: (params) {
                                    print('cancelled: $params');
                                  }),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            backgroundImage: NetworkImage(
                              "https://www.kindpng.com/picc/m/44-440826_chad-hurley-paypal-logo-hd-png-download.png",
                            )),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 45),
                          child: Text(
                            "Pay with PayPal",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                child: ListTile(
                  onTap: () async {
                    // OrderController orderController = OrderController();
                    setState(() {
                      waitForPayment = true;
                    });
                    // bool done =
                    //     await orderController.orderCheckout("Cash On Delivery");

                    setState(() {
                      waitForPayment = false;
                    });

                    // if (done) {
                    //   cartOfProduct.clear();

                      // CoolAlert.show(
                      //   context: context,
                      //   type: CoolAlertType.success,
                      //   text: "Your Order Placed successfully!",
                      //   onConfirmBtnTap: (){
                      //        Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
                      //   }
                      // );

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SuccessfulPayment()));
                    // } else {}
                  },
                  leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      backgroundImage: NetworkImage(
                          "https://img.freepik.com/free-photo/paper-craft-art-dollar-bill_53876-75083.jpg?w=740")),
                  title: Text(
                     "Cash On Delivery",
                    style:TextStyle(fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,)
                  ),
                ),
              ),
            ]),
    );
  }
}
