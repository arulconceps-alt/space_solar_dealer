import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:space_solar_dealer/src/home/repo/home_repo.dart';

part "home_event.dart";
part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepo repository;

  HomeBloc({required this.repository}) : super(const HomeInitial()) {
    on<FetchGamesEvent>((event, emit) async {
      emit(const HomeLoading());
      try {} catch (e) {}
    });
  }
}
