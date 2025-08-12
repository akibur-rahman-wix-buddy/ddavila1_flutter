import 'dart:developer';
import 'package:auto_animated/auto_animated.dart';
import 'package:ddavila/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:provider/provider.dart';
import '/helpers/all_routes.dart';
import 'constants/custome_theme.dart';
import 'features/user_app/checkout/presentation/checkout_screen.dart';
import 'features/user_app/products_screen/product_bid_screen.dart';
import 'helpers/helper_methods.dart';
import 'helpers/navigation_service.dart';
import 'helpers/register_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // * change by nurnabi + nayem
  // * #########################
  // await PurchaseHelper.init();
  // * #########################
  await GetStorage.init();
  diSetup();
  initiInternetChecker();
  DioSingleton.instance.create();
  log("Device Id: ======>>>>>>>>${appData.read(kKeyDeviceID)}");
  // await NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    rotation();
    setInitValue();
    return MultiProvider(
      providers: providers,
      child: AnimateIfVisibleWrapper(
        showItemInterval: const Duration(milliseconds: 150),
        child: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) async {
            showMaterialDialog(context);
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return const UtillScreenMobile();
            },
          ),
        ),
      ),
    );
  }
}

class UtillScreenMobile extends StatelessWidget {
  const UtillScreenMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 915),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) async {
            showMaterialDialog(context);
          },
          child: GetMaterialApp(
            locale: const Locale('en', 'US'),
            // translations: Language(), // Uncomment if using localization
            fallbackLocale: const Locale('en', 'US'),
            showPerformanceOverlay: false,

            theme: ThemeData(
              primarySwatch: CustomTheme.kToDark,
              useMaterial3: false,
            ),

            debugShowCheckedModeBanner: false,
            builder: (context, widget) {
              return MediaQuery(data: MediaQuery.of(context), child: widget!);
            },
            navigatorKey: NavigationService.navigatorKey,
            onGenerateRoute: RouteGenerator.generateRoute,

            // home: const LoadingScreen(),

            home: LoadingScreen(),

          ),
        );
      },
    );
  }
}
