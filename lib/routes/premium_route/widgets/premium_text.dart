import 'package:client/routes/premium_route/state/premium_route_state_model.dart';
import 'package:client/widgets/hexagon_dots/hexagon_dots_loading.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PremiumText extends StatelessWidget {
  const PremiumText({super.key});

  @override
  Widget build(BuildContext context) {
    final textFuture = context.watch<PremiumRouteStateModel>().premiumText;

    return FutureBuilder(
        future: textFuture,
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: snapshot.data!.mapIndexed((index, text) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                  ),
                );
              }).toList(),
            );
          }
          if (snapshot.hasError) {
            return const Text("Помилка завантаження");
          } else {
            return Center(
              child: HexagonDotsLoading.def(),
            );
          }
        });
  }
}
