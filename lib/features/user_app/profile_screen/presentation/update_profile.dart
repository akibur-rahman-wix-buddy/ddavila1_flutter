import 'dart:io';
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/features/auth_screen/complete_account_info/model/state_model.dart';
import 'package:ddavila/features/user_app/profile_screen/model/my_self_model_data.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/helpers/wab_view.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key,required this.userData});
 final  MySelfModelData userData;

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {


  String? selectedState;
  File? _imageFile;
  bool _isLoading = false;
  bool isOnBoardign = false;



  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipController = TextEditingController();

  final ImagePicker _picker = ImagePicker();




  @override
  void initState() {
    super.initState();
    _loadUserData();
    getStateApiRXObj.states();
isOnBoardign = widget.userData.data?.user?.onboardComplete == 1 ? true: false;
  }

  void _loadUserData() {
    // Listen to mySelfRx to get user data

      if (mounted) {
        setState(() {
          // Pre-populate fields with existing data
          nameController.text = widget.userData.data?.user?.name?? '';
          emailController.text = widget.userData.data?.user?.email ?? '';
          addressController.text =  widget.userData.data?.user?.address ?? '';
          cityController.text =  widget.userData.data?.user?.city ?? '';
          zipController.text =  widget.userData.data?.user?.zipCode ?? '';
          selectedState =  widget.userData.data?.user?.state;
        });
      }
   }
  XFile? _pickedXFile;

  Future<void> _pickImage(ImageSource source) async {
    try {

      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _pickedXFile = pickedFile;
          _imageFile = File(pickedFile.path);
          _fileImageError = false; // Reset error flag
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }
// Add these variables to your state class
  bool _networkImageError = false;
  bool _fileImageError = false;

  Widget _buildProfileImage() {
    return CircleAvatar(
      radius: 65.r,
      backgroundImage: _getBackgroundImage(),
      onBackgroundImageError: (exception, stackTrace) {
        _handleImageError();
      },
    );
  }

  ImageProvider _getBackgroundImage() {
    // Priority 1: User selected new image
    if (_imageFile != null && !_fileImageError) {
      return FileImage(_imageFile!);
    }

    // Priority 2: Network image from user data
    if (widget.userData.data?.user?.avatar != null &&
        widget.userData.data!.user!.avatar!.isNotEmpty &&
        !_networkImageError) {
      return NetworkImage(image_url+widget.userData.data!.user!.avatar!);
    }

    // Priority 3: Fallback to asset image
    return const AssetImage(AppImages.profile);
  }

  void _handleImageError() {
    if (mounted) {
      setState(() {
        if (_imageFile != null) {
          _fileImageError = true;
        } else {
          _networkImageError = true;
        }
      });
    }
  }


  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    emailController.dispose();
    cityController.dispose();
    zipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border16 = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: const BorderSide(color: Colors.grey),
    );

    return Scaffold(
      backgroundColor: AppColor.cFFFFFF,
      appBar: AppBar(
        title: const Text('Update Profile'),
        backgroundColor: AppColor.cFFFFFF,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: StreamBuilder<StatesModel>(
        stream: getStateApiRXObj.dataFetcher,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  UIHelper.verticalSpace(16.h),
                  const Text(
                    "Failed to load states",
                    style: TextStyle(color: Colors.red),
                  ),
                  UIHelper.verticalSpace(16.h),
                  ElevatedButton(
                    onPressed: () => getStateApiRXObj.states(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data?.data == null) {
            return const Center(child: Text("No states data found."));
          } else {
            final states = snapshot.data!.data!;

            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Update your photo and personal details here.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w600,
                        height: 1.40,
                      ),
                    ),
                    UIHelper.verticalSpace(24.h),

                    // Profile Image with Picker
                    Center(
                      child: Stack(
                        children: [
                          // Profile image with error handling
                          _buildProfileImage(),

                          // Camera icon
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _showImagePickerOptions,
                              child: Container(
                                padding: EdgeInsets.all(8.r),
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 20.r,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    UIHelper.verticalSpace(24.h),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Name",
                        border: border16,
                        enabledBorder: border16,
                        focusedBorder: border16,
                      ),
                    ),

                    UIHelper.verticalSpace(16.h),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email address",
                        border: border16,
                        enabled: false,
                        enabledBorder: border16,
                        focusedBorder: border16,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      readOnly: true, // Email is typically not editable
                    ),

                    UIHelper.verticalSpace(16.h),
                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                        labelText: "Address",
                        border: border16,
                        enabledBorder: border16,
                        focusedBorder: border16,
                      ),
                    ),

                    UIHelper.verticalSpace(16.h),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: "State",
                          border: border16,
                          enabledBorder: border16,
                          focusedBorder: border16,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        value: selectedState,
                        items: states
                            .map((state) => DropdownMenuItem<String>(
                          value: state.slug,
                          child: Text(
                            state.title ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ))
                            .toList(),
                        onChanged: (val) {
                          setState(() => selectedState = val);
                        },
                        dropdownColor: Colors.white,
                        menuMaxHeight: 200.h,
                      ),
                    ),

                    UIHelper.verticalSpace(16.h),
                    CustomButton(
                      text: isOnBoardign ? "Manage Stripe" : "Connect Stripe",
                      context: context,
                      minWidth: 150.w,
                      onTap: () async {
                        final stripeData = await stripeConnectRx.stripeConnectInfo();

                        if (stripeData != null && stripeData.data?.dashboardUrl != null) {
                          Get.to(
                            WebViewLink(link: stripeData.data!.dashboardUrl!),
                          );
                        } else {
                          ToastUtil.showShortToast("Stripe URL not available.");
                        }
                      },
                    ),

                    UIHelper.verticalSpace(16.h),
                    // City + Zip
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: cityController,
                            decoration: InputDecoration(
                              labelText: "City",
                              border: border16,
                              enabledBorder: border16,
                              focusedBorder: border16,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: TextFormField(
                            controller: zipController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Zip Code",
                              border: border16,
                              enabledBorder: border16,
                              focusedBorder: border16,
                            ),
                          ),
                        ),
                      ],
                    ),

                    UIHelper.verticalSpace(24.h),
                    SizedBox(
                      width: double.infinity,
                      height: 52.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        onPressed: _isLoading ? null : _updateProfile,
                        child: Text(
                          _isLoading? " uploading...":"Update Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    UIHelper.verticalSpace(24.h),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _updateProfile() async {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
      return;
    }

    if (selectedState == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your state')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      bool success = await updateProfileApiRx.updateProfileApiInformation(
          state: selectedState!,
          address: addressController.text.trim(),
          city: cityController.text.trim(),
          zipCode: zipController.text.trim(),
          avatar: _pickedXFile, // Use XFile instead of String path
          name: nameController.text
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );

        // Refresh user data
        mySelfRx.mySelfData();

        // Navigate back or to home screen
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to update profile. Please try again.')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: $error')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}