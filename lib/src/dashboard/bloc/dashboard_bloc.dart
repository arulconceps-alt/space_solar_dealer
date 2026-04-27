/*
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';



class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepositary repository;

  DashboardBloc({required this.repository}) : super(const HomeState()) {
    on<FetchGamesEvent>((event, emit) async {
      emit(state.copyWith(status: DashboardStatus.loading));
      try {
        final categories = await repository.getCategories();
        final games = await repository.getGames();
        emit(
          state.copyWith(
            status: DashboardStatus.loaded,
            categories: categories,
            games: games,
          ),
        );
      } catch (e) {
        emit(state.copyWith(status: DashboardStatus.error, message: e.toString()));
      }
    });
  }
}

*/
