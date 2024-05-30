import 'dart:async';
import 'package:client/widgets/icons/zno_google_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

const Set<String> _kIds = <String>{'zno_client_premium'};

class ButtonGooglePay extends StatefulWidget {
  const ButtonGooglePay({super.key});

  @override
  State<ButtonGooglePay> createState() => _ButtonGooglePayState();
}

class _ButtonGooglePayState extends State<ButtonGooglePay> {
  final Future<bool> isStoreAvailable = InAppPurchase.instance.isAvailable();
  final Future<ProductDetails> productDetails = InAppPurchase.instance
      .queryProductDetails(_kIds)
      .then((response) => response.productDetails
          .where((e) => e.id == "zno_client_premium")
          .first);

  void _onClickBuy(ProductDetails productDetails) async {
    await InAppPurchase.instance.buyNonConsumable(
        purchaseParam: PurchaseParam(productDetails: productDetails));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([isStoreAvailable, productDetails]),
        builder: ((BuildContext context, AsyncSnapshot<List<Object>> snapshot) {
          if (snapshot.hasData) {
            final isAvailable = snapshot.data![0] as bool;
            final prodDetails = snapshot.data![1] as ProductDetails;
            if (isAvailable) {
              return _ButtonPayWidget(
                onTap: () => _onClickBuy(prodDetails),
              );
            }
            return const Text('Немає зв\'язку з магазином');
          } else if (snapshot.hasError) {
            return const Text('Помилка завантаження');
          } else {
            return const CircularProgressIndicator(
              color: Color(0xFF428449),
            );
          }
        }));
  }
}

class _ButtonPayWidget extends StatelessWidget {
  final void Function() onTap;
  const _ButtonPayWidget({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65.h,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 0.75))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Придбати через',
              style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 16, 16, 16)),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 5.h, left: 10.w),
                child: CustomPaint(
                  isComplex: true,
                  painter: ZnoGoogleIcon(),
                  child: SizedBox(
                    height: 48.r,
                    width: 48.r,
                  ),
                )),
            Text(
              'Pay',
              style: TextStyle(
                  fontSize: 29.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
