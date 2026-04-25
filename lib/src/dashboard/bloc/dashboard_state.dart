/*
part of "home_bloc.dart";

enum DashboardStatus { initial, loading, loaded, error }

class DashboardState extends Equatable {
  final HomeStatus status;
  final List<CategoryModel> categories;
  final List<GameModel> games;
  final String message;

  const DashboardState({
    this.status = HomeStatus.initial,
    this.categories = const [],
    this.games = const [],
    this.message = '',
  });

  DashboardState copyWith({
    HomeStatus? status,
    List<CategoryModel>? categories,
    List<GameModel>? games,
    String? message,
  }) {
    return DashboardState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      games: games ?? this.games,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, categories, games, message];
}

*/
