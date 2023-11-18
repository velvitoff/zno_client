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
        .listen((AuthState data) {
      if (data.event == AuthChangeEvent.signedIn) {
        if (data.session == null) {
          return;
        }
        context
            .read<AuthStateModel>()
            .setUserAndSession(data.session!.user, data.session!);
      } else if (data.event == AuthChangeEvent.signedOut) {
        print('SIGN OUT');
        context.read<AuthStateModel>().clearUserAndSession();
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
