class WithdrawRepository {
  /// Simulates a withdraw call.
  /// In a real app, this would call your remote API.
  Future<void> withdraw({
    required String method,
    required String amount,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // Throw in some validation errors for demonstration
    final value = double.tryParse(amount);
    if (value == null || value <= 0) {
      throw Exception('Enter a valid amount');
    }
    if (value < 100) {
      throw Exception('Minimum withdraw amount is ₹100');
    }
  }
}
