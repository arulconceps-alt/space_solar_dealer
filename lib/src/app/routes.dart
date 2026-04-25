import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:space_solar_dealer/src/app/route_names.dart';
import 'package:space_solar_dealer/src/common/models/customer_model.dart';
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';
import 'package:space_solar_dealer/src/common/repos/prefences_repository.dart';
import 'package:space_solar_dealer/src/common/widgets/splashscreen.dart';
import 'package:space_solar_dealer/src/customer_detail/bloc/customer_details_bloc.dart';
import 'package:space_solar_dealer/src/customer_detail/repo/customer_details_repositary.dart';
import 'package:space_solar_dealer/src/customer_detail/view/custmer_details_screen.dart';
import 'package:space_solar_dealer/src/customer_list/bloc/customer_list_bloc.dart';
import 'package:space_solar_dealer/src/customer_list/repo/customer_list_repositary.dart';
import 'package:space_solar_dealer/src/customer_list/view/customer_list_screen.dart';
import 'package:space_solar_dealer/src/dashboard/view/dashboard.dart';
import 'package:space_solar_dealer/src/edit_profile/view/edit_profile_screen.dart';
import 'package:space_solar_dealer/src/login/view/login_screen.dart';
import 'package:space_solar_dealer/src/notifications/view/notification_screen.dart';
import 'package:space_solar_dealer/src/onboarding/view/onboarding_screen.dart';
import 'package:space_solar_dealer/src/otp_screen/bloc/otp_bloc.dart';
import 'package:space_solar_dealer/src/otp_screen/repo/otp_repositary.dart';
import 'package:space_solar_dealer/src/otp_screen/view/otp_screen.dart';
import 'package:space_solar_dealer/src/profile/view/profile_screen.dart';
import 'package:space_solar_dealer/src/register_new_customer/bloc/new_register_bloc.dart';
import 'package:space_solar_dealer/src/register_new_customer/repo/new_register_repositary.dart';
import 'package:space_solar_dealer/src/register_new_customer/view/register_customer_screen.dart';
import 'package:space_solar_dealer/src/registration_success_screen/view/registration_success_screen.dart';
import 'package:space_solar_dealer/src/signup/view/signup_screen.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/tickets_list_details.dart';
import 'package:space_solar_dealer/src/total_panel_ids/view/total_panel_List.dart';


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
      /// login

      GoRoute(
        name: RouteName.otp_verify,
        path: "/otp_verify",
        builder: (context, state) {
          final phone = state.extra as String;

          return BlocProvider(
            create: (context) => OtpBloc(
              repository: OtpRepositary(
                context.read<ApiRepository>(),
                context.read<PreferencesRepository>(),
              ),
            ),
            child: OtpScreen(phoneNumber: phone),
          );
        },
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
        builder: (context, state) {
          return BlocProvider(
            create: (context) => NewRegisterBloc(
              repository: NewRegisterRepositary(
                context.read<ApiRepository>(), // ✅ inject properly
              ),
            ),
            child: const RegisterCustomerScreen(),
          );
        },
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
        builder: (context, state) => const CustomerList(), // Simply return the screen
      ),
      /// customer details
      GoRoute(
        name: RouteName.customer_detail,
        path: '/customer_detail',
        builder: (context, state) {
          final customer = state.extra as CustomerModel;

          return BlocProvider(
            create: (context) => CustomerDetailBloc(
              CustomerDetailsRepositary(
                context.read<ApiRepository>(),
              ),
            ),
            child: CustomerDetailsScreen(customer: customer),
          );
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
      ///Panel Id's List screen
      GoRoute(
        name: RouteName.total_panel_list,
        path: "/total_panel_list",
        builder: (context, state) => const TotalPanelList(),
      ),
    ],
  );
}