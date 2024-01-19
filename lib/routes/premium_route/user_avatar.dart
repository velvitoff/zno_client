import 'package:client/models/auth_state_model.dart';
import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserAvatar extends StatefulWidget {
  const UserAvatar({super.key});

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  void onChoice(BuildContext context, String newValue) {
    if (newValue == 'Увійти через Google') {
      final authModel = context.read<AuthStateModel>();
      authModel.setAuthProviderGoogle();
      authModel.signIn();
    } else if (newValue == 'Вийти') {
      final authModel = context.read<AuthStateModel>();
      authModel.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? currentUser =
        context.select<AuthStateModel, User?>((p) => p.currentUser);

    List<String> items = [];
    List<double>? customHeights;
    bool firstChildIsDisabled = false;
    if (currentUser == null) {
      items.add('Увійти через Google');
    } else {
      items.add(currentUser.email == null ? 'No email' : currentUser.email!);
      items.add('Вийти');
      customHeights = [25.h, 60.h];
      firstChildIsDisabled = true;
    }

    return DropdownButtonHideUnderline(
        child: DropdownButton2(
            dropdownStyleData: DropdownStyleData(
              offset: Offset(0, -8.h),
              width: 230.w,
              decoration: const BoxDecoration(color: Colors.white),
            ),
            menuItemStyleData:
                MenuItemStyleData(height: 60.h, customHeights: customHeights),
            customButton: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Icon(
                  currentUser == null
                      ? Icons.no_accounts
                      : Icons.account_circle,
                  color: Colors.black87,
                ),
              ),
            ),
            items: items.mapIndexed((index, item) {
              final bool isEmail = firstChildIsDisabled && index == 0;
              return DropdownMenuItem<String>(
                enabled: !isEmail,
                value: item,
                child: Text(
                  item,
                  style: isEmail
                      ? TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87.withOpacity(0.85))
                      : TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                onChoice(context, newValue);
              }
            }));
  }
}
