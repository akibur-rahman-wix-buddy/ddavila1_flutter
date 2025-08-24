import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/features/auth_screen/complete_account_info/model/state_model.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompleteAccountInfoScreen extends StatefulWidget {
  const CompleteAccountInfoScreen({super.key});

  @override
  State<CompleteAccountInfoScreen> createState() => _CompleteAccountInfoScreenState();
}

class _CompleteAccountInfoScreenState extends State<CompleteAccountInfoScreen> {
  // Dropdown values
  final String selectedCountry = "USA";
  String? selectedState;
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool agreeTerms = false;

  @override
  void initState() {
    super.initState();
    // Call states API
    getStateApiRXObj.states();
  }

  @override
  void dispose() {
    addressController.dispose();
    cityController.dispose();
    zipController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  String? _validateInputs() {
    if (selectedState == null || selectedState!.isEmpty) {
      return "Please select a state";
    }
    if (addressController.text.trim().isEmpty) {
      return "Shipping address is required";
    }
    if (cityController.text.trim().isEmpty) {
      return "City is required";
    }
    if (zipController.text.trim().isEmpty) {
      return "Zip code is required";
    }
    if (phoneController.text.trim().isEmpty) {
      return "Phone number is required";
    }
    if (!agreeTerms) {
      return "You must agree to the terms and conditions";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final border16 = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: const BorderSide(color: Colors.grey),
    );

    return Scaffold(
      backgroundColor: AppColor.cFFFFFF,
      body: StreamBuilder<StatesModel>(
        stream: getStateApiRXObj.dataFetcher,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: CircularProgressIndicator()),
                UIHelper.verticalSpace(10.h),
                const Text(
                  "Loading...",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong!"));
          } else if (!snapshot.hasData || snapshot.data?.data == null) {
            return const Center(child: Text("No data found."));
          } else {
            final states = snapshot.data!.data!; // list<Datum>

            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UIHelper.verticalSpace(24.h),
                      const Text(
                        "Setup Your Profile for start trading",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w600,
                          height: 1.40,
                        ),
                      ),
                      UIHelper.verticalSpace(24.h),

                      /// Country (static USA) + State
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              enabled: false, // Makes it readonly
                              initialValue: "USA",
                              decoration: InputDecoration(
                                labelText: "Country",
                                border: border16,
                                disabledBorder: border16,
                                enabledBorder: border16,
                                focusedBorder: border16,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Container(
                              width: double.infinity, // Ensure it takes full width
                              child: DropdownButtonFormField<String>(
                                isExpanded: true, // Prevent overflow
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
                                  value: state.title ?? "",
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
                                menuMaxHeight: 200.h, // Limit dropdown height
                              ),
                            ),
                          ),
                        ],
                      ),

                      UIHelper.verticalSpace(16.h),

                      /// Shipping Address
                      TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: "Shipping Address",
                          border: border16,
                          enabledBorder: border16,
                          focusedBorder: border16,
                        ),
                        maxLines: 2,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Shipping address is required";
                          }
                          return null;
                        },
                      ),

                      UIHelper.verticalSpace(16.h),

                      /// City + Zip
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
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "City is required";
                                }
                                return null;
                              },
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
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Zip code is required";
                                }
                                if (!RegExp(r'^\d{5}(-\d{4})?$').hasMatch(value)) {
                                  return "Invalid zip code format";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),

                      UIHelper.verticalSpace(16.h),

                      /// Phone
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          border: border16,
                          enabledBorder: border16,
                          focusedBorder: border16,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Phone number is required";
                          }
                          if (!RegExp(r'^\+?1?\d{10}$').hasMatch(value.replaceAll(RegExp(r'[^\d]'), ''))) {
                            return "Invalid phone number format";
                          }
                          return null;
                        },
                      ),

                      UIHelper.verticalSpace(16.h),

                      /// Checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: agreeTerms,
                            checkColor: Colors.black,
                            fillColor: MaterialStateProperty.all(Colors.transparent),
                            side: const BorderSide(color: Colors.grey, width: 2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            onChanged: (val) {
                              setState(() => agreeTerms = val ?? false);
                            },
                          ),
                          const Expanded(
                            child: Text(
                              "I agree to the terms and conditions",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),

                      UIHelper.verticalSpace(24.h),

                      /// Continue Button
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
                          onPressed: () async {
                            final validationError = _validateInputs();
                            if (validationError != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(validationError)),
                              );
                              return;
                            }

                            try {
                              bool success = await completeProfileApiRxObj.completeProfileApi(
                                country: "USA",
                                state: selectedState!,
                                address: addressController.text.trim(),
                                city: cityController.text.trim(),
                                zip_code: zipController.text.trim(),
                                phone: phoneController.text.trim(),
                                terms: agreeTerms.toString(),
                              );

                              if (success) {
                                print('Profile completed successfully!');
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Failed to complete profile. Please try again.')),
                                );
                              }
                            } catch (error) {
                              print('API call error: $error');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error completing profile: $error')),
                              );
                            }
                          },
                          child: const Text(
                            "Continue",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}