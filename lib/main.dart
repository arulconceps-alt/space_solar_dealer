// main.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:space_solar_dealer/src/app/flavor_config.dart';
import 'package:space_solar_dealer/src/app/app.dart';

import 'package:space_solar_dealer/src/common/repos/api_repository.dart';
import 'package:space_solar_dealer/src/common/repos/prefences_repository.dart';

import 'package:space_solar_dealer/src/login/repo/login_repositary.dart';
import 'package:space_solar_dealer/src/login/bloc/login_bloc.dart';

import 'package:space_solar_dealer/src/customer_list/repo/customer_list_repositary.dart';
import 'package:space_solar_dealer/src/customer_list/bloc/customer_list_bloc.dart';

import 'package:space_solar_dealer/src/tickets_list_screen/bloc/ticket_list_details_bloc.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/bloc/ticket_list_details_event.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/repo/ticket_list_details_repositary.dart';

import 'package:space_solar_dealer/src/profile/bloc/profile_bloc.dart';
import 'package:space_solar_dealer/src/profile/bloc/profile_event.dart';
import 'package:space_solar_dealer/src/profile/repo/profile_repositary.dart';
import 'package:space_solar_dealer/src/total_panel_ids/bloc/total_panel_bloc.dart';
import 'package:space_solar_dealer/src/total_panel_ids/repo/total_panel_repositary.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = FlavorConfig(
    flavor: Flavor.dev,
    appName: "Space Solar",
    baseUrl: "http://187.127.131.80:5502/",
    useMockApi: false,
  );

  GetIt.I.registerSingleton<FlavorConfig>(config);

  final dio = Dio();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => PreferencesRepository(sharedPreferences),
        ),
        RepositoryProvider(
          create: (context) => ApiRepository(
            dio,
            context.read<PreferencesRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => LoginRepository(
            context.read<ApiRepository>(),
            context.read<PreferencesRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => CustomerListRepositary(
            context.read<ApiRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => TicketListDetailsRepositary(
            context.read<ApiRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => ProfileRepository(
            context.read<ApiRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => TotalPanelRepositary(
            context.read<ApiRepository>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(
              repository: context.read<LoginRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => CustomerListBloc(
              repository: context.read<CustomerListRepositary>(),
            ),
          ),
          BlocProvider(
            create: (context) => TicketListDetailsBloc(
              context.read<TicketListDetailsRepositary>(),
            )..add(LoadTicketsEvent()),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(
              context.read<ProfileRepository>(),
            )..add(LoadProfileEvent()),
          ),
          BlocProvider(
            create: (context) => TotalPanelBloc(
              context.read<TotalPanelRepositary>(),
            ),
          ),
        ],
        child: const App(),
      ),
    ),
  );
}