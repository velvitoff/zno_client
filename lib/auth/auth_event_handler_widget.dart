import 'package:client/models/auth_state_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthEventHandlerWidget extends StatefulWidget {
  final Widget child;
  const AuthEventHandlerWidget({super.key, required this.child});

  @override
  State<AuthEventHandlerWidget> createState() => _AuthEventHandlerWidgetState();
}

class _AuthEventHandlerWidgetState extends State<AuthEventHandlerWidget> {
  late final StreamSubscription<AuthState> authListener;

  @override
  void initState() {
    super.initState();
    authListener = Supabase.instance.client.auth.onAuthStateChange
        .listen((AuthState data) async {
      if (data.event == AuthChangeEvent.signedIn ||
          data.event == AuthChangeEvent.tokenRefreshed) {
        if (data.session == null) {
          return;
        }
        final model = context.read<AuthStateModel>();

        final bool isPremium =
            await model.isUserPremium(id: data.session!.user.id);
        model.setData(
            user: data.session!.user,
            session: data.session!,
            premium: isPremium);
      } else if (data.event == AuthChangeEvent.signedOut) {
        context.read<AuthStateModel>().clearData();
      }
    });
  }

  @override
  void dispose() {
    authListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
