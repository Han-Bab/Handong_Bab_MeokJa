import '../models/payment_request.dart';

class PaymentHtml {
  static String generate(PaymentRequest request) {
    String ret = "";
    switch (request.payBy) {
      case "계좌이체":
        ret = accountTransfer(request);
        break;
    }

    return ret;
  }

  static String accountTransfer(PaymentRequest request) {
    return '''<html>
      <head>
   <script src="https://js.tosspayments.com/v1"></script>
   </head>
   <body>
   <script>
   var tossPayments = TossPayments('test_ck_OEP59LybZ8Bdv6A1JxkV6GYo7pRe')
   tossPayments.requestPayment('${request.payBy}', {
   amount: ${request.amount},
   orderId: '${request.orderId}',
   orderName: '${request.orderName}',
   customerName: '${request.customerName}',
   bank: '${request.bank}',
   successUrl: window.location.origin + '/success',
   failUrl: window.location.origin + '/fail',
   })
   </script>
   </body>
   </html>
   ''';
  }
}

String successHtml = '''<html><h1>Success</h1></html>''';
String failHtml = '''<html><h1>Fail</h1></html>''';
