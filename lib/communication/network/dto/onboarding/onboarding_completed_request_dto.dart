import 'package:json_annotation/json_annotation.dart';

part 'onboarding_completed_request_dto.g.dart';

@JsonSerializable(createFactory: false)
class OnboardingCompletedRequestDTO {
  final String firstName;
  final String lastName;
  final String groupId;

  OnboardingCompletedRequestDTO({
    required this.firstName,
    required this.lastName,
    required this.groupId,
  });

  Map<String, dynamic> toJson() => _$OnboardingCompletedRequestDTOToJson(this);
}
