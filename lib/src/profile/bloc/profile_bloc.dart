
import 'package:bloc/bloc.dart';
import 'package:space_solar_dealer/src/profile/bloc/profile_event.dart';
import 'package:space_solar_dealer/src/profile/bloc/profile_state.dart';
import 'package:space_solar_dealer/src/profile/repo/profile_repositary.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repo;

  ProfileBloc(this.repo) : super(ProfileState()) {
    on<LoadProfileEvent>(_loadProfile);
    on<UpdateProfileEvent>(_updateProfile);
  }

  Future<void> _loadProfile(
      LoadProfileEvent event,
      Emitter<ProfileState> emit,
      ) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final profile = await repo.getProfile();

      emit(state.copyWith(
        status: ProfileStatus.success,
        profile: profile,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _updateProfile(
      UpdateProfileEvent event,
      Emitter<ProfileState> emit,
      ) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      await repo.updateProfile(event.body);

      final profile = await repo.getProfile(); // refresh

      emit(state.copyWith(
        status: ProfileStatus.success,
        profile: profile,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.failure,
        message: e.toString(),
      ));
    }
  }
}