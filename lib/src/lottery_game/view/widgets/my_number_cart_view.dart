import 'package:flutter/material.dart';

class SelectedLotteryNumber {
  final String label;
  final String price;
  final int quantity;

  SelectedLotteryNumber({
    required this.label,
    required this.price,
    required this.quantity,
  });
}

class MyNumberSummaryView extends StatelessWidget {
  final VoidCallback onClearAll;
  final List<SelectedLotteryNumber> selectedNumbers;
  final Function(int) onDeleteItem;

  const MyNumberSummaryView({
    super.key,
    required this.onClearAll,
    required this.selectedNumbers,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 515,
      decoration: const BoxDecoration(
        color: Color(0xFF24232A),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildHeader(context), // Added context here
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 12,
                  runSpacing: 16,
                  children: List.generate(
                    selectedNumbers.length,
                    (index) =>
                        _buildExactNumberBox(context, index), // Added context
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 24),
          const Text(
            'My Number',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: () => showDeletePopup(context, onClearAll),
            child: const Icon(Icons.delete, color: Color(0xFF9F9F9F)),
          ),
        ],
      ),
    );
  }

  Widget _buildExactNumberBox(BuildContext context, int index) {
    final item = selectedNumbers[index];
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 114,
          height: 34,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF313038),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                item.price,
                style: const TextStyle(color: Colors.white, fontSize: 11),
              ),
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFFCDB75D),
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.center,
                child: Text(
                  'x${item.quantity}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -4,
          right: -4,
          child: GestureDetector(
            onTap: () => showDeletePopup(context, () => onDeleteItem(index)),
            child: Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                color: Color(0xFFD9D9D9),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.black, size: 8),
            ),
          ),
        ),
      ],
    );
  }
}

void showDeletePopup(BuildContext context, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        // InsetPadding removes the default dialog margins that cause overflows
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          // Use constraints instead of fixed width to prevent overflow
          constraints: const BoxConstraints(maxWidth: 340),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: ShapeDecoration(
            color: const Color(0xFF24232A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Shrinks height to fit content
            children: [
              const Text(
                'Delete',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w600,
                  height: 1.30,
                  letterSpacing: -0.18,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please confirm you want to clear all numbers?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w400,
                  height: 1.30,
                  letterSpacing: -0.12,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  // Use Expanded so buttons fill available space without overflowing
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF313038),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        onConfirm();
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
