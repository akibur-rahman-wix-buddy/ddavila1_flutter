import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/common_widgets/custom_textfiled.dart';
import 'package:ddavila/features/user_app/filter_screen/model/cetagory_wise_sub_category_model_data.dart';
import 'package:ddavila/features/user_app/filter_screen/model/filter_fatch_data_model.dart';
import 'package:ddavila/features/user_app/filter_screen/presentation/filter_result_screen.dart';
import 'package:ddavila/features/user_app/home_screen/model/home_category_data_model.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _isCategoriesExpanded = false;
  Map<dynamic, bool> selectedSubCategories = {};
  Map<String, bool> selectedItems = {};

  TextEditingController maxController = TextEditingController();
  TextEditingController minController = TextEditingController();

  @override
  void initState() {
    filterCategoryRx.filterCategoryData();
    super.initState();
  }

  Widget _buildFilterSection(String title, List<String> items) {
    return ExpansionTile(
      title: Text(title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
      children: items.map((item) {
        final isChecked = selectedItems[item] ?? false;
        return CheckboxListTile(
          value: isChecked,
          title: Text(item),
          onChanged: (val) {
            setState(() {
              selectedItems[item] = val ?? false;
            });
          },
        );
      }).toList(),
    );
  }

  Future<void> _applyFilters() async {
    List<dynamic> selectedSubCatIds = selectedSubCategories.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    List<dynamic> selectedValues = selectedItems.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();





    bool success = await rxFilterPostRx.rxFilterPostInfo(
      max: maxController.text,
      min: minController.text,
      subCat: selectedSubCatIds,
      value: selectedValues,
    );

    if (success) {
      // Get the filtered data from the stream
      final filteredData = rxFilterPostRx.getFileData.value;
      final productData = FilterProductDataModel.fromJson(filteredData);

      // Navigate to the results screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FilteredResultsScreen(
            filteredProducts: productData,
          ),
        ),
      );
    }
  }

  void _resetFilters() {
    setState(() {
      selectedSubCategories.clear();
      selectedItems.clear();
    });
    print("All filters have been reset");
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with back arrow and search icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: SvgPicture.asset(
                      AppIcons.arrowBack,
                      width: 32,
                      height: 32,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      NavigationService.navigateTo(Routes.searchScreen);
                    },
                    child: SvgPicture.asset(
                      AppIcons.searchIcon,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
        
              // Categories Section
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Header Row
                      Row(
                        children: [
                          const Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Categories',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _isCategoriesExpanded = !_isCategoriesExpanded;
                              });
                            },
                            icon: Icon(
                              _isCategoriesExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                          ),
                        ],
                      ),
                          
                      // Collapsible Content
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 300),
                        crossFadeState: _isCategoriesExpanded
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        firstChild: StreamBuilder<HomeCategoryApiDataModel>(
                          stream: getHomeCategoryRx.dataFetcher,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          
                            if (!snapshot.hasData || snapshot.data?.data == null) {
                              return const Center(child: Text("No Categories Found"));
                            }
                          
                            final categories = snapshot.data!.data!;
                          
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                final category = categories[index];
                                return ExpansionTile(
                                  title: Text(category.title ?? ""),
                                  children: [
                                    if (category.subcategories != null)
                                      ...category.subcategories!.map((sub) {
                                        final isChecked =
                                            selectedSubCategories[sub.id ?? 0] ??
                                                false;
                                        return CheckboxListTile(
                                          value: isChecked,
                                          title: Text(sub.title ?? ""),
                                          onChanged: (val) {
                                            setState(() {
                                              selectedSubCategories[sub.id ?? 0] =
                                                  val ?? false;
                                            });
                                          },
                                        );
                                      }),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        secondChild: const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 20),
                      const Divider(color: Colors.grey, thickness: 1, height: 20),

                      // Filters Section
                      StreamBuilder<ProductFIlterModelData>(
                        stream: filterCategoryRx.dataFetcher,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData || snapshot.data?.data == null) {
                            return const Center(child: Text("No Filters Found"));
                          }

                          final filters = snapshot.data!.data!;

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return



                                _buildFilterSection(filters.toString(), filters.rarity ?? []);

                            },
                            // children: [
                            //
                            //
                            //
                            //
                            //   _buildFilterSection("Grade", filters.grade ?? []),
                            //   _buildFilterSection("Rarity", filters.rarity ?? []),
                            //   _buildFilterSection("Stage", filters.stage ?? []),
                            // ],
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(" Custom range",style: TextStyle(fontSize: 20.h,fontWeight: FontWeight.w700),)),

                      UIHelper.verticalSpace(12.h),

                      Row(
                        children: [
                          CustomTextField(controller: minController,fieldWidth: 150.w,hintText: "Min range ",inputType: TextInputType.number,),
                          UIHelper.horizontalSpace(20.w),
                          CustomTextField(controller:maxController, fieldWidth: 150.w,hintText: "Max range ",inputType: TextInputType.number),

                        ],
                      ),
                      UIHelper.verticalSpace(12.h),



                      // Apply and Reset buttons
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              minWidth: double.infinity,
                              text: 'Reset',
                              context: context,
                              color: Colors.grey,
                              onTap: _resetFilters,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomButton(
                              minWidth: double.infinity,
                              text: 'Apply',
                              context: context,
                              onTap: _applyFilters,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                ),
              ),
        

            ],
          ),
        ),
      ),
    );
  }

}