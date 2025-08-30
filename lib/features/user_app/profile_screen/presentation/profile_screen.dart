import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/features/user_app/profile_screen/model/my_self_model_data.dart';
import 'package:ddavila/features/user_app/profile_screen/widget/logout_dialouge_box.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    mySelfRx.mySelfData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
              20,
            ),
            child: Column(
              children: [
                StreamBuilder<MySelfModelData>(
                  stream: mySelfRx.dataFetcher,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                          UIHelper.verticalSpace(10.h),
                          const Text(
                            "Loading...",
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const Center(child: Text("Something went wrong!"));
                    } else if (!snapshot.hasData ||
                        snapshot.data?.data == null) {
                      return const Center(child: Text("No data found."));
                    } else {
                      var data = snapshot.data?.data?.user;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  50), // ensures image itself is rounded
                              child: Image.network(
                                data?.avatar != null
                                    ? image_url + data!.avatar!
                                    : "",
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    AppImages.profile, // fallback asset image
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  );
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    height: 80,
                                    width: 80,
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data?.name.toString() ?? "",
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                data?.email.toString() ?? "",
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              NavigationService.navigateToWithArgs(
                                  Routes.updateProfileScreen,
                                  {"userData": snapshot.data});
                            },
                            child: Image.asset(
                              AppImages.settingImage,
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                UIHelper.verticalSpaceMedium,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Profile Settings',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(12),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.c4275F6,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: SvgPicture.asset(
                                    AppIcons.packedIcon,
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                                Positioned(
                                  left: 32,
                                  child: Container(
                                    padding: EdgeInsets.all(2.5),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      '01',
                                      style: TextFontStyle
                                          .textLine7w400cFFFFFFDmSans
                                          .copyWith(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Packed',
                              style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                  .copyWith(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: SvgPicture.asset(
                                    AppIcons.truckIcon,
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                                Positioned(
                                  left: 32,
                                  child: Container(
                                    padding: EdgeInsets.all(2.5),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      '03',
                                      style: TextFontStyle
                                          .textLine7w400cFFFFFFDmSans
                                          .copyWith(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Delivery',
                              style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                  .copyWith(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: SvgPicture.asset(
                                    AppIcons.starIcon,
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Give a Rating',
                              style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                  .copyWith(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                UIHelper.verticalSpaceMedium,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'General',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(12),
                ProfileItemWidget(
                  title: 'Notification',
                  icon: SvgPicture.asset(
                    AppIcons.notificationIcon,
                  ),
                  onTap: () {},
                ),
                UIHelper.verticalSpace(8),
                ProfileItemWidget(
                  title: 'Security',
                  icon: SvgPicture.asset(
                    AppIcons.securityIcon,
                  ),
                  onTap: () {
                    print(">>>>>>>>>> this is security");
                    NavigationService.navigateTo(Routes.changePassword);
                  },
                ),
                UIHelper.verticalSpace(8),
                ProfileItemWidget(
                  title: 'Contact Us',
                  icon: SvgPicture.asset(
                    AppIcons.contactIcon,
                  ),
                  onTap: () {},
                ),
                UIHelper.verticalSpace(8),
                ProfileItemWidget(
                  title: 'Become a seller',
                  icon: SvgPicture.asset(
                    AppIcons.selerIcon,
                  ),
                  onTap: () {},
                ),
                UIHelper.verticalSpace(8),
                ProfileItemWidget(
                  title: 'Account Delete',
                  icon: SvgPicture.asset(
                    AppIcons.accountDelete,
                  ),
                  onTap: () {},
                ),
                UIHelper.verticalSpace(8),
                GestureDetector(
                  onTap: () async {
                    logoutDialogueBox(context);

                    // bool success =await postLogOutRX.logOut();
                    // if(success){
                    //   NavigationService.navigateToRemoveuntil(Routes.loginScreen);
                    // }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.cECEFF3,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                AppIcons.logoutIcon,
                              ),
                              UIHelper.horizontalSpace(25),
                              Text(
                                'Logout',
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          SvgPicture.asset(AppIcons.logoutNext),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileItemWidget extends StatelessWidget {
  final String title;
  final SvgPicture icon;
  final VoidCallback onTap;
  const ProfileItemWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.cECEFF3,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  icon,
                  UIHelper.horizontalSpace(25),
                  Text(
                    title,
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(AppIcons.nextIcon),
            ],
          ),
        ),
      ),
    );
  }
}
