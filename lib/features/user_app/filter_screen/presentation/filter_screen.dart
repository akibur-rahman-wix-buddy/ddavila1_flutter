import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _isGradedExpanded = false;
  bool _isSetExpanded = false;
  bool _isRarityExpanded = false;

  // * List of card titles or data for the list view
  final List<String> cardTitles = [
    'CCG Individual Cards',
    'CCG Sealed Packs',
    'CCG Supplies & Accessories',
    'CCG Mix Card Lots',
    'More',
  ];

  // * Checkbox values for the Graded section
  final List<Map<String, dynamic>> _checkboxValues = [
    {'label': 'No', 'value': false},
    {'label': 'Yes', 'value': false},
    {'label': 'Not Specified', 'value': false},
  ];

  // * List of checkboxes for Sets
  final List<Map<String, dynamic>> _checkboxSetValues = [
    {'label': 'Base Set', 'setvalue': false},
    {'label': 'Sword & Shield', 'setvalue': false},
    {'label': 'Scarlet & Violet', 'setvalue': false},
    {'label': 'XY', 'setvalue': false},
    {'label': 'Team Rocket', 'setvalue': false},
    {'label': 'Crown Zenith', 'setvalue': false},
    {'label': 'Fossil', 'setvalue': false},
    {'label': 'Abyss Rising', 'setvalue': false},
  ];

  // * List of checkboxes for Rarity (example data)
  final List<Map<String, dynamic>> _checkboxRarityValues = [
    {'label': 'Black Star Promo', 'rarityvalue': false},
    {'label': 'Common', 'rarityvalue': false},
    {'label': 'Holo Rare', 'rarityvalue': false},
    {'label': 'Rare', 'rarityvalue': false},
    {'label': 'Secret Rare', 'rarityvalue': false},
    {'label': 'Ultra Rare', 'rarityvalue': false},
  ];

  // Toggles the Graded section visibility
  void _toggleGradedList() {
    setState(() {
      _isGradedExpanded = !_isGradedExpanded;
    });
  }

  // Toggles the Set section visibility
  void _toggleSetList() {
    setState(() {
      _isSetExpanded = !_isSetExpanded;
    });
  }

  // Toggles the Rarity section visibility
  void _toggleRarityList() {
    setState(() {
      _isRarityExpanded = !_isRarityExpanded;
    });
  }

  // * Print selected checkbox values in the Graded section
  void _logSelectedValues() {
    List<String> selectedValues = [];
    for (var item in _checkboxValues) {
      if (item['value']) {
        selectedValues.add(item['label']);
      }
    }

    if (selectedValues.isNotEmpty) {
      print('Selected Graded Values: ${selectedValues.join(", ")}');
    } else {
      print('No Graded values selected.');
    }
  }

  // * Print selected checkbox values in the Set section
  void _logSelectedSetValues() {
    List<String> selectedValues = [];
    for (var item in _checkboxSetValues) {
      if (item['setvalue']) {
        selectedValues.add(item['label']);
      }
    }

    if (selectedValues.isNotEmpty) {
      print('Selected Set Values: ${selectedValues.join(", ")}');
    } else {
      print('No Set values selected.');
    }
  }

  // * Print selected checkbox values in the Rarity section
  void _logSelectedRarityValues() {
    List<String> selectedValues = [];
    for (var item in _checkboxRarityValues) {
      if (item['rarityvalue']) {
        selectedValues.add(item['label']);
      }
    }

    if (selectedValues.isNotEmpty) {
      print('Selected Rarity Values: ${selectedValues.join(", ")}');
    } else {
      print('No Rarity values selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // * Header with back arrow and search icon
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
                    SizedBox(width: 10),
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
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Categories',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'All',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Collectible Card Games',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ListView.builder(
                    shrinkWrap: true, // Prevent it from taking up full space
                    physics:
                        NeverScrollableScrollPhysics(), // Disable scrolling for this listview (so parent scrolls)
                    itemCount: cardTitles.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          cardTitles[index],
                          style:
                              TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                            color: AppColor.c3988FF,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // * Graded Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Graded',
                          style:
                              TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                              _isGradedExpanded ? Icons.remove : Icons.add),
                          onPressed: _toggleGradedList,
                        ),
                      ],
                    ),
                    if (_isGradedExpanded)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _checkboxValues.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Checkbox(
                                value: _checkboxValues[index]['value'],
                                onChanged: (bool? value) {
                                  setState(() {
                                    _checkboxValues[index]['value'] =
                                        value ?? false;
                                    _logSelectedValues(); // Log selected values
                                  });
                                },
                              ),
                              Text(
                                _checkboxValues[index]['label'],
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  color: AppColor.c000000,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                  ],
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 20,
                ),
                // * Set Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Set',
                          style:
                              TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          icon: Icon(_isSetExpanded ? Icons.remove : Icons.add),
                          onPressed: _toggleSetList,
                        ),
                      ],
                    ),
                    if (_isSetExpanded)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _checkboxSetValues.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Checkbox(
                                value: _checkboxSetValues[index]['setvalue'],
                                onChanged: (bool? value) {
                                  setState(() {
                                    _checkboxSetValues[index]['setvalue'] =
                                        value ?? false;
                                    _logSelectedSetValues(); // Log selected values
                                  });
                                },
                              ),
                              Text(
                                _checkboxSetValues[index]['label'],
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  color: AppColor.c000000,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                  ],
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 20,
                ),
                // * Rarity Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rarity',
                          style:
                              TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                              _isRarityExpanded ? Icons.remove : Icons.add),
                          onPressed: _toggleRarityList,
                        ),
                      ],
                    ),
                    if (_isRarityExpanded)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _checkboxRarityValues.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Checkbox(
                                value: _checkboxRarityValues[index]
                                    ['rarityvalue'],
                                onChanged: (bool? value) {
                                  setState(() {
                                    _checkboxRarityValues[index]
                                        ['rarityvalue'] = value ?? false;
                                    _logSelectedRarityValues(); // Log selected values
                                  });
                                },
                              ),
                              Text(
                                _checkboxRarityValues[index]['label'],
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  color: AppColor.c000000,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                  ],
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 20,
                ),
                SizedBox(height: 20),
                CustomButton(
                  minWidth: double.infinity,
                  text: 'Reset Filter',
                  context: context,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
