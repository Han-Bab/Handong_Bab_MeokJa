import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:toss_payment/toss_payment.dart';

import 'models/payment_request.dart';
import 'models/product.dart';
import 'services/mock_server.dart';
import 'widgets/order_widget.dart';
import 'widgets/product_widget.dart';

class Toss extends StatefulWidget {
  const Toss({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Toss> createState() => _TossState();
}

class _TossState extends State<Toss> {
  final Product _product = Product(price: 15000, name: '토스 티셔츠');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: Center(
              child: ProductWidget(
                product: _product,
              ),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            padding: const EdgeInsets.all(4),
            crossAxisCount: 3,
            children: List.generate(9, (index) {
              Widget ret = Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              );

              switch (index) {
                case 0:
                  ret = OrderWidget(
                    title: '계좌이체',
                    product: _product,
                    onTap: (request) {
                      _showPayment(context, request);
                    },
                    payBy: '계좌이체',
                  );
                  break;
              }
              return ret;
            }),
          ),
        ]),
      ),
    );
  }

  _showPayment(BuildContext context, PaymentRequest request) async {
    var ret = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        isDismissible: false,
        builder: (context) {
          bool success = false;
          return Container(
            margin: const EdgeInsets.only(top: 110),
            child: PaymentWebView(
              title: _product.name,
              paymentRequestUrl: request.url,
              onPageStarted: (url) {
                dev.log('onPageStarted.url = $url', name: "PaymentWebView");
              },
              onPageFinished: (url) {
                dev.log('onPageFinished.url = $url', name: "PaymentWebView");
                // TODO something to decide the payment is successful or not.
                success = url.contains('success');
              },
              onDisposed: () {},
              onTapCloseButton: () {
                Navigator.of(context).pop(success);
              },
            ),
          );
        });
    dev.log('ret = $ret', name: '_showPayment');
  }
}

extension PaymentRequestExtension on PaymentRequest {
  Uri get url {
    // TODO 토스페이를 위해 만든 Web 주소를 넣어주세요. 아래는 예시입니다.
    return Uri.http("localhost:8080", "payment", json);
  }
}
