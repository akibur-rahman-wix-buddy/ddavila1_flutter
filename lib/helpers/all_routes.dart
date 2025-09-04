import 'dart:io';
import 'package:ddavila/features/admin_app/admin_navigation.dart';
import 'package:ddavila/features/admin_app/auction_screen/create_auction_screen.dart';
import 'package:ddavila/features/admin_app/auction_screen/final_auction_screen.dart';
import 'package:ddavila/features/admin_app/dashboard_screen/admin_dashboard_screen.dart';
import 'package:ddavila/features/auth_screen/presentation/forget_otp_screen.dart';
import 'package:ddavila/features/auth_screen/presentation/forget_screen.dart';
import 'package:ddavila/features/auth_screen/presentation/login_screen.dart';
import 'package:ddavila/features/auth_screen/presentation/otp_varification_screen.dart';
import 'package:ddavila/features/auth_screen/presentation/reset_password_screen.dart';
import 'package:ddavila/features/auth_screen/presentation/role_screen.dart';
import 'package:ddavila/features/auth_screen/presentation/signin_screen.dart';
import 'package:ddavila/features/auth_screen/presentation/signup_screen.dart';
import 'package:ddavila/features/auth_screen/presentation/success_screen.dart';
import 'package:ddavila/features/user_app/filter_screen/presentation/filter_screen.dart';
import 'package:ddavila/features/user_app/home_screen/presentation/home_screen.dart';
import 'package:ddavila/features/user_app/home_screen/presentation/search_screen.dart';
import 'package:ddavila/features/user_app/products_screen/presentation/product_bid_screen.dart';
import 'package:ddavila/features/user_app/products_screen/presentation/products_screen.dart';
import 'package:ddavila/features/user_app/profile_screen/presentation/change_password.dart';
import 'package:ddavila/navigation_screen.dart';
import 'package:flutter/cupertino.dart';
import '../features/user_app/profile_screen/presentation/update_profile.dart'
    show UpdateProfileScreen;

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

  static const String otpVerificationScreen = '/otpVerificationScreen';
  static const String forgetOTPScreen = '/forgetOTPScreen';
  static const String resetNewPassScreen = '/resetNewPassScreen';
  static const String forgetPasswordScreen = '/forgetPasswordScreen';

  // * =============> Home navigation <============= */
  static const String homeScreen = '/homeScreen';
  static const String filterScreen = '/filterScreen';
  static const String searchScreen = '/searchScreen';
  static const String productsBidScreen = '/productsBidScreen';
  static const String navigationScreen = '/navigationScreen';

  // * =============> Cart navigation <============= */
  static const String productDetailsScreen = '/productDetailsScreen';

  // * ############################## Admin Dashboard ###########################################
  // * ##########################################################################################
  static const String adminNavigationScreen = '/adminNavigationScreen';
  static const String adminDashboard = '/adminDashboard';

  static const String myAuctionScreen = '/myAuctionScreen';

  // * ############################## Profile ###########################################

  static const String updateProfileScreen = '/updateProfileScreen';
  static const String changePassword = '/changePassword';
  static const String createAuctionScreen = '/createAuctionScreen';
  static const String finalAuctionScreen = '/finalAuctionScreen';
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();
  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // * Onboarding Screen

      // * Login Screen
      case Routes.myAuctionScreen:
        return Platform.isIOS
            ? UltimateSmoothTransitionRoute(
                widget: const ScreenTitle(widget: CreateAuctionScreen()),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const CreateAuctionScreen());

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
            : CupertinoPageRoute(
                builder: (context) => const NavigationScreen());

      case Routes.changePassword:
        return Platform.isIOS
            ? UltimateSmoothTransitionRoute(
                widget: const ScreenTitle(widget: ChangePassword()),
                settings: settings)
            : CupertinoPageRoute(builder: (context) => const ChangePassword());

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

      // * Home Screen
      case Routes.forgetPasswordScreen:
        return Platform.isIOS
            ? UltimateSmoothTransitionRoute(
                widget: const ScreenTitle(widget: ForgetPasswordScreen()),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const ForgetPasswordScreen());

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

      case Routes.productDetailsScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? UltimateSmoothTransitionRoute(
                widget: ProductsScreen(
                  slug: args['slug'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => ProductsScreen(
                      slug: args['slug'],
                    ));

      case Routes.updateProfileScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? UltimateSmoothTransitionRoute(
                widget: UpdateProfileScreen(
                  userData: args['userData'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => UpdateProfileScreen(
                      userData: args["userData"],
                    ));

      // * OTP Verification Screen
      case Routes.otpVerificationScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? UltimateSmoothTransitionRoute(
                widget: OtpVerificationScreen(
                  email: args['email'],
                ),
                settings: settings)
            : CupertinoPageRoute(

                builder: (context) => OtpVerificationScreen(
                      email: args['email'],
                    ),
                settings: settings);


      // * Forget OTP Screen
      case Routes.forgetOTPScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? UltimateSmoothTransitionRoute(
                widget: ForgetOTPScreen(
                  email: args['email'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => ForgetOTPScreen(
                      email: args['email'],
                    ),
                settings: settings);

      // * Reset New Password Screen
      case Routes.resetNewPassScreen:
        return Platform.isIOS
            ? UltimateSmoothTransitionRoute(
                widget: const ScreenTitle(widget: ResetPasswordScreen()),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const ResetPasswordScreen());

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

      // * #################################################### Admin Flow #######################################
      // * #######################################################################################################
      // * #######################################################################################################
      case Routes.adminNavigationScreen:
        return Platform.isIOS
            ? UltimateSmoothTransitionRoute(
                widget: const ScreenTitle(
                  widget: AdminNavigationScreen(),
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const AdminNavigationScreen(),
              );

      case Routes.adminDashboard:
        return Platform.isIOS
            ? UltimateSmoothTransitionRoute(
                widget: const ScreenTitle(
                  widget: AdminDashboardScreen(),
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const AdminDashboardScreen(),
              );

      // * ####################################################################################
      // * ################################# Final Flow #######################################
      // * ####################################################################################

      case Routes.finalAuctionScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? UltimateSmoothTransitionRoute(
                widget: FinalAuctionScreen(
                  descriptionText: args['descriptionText'],
                  subCategory: args['subCategory'],
                  category: args['category'],
                  property: args['property'],
                  imageItem: args['imageItem'],
                  titleText: args['titleText'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => FinalAuctionScreen(
                      descriptionText: args['descriptionText'],
                      subCategory: args['subCategory'],
                      category: args['category'],
                      property: args['property'],
                      imageItem: args['imageItem'],
                      titleText: args['titleText'],
                    ));

      // * Filter Screen
      case Routes.createAuctionScreen:
        return Platform.isIOS
            ? UltimateSmoothTransitionRoute(
                widget: const ScreenTitle(widget: CreateAuctionScreen()),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const CreateAuctionScreen());

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
