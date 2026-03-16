import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/lottery_game/view/widgets/chips_horizontal_row.dart';
import 'package:space_solar_dealer/src/common/widgets/lottery_top_bar.dart';
import 'package:space_solar_dealer/src/lottery_game/view/widgets/lottery_footer_bar.dart';
import 'package:space_solar_dealer/src/lottery_game/view/widgets/lottery_info_card.dart';
import 'package:space_solar_dealer/src/lottery_game/view/widgets/lottery_number_card.dart';
import 'package:space_solar_dealer/src/lottery_game/view/widgets/lottery_number_card_double.dart';
import 'package:space_solar_dealer/src/lottery_game/view/widgets/my_number_cart_view.dart';

class LotteryGameScreen extends StatefulWidget {
  final String stateName;
  const LotteryGameScreen({super.key, required this.stateName});

  @override
  State<LotteryGameScreen> createState() => _LotteryGameScreenState();
}

class _LotteryGameScreenState extends State<LotteryGameScreen> {
  String selectedTime = "02:00 PM";
  double _totalPrice = 0.0;
  int _totalCount = 0;
  bool isCartVisible = false;
  List<SelectedLotteryNumber> myItems = [];

  void _handleAddition(
    String letter,
    String value,
    int qty,
    double pricePerUnit,
  ) {
    setState(() {
      _totalCount += qty;
      _totalPrice += (pricePerUnit * qty);

      myItems.add(
        SelectedLotteryNumber(
          label: "$letter=$value",
          price: "₹${pricePerUnit.toStringAsFixed(1)}",
          quantity: qty,
        ),
      );
    });
  }

  void _handleClearAll() {
    setState(() {
      _totalPrice = 0.0;
      _totalCount = 0;
      myItems.clear();
      // Auto-switch back to game view when cart is cleared
      isCartVisible = false;
    });
  }

  void _handleDeleteItem(int index) {
    setState(() {
      final item = myItems[index];
      double unitPrice = double.tryParse(item.price.replaceAll('₹', '')) ?? 0.0;

      _totalCount -= item.quantity;
      _totalPrice -= (unitPrice * item.quantity);
      myItems.removeAt(index);

      // Auto-switch back to game view if the last item was deleted
      if (myItems.isEmpty) {
        isCartVisible = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1A1F),
      bottomNavigationBar: LotteryFooterBar(
        totalAmount: _totalPrice,
        totalNumbers: _totalCount,
        // Only allow toggling if there are items in the cart
        onToggle: () {
          if (myItems.isNotEmpty) {
            setState(() => isCartVisible = !isCartVisible);
          }
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              _buildTopBar(),
              const SizedBox(height: 16),
              ChipsHorizontalRow(
                times: const ["02:00 PM", "03:00 PM", "05:00 PM", "10:00 AM"],
                onTimeSelected: (time) => setState(() => selectedTime = time),
              ),
              const SizedBox(height: 16),
              LotteryInfoCard(drawTime: selectedTime),
              const SizedBox(height: 16),

              if (!isCartVisible) ...[
                // --- GAME SELECTION VIEW ---
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    children: [
                      LotteryNumberCard(onAdd: _handleAddition),
                      const SizedBox(height: 16),
                      LotteryNumberCardDouble(
                        lotteryType: "Double Digit",
                        prize: "Win ₹1000",
                        ticketPrice: "₹100",
                        onAdd: _handleAddition,
                        rows: const [
                          ["A", "B"],
                          ["A", "C"],
                          ["B", "C"],
                        ],
                      ),
                    ],
                  ),
                ),
              ] else ...[
                // --- CART / SUMMARY VIEW ---
                Expanded(
                  child: MyNumberSummaryView(
                    selectedNumbers: myItems,
                    onClearAll: _handleClearAll,
                    onDeleteItem: _handleDeleteItem,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return LotteryTopBar(
      title: "${widget.stateName} Game",
      leftIcon: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      rightIcon: Image.asset(
        "assets/images/bottom_icons/navi_favourites.png",
        width: 22,
        height: 22,
        color: ColorPalette.primary, // optional if you want white color
      ),
    );
  }
}
