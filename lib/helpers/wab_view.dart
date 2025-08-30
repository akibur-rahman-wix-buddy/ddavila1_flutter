// ignore_for_file: depend_on_referenced_packages
import 'dart:developer';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';

class WebViewLink extends StatefulWidget {
  const WebViewLink({super.key, required this.link});

  final String link;

  @override
  State<WebViewLink> createState() => _WebViewLinkState();
}

class _WebViewLinkState extends State<WebViewLink> {
  late final WebViewController _controller;
  bool _isLoading = true; // Track the loading state

  @override
  void initState() {
    super.initState();
    final url = widget.link;
    if (Uri.tryParse(url)?.hasAbsolutePath ?? false) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (_) {
              setState(() {
                _isLoading = true;
              });
            },
            onPageFinished: (_) {
              setState(() {
                _isLoading = false;
              });
            },
            onNavigationRequest: (NavigationRequest request) {
              log('Navigating to: ${request.url}');
              if (request.url ==
                  'https://errol.softvencefsd.xyz/checkout/succes55s') {
                // if (request.url.contains('roxyleisure.co.uk')) {
                NavigationService.navigateTo(Routes.navigationScreen);

                return NavigationDecision.prevent;
              } else if (request.url.contains(
                  'https://thehobbynexus.com/sign-in')) {
                NavigationService.navigateTo(Routes.navigationScreen);
              }else if (request.url.contains(
                  'https://thehobbynexus.com/error')) {
                NavigationService.navigateTo(Routes.navigationScreen);
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(url));
    } else {
      throw Exception("Invalid URL: $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading) // Show progress indicator while loading
              Center(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: Stack(
                      children: [
                        Lottie.asset(
                          'assets/lotties/loadings_lottie.json',
                          width: 200.w,
                          height: 200.h,
                          fit: BoxFit.contain,
                        ),
                        Positioned(
                          bottom: 40,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Text(
                              "Loading",
                              style: TextFontStyle.buttonTextStyle
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
