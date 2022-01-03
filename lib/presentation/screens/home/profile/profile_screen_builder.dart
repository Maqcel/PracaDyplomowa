import 'package:flutter/material.dart';
import 'package:praca_inz/config/dimensions/padding_dimension.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';
import 'package:praca_inz/presentation/screens/home/profile/widget/user_profile_card.dart';

class ProfileScreenBuilder {
  static Widget build({
    required BuildContext context,
    required Function() onLogoutButtonClicked,
  }) =>
      SafeArea(
        child: Column(
          children: [
            _userProfileCard(),
            ElevatedButton(
              onPressed: () => onLogoutButtonClicked(),
              child: Text(context.localizations.profileLogoutButtonText),
            ),
          ],
        ),
      );

  static Widget _userProfileCard() => const Padding(
        padding: EdgeInsets.only(
          left: PaddingDimension.medium,
          right: PaddingDimension.medium,
          bottom: PaddingDimension.medium,
        ),
        child: UserProfileCard(
          firstName: 'firstName',
          lastName: 'lastName',
          groupId: 'T1021',
        ),
      );
}
