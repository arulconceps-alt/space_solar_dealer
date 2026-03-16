import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/common/models/game_model.dart';
import 'package:space_solar_dealer/src/lottery/view/widgets/result_inner_screen.dart';

class LotteryHistoryCard extends StatelessWidget {
  final String selectedState;
  final List<LotteryHistoryModel> historyData;

  const LotteryHistoryCard({
    super.key,
    required this.selectedState,
    required this.historyData,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> statesToShow = selectedState == "All"
        ? historyData.map((e) => e.state).toSet().toList()
        : [selectedState];

    if (statesToShow.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "No history available",
            style: TextStyle(color: Colors.grey, fontFamily: 'DM Sans'),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: statesToShow.length,
      itemBuilder: (context, stateIndex) {
        final currentState = statesToShow[stateIndex];
        final stateFilteredData = historyData
            .where((item) => item.state == currentState)
            .toList();

        if (stateFilteredData.isEmpty) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Color(0xFF313038),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.stars,
                      color: Colors.amber,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "$currentState Lottery",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildMoreButton(context, currentState),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: const Color(0xFF24232A),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildResponsiveRow(
                      isHeader: true,
                      date: 'Date',
                      time: 'Time',
                      a: 'A',
                      b: 'B',
                      c: 'C',
                    ),
                    ...stateFilteredData.asMap().entries.map((entry) {
                      int index = entry.key;
                      var item = entry.value;
                      bool isLast = index == stateFilteredData.length - 1;

                      return Column(
                        children: [
                          _buildResponsiveRow(
                            isHeader: false,
                            date: item.date,
                            time: item.time,
                            a: item.a,
                            b: item.b,
                            c: item.c,
                          ),
                          if (!isLast)
                            Divider(
                              height: 1,
                              indent: 16,
                              endIndent: 16,
                              color: Colors.white.withOpacity(0.05),
                            ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMoreButton(BuildContext context, String stateName) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ResultInnerScreen(
              stateName: stateName,
              historyData: historyData,
            ),
          ),
        );
      },
      child: Container(
        // 2. Padding makes the "hit area" larger and easier to click
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF24232A),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'More',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveRow({
    required bool isHeader,
    required String date,
    required String time,
    required String a,
    required String b,
    required String c,
  }) {
    final textStyle = TextStyle(
      color: isHeader ? Colors.white70 : const Color(0xFF9F9F9F),
      fontSize: 13,
      fontFamily: 'DM Sans',
      fontWeight: isHeader ? FontWeight.w500 : FontWeight.w600,
    );

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: isHeader
          ? const BoxDecoration(color: Color(0xFF313038))
          : null,
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(date, style: textStyle)),
          Expanded(flex: 2, child: Text(time, style: textStyle)),
          const Spacer(),
          _buildLetterBox(a, isHeader: isHeader),
          const SizedBox(width: 8),
          _buildLetterBox(b, isHeader: isHeader),
          const SizedBox(width: 8),
          _buildLetterBox(c, isHeader: isHeader),
        ],
      ),
    );
  }

  Widget _buildLetterBox(String text, {required bool isHeader}) {
    return Container(
      width: 26,
      height: 26,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isHeader ? const Color(0xFF1C1B20) : const Color(0xFF313038),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
