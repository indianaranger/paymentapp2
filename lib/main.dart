import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _externalWallet);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _paymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _paymentFailure);
  }

  @override
  void dispose() {
    _razorpay.clear(); // Dispose the Razorpay instance when not needed
    super.dispose();
  }

  void _paymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Success payment: ${response.paymentId}", timeInSecForIosWeb: 4);
  }

  void _paymentFailure(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment failed: ${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
  }

  void _externalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External wallet is :${response.walletName}",
        timeInSecForIosWeb: 4);
  }

  void makePayment() async {
    var options = {
      'key': 'rzp_test_LHmm4k8DuraSma',
      'amount': 10000,
      'name': 'Ajay',
      'description': 'flat tire',
      'prefill': {'contact': "9605642345", 'email': "ajaycyriac581@gmail.com"},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment gateway'),
      ),
      body: ListView(
        children: [
          
          Card(
            child: ListTile(
              //`title: const Text(''),
              leading: Image.network(
                  'https://www.mobileautomechanicsli.com/wp-content/uploads/2019/04/logo-blue-01.png'),
              
              //subtitle: const Text('It is cheap nickers!!'),
              trailing: ElevatedButton(
                onPressed: () {
                  makePayment();
                },
                child: const Text('Buy Now'),
              ),
            ),
          )
        ],
      ),
    );
  }
}