import 'dart:async';
import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/app/route_names.dart';
import 'package:go_router/go_router.dart';

class OtpLayout extends StatefulWidget {
  const OtpLayout({super.key});

  @override
  State<OtpLayout> createState() => _OtpLayoutState();
}

class _OtpLayoutState extends State<OtpLayout> {
  int _seconds = 15;
  Timer? _timer;
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _nodes = List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_seconds > 0)
        setState(() => _seconds--);
      else
        _timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 336,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 15,
        children: [
          _buildLogo(),
          const Text(
            'Enter 6-digit code sent to your Phone',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
          _buildPhoneBanner(),
          _buildOtpGrid(),
          _buildResendRow(),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildLogo() => CircleAvatar(
    radius: 30,
    backgroundColor: const Color(0xFFF3F5F4),
    child: Image.network("https://placehold.co/54x21", width: 54),
  );

  Widget _buildPhoneBanner() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: const Color(0xFF313038),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('+91 9900887766', style: TextStyle(color: Colors.white)),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF24232A),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'Change',
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildOtpGrid() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List.generate(
      6,
      (i) => SizedBox(
        width: 37,
        height: 37,
        child: TextField(
          controller: _controllers[i],
          focusNode: _nodes[i],
          textAlign: TextAlign.center,
          maxLength: 1,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            counterText: "",
            filled: true,
            fillColor: const Color(0xFF313038),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (v) =>
              (v.isNotEmpty && i < 5) ? _nodes[i + 1].requestFocus() : null,
        ),
      ),
    ),
  );

  Widget _buildResendRow() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        'Resend OTP',
        style: TextStyle(color: Colors.white, fontSize: 11),
      ),
      Text(
        '00:${_seconds.toString().padLeft(2, '0')}',
        style: const TextStyle(color: Color(0xFF3CA6EA)),
      ),
    ],
  );

  // Inside otp_layout.dart

  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: () {
        // 1. (Optional) Here you would normally call your API to verify the OTP
        debugPrint("OTP Submitted");

        // 2. Navigate to the Success Screen using the Route Name
        // Use .goNamed to prevent the user from going back to the OTP screen
        context.goNamed(RouteName.walletLinkingSuccess);
      },
      child: Container(
        width: double.infinity,
        height: 41,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)],
          ),
          borderRadius: BorderRadius.circular(7.47),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.93,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
