import 'dart:async';
import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/common/models/game_model.dart';
import 'package:space_solar_dealer/src/common/widgets/lottery_top_bar.dart';

class ResultInnerScreen extends StatefulWidget {
  final String stateName;
  final List<LotteryHistoryModel> historyData;

  const ResultInnerScreen({
    super.key,
    required this.stateName,
    required this.historyData,
  });

  @override
  State<ResultInnerScreen> createState() => _ResultInnerScreenState();
}

class _ResultInnerScreenState extends State<ResultInnerScreen> {
  int _currentPage = 1;
  final int _rowsPerPage = 10;

  // Timer State
  Timer? _timer;
  Duration _duration = const Duration(hours: 1, minutes: 25, seconds: 40);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_duration.inSeconds > 0) {
        setState(() => _duration -= const Duration(seconds: 1));
      } else {
        _timer?.cancel();
      }
    });
  }

  // Helper to format duration into digits
  List<String> _getTimerDigits() {
    String h = _duration.inHours.toString().padLeft(2, '0');
    String m = (_duration.inMinutes % 60).toString().padLeft(2, '0');
    String s = (_duration.inSeconds % 60).toString().padLeft(2, '0');
    // Returns [H1, H2, M1, M2, S1, S2]
    return [...h.split(''), ...m.split(''), ...s.split('')];
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = widget.historyData
        .where((e) => e.state == widget.stateName)
        .toList();

    final int totalItems = filteredData.length;
    final int totalPages = (totalItems / _rowsPerPage).ceil();
    final int startIndex = (_currentPage - 1) * _rowsPerPage;
    final int endIndex = (startIndex + _rowsPerPage > totalItems)
        ? totalItems
        : startIndex + _rowsPerPage;

    final currentTablePage = filteredData.sublist(startIndex, endIndex);

    return Scaffold(
      backgroundColor: const Color(0xFF1C1B20),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTopBar(),
            const SizedBox(height: 16),
            _buildFigmaHeader(),
            const SizedBox(height: 24),
            Container(
              width: 343,
              decoration: ShapeDecoration(
                color: const Color(0xFF24232A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  _buildTableRow(
                    isHeader: true,
                    date: 'Date',
                    time: 'Time',
                    a: 'A',
                    b: 'B',
                    c: 'C',
                  ),
                  ...currentTablePage.map(
                    (item) => Column(
                      children: [
                        _buildTableRow(
                          isHeader: false,
                          date: item.date,
                          time: item.time,
                          a: item.a,
                          b: item.b,
                          c: item.c,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.white.withOpacity(0.05),
                        ),
                      ],
                    ),
                  ),
                  _buildPaginationRow(totalItems, totalPages),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFigmaHeader() {
    final digits = _getTimerDigits();
    return Container(
      width: 344,
      height: 147,
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: const Color(0xFF313038),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const ShapeDecoration(
                  color: Color(0xFF24232A),
                  shape: OvalBorder(),
                ),
                child: const Icon(
                  Icons.auto_graph,
                  color: Colors.amber,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.stateName} Lottery',
                      style: _textStyle(
                        16,
                        Colors.white,
                        FontWeight.w600,
                        italic: true,
                      ),
                    ),
                    Text(
                      'Draw Result',
                      style: _textStyle(
                        12,
                        const Color(0xFF9F9F9F),
                        FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              _buildActionBtn('Play Now'),
            ],
          ),
          Container(
            width: 320,
            height: 58,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: ShapeDecoration(
              color: const Color(0xFF24232A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Draw',
                      style: _textStyle(
                        12,
                        const Color(0xFF9F9F9F),
                        FontWeight.w400,
                      ),
                    ),
                    Text(
                      '03.00 PM',
                      style: _textStyle(12, Colors.white, FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    _buildDigitBox(digits[0]),
                    const SizedBox(width: 4),
                    _buildDigitBox(digits[1]),
                    _buildColon(),
                    _buildDigitBox(digits[2]),
                    const SizedBox(width: 4),
                    _buildDigitBox(digits[3]),
                    _buildColon(),
                    _buildDigitBox(digits[4]),
                    const SizedBox(width: 4),
                    _buildDigitBox(digits[5]),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationRow(int total, int totalPages) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          Text(
            'Total $total',
            style: _textStyle(14, const Color(0xFF9F9F9F), FontWeight.w600),
          ),
          const Spacer(),
          GestureDetector(
            onTap: _currentPage > 1
                ? () => setState(() => _currentPage--)
                : null,
            child: _buildArrowBox('<'),
          ),
          const SizedBox(width: 12),
          // Simple Page Number display
          for (int i = 1; i <= totalPages; i++)
            if (i >= _currentPage - 1 && i <= _currentPage + 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: GestureDetector(
                  onTap: () => setState(() => _currentPage = i),
                  child: Text(
                    '$i',
                    style: _textStyle(
                      14,
                      _currentPage == i
                          ? Colors.white
                          : const Color(0xFF9F9F9F),
                      FontWeight.w600,
                    ),
                  ),
                ),
              ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _currentPage < totalPages
                ? () => setState(() => _currentPage++)
                : null,
            child: _buildArrowBox('>'),
          ),
        ],
      ),
    );
  }

  // UI Components
  Widget _buildActionBtn(String label) {
    return Container(
      width: 88,
      height: 36,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: const Color(0xFF24232A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(label, style: _textStyle(14, Colors.white, FontWeight.w400)),
    );
  }

  Widget _buildDigitBox(String text) {
    return Container(
      width: 22,
      height: 32,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: const Color(0xFF313038),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Text(text, style: _textStyle(12, Colors.white, FontWeight.w500)),
    );
  }

  Widget _buildArrowBox(String arrow) {
    return Container(
      width: 26,
      height: 26,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: const Color(0xFF313038),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Text(arrow, style: _textStyle(14, Colors.white, FontWeight.w500)),
    );
  }

  Widget _buildColon() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: Text(':', style: _textStyle(12, Colors.white, FontWeight.w600)),
  );

  Widget _buildTableRow({
    required bool isHeader,
    required String date,
    required String time,
    required String a,
    required String b,
    required String c,
  }) {
    final style = _textStyle(
      12,
      isHeader ? const Color(0xFF9F9F9F) : Colors.white,
      isHeader ? FontWeight.w400 : FontWeight.w500,
    );
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: isHeader
          ? const BoxDecoration(
              color: Color(0xFF313038),
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            )
          : null,
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(date, style: style)),
          Expanded(flex: 2, child: Text(time, style: style)),
          _buildDigitBox(a),
          const SizedBox(width: 8),
          _buildDigitBox(b),
          const SizedBox(width: 8),
          _buildDigitBox(c),
        ],
      ),
    );
  }

  TextStyle _textStyle(
    double size,
    Color color,
    FontWeight weight, {
    bool italic = false,
  }) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontFamily: 'DM Sans',
      fontWeight: weight,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      height: 1.30,
      letterSpacing: size * -0.01,
    );
  }

  Widget _buildTopBar() {
    return LotteryTopBar(
      title: "${widget.stateName} Game",
      leftIcon: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      rightIcon: null,
    );
  }
}
