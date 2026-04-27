/*
import 'package:gb_lottery/src/common/constants/constansts.dart';
import 'package:gb_lottery/src/common/models/category_model.dart';
import 'package:gb_lottery/src/common/models/game_model.dart';
import 'package:gb_lottery/src/common/repos/api_repository.dart';
import 'package:gb_lottery/src/home/data/home_mock_data.dart';

class HomeRepo {
  final ApiRepository _apiRepository;

  HomeRepo(this._apiRepository);

  Future<List<CategoryModel>> getCategories() async {
    try {
      await _apiRepository.getRequest(Constants.api.getCategories); // Using new getRequest method
      return HomeMockData.gameCategories.map((item) {
        return CategoryModel(
          id: item.label.toLowerCase(),
          name: item.label,
          imagePath: item.imagePath,
        );
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<GameModel>> getGames() async {
    try {
      await _apiRepository.getRequest(Constants.api.getGames); // Using new getRequest method
      // Return some dummy games from LotteryRepository or similar
      return [
        const GameModel(
          state: 'Kerala',
          price: '₹40,000',
          hours: '01h',
          minutes: '05m',
          seconds: '20s',
          image: 'assets/images/home/home_lottery.webp',
        ),
        const GameModel(
          state: 'Goa',
          price: '₹40,000',
          hours: '02h',
          minutes: '10m',
          seconds: '30s',
          image: 'assets/images/home/home_lottery.webp',
        ),
      ];
    } catch (e) {
      rethrow;
    }
  }
}
*/
