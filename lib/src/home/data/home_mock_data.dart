/// Mock data for the home page sections.
/// Uses asset paths under [assets/images/home] where assets exist.
library;

class HomeMockData {
  HomeMockData._();

  static const String _base = 'assets/images/home';

  // --- Welcome (Gamerz Bank) - 1st image design ---
  static const String welcomeLine1 = 'Welcome to';
  static const String welcomeLine2 = 'Gamerz Bank';
  static const String welcomeSubtitle = 'One wallet. Endless wins.';
  static const String welcomeDisclaimer = '100% Secure and Trusted Platform...';
  static const String gbLogoPath = '$_base/logo.png';

  // --- Game categories (horizontal row: Card, Sports, Lottery, Casino, Horse) ---
  static const List<GameCategoryItem> gameCategories = [
    GameCategoryItem(label: 'Card', imagePath: '$_base/home_card.png'),
    GameCategoryItem(label: 'Sports', imagePath: '$_base/home_sport.png'),
    GameCategoryItem(label: 'Lottery', imagePath: '$_base/home_lottery.png'),
    GameCategoryItem(label: 'Casino', imagePath: '$_base/home_casino.png'),
    GameCategoryItem(label: 'Horse', imagePath: '$_base/home_horse.png'),
  ];

  // --- IPL section: image slider (3 images) ---
  static const String iplBannerImage = '$_base/home_ipl_logo.png';
  static const List<String> iplSliderImages = [
    '$_base/home_banner_1.jpg',
    '$_base/home_banner_2.jpg',
    '$_base/home_banner_3.jpg',
  ];

  // --- Enter the World of GB ---
  static const String enterWorldTitle = 'Enter the World of GB';
  static const String enterWorldMainBanner = '$_base/home_rummy_banner.png';
  static const String enterWorldMainBannerLabel = 'RUMMY';
  static const String enterWorldCricket = '$_base/home_cricket.jpg';
  static const String enterWorldLottery = '$_base/home_misc_1.jpg';
  static const String enterWorldHorseRacing = '$_base/home_horse_racing.jpg';

  // --- Fantasy Sports ---
  static const String fantasyTitle = 'Fantasy Sports';
  static const String fantasyTagline =
      'Build your team. Play smart. Win real rewards.';
  static const String fantasyBannerLeft = '$_base/home_placeholder_1.jpg';
  static const String fantasyBannerRight = '$_base/home_ipl_logo.png';
  static const String fantasyBannerThird = '$_base/home_placeholder_1.jpg';
  static const String fantasyTabOngoing = 'Ongoing';
  static const String fantasyTabUpcoming = 'Upcoming';
  static const String matchTeamALogo = '$_base/home_team_mi.jpg';
  static const String matchTeamBLogo = '$_base/home_team_csk.png';
  static const String matchTeamAName = 'MI';
  static const String matchTeamBName = 'CSK';
  static const String matchDate = 'Monday, 15 Dec';
  static const String matchCountdownLabel = 'Match Starting In :';
  static const String matchCountdown = '08h : 38m';
  static const String matchCardTopSvg = '$_base/home_game_list_top.svg';
  static const String matchCardBottomSvg = '$_base/home_game_list_bottom.svg';

  // --- Game Center (2x2): order = top-left, top-right, bottom-left, bottom-right ---
  static const String gameCenterTitle = 'Game Center';
  static const String gameCenterTagline =
      'Manage everything you need, right here.';
  static const List<GameCenterItem> gameCenterItems = [
    GameCenterItem(label: 'Leader\nboard', icon: 3),
    GameCenterItem(label: 'Wallet', icon: 1),
    GameCenterItem(label: 'Game\nHistory', icon: 2),
    GameCenterItem(label: 'Levels', icon: 4),
  ];

  // --- Promotional Space ---
  static const String promoTitle = 'Promotional Space';

  // --- Pure Luck - Instant Results ---
  static const String pureLuckTitle = 'Pure Luck - Instant results.';
  static const String pureLuckTagline = 'No strategy. Just spin and see';
  static const List<PureLuckGame> pureLuckGames = [
    PureLuckGame(
      title: 'MORE SLOTS',
      imagePath: '$_base/home_lobby_slots.png',
      playLabel: 'Play Now',
      categoryBanner: 'MORE SLOTS',
    ),
    PureLuckGame(
      title: 'E - GAMING',
      imagePath: '$_base/home_lobby_ezg.png',
      playLabel: 'Play',
      categoryBanner: 'MORE SLOTS',
    ),
    PureLuckGame(
      title: 'MARBLES LOBBY',
      imagePath: '$_base/home_lobby_asg.png',
      playLabel: 'Play Now',
      categoryBanner: 'MARBLES',
    ),
    PureLuckGame(
      title: 'PLAY NOW',
      imagePath: '$_base/home_lobby_marbles.png',
      playLabel: 'Play',
    ),
    PureLuckGame(
      title: 'WINFINITY',
      imagePath: '$_base/home_lobby_win_live.png',
      playLabel: 'Play Now',
      categoryBanner: 'MORE SLOTS',
    ),
    PureLuckGame(
      title: 'ASIA GAMING',
      imagePath: '$_base/home_placeholder_2.jpg',
      playLabel: 'Play',
      categoryBanner: 'MORE SLOTS',
    ),
    PureLuckGame(
      title: 'EZUGI',
      imagePath: '$_base/home_lobby_vivo.png',
      playLabel: 'Play Now',
      categoryBanner: 'MORE SLOTS',
    ),
    PureLuckGame(
      title: 'VIVO GAMING',
      imagePath: '$_base/home_lobby_asg.png',
      playLabel: 'Play',
      categoryBanner: 'MORE SLOTS',
    ),
  ];
}

class GameCategoryItem {
  final String label;
  final String imagePath;
  const GameCategoryItem({required this.label, required this.imagePath});
}

class GameCenterItem {
  final String label;
  final int icon; // 0=lobby, 1=wallet, 2=history, 3=leaderboard
  const GameCenterItem({required this.label, required this.icon});
}

class PureLuckGame {
  final String title;
  final String imagePath;
  final String playLabel;
  final String? categoryBanner;
  const PureLuckGame({
    required this.title,
    required this.imagePath,
    required this.playLabel,
    this.categoryBanner,
  });
}
