import 'package:client/locator.dart';
import 'package:client/services/supabase_service.dart';
import 'package:client/widgets/hexagon_dots/hexagon_dots_loading.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PremiumText extends StatefulWidget {
  const PremiumText({super.key});

  @override
  State<PremiumText> createState() => _PremiumTextState();
}

class _PremiumTextState extends State<PremiumText> {
  late final Future<List<String>> textFuture;

  @override
  void initState() {
    textFuture = locator.get<SupabaseService>().getPremiumText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
