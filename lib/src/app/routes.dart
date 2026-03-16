import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/add_money/view/add_money_page.dart';
import 'package:space_solar_dealer/src/kyc_verification/view/kyc_verification.dart';
import 'package:space_solar_dealer/src/payement_mode/view/payment_mode_page.dart';
import 'package:space_solar_dealer/src/app/route_names.dart';
import 'package:space_solar_dealer/src/common/widgets/splashscreen.dart';
import 'package:space_solar_dealer/src/home/view/home_view.dart';
import 'package:space_solar_dealer/src/myAccount/view/my_account_screen.dart';
import 'package:space_solar_dealer/src/lottery/view/lottery_home.dart';
import 'package:space_solar_dealer/src/onboarding/view/OnboardingView.dart';
import 'package:space_solar_dealer/src/wallet_link/view/transaction_status_page.dart';
import 'package:space_solar_dealer/src/wallet_link/view/wallet_linking_otp_page.dart';
import 'package:space_solar_dealer/src/wallet_link/view/wallet_linking_page.dart';
import 'package:space_solar_dealer/src/register/view/register_screen.dart';
import 'package:space_solar_dealer/src/success/view/success_screen.dart';
import 'package:space_solar_dealer/src/suggestion/view/suggestion_box_screen.dart';
import 'package:space_solar_dealer/src/suggestion/view/suggestion_success_screen.dart';
import 'package:space_solar_dealer/src/supportchat/view/support_chat_screen.dart';
import 'package:space_solar_dealer/src/wallet/view/wallet_screen.dart';

import 'package:space_solar_dealer/src/withdraw/view/withdraw_page.dart';
import 'package:space_solar_dealer/src/withdraw/view/widgets/withdraw_successful_page.dart';
import 'package:go_router/go_router.dart';
import '../login/view/login_screen.dart';
import '../otp/view/otp_screen.dart';

class Routes {
  GoRouter router = GoRouter(
    initialLocation: "/",

    routes: [
      /// Splash
      GoRoute(
        name: RouteName.splashscreen,
        path: "/",
        builder: (context, state) => const SplashScreen(),
      ),

      /// OnBoarding
      GoRoute(
        name: RouteName.onboarding,
        path: "/onboarding",
        builder: (context, state) => const OnboardingView(),
      ),

      /// Login
      GoRoute(
        name: RouteName.login,
        path: "/login",
        builder: (context, state) => const LoginScreen(),
      ),

      /// OTP
      GoRoute(
        name: RouteName.otp,
        path: "/otp",
        builder: (context, state) => const OtpScreen(),
      ),

      /// Name Register
      GoRoute(
        name: RouteName.register,
        path: "/register",
        builder: (context, state) => const RegisterScreen(),
      ),

      /// Login Success
      GoRoute(
        name: RouteName.success,
        path: "/success",
        builder: (context, state) => const SuccessScreen(),
      ),
      GoRoute(
        name: RouteName.home,
        path: "/home",
        builder: (context, state) => HomeView(),
      ),

      ///myAccount
      GoRoute(
        name: RouteName.myAccount,
        path: "/myAccount",
        builder: (context, state) => MyAccountScreen(),
      ),

      ///wallet
      GoRoute(
        name: RouteName.wallet,
        path: "/wallet",
        builder: (context, state) => WalletScreen(),
      ),

      ///wallet
      GoRoute(
        name: RouteName.kyc_verify,
        path: "/kyc_verify",
        builder: (context, state) => KycVerification(),
      ),

      /// Support chat
      GoRoute(
        name: RouteName.chat,
        path: "/chat",
        builder: (context, state) => SupportChatScreen(),
      ),

      /// Suggestion Box
      GoRoute(
        name: RouteName.suggestion,
        path: "/suggestion",
        builder: (context, state) => SuggestionBoxScreen(),
      ),

      /// Suggestion Box Success Screen
      GoRoute(
        name: RouteName.suggestion_success,
        path: "/suggestion_success",
        builder: (context, state) => SuggestionSuccessScreen(),
      ),
      GoRoute(
        name: RouteName.lotteryhome,
        path: "/lotteryhome",
        builder: (context, state) => LotteryHome(),
      ),
      GoRoute(
        name: RouteName.withdrawPage,
        path: "/withdrawPage",
        builder: (context, state) => WithdrawPage(),
      ),
      GoRoute(
        name: RouteName.withdrawSuccessful,
        path: "/withdrawSuccessful",
        builder: (context, state) => const WithdrawSuccessfulPage(),
      ),
      GoRoute(
        name: RouteName.AddMoneyPage,
        path: "/AddMoneyPage",
        builder: (context, state) => AddMoneyPage(),
      ),
      GoRoute(
        name: RouteName.paymentModePage,
        path: "/paymentModePage",
        builder: (context, state) => PaymentModePage(),
      ),
      GoRoute(
        name: RouteName.walletLinkingPage,
        path: "/walletLinkingPage",
        builder: (context, state) => WalletLinkingPage(),
      ),

      /// Wallet OTP Verification Screen
      GoRoute(
        name: RouteName.walletOtpSent,
        path: "/walletOtpSent",
        builder: (context, state) => const WalletLinkingOtpPage(),
      ),

      /// Transaction Processing
      /// Transaction Processing
      GoRoute(
        name: RouteName.walletLinkingProcessing,
        path: "/walletLinkingProcessing", // Unique path
        builder: (context, state) => const TransactionStatusPage(
          title: 'Payment Transaction in Progress',
          subtitle: 'Do not Press back or refresh',
          assetGif: 'assets/gifs/blue_loader.gif',
          isPending: false,
        ),
      ),

      /// Transaction Success
      GoRoute(
        name: RouteName.walletLinkingSuccess,
        path: "/walletLinkingSuccess", // Unique path
        builder: (context, state) => const TransactionStatusPage(
          title: 'Payment Transaction Successful',
          subtitle: 'will redirect back automatically in 5 secs...',
          assetGif: 'assets/gifs/success_check.gif',
          isPending: false,
        ),
      ),

      /// Transaction Pending
      GoRoute(
        name: RouteName.walletLinkingPending,
        path: "/walletLinkingPending", // Unique path
        builder: (context, state) => const TransactionStatusPage(
          title: 'Transaction Pending. Don’t worry',
          subtitle: 'Your money will be refunded in 2-3 working days',
          assetGif: 'assets/gifs/pending_alert.gif',
          isPending: true,
        ),
      ),

      /// KYC File upload Success
      GoRoute(
        name: RouteName.kycFileUpdateSuccess,
        path: "/kycFileUpdateSuccess", // Unique path
        builder: (context, state) => const TransactionStatusPage(
          title: 'KYC Verified Successful',
          subtitle: 'will redirect back automatically in 5 secs...',
          assetGif: 'assets/gifs/success_check.gif',
          isPending: false,
        ),
      ),
    ],
  );
}
