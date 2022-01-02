import 'package:equatable/equatable.dart';
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

  @override
  List<Object> get props => [
        uid,
        firstName,
        lastName,
        groupId,
        completedSessions,
      ];
}
