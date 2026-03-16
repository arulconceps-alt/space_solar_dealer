import 'package:space_solar_dealer/src/common/models/game_model.dart';

class LotteryRepository {
  // Configuration for dummy data - can be easily replaced with API calls
  static const List<Map<String, dynamic>> _dummyGamesData = [
    {
      'state': 'Kerala',
      'price': '₹40,000',
      'hours': '01h',
      'minutes': '05m',
      'seconds': '20s',
      'image': 'assets/images/icons/state_lottery_01.png',
    },
    {
      'state': 'Goa',
      'price': '₹40,000',
      'hours': '02h',
      'minutes': '10m',
      'seconds': '30s',
      'image': 'assets/images/icons/state_lottery_02.png',
    },
    {
      'state': 'Assam',
      'price': '₹40,000',
      'hours': '01h',
      'minutes': '30m',
      'seconds': '10s',
      'image': 'assets/images/icons/state_lottery_01.png',
    },
  ];

  static const List<Map<String, dynamic>> _dummyHistoryData = [
    {
      'state': 'Kerala',
      'date': '12/03',
      'time': '3 PM',
      'a': '1',
      'b': '2',
      'c': '3',
    },
    {
      'state': 'Goa',
      'date': '12/03',
      'time': '8 PM',
      'a': '5',
      'b': '8',
      'c': '9',
    },
  ];

  static const String _dummyBalance = '5 093.76';

  static const List<String> _dummyStatesData = [
    'All',
    'Arunachal',
    'Assam',
    'Goa',
    'Kerala',
  ];

  static const List<Map<String, dynamic>> _dummyWinnersData = [
    {
      'playerId': '125****',
      'location': 'Coimbatore',
      'prize': '₹40,000',
      'avatarPath': 'assets/images/icons/state_lottery_01.png',
    },
    {
      'playerId': '258****',
      'location': 'Mumbai',
      'prize': '₹35,000',
      'avatarPath': 'assets/images/icons/state_lottery_02.png',
    },
    {
      'playerId': '347****',
      'location': 'Delhi',
      'prize': '₹30,000',
      'avatarPath': 'assets/images/icons/state_lottery_01.png',
    },
  ];

  static const List<Map<String, dynamic>> _dummyQuickActionsData = [
    {
      'title': 'Add Money',
      'subtitle': 'Top up wallet',
      'iconPath': 'assets/images/icons/add_money.png',
    },
    {
      'title': 'My Results',
      'subtitle': 'Check past draws',
      'iconPath': 'assets/images/icons/results.png',
    },
    {
      'title': 'Support',
      'subtitle': 'Help & FAQs',
      'iconPath': 'assets/images/icons/support.png',
    },
  ];

  static const List<Map<String, dynamic>> _dummyFeaturesData = [
    {'label': 'Card', 'imagePath': 'assets/images/home/home_card.png'},
    {'label': 'Sports', 'imagePath': 'assets/images/home/home_sport.png'},
    {'label': 'Lottery', 'imagePath': 'assets/images/home/home_lottery.png'},
    {'label': 'Casino', 'imagePath': 'assets/images/home/home_casino.png'},
    {'label': 'Horse', 'imagePath': 'assets/images/home/home_horse.png'},
  ];

  static const List<Map<String, dynamic>> _dummyYzabcGamesData = [
    {
      'state': 'Arunachal',
      'price': '₹40,000',
      'hours': '01h',
      'minutes': '00m',
      'seconds': '00s',
      'image': 'assets/images/icons/state_lottery_01.png',
    },
    {
      'state': 'Kerala',
      'price': '₹40,000',
      'hours': '02h',
      'minutes': '00m',
      'seconds': '00s',
      'image': 'assets/images/icons/state_lottery_02.png',
    },
  ];

  /// Fetches available lottery states.
  /// In a real app, this would call: GET /api/states
  Future<List<String>> getAvailableStates() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // TODO: Replace with API call
    // final response = await _apiClient.get('/states');
    // return response.data.map((state) => state['name'] as String).toList();

    return _dummyStatesData;
  }

  /// Fetches the user's balance.
  /// In a real app, this would call: GET /api/user/balance
  Future<String> getBalance() async {
    await Future.delayed(const Duration(milliseconds: 400));

    // TODO: Replace with API call
    // final response = await _apiClient.get('/user/balance');
    // return response.data['balance'] as String;

    return _dummyBalance;
  }

  /// Fetches yesterday's winners.
  /// In a real app, this would call: GET /api/winners
  Future<List<LotteryWinnerModel>> getWinners() async {
    await Future.delayed(const Duration(milliseconds: 600));

    // TODO: Replace with API call
    // final response = await _apiClient.get('/winners');
    // return response.data.map((json) => LotteryWinnerModel.fromJson(json)).toList();

    return _dummyWinnersData
        .map((json) => LotteryWinnerModel.fromJson(json))
        .toList();
  }

  /// Fetches quick action items for the home screen.
  /// In a real app, this would call: GET /api/quick-actions
  Future<List<LotteryQuickActionModel>> getQuickActions() async {
    await Future.delayed(const Duration(milliseconds: 600));

    // TODO: Replace with API call
    // final response = await _apiClient.get('/quick-actions');
    // return response.data.map((json) => LotteryQuickActionModel.fromJson(json)).toList();

    return _dummyQuickActionsData
        .map((json) => LotteryQuickActionModel.fromJson(json))
        .toList();
  }

  /// Fetches feature grid items.
  /// In a real app, this would call: GET /api/features
  Future<List<LotteryFeatureModel>> getFeatures() async {
    await Future.delayed(const Duration(milliseconds: 600));

    // TODO: Replace with API call
    // final response = await _apiClient.get('/features');
    // return response.data.map((json) => LotteryFeatureModel.fromJson(json)).toList();

    return _dummyFeaturesData
        .map((json) => LotteryFeatureModel.fromJson(json))
        .toList();
  }

  /// Fetches YZABC game list.
  /// In a real app, this would call: GET /api/yzabc-games
  Future<List<GameModel>> getYzabcGames() async {
    await Future.delayed(const Duration(milliseconds: 800));

    // TODO: Replace with API call
    // final response = await _apiClient.get('/yzabc-games');
    // return response.data.map((json) => GameModel.fromJson(json)).toList();

    return _dummyYzabcGamesData
        .map((json) => GameModel.fromJson(json))
        .toList();
  }

  /// Fetches lottery games with optional filtering.
  /// In a real app, this would call: GET /api/games?state={state}&limit={limit}
  Future<List<GameModel>> getGames({
    String? stateFilter,
    int? limit,
    bool? activeOnly,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // TODO: Replace with API call
    // final queryParams = {
    //   if (stateFilter != null && stateFilter != 'All') 'state': stateFilter,
    //   if (limit != null) 'limit': limit.toString(),
    //   if (activeOnly != null) 'active': activeOnly.toString(),
    // };
    // final response = await _apiClient.get('/games', queryParameters: queryParams);
    // return response.data.map((json) => GameModel.fromJson(json)).toList();

    var gamesData = _dummyGamesData;

    // Apply filters
    if (stateFilter != null && stateFilter != 'All') {
      gamesData = gamesData
          .where((game) => game['state'] == stateFilter)
          .toList();
    }

    if (limit != null) {
      gamesData = gamesData.take(limit).toList();
    }

    return gamesData.map((json) => GameModel.fromJson(json)).toList();
  }

  /// Fetches lottery history with optional filtering and pagination.
  /// In a real app, this would call: GET /api/history?state={state}&page={page}&limit={limit}
  Future<List<LotteryHistoryModel>> getHistory({
    String? stateFilter,
    int? page,
    int? limit,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // TODO: Replace with API call
    // final queryParams = {
    //   if (stateFilter != null && stateFilter != 'All') 'state': stateFilter,
    //   if (page != null) 'page': page.toString(),
    //   if (limit != null) 'limit': limit.toString(),
    //   if (fromDate != null) 'from_date': fromDate.toIso8601String(),
    //   if (toDate != null) 'to_date': toDate.toIso8601String(),
    // };
    // final response = await _apiClient.get('/history', queryParameters: queryParams);
    // return response.data.map((json) => LotteryHistoryModel.fromJson(json)).toList();

    var historyData = _dummyHistoryData;

    // Apply filters
    if (stateFilter != null && stateFilter != 'All') {
      historyData = historyData
          .where((item) => item['state'] == stateFilter)
          .toList();
    }

    // Apply pagination
    if (page != null && limit != null) {
      final startIndex = (page - 1) * limit;
      final endIndex = startIndex + limit;
      if (startIndex < historyData.length) {
        historyData = historyData.sublist(
          startIndex,
          endIndex > historyData.length ? historyData.length : endIndex,
        );
      } else {
        historyData = [];
      }
    }

    return historyData
        .map((json) => LotteryHistoryModel.fromJson(json))
        .toList();
  }

  /// Fetches a specific game by ID or state.
  /// In a real app, this would call: GET /api/games/{id}
  Future<GameModel?> getGameById(String gameId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    // TODO: Replace with API call
    // final response = await _apiClient.get('/games/$gameId');
    // return response.data != null ? GameModel.fromJson(response.data) : null;

    // For dummy data, find by state (since we don't have IDs)
    final gameData = _dummyGamesData.firstWhere(
      (game) => game['state'] == gameId,
      orElse: () => {},
    );

    return gameData.isNotEmpty ? GameModel.fromJson(gameData) : null;
  }

  /// Searches games by query.
  /// In a real app, this would call: GET /api/games/search?q={query}
  Future<List<GameModel>> searchGames(String query) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // TODO: Replace with API call
    // final response = await _apiClient.get('/games/search', queryParameters: {'q': query});
    // return response.data.map((json) => GameModel.fromJson(json)).toList();

    final lowercaseQuery = query.toLowerCase();
    final filteredData = _dummyGamesData.where((game) {
      final state = game['state'].toString().toLowerCase();
      return state.contains(lowercaseQuery);
    }).toList();

    return filteredData.map((json) => GameModel.fromJson(json)).toList();
  }
}
