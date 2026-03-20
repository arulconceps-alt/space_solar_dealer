import 'package:go_router/go_router.dart';
import 'package:space_solar_dealer/src/app/route_names.dart';
import 'package:space_solar_dealer/src/common/widgets/splashscreen.dart';
import 'package:space_solar_dealer/src/home/view/home_screen.dart';
import 'package:space_solar_dealer/src/login/view/login_screen.dart';
import 'package:space_solar_dealer/src/onboarding/view/onboarding_screen.dart';
import 'package:space_solar_dealer/src/register_new_customer/view/register_customer_screen.dart';
import 'package:space_solar_dealer/src/registration_success_screen/view/registration_success_screen.dart';
import 'package:space_solar_dealer/src/signup/view/signup_screen.dart';




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
      /// onboarding
      GoRoute(
        name: RouteName.onboarding,
        path: "/onboarding",
        builder: (context, state) => const OnboardingScreen(),
      ),
      /// login
      GoRoute(
        name: RouteName.login,
        path: "/login",
        builder: (context, state) => const LoginScreen(),
      ),
      /// signup
      GoRoute(
        name: RouteName.signup,
        path: "/signup",
        builder: (context, state) => const SignupScreen(),
      ),
      /// Dashboard
      GoRoute(
        name: RouteName.home,
        path: "/home",
        builder: (context, state) => const HomeScreen(),
      ),
      /// new_customer_register
      GoRoute(
        name: RouteName.customer_register,
        path: "/customer_register",
        builder: (context, state) => const RegisterCustomerScreen(),
      ),
      /// registeration_success
      GoRoute(
        name: RouteName.registration_success,
        path: "/registration_success",
        builder: (context, state) => const RegistrationSuccessScreen(),
      ),
    ],
  );
}