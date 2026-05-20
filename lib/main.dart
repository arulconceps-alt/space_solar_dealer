import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_solar_dealer/firebase_options.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:space_solar_dealer/src/app/flavor_config.dart';
import 'package:space_solar_dealer/src/app/app.dart';
import 'package:space_solar_dealer/src/common/constants/constansts.dart';
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';
import 'package:space_solar_dealer/src/common/repos/prefences_repository.dart';
import 'package:space_solar_dealer/src/common/services/network_listener.dart';
import 'package:space_solar_dealer/src/login/repo/login_repositary.dart';
import 'package:space_solar_dealer/src/login/bloc/login_bloc.dart';
import 'package:space_solar_dealer/src/customer_list/repo/customer_list_repositary.dart';
import 'package:space_solar_dealer/src/customer_list/bloc/customer_list_bloc.dart';
import 'package:space_solar_dealer/src/notifications/data/notification_popup_service.dart';
import 'package:space_solar_dealer/src/notifications/data/notification_service.dart';
import 'package:space_solar_dealer/src/notifications/data/notification_store.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/bloc/ticket_list_details_bloc.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/bloc/ticket_list_details_event.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/repo/ticket_list_details_repositary.dart';
import 'package:space_solar_dealer/src/profile/bloc/profile_bloc.dart';
import 'package:space_solar_dealer/src/profile/bloc/profile_event.dart';
import 'package:space_solar_dealer/src/profile/repo/profile_repositary.dart';
import 'package:space_solar_dealer/src/total_panel_ids/bloc/total_panel_bloc.dart';
import 'package:space_solar_dealer/src/total_panel_ids/repo/total_panel_repositary.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// LOCAL NOTIFICATION PLUGIN
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// BACKGROUND MESSAGE HANDLER
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  debugPrint("BACKGROUND MESSAGE => ${message.notification?.title}");
}

Future<String> downloadAndSaveFile(String url, String fileName) async {
  final directory = await getApplicationDocumentsDirectory();

  final filePath = '${directory.path}/$fileName';

  final response = await http.get(Uri.parse(url));

  final file = File(filePath);

  await file.writeAsBytes(response.bodyBytes);

  return filePath;
}

/// SHOW LOCAL NOTIFICATION
Future<void> showFlutterNotification(RemoteMessage message) async {
  final notification = message.notification;

  if (notification == null) return;

  String? bigPicturePath;

  /// IMAGE URL FROM BACKEND
  final imageUrl =
      message.notification?.android?.imageUrl ??
      message.notification?.apple?.imageUrl;

  /// DOWNLOAD IMAGE
  if (imageUrl != null && imageUrl.isNotEmpty) {
    try {
      bigPicturePath = await downloadAndSaveFile(
        imageUrl,
        'notification_image',
      );
    } catch (e) {
      debugPrint("IMAGE DOWNLOAD ERROR => $e");
    }
  }

 final BigPictureStyleInformation bigPictureStyle =
    BigPictureStyleInformation(
  FilePathAndroidBitmap(bigPicturePath ?? ''),

  contentTitle: notification.title,

  summaryText: notification.body,

  hideExpandedLargeIcon: true,
);

  /// ANDROID DETAILS
  final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'high_importance_channel',
    'High Importance Notifications',

    channelDescription: 'Important notifications',

    importance: Importance.max,
    priority: Priority.high,
    playSound: true,

    styleInformation: bigPicturePath != null ? bigPictureStyle : null,
  );

  final NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
  );

 
  await flutterLocalNotificationsPlugin.show(
    notification.hashCode,

    notification.title ?? '',

    notification.body ?? '',

    notificationDetails,

    payload: jsonEncode(message.data),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await NotificationService.instance.init();

  await NotificationStore.instance.loadNotifications();

  /// FIREBASE INIT
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// BACKGROUND HANDLER
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  /// NOTIFICATION PERMISSION
  NotificationSettings settings = await FirebaseMessaging.instance
      .requestPermission(alert: true, badge: true, sound: true);

  debugPrint('Permission => ${settings.authorizationStatus}');

  /// FCM TOKEN
  String? token = await FirebaseMessaging.instance.getToken();

  debugPrint('FCM TOKEN => $token');

  /// SHARED PREF
  final sharedPreferences = await SharedPreferences.getInstance();

  if (token != null) {
    await sharedPreferences.setString(Constants.store.DEVICE_TOKEN, token);
  }

  /// LOCAL NOTIFICATION INITIALIZATION
  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      debugPrint("NOTIFICATION CLICKED => ${response.payload}");
    },
  );

  /// FOREGROUND MESSAGE
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    debugPrint("FOREGROUND MESSAGE => ${message.notification?.title}");

    final title = message.notification?.title ?? '';

    final body = message.notification?.body ?? '';

    await NotificationStore.instance.addNotification(
      title: title,
      body: body,
      imageUrl: message.notification?.android?.imageUrl,
    );

    await showFlutterNotification(message);

  final notificationBody =
      body.toUpperCase();

  /// POPUP HIDE FOR OPEN STATUS
  if (!notificationBody.contains("OPEN")) {
    showInAppNotification(
      title: title,
      body: body,
      imageUrl:
          message.notification?.android?.imageUrl,
    );
  }
});

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint("BACKGROUND NOTIFICATION CLICKED");

    debugPrint("DATA => ${message.data}");
  });

  /// TERMINATED CLICK
  RemoteMessage? initialMessage = await FirebaseMessaging.instance
      .getInitialMessage();

  if (initialMessage != null) {
    debugPrint("APP OPENED FROM TERMINATED STATE");

    debugPrint("INITIAL DATA => ${initialMessage.data}");
  }

  /// FLAVOR CONFIG
  final config = FlavorConfig(
    flavor: Flavor.dev,
    appName: "Space Solar",
    baseUrl: "http://187.127.131.80:5502/",
    useMockApi: false,
  );

  GetIt.I.registerSingleton<FlavorConfig>(config);

  /// DIO
  final dio = Dio();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => PreferencesRepository(sharedPreferences),
        ),

        RepositoryProvider(
          create: (context) =>
              ApiRepository(dio, context.read<PreferencesRepository>()),
        ),

        RepositoryProvider(
          create: (context) => LoginRepository(
            context.read<ApiRepository>(),
            context.read<PreferencesRepository>(),
          ),
        ),

        RepositoryProvider(
          create: (context) =>
              CustomerListRepositary(context.read<ApiRepository>()),
        ),

        RepositoryProvider(
          create: (context) =>
              TicketListDetailsRepositary(context.read<ApiRepository>()),
        ),

        RepositoryProvider(
          create: (context) => ProfileRepository(context.read<ApiRepository>()),
        ),

        RepositoryProvider(
          create: (context) =>
              TotalPanelRepositary(context.read<ApiRepository>()),
        ),
      ],

      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                LoginBloc(repository: context.read<LoginRepository>()),
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
            create: (context) =>
                ProfileBloc(context.read<ProfileRepository>())
                  ..add(LoadProfileEvent()),
          ),

          BlocProvider(
            create: (context) =>
                TotalPanelBloc(context.read<TotalPanelRepositary>()),
          ),
        ],

        child: const NetworkListener(child: App()),
      ),
    ),
  );
}
