// main.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_solar_dealer/src/app/flavor_config.dart';
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';
import 'package:space_solar_dealer/src/common/repos/prefences_repository.dart';
import 'package:space_solar_dealer/src/login/repo/login_repositary.dart';
import 'package:space_solar_dealer/src/customer_list/repo/customer_list_repositary.dart'; // 1. Import Repo
import 'package:space_solar_dealer/src/customer_list/bloc/customer_list_bloc.dart'; // 2. Import Bloc
import 'package:space_solar_dealer/src/login/bloc/login_bloc.dart';
import 'src/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = FlavorConfig(
    flavor: Flavor.dev,
    appName: "Space Solar",
    baseUrl: "http://187.127.131.80:5502/api/v1/",
    useMockApi: false,
  );
  GetIt.I.registerSingleton<FlavorConfig>(config);

  final dio = Dio();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => PreferencesRepository(sharedPreferences),
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
        // 3. Register Customer Repository
        RepositoryProvider(
          create: (context) => CustomerListRepositary(
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
          // 4. Register Customer Bloc
          BlocProvider(
            create: (context) => CustomerListBloc(
              repository: context.read<CustomerListRepositary>(),
            ),
          ),
        ],
        child: const App(),
      ),
    ),
  );
}