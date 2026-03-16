import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_solar_dealer/src/common/models/game_model.dart';
import 'package:logger/logger.dart';
import 'package:space_solar_dealer/src/lottery/repo/lottery_repository.dart';

part 'lottery_event.dart';
part 'lottery_state.dart';

class LotteryBloc extends Bloc<LotteryEvent, LotteryState> {
  LotteryBloc({required LotteryRepository repository})
    : _repository = repository,
      super(LotteryState.initial) {
    on<InitializeLottery>(_onInitialize);
    on<SelectState>(_onSelectState);
    on<SelectTab>(_onSelectTab);
    on<LoadGames>(_onLoadGames);
    on<LoadHistory>(_onLoadHistory);
    on<ResetLotteryMessage>(_onReset);
  }

  final LotteryRepository _repository;
  final _log = Logger();

  Future<void> _onInitialize(
    InitializeLottery event,
    Emitter<LotteryState> emit,
  ) async {
    _log.d('LotteryBloc::_onInitialize::Initializing lottery');
    try {
      emit(state.copyWith(status: () => LotteryStatus.loading));

      // Load all data in parallel for better performance
      final results = await Future.wait([
        _repository.getAvailableStates(),
        _repository.getBalance(),
        _repository.getGames(stateFilter: state.selectedState),
        _repository.getYzabcGames(),
        _repository.getHistory(stateFilter: state.selectedState),
        _repository.getWinners(),
        _repository.getQuickActions(),
        _repository.getFeatures(),
      ]);

      final availableStates = results[0] as List<String>;
      final balance = results[1] as String;
      final games = results[2] as List<GameModel>;
      final yzabcGames = results[3] as List<GameModel>;
      final history = results[4] as List<LotteryHistoryModel>;
      final winners = results[5] as List<LotteryWinnerModel>;
      final quickActions = results[6] as List<LotteryQuickActionModel>;
      final features = results[7] as List<LotteryFeatureModel>;

      emit(
        state.copyWith(
          status: () => LotteryStatus.loaded,
          balance: () => balance,
          availableStates: () => availableStates,
          games: () => games,
          yzabcGames: () => yzabcGames,
          history: () => history,
          winners: () => winners,
          quickActions: () => quickActions,
          features: () => features,
          message: () => 'Lottery initialized successfully',
        ),
      );
    } catch (e) {
      _log.e('LotteryBloc::_onInitialize::Error: $e');
      emit(
        state.copyWith(
          status: () => LotteryStatus.failure,
          message: () => e.toString(),
        ),
      );
    }
  }

  Future<void> _onSelectState(
    SelectState event,
    Emitter<LotteryState> emit,
  ) async {
    emit(
      state.copyWith(
        status: () => LotteryStatus.loading,
        selectedState: () => event.state,
      ),
    );

    try {
      final games = await _repository.getGames(stateFilter: event.state);
      final history = await _repository.getHistory(stateFilter: event.state);

      emit(
        state.copyWith(
          status: () => LotteryStatus.loaded,
          games: () => games,
          history: () => history,
        ),
      );
    } catch (e) {
      _log.e('LotteryBloc::_onSelectState::Error: $e');
      emit(
        state.copyWith(
          status: () => LotteryStatus.failure,
          message: () => e.toString(),
        ),
      );
    }
  }

  void _onSelectTab(SelectTab event, Emitter<LotteryState> emit) {
    emit(state.copyWith(currentTabIndex: () => event.tabIndex));
  }

  Future<void> _onLoadGames(LoadGames event, Emitter<LotteryState> emit) async {
    try {
      emit(state.copyWith(status: () => LotteryStatus.loading));
      final games = await _repository.getGames(
        stateFilter: state.selectedState,
      );
      emit(
        state.copyWith(status: () => LotteryStatus.loaded, games: () => games),
      );
    } catch (e) {
      _log.e('LotteryBloc::_onLoadGames::Error: $e');
      emit(
        state.copyWith(
          status: () => LotteryStatus.failure,
          message: () => e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoadHistory(
    LoadHistory event,
    Emitter<LotteryState> emit,
  ) async {
    try {
      emit(state.copyWith(status: () => LotteryStatus.loading));
      final history = await _repository.getHistory(
        stateFilter: state.selectedState,
      );
      emit(
        state.copyWith(
          status: () => LotteryStatus.loaded,
          history: () => history,
        ),
      );
    } catch (e) {
      _log.e('LotteryBloc::_onLoadHistory::Error: $e');
      emit(
        state.copyWith(
          status: () => LotteryStatus.failure,
          message: () => e.toString(),
        ),
      );
    }
  }

  void _onReset(ResetLotteryMessage event, Emitter<LotteryState> emit) {
    emit(state.copyWith(message: () => ''));
  }
}
