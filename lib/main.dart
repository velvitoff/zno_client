import 'package:client/locator.dart';
import 'package:client/providers/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:client/routes.dart';

void main() {
  getItSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) {
          return AuthStateProvider(
              child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: Routes.router,
            title: 'Тести ЗНО і НМТ',
            theme: ThemeData(
                primarySwatch: Colors.green,
                fontFamily: 'Ubuntu',
                scaffoldBackgroundColor: const Color(0xFFF9F9F9)),
          ));
        });
  }
}
