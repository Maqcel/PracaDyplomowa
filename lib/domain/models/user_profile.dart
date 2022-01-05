import 'package:equatable/equatable.dart';
import 'package:praca_inz/communication/network/dto/user/user_profile_dto.dart';
import 'package:praca_inz/domain/models/session_result.dart';

class UserProfile extends Equatable {
  final String uid;
  final String firstName;
  final String lastName;
  final String groupId;
  final List<SessionResult> completedSessions;

  const UserProfile({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.groupId,
    required this.completedSessions,
  });

  factory UserProfile.fromDTO(UserProfileDTO dto) => UserProfile(
        uid: dto.uid,
        firstName: dto.firstName,
        lastName: dto.lastName,
        groupId: dto.groupId,
        completedSessions: dto.completedSessions
            .map((session) => SessionResult.fromDTO(session))
            .toList(),
      );

  @override
  List<Object> get props => [
        uid,
        firstName,
        lastName,
        groupId,
        completedSessions,
      ];
}
