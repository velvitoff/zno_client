import 'package:client/state_models/auth_state_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AuthStateProvider extends StatelessWidget {
  final Widget child;
  const AuthStateProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthStateModel(),
      child: child,
    );
  }
}
