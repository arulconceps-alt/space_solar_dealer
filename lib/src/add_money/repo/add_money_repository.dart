import 'package:space_solar_dealer/src/common/models/add_money_model.dart';

class AddMoneyRepository {
  /// Simulates fetching available promos.
  /// In a real app, this would call your remote API.
  Future<List<PromoModel>> getPromos() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // Return dummy promos
    return [
      PromoModel.fromJson({
        'code': 'JEETBONUS',
        'description': 'Get 100% Cashback upto ₹5000 in Bonus wallet.',
        'minDeposit': '₹5000',
        'validity': '2 times per user.',
      }),
    ];
  }

  /// Simulates validating and proceeding with payment.
  /// In a real app, this would initiate payment flow.
  Future<void> proceedToPay({required String amount, String? promoCode}) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // Throw in some validation errors for demonstration
    final value = double.tryParse(amount);
    if (value == null || value <= 0) {
      throw Exception('Enter a valid amount');
    }
    if (value < 10) {
      throw Exception('Minimum add amount is ₹10');
    }
    // Success - in real app, this would redirect to payment gateway
  }
}
