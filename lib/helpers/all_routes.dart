import 'dart:io';
import 'package:ddavila/features/auth_screen/presentation/login_screen.dart';
import 'package:ddavila/features/auth_screen/presentation/role_screen.dart';
import 'package:ddavila/features/auth_screen/presentation/signin_screen.dart';
import 'package:ddavila/features/auth_screen/presentation/signup_screen.dart';
import 'package:ddavila/features/auth_screen/presentation/success_screen.dart';
import 'package:ddavila/features/user_app/filter_screen/presentation/filter_screen.dart';
import 'package:ddavila/features/user_app/home_screen/presentation/home_screen.dart';
import 'package:ddavila/features/user_app/home_screen/presentation/search_screen.dart';
import 'package:ddavila/features/user_app/products_screen/product_bid_screen.dart';
import 'package:ddavila/features/user_app/products_screen/products_screen.dart';
import 'package:ddavila/navigation_screen.dart';
import 'package:flutter/cupertino.dart';

final class Routes {
  static final Routes _routes = Routes._internal();
  Routes._internal();
  static Routes get instance => _routes;

  // * =============> Loading navigation <============= */
  static const String loadingScreen = '/loading';

  // * =============> Onboarding navigation <============= */
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String splashScreen = '/splashScreen';

  // * =============> Login navigation <============= */
  static const String loginScreen = '/loginScreen';
  static const String roleScreen = '/roleScreen';

  // * =============> Auth navigation <============= */
  static const String signInScreen = '/signInScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String successScreen = '/successScreen';

  // * =============> Home navigation <============= */
  static const String homeScreen = '/homeScreen';
  static const String filterScreen = '/filterScreen';
  static const String searchScreen = '/searchScreen';
  static const String productsBidScreen = '/productsBidScreen';
  static const String  navigationScreen = '/navigationScreen';

  // * =============> Cart navigation <============= */
  static const String productDetailsScreen = '/productDetailsScreen';
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();
  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // * Onboarding Screen

      // * Login Screen
      case Routes.loginScreen:
        return Platform.isIOS
            ? UltimateSmoothTransitionRoute(
                widget: const ScreenTitle(widget: LoginScreen()),
                settings: settings)
            : CupertinoPageRoute(builder: (context) => const LoginScreen());

      // * Role Screen
      case Routes.roleScreen:
        return Platform.isIOS
            ? UltimateSmoothTransitionRoute(
                widget: const ScreenTitle(widget: RoleScreen()),
                settings: settings)
            : CupertinoPageRoute(builder: (context) => const RoleScreen());

      // * Sign In Screen
      case Routes.signInScreen:
        return Platform.isIOS
            ? UltimateSmoothTransitionRoute(
                widget: const ScreenTitle(widget: SignInScreen()),
                settings: settings)
            : CupertinoPageRoute(builder: (context) => const SignInScreen());

      // * Sign In Screen
      case Routes.signUpScreen:
        return Platform.isIOS
            ? UltimateSmoothTransitionRoute(
                widget: const ScreenTitle(widget: SignUpScreen()),
                settings: settings)
            : CupertinoPageRoute(builder: (context) => const SignUpScreen());

      // * Sign In Screen
      case Routes.navigationScreen:
        return Platform.isIOS
            ? UltimateSmoothTransitionRoute(
                widget: const ScreenTitle(widget: NavigationScreen()),
                settings: settings)
            : CupertinoPageRoute(builder: (context) => const NavigationScreen());

      // * Success Screen
      case Routes.successScreen:
        return Platform.isIOS
            ? UltimateSmoothTransitionRoute(
                widget: const ScreenTitle(widget: SuccessScreen()),
                settings: settings)
            : CupertinoPageRoute(builder: (context) => const SuccessScreen());

      // * Home Screen
      case Routes.homeScreen:
        return Platform.isIOS
            ? UltimateSmoothTransitionRoute(
                widget: const ScreenTitle(widget: HomeScreen()),
                settings: settings)
            : CupertinoPageRoute(builder: (context) => const HomeScreen());

      // * Filter Screen
      case Routes.filterScreen:
        return Platform.isIOS
            ? UltimateSmoothTransitionRoute(
                widget: const ScreenTitle(widget: FilterScreen()),
                settings: settings)
            : CupertinoPageRoute(builder: (context) => const FilterScreen());

      // * Filter Screen
      case Routes.searchScreen:
        return Platform.isIOS
            ? UltimateSmoothTransitionRoute(
                widget: const ScreenTitle(widget: SearchUserScreen()),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const SearchUserScreen());

      // * Products Screen
      case Routes.productDetailsScreen:
        return Platform.isIOS
            ? UltimateSmoothTransitionRoute(
                widget: const ScreenTitle(widget: ProductsScreen()),
                settings: settings)
            : CupertinoPageRoute(builder: (context) => const ProductsScreen());


      case Routes.productsBidScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? UltimateSmoothTransitionRoute(
            widget: ProductsBidScreen(
              productId: args['productId'],
              slag: args['slag'],
            ),
            settings: settings)
            : CupertinoPageRoute(
            builder: (context) => ProductsBidScreen(
              slag: args['slag'],
              productId: args['productId'],
            ));






      default:
        return null;
    }
  }
}

class ScreenTitle extends StatelessWidget {
  final Widget widget;

  const ScreenTitle({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: .5, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: widget,
    );
  }
}

////// Slide animation on going screen ///

class SlideFadeTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  SlideFadeTransitionRoute({required this.widget, required this.settings})
      : super(
          settings: settings,
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Slide from bottom and fade in simultaneously
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(0, 1), // Starts from bottom
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ));

            final fadeAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeIn,
            );

            return SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: child,
              ),
            );
          },
        );
}

////// Slide animation on going screen ///

class UltimateSmoothTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  UltimateSmoothTransitionRoute({required this.widget, required this.settings})
      : super(
          settings: settings,
          transitionDuration: const Duration(milliseconds: 200),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (context, animation, secondaryAnimation) => widget,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final slideAnimation = Tween<Offset>(
              begin: const Offset(0, 0.1), // Subtle slide from bottom
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ));

            final scaleAnimation = Tween<double>(
              begin: 0.98, // Slight zoom in effect
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ));

            final fadeAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ));

            return SlideTransition(
              position: slideAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: FadeTransition(
                  opacity: fadeAnimation,
                  child: child,
                ),
              ),
            );
          },
        );
}
