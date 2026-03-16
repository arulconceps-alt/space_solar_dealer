import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_solar_dealer/src/common/models/game_model.dart';
import 'package:space_solar_dealer/src/home/view/widgets/pure_luck_section.dart';
import 'package:space_solar_dealer/src/lottery/bloc/lottery_bloc.dart';
import 'package:space_solar_dealer/src/lottery/repo/lottery_repository.dart';
import 'package:space_solar_dealer/src/lottery/view/widgets/chips_horizontal_row.dart';
import 'package:space_solar_dealer/src/lottery/view/widgets/fantasy_sports.dart';
import 'package:space_solar_dealer/src/lottery/view/widgets/game_section.dart';
import 'package:space_solar_dealer/src/lottery/view/widgets/lottery_banner_section.dart';
import 'package:space_solar_dealer/src/lottery/view/widgets/lottery_bottom_navbar.dart';
import 'package:space_solar_dealer/src/lottery/view/widgets/lottery_result_card.dart';
import 'package:space_solar_dealer/src/lottery/view/widgets/quick_actions_row.dart';
import 'package:space_solar_dealer/src/lottery/view/widgets/topAppbar.dart';
import 'package:space_solar_dealer/src/lottery/view/widgets/whats_in_gb_section.dart';
import 'package:space_solar_dealer/src/lottery/view/widgets/winners_section.dart';
import 'package:space_solar_dealer/src/lottery/view/widgets/yzabc_game_section.dart';

class LotteryHome extends StatelessWidget {
  const LotteryHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          LotteryBloc(repository: LotteryRepository())
            ..add(const InitializeLottery()),
      child: Scaffold(
        backgroundColor: const Color(0xFF1B1A1F),
        body: BlocBuilder<LotteryBloc, LotteryState>(
          builder: (context, state) {
            final bloc = context.read<LotteryBloc>();

            if (state.status == LotteryStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == LotteryStatus.failure) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    state.message.isNotEmpty
                        ? state.message
                        : 'Something went wrong. Please try again.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            }

            return Column(
              children: [
                BlocSelector<LotteryBloc, LotteryState, String>(
                  selector: (state) => state.balance,
                  builder: (context, balance) => TopAppBar(
                    balance: balance,
                    onAddPressed: () => debugPrint('Add money clicked'),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      const SizedBox(height: 16),
                      const LotteryBannerSection(),
                      const SizedBox(height: 16),
                      BlocSelector<
                        LotteryBloc,
                        LotteryState,
                        (String, List<String>)
                      >(
                        selector: (state) =>
                            (state.selectedState, state.availableStates),
                        builder: (context, selectedTuple) {
                          final bloc = context.read<LotteryBloc>();
                          return ChipsHorizontalRow(
                            selectedState: selectedTuple.$1,
                            chips: selectedTuple.$2,
                            onSelected: (state) =>
                                bloc.add(SelectState(state: state)),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      BlocSelector<
                        LotteryBloc,
                        LotteryState,
                        (
                          int,
                          String,
                          List<GameModel>,
                          List<LotteryHistoryModel>,
                        )
                      >(
                        selector: (state) => (
                          state.currentTabIndex,
                          state.selectedState,
                          state.games,
                          state.history,
                        ),
                        builder: (context, gameData) {
                          final (tabIndex, selectedState, games, history) =
                              gameData;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: tabIndex == 2
                                ? LotteryHistoryCard(
                                    selectedState: selectedState,
                                    historyData: history,
                                  )
                                : AbcGameSection(
                                    selectedState: selectedState,
                                    games: games,
                                  ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: WinnersSection(),
                      ),
                      const SizedBox(height: 16),
                      const QuickActionsRow(),
                      const SizedBox(height: 16),
                      BlocSelector<LotteryBloc, LotteryState, List<GameModel>>(
                        selector: (state) => state.yzabcGames,
                        builder: (context, yzabcGames) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: YzabcGameSection(games: yzabcGames),
                        ),
                      ),
                      const SizedBox(height: 16),
                      BlocSelector<
                        LotteryBloc,
                        LotteryState,
                        List<LotteryFeatureModel>
                      >(
                        selector: (state) => state.features,
                        builder: (context, features) =>
                            WhatsInGbSection(features: features),
                      ),
                      const SizedBox(height: 16),
                      FantasySports(),
                      const SizedBox(height: 16),
                      const PureLuckSection(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: BlocSelector<LotteryBloc, LotteryState, int>(
          selector: (state) => state.currentTabIndex,
          builder: (context, currentTabIndex) {
            final bloc = context.read<LotteryBloc>();
            return LotteryBottomNavBar(
              currentIndex: currentTabIndex,
              onTabSelected: (index) => bloc.add(SelectTab(tabIndex: index)),
            );
          },
        ),
      ),
    );
  }
}
