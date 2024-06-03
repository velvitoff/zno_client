import 'package:client/routes/settings_route/settings_page.dart';
import 'package:client/routes/settings_route/state/settings_route_state_model.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

class SettingsRoute extends StatelessWidget {
  const SettingsRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsRouteStateModel(),
      child: const Scaffold(
        body: SettingsPage(),
        bottomNavigationBar: ZnoBottomNavigationBar(
          activeRoute: ZnoBottomNavigationEnum.settings,
        ),
      ),
    );
  }
}
