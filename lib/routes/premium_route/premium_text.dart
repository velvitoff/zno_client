import 'package:client/locator.dart';
import 'package:client/services/supabase_service.dart';
import 'package:client/widgets/zno_loading.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PremiumText extends StatefulWidget {
  const PremiumText({super.key});

  @override
  State<PremiumText> createState() => _PremiumTextState();
}

class _PremiumTextState extends State<PremiumText> {
  final Future<List<String>> textFuture =
      locator.get<SupabaseService>().getPremiumText();

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
              child: SizedBox(
                height: 170.h,
                child: const ZnoLoading(),
              ),
            );
          }
        });
  }
}
