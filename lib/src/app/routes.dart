import 'package:go_router/go_router.dart';
import 'package:space_solar_dealer/src/app/route_names.dart';
import 'package:space_solar_dealer/src/common/widgets/splashscreen.dart';
import 'package:space_solar_dealer/src/customer_detail/view/custmer_details_screen.dart';
import 'package:space_solar_dealer/src/customer_list/view/customer_list_screen.dart';
import 'package:space_solar_dealer/src/dashboard/dashboard.dart';
import 'package:space_solar_dealer/src/edit_profile/view/edit_profile_screen.dart';
import 'package:space_solar_dealer/src/login/view/login_screen.dart';
import 'package:space_solar_dealer/src/notifications/view/notification_screen.dart';
import 'package:space_solar_dealer/src/onboarding/view/onboarding_screen.dart';
import 'package:space_solar_dealer/src/profile/view/profile_screen.dart';
import 'package:space_solar_dealer/src/register_new_customer/view/register_customer_screen.dart';
import 'package:space_solar_dealer/src/registration_success_screen/view/registration_success_screen.dart';
import 'package:space_solar_dealer/src/signup/view/signup_screen.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/tickets_list_details.dart';




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
        builder: (context, state) => const Dashboard(),
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
      /// customer list
      GoRoute(
        name: RouteName.customer_list,
        path: "/customer_list",
        builder: (context, state) => const CustomerList(),
      ),
      /// customer details
      GoRoute(
        name: RouteName.customer_detail,
        path: "/customer_detail",
        builder: (context, state) {
          final name = state.extra as String; // ✅ GET DATA
          return CustomerDetailsScreen(name: name);
        },
      ),
      ///ticket list details
      GoRoute(
        name: RouteName.ticket_list,
        path: "/ticket_list",
        builder: (context, state) => const TicketsListDetails(),
      ),
      ///profile screen
      GoRoute(
        name: RouteName.profile_screen,
        path: "/profile_screen",
        builder: (context, state) => const ProfileScreen(),
      ),
      ///Edit profile screen
      GoRoute(
        name: RouteName.edit_profile_screen,
        path: "/edit_profile_screen",
        builder: (context, state) => const EditProfileScreen(),
      ),
      ///notification screen
      GoRoute(
        name: RouteName.notification_screen,
        path: "/notification_screen",
        builder: (context, state) => const NotificationScreen(),
      ),
    ],
  );
}