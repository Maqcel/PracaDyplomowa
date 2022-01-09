import 'package:flutter/material.dart';
import 'package:praca_inz/config/dimensions/padding_dimension.dart';
import 'package:praca_inz/domain/models/session_result.dart';
import 'package:praca_inz/domain/models/user_profile.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';
import 'package:praca_inz/presentation/screens/home/profile/widget/user_profile_card.dart';

class ProfileScreenBuilder {
  static Widget build({
    required BuildContext context,
    required UserProfile user,
    required Function() onLogoutButtonClicked,
  }) =>
      SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _userProfileCard(user, onLogoutButtonClicked),
            _completedSessionsCounter(context, user.completedSessions.length),
            Expanded(
              child: ListView(
                children:
                    _completedSessionsCards(context, user.completedSessions),
              ),
            ),
          ],
        ),
      );

  static Widget _userProfileCard(
    UserProfile user,
    Function() onLogoutButtonClicked,
  ) =>
      Padding(
        padding: const EdgeInsets.only(
          left: PaddingDimension.medium,
          right: PaddingDimension.medium,
          bottom: PaddingDimension.medium,
        ),
        child: UserProfileCard(
          firstName: user.firstName,
          lastName: user.lastName,
          groupId: user.groupId,
          onLogoutButtonClicked: onLogoutButtonClicked,
        ),
      );

  static Widget _completedSessionsCounter(
    BuildContext context,
    int sessionsCount,
  ) =>
      Text(
        context.localizations.profileTotalAmountOfSessionsCount(sessionsCount),
        style: context.theme.textTheme.headline3,
        textAlign: TextAlign.center,
      );

  static List<Widget> _completedSessionsCards(
    BuildContext context,
    List<SessionResult> sessions,
  ) =>
      sessions.map((session) => _sessionCard(context, session)).toList();

  static Widget _sessionCard(
    BuildContext context,
    SessionResult sessionResult,
  ) =>
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: PaddingDimension.medium,
            vertical: PaddingDimension.xSmall),
        child: Card(
          elevation: PaddingDimension.small,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  _cardRowContent(context.localizations
                      .profileSessionCardDateOfSession(
                          sessionResult.sessionDate,
                          sessionResult.sessionDate)),
                  _cardRowContent(context.localizations
                      .profileSessionCardNumberOfCompressions(
                          sessionResult.numberOfChestCompressions)),
                  _cardRowContent(context.localizations
                      .profileSessionCardaverageCompressionsRate(sessionResult
                          .averageCompressionsRate
                          .toStringAsFixed(2))),
                ],
              ),
              _gradeColumn(context, sessionResult),
            ],
          ),
        ),
      );

  static Widget _cardRowContent(String text) => Padding(
        padding: const EdgeInsets.all(PaddingDimension.xSmall),
        child: Text(text),
      );

  static Widget _gradeColumn(
          BuildContext context, SessionResult sessionResult) =>
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          context.localizations.profileSessionCardSessionGradeLabel,
          style: context.theme.textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        Text(
          sessionResult.calculateSessionGrade().toStringAsFixed(2),
          style: context.theme.textTheme.headline4,
          textAlign: TextAlign.center,
        ),
      ]);
}
