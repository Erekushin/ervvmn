import 'dart:async';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ervvlgerege/Controllers/entrance.dart';
import 'package:ervvlgerege/Controllers/medical.dart';
import 'package:ervvlgerege/Controllers/profile.dart';
import 'package:ervvlgerege/Controllers/search.dart';
import 'package:ervvlgerege/global_constants.dart';
import 'package:ervvlgerege/views/chat/chat_home.dart';
import 'package:ervvlgerege/views/chat/conversation.dart';
import 'package:ervvlgerege/views/entrance/forget_pass.dart';
import 'package:ervvlgerege/views/entrance/login.dart';
import 'package:ervvlgerege/views/entrance/register.dart';
import 'package:ervvlgerege/views/medical/medical_home.dart';
import 'package:ervvlgerege/views/profile/main_profile.dart';
import 'package:ervvlgerege/views/profile/my_information/general_info.dart';
import 'package:ervvlgerege/views/profile/my_information/health_info.dart';
import 'package:ervvlgerege/views/profile/my_services/myServices.dart';
import 'package:ervvlgerege/views/profile/my_services/service_info.dart';
import 'package:ervvlgerege/views/profile/spacialist_settings.dart/specialist_registration.dart';
import 'package:ervvlgerege/views/profile/spacialist_settings.dart/specialist_settings.dart';
import 'package:ervvlgerege/views/profile/task_calendar.dart';
import 'package:ervvlgerege/views/search/search.dart';
import 'package:ervvlgerege/views/settings/settings.dart';
import 'package:ervvlgerege/views/wallet/wallet_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';

import 'Controllers/chat.dart';
import 'Controllers/content/survey/survey_creation.dart';
import 'Controllers/image.dart';
import 'Helpers/logging.dart';
import 'MyWidgets/app/bottom_navbar.dart';
import 'views/welcome/splash_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}

Future<void> main() async {
  //version1 root
  final medlog = logger(AppRoot);

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(); //TODO
  // AwesomeNotifications().initialize(null, [
  //   NotificationChannel(
  //     channelKey: 'medtech',
  //     channelName: 'medtech notification',
  //     channelDescription: "medtech notification",
  //     defaultColor: const Color(0XFF9050DD),
  //     importance: NotificationImportance.High,
  //     ledColor: Colors.white,
  //     channelShowBadge: true,
  //     playSound: true,
  //     enableLights: true,
  //     enableVibration: true,
  //     defaultRingtoneType: DefaultRingtoneType.Notification,
  //   ),
  // ]);
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // messaging.getToken().then((value) => {
  //       GlobalHelpers.deviceToken = value.toString(),
  //       medlog.i('wtf: ${GlobalHelpers.deviceToken}')
  //     });

  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  // medlog.i('User granted permission: ${settings.authorizationStatus}');

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   medlog.wtf('---NOTIFICATION---: ${message.notification?.title}');
  //   AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //         id: 1,
  //         channelKey: 'medtech',
  //         title: message.notification?.title.toString(),
  //         body: message.notification?.body.toString()),
  //   );
  // });
  // FirebaseMessaging.onMessageOpenedApp.listen((message) {
  //   medlog.i('Message clicked!: $message');
  // });

  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   medlog.i('body note 0: $message');
  // });

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const AppRoot());
}

class AppRoot extends StatefulWidget {
  const AppRoot({Key? key}) : super(key: key);
  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  late Stream<BottomNavbarKeys> bottomNavbarSwitcher;
  @override
  void initState() {
    super.initState();
    GlobalHelpers.bottomnavbarSwitcher = StreamController();
    bottomNavbarSwitcher = GlobalHelpers.bottomnavbarSwitcher.stream;
  }

  @override
  Widget build(BuildContext context) {
    GlobalHelpers.bottomnavbarSwitcher.add(BottomNavbarKeys.hideNavBar);
    return MaterialApp(
      // showPerformanceOverlay: true,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            GetMaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: RouteUnits.splashScreen,
              initialBinding: BindingsBuilder(() => bindInitialControllers()),
              getPages: [
                //splash screen
                GetPage(
                    name: RouteUnits.splashScreen,
                    page: () => const WelcomeSplash()),
                //entrance
                GetPage(name: RouteUnits.login, page: () => const Login()),
                GetPage(name: RouteUnits.register, page: () => const SignUp()),
                GetPage(
                    name: RouteUnits.forgetpass,
                    page: () => const ForgetPass()),
                //medical
                GetPage(
                    name: RouteUnits.medicalhome,
                    page: () => const MedicalHome()),

                //profile
                GetPage(
                    name: RouteUnits.profile, page: () => const MainProfile()),
                GetPage(
                    name: RouteUnits.generalInfo,
                    page: () => const GeneralInfo()),
                GetPage(
                    name: RouteUnits.healthInfo,
                    page: () => const HealthInfo()),

                GetPage(
                    name: RouteUnits.specialistSetting,
                    page: () => const SpecialistInfo()),
                GetPage(
                    name: RouteUnits.specialistRegistration,
                    page: () => const SpecialistRegistration()),
                GetPage(
                    name: RouteUnits.taskCalendar,
                    page: () => const TaskCalendarBig()),
                GetPage(
                    name: RouteUnits.myServices,
                    page: () => const MyServices()),
                GetPage(
                    name: RouteUnits.myServiceInfo,
                    page: () => const ServiceInfo()),
                //wallet
                GetPage(
                    name: RouteUnits.wallet, page: () => const WalletMain()),

                //chat
                GetPage(
                    name: RouteUnits.chathome, page: () => const ChatHome()),
                GetPage(
                    name: RouteUnits.conversation,
                    page: () => const Conversation()),
                // GetPage(
                //     name: RouteUnits.videoCall,
                //     page: () => VideoSDKQuickStart()),

                //others
                GetPage(name: RouteUnits.setting, page: () => const Settings()),
                GetPage(name: RouteUnits.search, page: () => const SearchV())
              ],
            ),
            // bottom navigation
            StreamBuilder<BottomNavbarKeys>(
                stream: bottomNavbarSwitcher,
                builder: (context, snapshot) {
                  switch (snapshot.data) {
                    case BottomNavbarKeys.hideNavBar:
                      return const SizedBox(height: 1);
                    default:
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: MyBottomNavbar(
                          comingKey:
                              snapshot.data ?? BottomNavbarKeys.hideNavBar,
                        ),
                      );
                  }
                })
          ],
        ),
      ),
    );
  }

  bindInitialControllers() {
    Get.put(SearchC(), permanent: true);
    Get.put(ProC(), permanent: true);
    Get.put(ImageCont(), permanent: true);

    Get.put(AuthC(), permanent: true);
    Get.put(MedicalCont(), permanent: true);
    Get.put(ChatC(), permanent: true);
    Get.put(CreationCont());
  }
}
