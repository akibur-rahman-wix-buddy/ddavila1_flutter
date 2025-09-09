// ignore_for_file: unused_local_variable, unnecessary_to_list_in_spreads, avoid_print, curly_braces_in_flow_control_structures, deprecated_member_use, prefer_final_fields, unused_element

import 'dart:convert';
import 'dart:developer';
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_appbar.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/features/admin_app/auction_screen/model/category_model.dart';
import 'package:ddavila/features/admin_app/auction_screen/model/property_model.dart';
import 'package:ddavila/features/admin_app/auction_screen/model/sub_property_model.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CreateAuctionScreen extends StatefulWidget {
  const CreateAuctionScreen({super.key});
  @override
  State<CreateAuctionScreen> createState() => _CreateAuctionScreenState();
}

class _CreateAuctionScreenState extends State<CreateAuctionScreen> {
  final TextEditingController _coreFeaturesController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String fontStyle = 'Calibri';
  String selectedTitle = '';
  String selectedValue = '';
  String coreFeaturesHtml = '';
  String descriptionHtml = '';
  String descriptionHtmlText = '';
  String coreFeaturesHtmlText = '';
  double fontSize = 12;
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderlined = false;
  TextAlign _alignment = TextAlign.left;
  int? selectedCategoryId;
  String? selectedCategoryTitle;
  int? selectedSubCategoryId;
  String? selectedSubCategoryTitle;
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _subCategoryController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  List<Map<String, dynamic>> propertyRows = [];
  List<String> valueOptions = ['Add New Item'];
  List<Map<String, String>> titleValuePairs = [];
  // * ########## Image
  List<Map<String, String>> _cardImages = [];
  List<String> imagePaths = [];

  @override
  void initState() {
    super.initState();
    _loadSavedText();
    getCategoryAPIRXObj.getCategoryRX();
    getPropertyAPIRXObj.getPropertyRX();
    propertyRows.add({
      'selectedTitle': '',
      'selectedValue': '',
      'titleController': TextEditingController(),
      'valueController': TextEditingController(),
    });
  }

  @override
  void dispose() {
    _coreFeaturesController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _subCategoryController.dispose();
    for (var row in propertyRows) {
      row['titleController']?.dispose();
      row['valueController']?.dispose();
    }
    super.dispose();
  }

  void _toggleBold() => setState(() => _isBold = !_isBold);
  void _toggleItalic() => setState(() => _isItalic = !_isItalic);
  void _toggleUnderline() => setState(() => _isUnderlined = !_isUnderlined);
  void _setAlignment(TextAlign alignment) =>
      setState(() => _alignment = alignment);

  // void _logTitleValuePairs() {
  //   // Pretty print titleValuePairs in JSON format
  //   const encoder = JsonEncoder.withIndent('  ');
  //   final formattedJson = encoder.convert(titleValuePairs);
  //   log('Title-Value Pairs:\n$formattedJson');
  // }

  // *  ####################### HTML EDITOR #########################
  Future<void> _resetFile() async {
    try {
      final file = File(
          '${(await getApplicationDocumentsDirectory()).path}/editor_text.html');
      if (await file.exists()) await file.delete();
      if (mounted) {
        setState(() {
          _coreFeaturesController.text = '';
          _descriptionController.text = '';
        });
        log('Content reset successfully!');
      }
    } catch (e) {
      if (mounted) {
        log('Failed to reset content');
      }
    }
  }

  Future<void> _loadSavedText() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/editor_text.html');
      if (!await file.exists()) return;

      final savedText = await file.readAsString();
      final RegExp divRegex = RegExp(r'<div>(.*?)</div>', dotAll: true);
      final RegExpMatch? match = divRegex.firstMatch(savedText);
      String textContent = match?.group(1) ?? '';

      textContent = textContent.replaceAll('<br>', '\n');

      if (mounted) {
        setState(() {
          _coreFeaturesController.text = '';
          _descriptionController.text = '';
        });
      }
    } catch (e) {
      if (mounted) {
        log('Failed to load saved content');
      }
    }
  }

  Future<void> _saveText() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/editor_text.html');

      // Process Core Features
      String coreFeaturesText = _coreFeaturesController.text;
      String styledCoreFeatures = coreFeaturesText
          .replaceAll('&', '&amp;')
          .replaceAll('<', '&lt;')
          .replaceAll('>', '&gt;');

      if (_isBold) styledCoreFeatures = '<b>$styledCoreFeatures</b>';
      if (_isItalic) styledCoreFeatures = '<i>$styledCoreFeatures</i>';
      if (_isUnderlined) styledCoreFeatures = '<u>$styledCoreFeatures</u>';

      // Process Description
      String descriptionText = _descriptionController.text;
      String styledDescription = descriptionText
          .replaceAll('&', '&amp;')
          .replaceAll('<', '&lt;')
          .replaceAll('>', '&gt;');

      if (_isBold) styledDescription = '<b>$styledDescription</b>';
      if (_isItalic) styledDescription = '<i>$styledDescription</i>';
      if (_isUnderlined) styledDescription = '<u>$styledDescription</u>';

      // Combine for saving to file
      String htmlContent = '''
<div>
 <h2>Core Features</h2>
 ${styledCoreFeatures.replaceAll('\n', '<br>')}
 <h2>Description</h2>
 ${styledDescription.replaceAll('\n', '<br>')}
</div>
''';

      // Save to file
      await file.writeAsString(htmlContent);

      // Log the HTML content separately
      coreFeaturesHtmlText = coreFeaturesHtml = '''
<div>
 ${styledCoreFeatures.replaceAll('\n', '<br>')}
</div>
''';

      descriptionHtmlText = descriptionHtml = '''
<div>
 ${styledDescription.replaceAll('\n', '<br>')}
</div>
''';

      // Log immediately after setting
      log('Description Data: $descriptionHtmlText');
      log('Core Features Data: $coreFeaturesHtmlText');

      if (mounted) {
        log('Saved as HTML and logged successfully!');
      }
    } catch (e) {
      if (mounted) {
        log('Failed to save content');
      }
    }
  }

  // * ####################### Image list ##########################
  Future<void> _showImageSourceDialog() async {
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              title: const Text('Camera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );

    if (!mounted || source == null) return;

    if (source == ImageSource.gallery) {
      await _pickImagesFromGallery();
    } else if (source == ImageSource.camera) {
      await _pickImageFromCamera();
    }
  }

  Future<void> _pickImagesFromGallery() async {
    try {
      final picker = ImagePicker();
      final List<XFile>? pickedImages =
          await picker.pickMultiImage(imageQuality: 85);
      if (!mounted || pickedImages == null || pickedImages.isEmpty) return;

      List<String> newPaths = [];
      List<Map<String, String>> newCardImages = [];
      for (var picked in pickedImages) {
        final file = File(picked.path);
        final fileSize = await file.length() / (1024 * 1024); // Size in MB
        if (fileSize > 25) {
          log('Image ${picked.name} exceeds 25 MB limit');
          continue;
        }

        final bytes = await picked.readAsBytes();
        final b64 = base64Encode(bytes);
        final pathLower = picked.path.toLowerCase();
        String mime = 'image/jpeg';
        if (pathLower.endsWith('.png')) {
          mime = 'image/png';
        } else if (pathLower.endsWith('.gif')) {
          mime = 'image/gif';
        } else if (pathLower.endsWith('.webp')) {
          mime = 'image/webp';
        } else if (pathLower.endsWith('.bmp')) {
          mime = 'image/bmp';
        } else if (pathLower.endsWith('.heic') || pathLower.endsWith('.heif')) {
          mime = 'image/heic';
        }

        final dataUrl = 'data:$mime;base64,$b64';
        newPaths.add(picked.path);
        newCardImages.add({'src': dataUrl, 'link': ''});
      }

      if (newPaths.isNotEmpty) {
        setState(() {
          imagePaths.addAll(newPaths);
          _cardImages.addAll(newCardImages);
        });
        log('Selected image paths: $imagePaths');
        log('Images added from gallery');
      }
    } catch (e) {
      if (mounted) {
        log('Failed to add images from gallery: $e');
      }
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final picker = ImagePicker();
      final XFile? picked =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 85);
      if (!mounted || picked == null) return;

      final file = File(picked.path);
      final fileSize = await file.length() / (1024 * 1024); // Size in MB
      if (fileSize > 25) {
        log('Image exceeds 25 MB limit');
        return;
      }

      final bytes = await picked.readAsBytes();
      final b64 = base64Encode(bytes);
      final pathLower = picked.path.toLowerCase();
      String mime = 'image/jpeg';
      if (pathLower.endsWith('.png')) {
        mime = 'image/png';
      } else if (pathLower.endsWith('.gif')) {
        mime = 'image/gif';
      } else if (pathLower.endsWith('.webp')) {
        mime = 'image/webp';
      } else if (pathLower.endsWith('.bmp')) {
        mime = 'image/bmp';
      } else if (pathLower.endsWith('.heic') || pathLower.endsWith('.heif')) {
        mime = 'image/heic';
      }

      final dataUrl = 'data:$mime;base64,$b64';

      setState(() {
        _cardImages.add({'src': dataUrl, 'link': ''});
        imagePaths.add(picked.path);
        print('Selected image paths: $imagePaths');
      });

      if (mounted) {
        log('Image added from camera');
      }
    } catch (e) {
      if (mounted) {
        log('Failed to add image from camera: $e');
      }
    }
  }

  void _insertImagePlaceholder(int index) {
    final cursorPos = _coreFeaturesController.selection.baseOffset;
    final text = _coreFeaturesController.text;
    final placeholder = '[image$index]';
    final newText = cursorPos >= 0
        ? text.replaceRange(cursorPos, cursorPos, placeholder)
        : '$text$placeholder';
    if (mounted) {
      setState(() {
        _coreFeaturesController.text = newText;
        _coreFeaturesController.selection = TextSelection.collapsed(
            offset: cursorPos >= 0
                ? cursorPos + placeholder.length
                : newText.length);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasAnyImage = _cardImages.isNotEmpty;
    return Scaffold(
      appBar: CustomAppBar(text: 'Create Auction'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Create Listing',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Our Standard Service Plan is designed for homeowners who want a reliable and cost-effective solution without compromising on quality. ',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.c666666,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                UIHelper.verticalSpace(10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(AppIcons.lineIcon),
                    Text(
                      'Item Details',
                      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        color: AppColor.blackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SvgPicture.asset(AppIcons.lineIcon),
                  ],
                ),
                UIHelper.verticalSpace(10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Product Title',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10),
                TextFormField(
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Enter Product Title',
                    hintStyle:
                        TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.cAEAEAE,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                UIHelper.verticalSpace(10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Item Details',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10),

                // * // * ########## Image Picker ##################
                GestureDetector(
                  onTap: _showImageSourceDialog,
                  child: DottedBorderContainer(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        hasAnyImage
                            ? SizedBox(
                                height: 60,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _cardImages.length,
                                  itemBuilder: (context, index) {
                                    final image = _cardImages[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          image['src']!.startsWith('data:')
                                              ? Image.memory(
                                                  base64Decode(image['src']!
                                                      .split(',')
                                                      .last),
                                                  width: 48,
                                                  height: 48,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  image['src']!,
                                                  width: 48,
                                                  height: 48,
                                                  fit: BoxFit.cover,
                                                ),
                                          // Cross icon overlay
                                          Positioned(
                                            right: -6,
                                            top: -6,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _cardImages.removeAt(index);
                                                  if (index <
                                                      imagePaths.length) {
                                                    imagePaths.removeAt(index);
                                                  }
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                  shape: BoxShape.circle,
                                                ),
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            : CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.grey.shade100,
                                child: Image.asset(AppImages.picImage),
                              ),
                        const SizedBox(height: 12),
                        Text(
                          "Click to Upload Front Side of Card",
                          style:
                              TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "(Max. File size: 25 MB)",
                          style:
                              TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // * ########################################################
                UIHelper.verticalSpace(10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Description',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(color: Colors.red, width: 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              color: Colors.grey[200],
                              height: 48,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    DropdownButton<String>(
                                      value: fontStyle,
                                      items: <String>[
                                        'Calibri',
                                        'Arial',
                                        'Times New Roman'
                                      ]
                                          .map<DropdownMenuItem<String>>(
                                            (String value) =>
                                                DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value,
                                                  style: const TextStyle(
                                                      fontSize: 14)),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (String? newValue) =>
                                          setState(() => fontStyle = newValue!),
                                    ),
                                    const SizedBox(width: 4),
                                    DropdownButton<double>(
                                      value: fontSize,
                                      items: [12.0, 14.0, 16.0, 18.0, 20.0]
                                          .map<DropdownMenuItem<double>>(
                                            (double value) =>
                                                DropdownMenuItem<double>(
                                              value: value,
                                              child: Text('$value',
                                                  style: const TextStyle(
                                                      fontSize: 14)),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (double? newValue) =>
                                          setState(() => fontSize = newValue!),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.format_bold,
                                          size: 20),
                                      onPressed: _toggleBold,
                                      color:
                                          _isBold ? Colors.black : Colors.grey,
                                      tooltip: 'Bold',
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.format_italic,
                                          size: 20),
                                      onPressed: _toggleItalic,
                                      color: _isItalic
                                          ? Colors.black
                                          : Colors.grey,
                                      tooltip: 'Italic',
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.format_underlined,
                                          size: 20),
                                      onPressed: _toggleUnderline,
                                      color: _isUnderlined
                                          ? Colors.black
                                          : Colors.grey,
                                      tooltip: 'Underline',
                                    ),
                                    DropdownButton<TextAlign>(
                                      value: _alignment,
                                      items: const [
                                        DropdownMenuItem(
                                            value: TextAlign.left,
                                            child: Text('Left')),
                                        DropdownMenuItem(
                                            value: TextAlign.center,
                                            child: Text('Center')),
                                        DropdownMenuItem(
                                            value: TextAlign.right,
                                            child: Text('Right')),
                                      ],
                                      onChanged: (TextAlign? newValue) {
                                        if (newValue != null)
                                          _setAlignment(newValue);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.done, size: 20),
                                      onPressed: _saveText,
                                      color: Colors.green,
                                      tooltip: 'Done',
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline,
                                          size: 20),
                                      onPressed: _resetFile,
                                      color: Colors.red,
                                      tooltip: 'Delete',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                child: TextField(
                                  controller: _descriptionController,
                                  maxLines: null,
                                  minLines: 20,
                                  textAlign: _alignment,
                                  decoration: const InputDecoration(
                                    hintText: 'Write here...',
                                    border: OutlineInputBorder(),
                                  ),
                                  style: TextStyle(
                                    fontFamily: fontStyle,
                                    fontSize: fontSize,
                                    fontWeight: _isBold
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontStyle: _isItalic
                                        ? FontStyle.italic
                                        : FontStyle.normal,
                                    decoration: _isUnderlined
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Item Details',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10),
                StreamBuilder<CategoryModel>(
                  stream: getCategoryAPIRXObj.dataFetcher,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    final categoryData = snapshot.data;
                    final categories = categoryData?.data ?? [];

                    if (selectedCategoryId == null && categories.isNotEmpty) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          selectedCategoryId = categories.first.id;
                          selectedCategoryTitle = categories.first.title;
                          _categoryController.text =
                              categories.first.title ?? '';
                          final subcategories =
                              categories.first.subcategories ?? [];
                          if (subcategories.isNotEmpty) {
                            selectedSubCategoryId = subcategories.first.id;
                            selectedSubCategoryTitle =
                                subcategories.first.title;
                            _subCategoryController.text =
                                subcategories.first.title ?? '';
                          } else {
                            selectedSubCategoryId = null;
                            selectedSubCategoryTitle = null;
                            _subCategoryController.text =
                                'No subcategories available';
                          }
                        });
                      });
                    }

                    final selectedCategory = categories.firstWhere(
                      (category) => category.id == selectedCategoryId,
                      orElse: () =>
                          categories.isNotEmpty ? categories.first : Datum(),
                    );
                    final subCategoryOptions = selectedCategory.subcategories
                            ?.map((sub) => sub.title ?? '')
                            .toList() ??
                        [];

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Category*',
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  color: AppColor.blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            UIHelper.verticalSpace(10),
                            DropDownCustomTextField(
                              fieldWidth: 170.w,
                              hintText: "Category",
                              hintTextStyle: TextFontStyle
                                  .textLine7w400cFFFFFFDmSans
                                  .copyWith(
                                color: AppColor.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              controller: _categoryController,
                              dropdownItems: categories
                                  .map((category) => category.title ?? '')
                                  .toList(),
                              onItemSelected: (value) {
                                setState(() {
                                  final selected = categories.firstWhere(
                                    (category) => category.title == value,
                                    orElse: () => Datum(),
                                  );
                                  selectedCategoryId = selected.id;
                                  selectedCategoryTitle = selected.title;
                                  _categoryController.text = value;
                                  selectedSubCategoryId = null;
                                  selectedSubCategoryTitle = null;
                                  _subCategoryController.clear();
                                  final subcategories =
                                      selected.subcategories ?? [];
                                  if (subcategories.isNotEmpty) {
                                    selectedSubCategoryId =
                                        subcategories.first.id;
                                    selectedSubCategoryTitle =
                                        subcategories.first.title;
                                    _subCategoryController.text =
                                        subcategories.first.title ?? '';
                                  } else {
                                    _subCategoryController.text =
                                        'No subcategories available';
                                  }
                                });
                                print("Category ID: $selectedCategoryId");
                              },
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Sub Category*',
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  color: AppColor.blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            UIHelper.verticalSpace(10),
                            DropDownCustomTextField(
                              fieldWidth: 170.w,
                              hintText: subCategoryOptions.isEmpty
                                  ? "No subcategories available"
                                  : "Sub-Category",
                              hintTextStyle: TextFontStyle
                                  .textLine7w400cFFFFFFDmSans
                                  .copyWith(
                                color: AppColor.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              controller: _subCategoryController,
                              dropdownItems: subCategoryOptions,
                              isEnabled: subCategoryOptions.isNotEmpty,
                              onItemSelected: (value) {
                                setState(() {
                                  final selected = selectedCategory
                                      .subcategories
                                      ?.firstWhere(
                                    (sub) => sub.title == value,
                                    orElse: () => Subcategory(),
                                  );
                                  selectedSubCategoryId = selected?.id;
                                  selectedSubCategoryTitle = selected?.title;
                                  _subCategoryController.text = value;
                                });
                                log("Sub Category ID: $selectedSubCategoryId");
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                UIHelper.verticalSpaceMedium,

                // * ############################# Property Section Started ##################################
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Properties',
                      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        color: AppColor.blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    // * Add Property Button (Add)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          final lastRow = propertyRows.last;
                          final selectedTitle =
                              lastRow['selectedTitle'] as String?;
                          final selectedValue =
                              lastRow['selectedValue'] as String?;
                          if (selectedTitle != null &&
                              selectedValue != null &&
                              selectedTitle.isNotEmpty &&
                              selectedValue.isNotEmpty &&
                              selectedTitle != 'Add New Item' &&
                              selectedValue != 'Add New Item') {
                            if (!valueOptions.contains(selectedValue)) {
                              valueOptions.insert(
                                  valueOptions.length - 1, selectedValue);
                            }
                            if (titleValuePairs.length >
                                propertyRows.length - 1) {
                              titleValuePairs.last = {
                                'title': selectedTitle,
                                'value': selectedValue,
                              };
                            } else {
                              titleValuePairs.add({
                                'title': selectedTitle,
                                'value': selectedValue,
                              });
                            }
                          }
                          propertyRows.add({
                            'selectedTitle': '',
                            'selectedValue': '',
                            'titleController': TextEditingController(),
                            'valueController': TextEditingController(),
                          });
                          //_logTitleValuePairs();
                        });
                      },
                      child: Text(
                        'Add',
                        style:
                            TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                          color: AppColor.c4275F6,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceMedium,

                StreamBuilder<PropertyModel>(
                  stream: getPropertyAPIRXObj.dataFetcher,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    final propertyData = snapshot.data;
                    final titleOptions = [
                      ...?propertyData?.data
                          ?.map((datum) => datum.title ?? '')
                          .toList(),
                      'Add New Item'
                    ];

                    return Column(
                      children: List.generate(propertyRows.length, (index) {
                        final row = propertyRows[index];
                        final titleController =
                            row['titleController'] as TextEditingController;
                        final valueController =
                            row['valueController'] as TextEditingController;

                        // Store selected title
                        var selectedTitle = row['selectedTitle'] as String?;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // * Title Text
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Title*',
                                    style: TextFontStyle
                                        .textLine7w400cFFFFFFDmSans
                                        .copyWith(
                                      color: AppColor.blackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                UIHelper.verticalSpace(10),

                                // * ############################################################
                                // * ##################### Add Properties #######################
                                // * ############################################################
                                SizedBox(
                                  width: 150.w,
                                  child: DropDownCustomTextField(
                                    fieldWidth: 150.w,
                                    hintText: 'Title',
                                    hintTextStyle: TextFontStyle
                                        .textLine7w400cFFFFFFDmSans
                                        .copyWith(
                                      color: AppColor.blackColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    controller: titleController,
                                    dropdownItems: titleOptions,
                                    onItemSelected: (value) {
                                      setState(() {
                                        if (value == 'Add New Item') {
                                          row['selectedTitle'] = '';
                                          titleController.clear();
                                          row['selectedValue'] = '';
                                          valueController.clear();
                                        } else {
                                          row['selectedTitle'] = value;
                                          titleController.text = value;
                                          selectedTitle = titleController.text;
                                          // Clear previous value when title changes
                                          row['selectedValue'] = '';
                                          valueController.clear();
                                          // Call API to fetch sub-properties for the selected title
                                          getSubPropertyAPIRXObj
                                              .getSubPropertyRX(value);
                                        }
                                        if (index < titleValuePairs.length) {
                                          titleValuePairs[index] = {
                                            'title':
                                                row['selectedTitle'] as String,
                                            'value':
                                                row['selectedValue'] as String,
                                          };
                                        } else {
                                          titleValuePairs.add({
                                            'title':
                                                row['selectedTitle'] as String,
                                            'value':
                                                row['selectedValue'] as String,
                                          });
                                        }
                                        print('Selected Title: $value');
                                      });
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        row['selectedTitle'] = value;
                                        if (index < titleValuePairs.length) {
                                          titleValuePairs[index] = {
                                            'title': value,
                                            // 'value':
                                            //     row['selectedValue'] as String,
                                          };
                                        }
                                        print('Title Changed: $value');
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Value*',
                                    style: TextFontStyle
                                        .textLine7w400cFFFFFFDmSans
                                        .copyWith(
                                      color: AppColor.blackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                UIHelper.verticalSpace(10),

                                // * value text
                                StreamBuilder<SubPropertyModel>(
                                  stream: getSubPropertyAPIRXObj.dataFetcher,
                                  builder: (context, subSnapshot) {
                                    List<String> subPropertyOptions = [
                                      'Add New Item'
                                    ];

                                    final subPropertyData = subSnapshot.data;
                                    if (subPropertyData != null &&
                                        subPropertyData.data != null) {
                                      subPropertyOptions = [
                                        ...subPropertyData.data!
                                            .map((sub) => sub.value ?? '')
                                            .toList(),
                                        'Add New Item'
                                      ];
                                    }

                                    return SizedBox(
                                      width: 150.w,
                                      child: DropDownCustomTextField(
                                        fieldWidth: 150.w,
                                        hintText: 'Value',
                                        hintTextStyle: TextFontStyle
                                            .textLine7w400cFFFFFFDmSans
                                            .copyWith(
                                          color: AppColor.blackColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        controller: valueController,
                                        dropdownItems: subPropertyOptions,
                                        onItemSelected: (value) {
                                          setState(() {
                                            if (value == 'Add New Item') {
                                              row['selectedValue'] = '';
                                              valueController.clear();
                                            } else {
                                              row['selectedValue'] = value;
                                              valueController.text = value;
                                            }
                                            if (index <
                                                titleValuePairs.length) {
                                              titleValuePairs[index] = {
                                                'title': row['selectedTitle']
                                                    as String,
                                                'value': row['selectedValue']
                                                    as String,
                                              };
                                            } else {
                                              titleValuePairs.add({
                                                'title': row['selectedTitle']
                                                    as String,
                                                'value': row['selectedValue']
                                                    as String,
                                              });
                                            }
                                            log('Selected Value for Title ${row['selectedTitle']}: $value');
                                          });
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            row['selectedValue'] = value;
                                            if (index <
                                                titleValuePairs.length) {
                                              titleValuePairs[index] = {
                                                'title': row['selectedTitle']
                                                    as String,
                                                'value': value,
                                              };
                                            }
                                          });
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (index < titleValuePairs.length) {
                                    titleValuePairs.removeAt(index);
                                  }
                                  propertyRows[index]['titleController']
                                      ?.dispose();
                                  // propertyRows[index]['valueController']
                                  //     ?.dispose();
                                  propertyRows.removeAt(index);
                                  // _logTitleValuePairs();
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 30.h),
                                child: SvgPicture.asset(
                                  AppIcons.blueCross,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    );
                  },
                ),
                // * ############################# Property Section Ended ##################################

                UIHelper.verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      onTap: () {},
                      text: 'Back',
                      context: context,
                      minWidth: 170,
                      color: AppColor.cF3F2F2,
                      textStyle:
                          TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        color: AppColor.blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    CustomButton(
                      onTap: () async {
                        print(titleValuePairs);
                        var titleList =
                            titleValuePairs.map((e) => e['title']).toList();
                        var valueList =
                            titleValuePairs.map((e) => e['value']).toList();
                        print(titleList);
                        print(valueList);
                        await _saveText();
                        log("Description Data: $descriptionHtmlText");
                        log("Select Sub Category: ${selectedSubCategoryId.toString()}");
                        log("Select Category: ${selectedCategoryId.toString()}");
                        log("Images: $imagePaths");
                        // _logTitleValuePairs();
                        NavigationService.navigateToWithArgs(
                            Routes.finalAuctionScreen, {
                          'titleText': _titleController.text,
                          'descriptionText': descriptionHtmlText,
                          'subCategory': selectedSubCategoryId.toString(),
                          'category': selectedCategoryId.toString(),
                          'imageItem': imagePaths,
                          'propertyTitle': titleList,
                          'propertyValue': valueList,
                        });
                      },
                      text: 'Next',
                      context: context,
                      minWidth: 170.w,
                      textStyle:
                          TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        color: AppColor.cFFFFFF,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DropDownCustomTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final double? fieldHeight;
  final double? fieldWidth;
  final String? Function(String?)? validator;
  final bool isEnabled;
  final bool readOnly;
  final Widget? prefixIcon;
  final bool obscureText;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? hintTextStyle;
  final Color? fieldColor;
  final Function(String)? onChanged;
  final List<String>? dropdownItems;
  final Function(String)? onItemSelected;

  const DropDownCustomTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.inputType,
    this.fieldHeight,
    this.fieldWidth,
    this.validator,
    this.isEnabled = true,
    this.obscureText = false,
    this.prefixIcon,
    this.borderRadius,
    this.padding,
    this.hintTextStyle,
    this.fieldColor,
    this.onChanged,
    this.readOnly = false,
    this.dropdownItems,
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: fieldColor ?? AppColor.whiteColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
        border: Border.all(
          color: AppColor.blackColor.withOpacity(0.1),
          width: 1.w,
        ),
      ),
      height: fieldHeight ?? 55.h,
      width: fieldWidth ?? 343.w,
      child: TextFormField(
        controller: controller,
        validator: validator,
        enabled: isEnabled,
        obscureText: obscureText,
        readOnly: readOnly,
        minLines: 1,
        style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
          color: AppColor.blackColor,
        ),
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 17.h),
          hintText: hintText,
          hintStyle: hintTextStyle ??
              TextStyle(
                fontSize: 12.sp,
                color: AppColor.c7B7B7B,
                height: 1.50.h,
                fontWeight: FontWeight.w300,
              ),
          labelText: labelText,
          labelStyle: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
            fontSize: 10.sp,
            color: AppColor.c000000,
            fontWeight: FontWeight.w300,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          prefixIcon: prefixIcon,
          suffixIcon: dropdownItems != null
              ? GestureDetector(
                  onTap: () async {
                    final RenderBox button =
                        context.findRenderObject() as RenderBox;
                    final RenderBox overlay = Overlay.of(context)
                        .context
                        .findRenderObject() as RenderBox;

                    final RelativeRect position = RelativeRect.fromRect(
                      Rect.fromPoints(
                        button.localToGlobal(Offset.zero, ancestor: overlay),
                        button.localToGlobal(
                            button.size.bottomRight(Offset.zero),
                            ancestor: overlay),
                      ),
                      Offset.zero & overlay.size,
                    );

                    final String? selected = await showMenu<String>(
                      context: context,
                      position: position,
                      items: dropdownItems!
                          .map((e) => PopupMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    color: AppColor.blackColor,
                                  ),
                                ),
                              ))
                          .toList(),
                    );

                    if (selected != null) {
                      controller?.text = selected;
                      if (onItemSelected != null) {
                        onItemSelected!(selected);
                      }
                    }
                  },
                  child: const Icon(Icons.arrow_drop_down),
                )
              : null,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        keyboardType: inputType,
      ),
    );
  }
}

// * ###################################################################################
class DottedBorderContainer extends StatelessWidget {
  final Widget child;

  const DottedBorderContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade400,
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
