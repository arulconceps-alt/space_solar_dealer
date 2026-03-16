import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/app/route_names.dart';
import 'package:space_solar_dealer/src/drawer_menu/view/drawer_menu.dart';
import 'package:space_solar_dealer/src/home/bloc/home_bloc.dart';
import 'package:space_solar_dealer/src/home/repo/home_repo.dart';
import 'package:space_solar_dealer/src/home/view/widgets/home_bottom_nav.dart'; // Ensure this import exists
import 'package:space_solar_dealer/src/home/view/widgets/sections.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(repository: HomeRepo())..add(const FetchGamesEvent()),
      child: const HomeViewContent(),
    );
  }
}

class HomeViewContent extends StatefulWidget {
  const HomeViewContent({super.key});

  @override
  State<HomeViewContent> createState() => _HomeViewContentState();
}

class _HomeViewContentState extends State<HomeViewContent> {
  int _selectedIndex = 0;

  /// Main Home Tab Content
  Widget _buildHomeContent() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const HomeHeaderSection(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                WelcomeSection(),
                SizedBox(height: 20),
                GameCategoriesSection(),
                SizedBox(height: 20),
                IplBannerSection(),
                SizedBox(height: 24),
                EnterWorldSection(),
                SizedBox(height: 24),
                FantasySportsSection(),
                SizedBox(height: 24),
                GameCenterSection(),
                SizedBox(height: 20),
                PromoSection(),
                SizedBox(height: 24),
                PureLuckSection(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Games Tab Content (Placeholder)
  Widget _buildGames() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.gamepad_rounded, color: ColorPalette.primary, size: 64),
          SizedBox(height: 16),
          Text(
            'Games',
            style: TextStyle(
              color: ColorPalette.textPrimary,
              fontWeight: FontWeight.w900,
              fontSize: 20,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Coming soon…',
            style: TextStyle(color: ColorPalette.textTertiary, fontSize: 14),
          ),
        ],
      ),
    );
  }

  /// Leaderboard Tab Content (Placeholder)
  Widget _buildLeaderboard() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.emoji_events_rounded,
            color: ColorPalette.primary,
            size: 64,
          ),
          SizedBox(height: 16),
          Text(
            'LEADERBOARD',
            style: TextStyle(
              color: ColorPalette.textPrimary,
              fontWeight: FontWeight.w900,
              fontSize: 20,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Coming soon…',
            style: TextStyle(color: ColorPalette.textTertiary, fontSize: 14),
          ),
        ],
      ),
    );
  }

  /// Profile Tab Content (Now just a background placeholder)
  Widget _buildProfilePlaceholder() {
    return const Scaffold(backgroundColor: ColorPalette.background);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(),
      extendBody: true,
      backgroundColor: ColorPalette.background,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeContent(),
          _buildGames(),
          _buildLeaderboard(),
          _buildProfilePlaceholder(),
        ],
      ),
      bottomNavigationBar: FadeInUp(
        child: HomeBottomNav(
          selectedIndex: _selectedIndex,
          onTap: (index) {
            // DIRECT NAVIGATION: If Profile tab (index 3) is pressed
            if (index == 3) {
              context.pushNamed(RouteName.myAccount);
            } else {
              // Standard tab switching for others
              setState(() => _selectedIndex = index);
            }
          },
        ),
      ),
    );
  }
}
