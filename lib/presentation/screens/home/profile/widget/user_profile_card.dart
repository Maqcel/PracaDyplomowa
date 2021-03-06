import 'package:flutter/material.dart';
import 'package:praca_inz/config/dimensions/padding_dimension.dart';
import 'package:praca_inz/config/dimensions/radius_dimension.dart';
import 'package:praca_inz/config/theme/color_palette.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';
import 'package:praca_inz/presentation/widget/background_mesh.dart';

class UserProfileCard extends StatelessWidget {
  final String _firstName;
  final String _lastName;
  final String _groupId;
  final Function() _onLogoutButtonClicked;

  const UserProfileCard({
    Key? key,
    required String firstName,
    required String lastName,
    required String groupId,
    required Function() onLogoutButtonClicked,
  })  : _firstName = firstName,
        _lastName = lastName,
        _groupId = groupId,
        _onLogoutButtonClicked = onLogoutButtonClicked,
        super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(RadiusDimension.circularLarge),
        ),
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            _background(context),
            Positioned.fill(child: _content(context)),
          ],
        ),
      );

  Widget _background(BuildContext context) => ClipRRect(
        borderRadius: const BorderRadius.all(RadiusDimension.circularMedium),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          child: const BackgroundMesh(
            shader: ColorPalette.colorPrimary1000,
            foreground: ColorPalette.colorPrimary800,
          ),
        ),
      );

  Widget _content(BuildContext context) => Padding(
        padding: const EdgeInsets.all(PaddingDimension.medium),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                _userIconExpandedRow(context),
                const SizedBox(height: PaddingDimension.medium),
                _userNameRow(context),
                _userGroupRow(context),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [_logoutButton(context, _onLogoutButtonClicked)],
            )
          ],
        ),
      );

  Widget _userIconExpandedRow(BuildContext context) => Expanded(
        child: Row(
          children: [_userProfileIcon(context)],
        ),
      );

  Widget _userProfileIcon(BuildContext context) => Icon(
        Icons.person_outline_rounded,
        color: ColorPalette.colorBasic0,
        size: MediaQuery.of(context).size.height * 0.1,
      );

  Widget _userNameRow(BuildContext context) => Container(
      alignment: Alignment.centerLeft,
      child: Text(
        _userNameString(context),
        overflow: TextOverflow.ellipsis,
        style: context.theme.textTheme.headline3
            ?.copyWith(color: ColorPalette.colorBasic0),
      ));

  String _userNameString(BuildContext context) => '$_firstName $_lastName';

  Widget _userGroupRow(BuildContext context) => Container(
      alignment: Alignment.centerLeft,
      child: Text(
        _groupId,
        overflow: TextOverflow.ellipsis,
        style: context.theme.textTheme.bodyText1
            ?.copyWith(color: ColorPalette.colorBasic0),
      ));

  static Widget _logoutButton(
    BuildContext context,
    Function() onLogoutButtonClicked,
  ) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: ColorPalette.colorSecondary1000,
            ),
            onPressed: () => onLogoutButtonClicked(),
            child: Text(context.localizations.profileLogoutButtonText),
          ),
        ],
      );
}
