import 'package:json_annotation/json_annotation.dart';
import 'package:praca_inz/communication/network/dto/session/session_result_dto.dart';

part 'user_profile_dto.g.dart';

@JsonSerializable()
class UserProfileDTO {
  @JsonKey(name: 'uid')
  final String uid;

  @JsonKey(name: 'firstName')
  final String firstName;

  @JsonKey(name: 'lastName')
  final String lastName;

  @JsonKey(name: 'groupId')
  final String groupId;

  @JsonKey(name: 'completedSessions')
  final List<SessionResultDTO> completedSessions;

  UserProfileDTO({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.groupId,
    required this.completedSessions,
  });

  factory UserProfileDTO.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileDTOToJson(this);
}
