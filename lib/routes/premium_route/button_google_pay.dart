//import 'package:client/payment_config.dart';
import 'package:flutter/material.dart';
//import 'package:pay/pay.dart';

class ButtonGooglePay extends StatelessWidget {
  const ButtonGooglePay({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Pay button');
  }
}
/*
class ButtonGooglePay extends StatelessWidget {
  const ButtonGooglePay({super.key});

  static const _paymentItems = [
    PaymentItem(
      label: 'Преміум',
      amount: '1.0',
      status: PaymentItemStatus.final_price,
    )
  ];

  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
  }

  @override
  Widget build(BuildContext context) {
    return GooglePayButton(
        paymentConfiguration: PaymentConfiguration.fromJsonString(
            PaymentConfig.defaultGooglePayString),
        onPaymentResult: onGooglePayResult,
        paymentItems: _paymentItems);
  }
}
*/