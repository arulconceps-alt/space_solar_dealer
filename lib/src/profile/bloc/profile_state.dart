import 'package:space_solar_dealer/src/common/models/profile_model.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState {
  final ProfileStatus status;
  final ProfileModel? profile;
  final String message;

  ProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.message = '',
  });

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileModel? profile,
    String? message,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      message: message ?? this.message,
    );
  }
}