abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final Map<String, dynamic> body;

  UpdateProfileEvent(this.body);
}