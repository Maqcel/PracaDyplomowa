import 'package:equatable/equatable.dart';
import 'package:praca_inz/domain/models/session_result.dart';

class UserProfile extends Equatable {
  final String firstName;
  final String lastName;
  final String groupId;
  final List<SessionResult> completedSessions;

  const UserProfile({
    required this.firstName,
    required this.lastName,
    required this.groupId,
    required this.completedSessions,
  });

  @override
  List<Object> get props => [
        firstName,
        lastName,
        groupId,
        completedSessions,
      ];
}
