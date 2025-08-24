import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



void logoutDialogueBox(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Exit Group?",
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: MediaQuery.of(context).size.width * 1.85.w,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: AppColor.allPrimaryColor, ///=======Card Back Ground Color=========//
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                      'Logging Out?',
                      textAlign: TextAlign.start,
                      style: TextFontStyle.textLine16w500cFFFFFFLato,),

                  UIHelper.verticalSpace(20.h),

                   Text(
                      'Are you sure want to Log out from your Dating account?',
                      textAlign: TextAlign.start,
                      style: TextFontStyle.textLine12w500cFFFFFFLato
                  ),
                  UIHelper.verticalSpace(30.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Confirm Logout Button
                      CustomButton(

                        minWidth: 120.w,
                        text: 'Cancel',
                        onTap: () {
                          if (kDebugMode) {
                            print('==================>>>>>>>Exit Cancel ');
                          }
                          Navigator.of(context).pop();
                        },
                        borderRadius: 50.r,context: context,

                      ),
                      UIHelper.horizontalSpace(10.w),
                      CustomButton(
                        minWidth: 120.w,
                        text: 'Done',
                        onTap: () async {

                          if (kDebugMode) {
                            bool success  = await postLogOutRX.logOut();
                            if(success){
                              NavigationService.navigateToRemoveuntil(Routes.loginScreen);
                            }
                          }
                        },
                        borderRadius: 50.r, context: context,
                      ),
                      UIHelper.verticalSpace(38.h),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.8, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
        ),
        child: child,
      );
    },
  );
}
