// // // ignore_for_file: unused_element
// // ignore_for_file: unused_element

// import 'dart:developer';
// import 'package:ddavila/assets_helper/app_colors.dart';
// import 'package:ddavila/assets_helper/app_icons.dart';
// import 'package:ddavila/assets_helper/app_image.dart';
// import 'package:ddavila/assets_helper/text_font_style.dart';
// import 'package:ddavila/common_widgets/custom_appbar.dart';
// import 'package:ddavila/common_widgets/custom_button.dart';
// import 'package:ddavila/features/admin_app/auction_screen/model/category_model.dart';
// import 'package:ddavila/features/admin_app/auction_screen/model/property_model.dart';
// import 'package:ddavila/features/admin_app/auction_screen/model/sub_property_model.dart';
// import 'package:ddavila/helpers/ui_helpers.dart';
// import 'package:ddavila/networks/api_acess.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'dart:convert';
// import 'package:path_provider/path_provider.dart';

// class CreateAuctionScreen extends StatefulWidget {
//   final void Function(String) onNotification;

//   static void _defaultNotification(String message) {}

//   const CreateAuctionScreen({super.key, required this.onNotification});

//   @override
//   State<CreateAuctionScreen> createState() => _CreateAuctionScreenState();
// }

// class _CreateAuctionScreenState extends State<CreateAuctionScreen> {
//   // Existing variables...
//   final TextEditingController _coreFeaturesController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   String fontStyle = 'Calibri';
//   double fontSize = 12;
//   bool _isBold = false;
//   bool _isItalic = false;
//   bool _isUnderlined = false;
//   TextAlign _alignment = TextAlign.left;
//   List<Map<String, String>> _images = []; // For description editor images
//   List<Map<String, String>> _cardImages =
//       []; // For DottedBorderContainer images
//   List<String> imagePaths = [];
//   int _imageCounter = 0;

//   // Other state variables remain unchanged...
//   int? selectedCategoryId;
//   String? selectedCategoryTitle;
//   int? selectedSubCategoryId;
//   String? selectedSubCategoryTitle;
//   final TextEditingController _categoryController = TextEditingController();
//   final TextEditingController _subCategoryController = TextEditingController();
//   List<Map<String, dynamic>> propertyRows = [];
//   List<String> valueOptions = ['Add New Item'];
//   List<Map<String, String>> titleValuePairs = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadSavedText();
//     getCategoryAPIRXObj.getCategoryRX();
//     getPropertyAPIRXObj.getPropertyRX();
//     propertyRows.add({
//       'selectedTitle': '',
//       'selectedValue': '',
//       'titleController': TextEditingController(),
//       'valueController': TextEditingController(),
//     });
//   }

//   @override
//   void dispose() {
//     _coreFeaturesController.dispose();
//     _descriptionController.dispose();
//     _categoryController.dispose();
//     _subCategoryController.dispose();
//     for (var row in propertyRows) {
//       row['titleController']?.dispose();
//       row['valueController']?.dispose();
//     }
//     super.dispose();
//   }

//   void _toggleBold() => setState(() => _isBold = !_isBold);
//   void _toggleItalic() => setState(() => _isItalic = !_isItalic);
//   void _toggleUnderline() => setState(() => _isUnderlined = !_isUnderlined);
//   void _setAlignment(TextAlign alignment) =>
//       setState(() => _alignment = alignment);

//   Future<void> _resetFile() async {
//     try {
//       final file = File(
//           '${(await getApplicationDocumentsDirectory()).path}/editor_text.html');
//       if (await file.exists()) await file.delete();
//       if (mounted) {
//         setState(() {
//           _coreFeaturesController.text = '';
//           _descriptionController.text = '';
//           _images.clear();
//           _imageCounter = 0;
//         });
//         widget.onNotification('Content reset successfully!');
//       }
//     } catch (e) {
//       if (mounted) {
//         widget.onNotification('Failed to reset content');
//       }
//     }
//   }

//   // Modified _loadSavedText (unchanged, included for context)
//   Future<void> _loadSavedText() async {
//     try {
//       final directory = await getApplicationDocumentsDirectory();
//       final file = File('${directory.path}/editor_text.html');
//       if (!await file.exists()) return;

//       final savedText = await file.readAsString();
//       final RegExp divRegex = RegExp(r'<div>(.*?)</div>', dotAll: true);
//       final RegExpMatch? match = divRegex.firstMatch(savedText);
//       String textContent = match?.group(1) ?? '';

//       final RegExp imageRegex = RegExp(
//           r'<a href="([^"]*)"><img src="([^"]*)" alt="Inserted Image"[^>]*></a>',
//           multiLine: true);
//       final imageMatches = imageRegex.allMatches(savedText).toList();
//       _images.clear();
//       _imageCounter = 0;

//       for (var match in imageMatches) {
//         _imageCounter++;
//         _images.add({
//           'src': match.group(2) ?? '',
//           'link': match.group(1) ?? '',
//         });
//       }

//       textContent = textContent
//           .replaceAll('<br>', '\n')
//           .replaceAllMapped(imageRegex, (Match match) {
//         final index = imageMatches.indexOf(match as RegExpMatch) + 1;
//         return '[image$index]';
//       }).replaceAll(RegExp(r'[^\x00-\x7F\n\[\]\d]'), '');

//       if (mounted) {
//         setState(() {
//           _coreFeaturesController.text = textContent;
//           _descriptionController.text = '';
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         widget.onNotification('Failed to load saved content');
//       }
//     }
//   }

//   // Modified _saveText (unchanged, included for context)
//   Future<void> _saveText() async {
//     try {
//       final directory = await getApplicationDocumentsDirectory();
//       final file = File('${directory.path}/editor_text.html');
//       String textWithImages = _coreFeaturesController.text;
//       String descriptionText = _descriptionController.text;

//       String styledText = textWithImages
//           .replaceAll('&', '&amp;')
//           .replaceAll('<', '&lt;')
//           .replaceAll('>', '&gt;');

//       if (_isBold) styledText = '<b>$styledText</b>';
//       if (_isItalic) styledText = '<i>$styledText</i>';
//       if (_isUnderlined) styledText = '<u>$styledText</u>';

//       for (int i = 0; i < _images.length; i++) {
//         final image = _images[i];
//         final src = image['src']!;
//         final link = image['link']!.isNotEmpty ? image['link']! : src;
//         final imageBlock = '''
// <a href="$link" target="_blank" rel="noopener">
//   <img src="$src" alt="Inserted Image" style="max-width: 100%; height: auto; display: inline; vertical-align: middle;">
// </a>
// ''';
//         styledText = styledText.replaceAll('[image${i + 1}]', imageBlock);
//       }

//       String htmlContent = '''
// <!DOCTYPE html>
// <html>
// <head>
//   <meta charset="utf-8">
//   <style>
//     body { font-family: $fontStyle; font-size: ${fontSize}px; margin: 16px; }
//     .bold { font-weight: bold; }
//     .italic { font-style: italic; }
//     .underline { text-decoration: underline; }
//     .left { text-align: left; }
//     .center { text-align: center; }
//     .right { text-align: right; }
//     a { color: #1a73e8; }
//     img { vertical-align: middle; }
//   </style>
// </head>
// <body class="${_alignment == TextAlign.center ? 'center' : _alignment == TextAlign.right ? 'right' : 'left'}">
//   <div>
//     ${styledText.replaceAll('\n', '<br>')}
//   </div>
// </body>
// </html>
// ''';

//       await file.writeAsString(htmlContent);
//       if (mounted) {
//         widget.onNotification('Saved as HTML successfully!');
//       }
//     } catch (e) {
//       if (mounted) {
//         widget.onNotification('Failed to save content');
//       }
//     }
//   }

//   // Modified _pickImagesFromGallery
//   Future<void> _pickImagesFromGallery() async {
//     try {
//       final picker = ImagePicker();
//       final List<XFile>? pickedImages =
//           await picker.pickMultiImage(imageQuality: 85);
//       if (!mounted || pickedImages == null || pickedImages.isEmpty) return;

//       List<String> newPaths = [];
//       List<Map<String, String>> newCardImages = [];
//       for (var picked in pickedImages) {
//         final file = File(picked.path);
//         final fileSize = await file.length() / (1024 * 1024); // Size in MB
//         if (fileSize > 25) {
//           widget.onNotification('Image ${picked.name} exceeds 25 MB limit');
//           continue;
//         }

//         final bytes = await picked.readAsBytes();
//         final b64 = base64Encode(bytes);
//         final pathLower = picked.path.toLowerCase();
//         String mime = 'image/jpeg';
//         if (pathLower.endsWith('.png')) {
//           mime = 'image/png';
//         } else if (pathLower.endsWith('.gif')) {
//           mime = 'image/gif';
//         } else if (pathLower.endsWith('.webp')) {
//           mime = 'image/webp';
//         } else if (pathLower.endsWith('.bmp')) {
//           mime = 'image/bmp';
//         } else if (pathLower.endsWith('.heic') || pathLower.endsWith('.heif')) {
//           mime = 'image/heic';
//         }

//         final dataUrl = 'data:$mime;base64,$b64';
//         newPaths.add(picked.path);
//         newCardImages.add({'src': dataUrl, 'link': ''});
//       }

//       if (newPaths.isNotEmpty) {
//         setState(() {
//           imagePaths.addAll(newPaths);
//           _cardImages.addAll(newCardImages);
//         });
//         print('Selected image paths: $imagePaths');
//         widget.onNotification('Images added from gallery');
//       }
//     } catch (e) {
//       if (mounted) {
//         widget.onNotification('Failed to add images from gallery: $e');
//       }
//     }
//   }

//   // Modified _pickImageFromCamera
//   Future<void> _pickImageFromCamera() async {
//     try {
//       final picker = ImagePicker();
//       final XFile? picked =
//           await picker.pickImage(source: ImageSource.camera, imageQuality: 85);
//       if (!mounted || picked == null) return;

//       final file = File(picked.path);
//       final fileSize = await file.length() / (1024 * 1024); // Size in MB
//       if (fileSize > 25) {
//         widget.onNotification('Image exceeds 25 MB limit');
//         return;
//       }

//       final bytes = await picked.readAsBytes();
//       final b64 = base64Encode(bytes);
//       final pathLower = picked.path.toLowerCase();
//       String mime = 'image/jpeg';
//       if (pathLower.endsWith('.png')) {
//         mime = 'image/png';
//       } else if (pathLower.endsWith('.gif')) {
//         mime = 'image/gif';
//       } else if (pathLower.endsWith('.webp')) {
//         mime = 'image/webp';
//       } else if (pathLower.endsWith('.bmp')) {
//         mime = 'image/bmp';
//       } else if (pathLower.endsWith('.heic') || pathLower.endsWith('.heif')) {
//         mime = 'image/heic';
//       }

//       final dataUrl = 'data:$mime;base64,$b64';

//       setState(() {
//         _cardImages.add({'src': dataUrl, 'link': ''});
//         imagePaths.add(picked.path);
//         print('Selected image paths: $imagePaths');
//       });

//       if (mounted) {
//         widget.onNotification('Image added from camera');
//       }
//     } catch (e) {
//       if (mounted) {
//         widget.onNotification('Failed to add image from camera: $e');
//       }
//     }
//   }

//   // _insertImagePlaceholder (unchanged, included for context)
//   void _insertImagePlaceholder(int index) {
//     final cursorPos = _coreFeaturesController.selection.baseOffset;
//     final text = _coreFeaturesController.text;
//     final placeholder = '[image$index]';
//     final newText = cursorPos >= 0
//         ? text.replaceRange(cursorPos, cursorPos, placeholder)
//         : '$text$placeholder';
//     if (mounted) {
//       setState(() {
//         _coreFeaturesController.text = newText;
//         _coreFeaturesController.selection = TextSelection.collapsed(
//             offset: cursorPos >= 0
//                 ? cursorPos + placeholder.length
//                 : newText.length);
//       });
//     }
//   }

//   // Modified _pickImageFromGallery (for description editor, unchanged)
//   Future<void> _pickImageFromGallery() async {
//     try {
//       final picker = ImagePicker();
//       final XFile? picked =
//           await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
//       if (!mounted || picked == null) return;

//       final bytes = await picked.readAsBytes();
//       final b64 = base64Encode(bytes);
//       final pathLower = picked.path.toLowerCase();
//       String mime = 'image/jpeg';
//       if (pathLower.endsWith('.png')) {
//         mime = 'image/png';
//       } else if (pathLower.endsWith('.gif')) {
//         mime = 'image/gif';
//       } else if (pathLower.endsWith('.webp')) {
//         mime = 'image/webp';
//       } else if (pathLower.endsWith('.bmp')) {
//         mime = 'image/bmp';
//       } else if (pathLower.endsWith('.heic') || pathLower.endsWith('.heif')) {
//         mime = 'image/heic';
//       }

//       final dataUrl = 'data:$mime;base64,$b64';

//       setState(() {
//         _imageCounter++;
//         _images.add({'src': dataUrl, 'link': ''});
//         _insertImagePlaceholder(_imageCounter);
//       });

//       if (mounted) {
//         widget.onNotification('Image added from gallery');
//       }
//     } catch (e) {
//       if (mounted) {
//         widget.onNotification('Failed to add image from gallery');
//       }
//     }
//   }

//   // Modified _addImageFromUrl (for description editor, unchanged)
//   Future<void> _addImageFromUrl() async {
//     final urlController = TextEditingController();
//     final url = await showDialog<String>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Enter Image URL'),
//         content: TextField(
//           controller: urlController,
//           decoration:
//               const InputDecoration(hintText: 'https://example.com/image.jpg'),
//           keyboardType: TextInputType.url,
//         ),
//         actions: [
//           TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel')),
//           TextButton(
//               onPressed: () =>
//                   Navigator.pop(context, urlController.text.trim()),
//               child: const Text('OK')),
//         ],
//       ),
//     );

//     if (!mounted || url == null || url.isEmpty) return;

//     setState(() {
//       _imageCounter++;
//       _images.add({'src': url, 'link': ''});
//       _insertImagePlaceholder(_imageCounter);
//     });
//   }

//   // Modified _addCustomLink (for description editor, unchanged)
//   Future<void> _addCustomLink() async {
//     final urlController = TextEditingController();
//     final url = await showDialog<String>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Enter Link URL (optional)'),
//         content: TextField(
//           controller: urlController,
//           decoration: const InputDecoration(hintText: 'https://example.com'),
//           keyboardType: TextInputType.url,
//         ),
//         actions: [
//           TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel')),
//           TextButton(
//               onPressed: () =>
//                   Navigator.pop(context, urlController.text.trim()),
//               child: const Text('OK')),
//         ],
//       ),
//     );

//     if (!mounted || url == null || url.isEmpty || _images.isEmpty) return;

//     setState(() {
//       _images.last['link'] = url;
//     });
//   }

//   // Modified _showImageSourceDialog (unchanged, included for context)
//   Future<void> _showImageSourceDialog() async {
//     final source = await showDialog<ImageSource>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Select Image Source'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               title: const Text('Gallery'),
//               onTap: () => Navigator.pop(context, ImageSource.gallery),
//             ),
//             ListTile(
//               title: const Text('Camera'),
//               onTap: () => Navigator.pop(context, ImageSource.camera),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//         ],
//       ),
//     );

//     if (!mounted || source == null) return;

//     if (source == ImageSource.gallery) {
//       await _pickImagesFromGallery();
//     } else if (source == ImageSource.camera) {
//       await _pickImageFromCamera();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final hasAnyImage = _cardImages.isNotEmpty; // Changed to _cardImages
//     return Scaffold(
//       appBar: CustomAppBar(text: 'Create Auction'),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 // Other UI elements unchanged...
//                 Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     'Create Listing',
//                     style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                       color: AppColor.blackColor,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     'Our Standard Service Plan is designed for homeowners who want a reliable and cost-effective solution without compromising on quality. ',
//                     style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                       color: AppColor.c666666,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w800,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 UIHelper.verticalSpace(10),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SvgPicture.asset(AppIcons.lineIcon),
//                     Text(
//                       'Item Details',
//                       style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                         color: AppColor.blackColor,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                     SvgPicture.asset(AppIcons.lineIcon),
//                   ],
//                 ),
//                 UIHelper.verticalSpace(10),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Item Details',
//                     style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                       color: AppColor.blackColor,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                 ),
//                 UIHelper.verticalSpace(10),
//                 GestureDetector(
//                   onTap: _showImageSourceDialog,
//                   child: DottedBorderContainer(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         hasAnyImage
//                             ? SizedBox(
//                                 height: 60,
//                                 child: ListView.builder(
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: _cardImages
//                                       .length, // Changed to _cardImages
//                                   itemBuilder: (context, index) {
//                                     final image = _cardImages[index];
//                                     return Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 4),
//                                       child: image['src']!.startsWith('data:')
//                                           ? Image.memory(
//                                               base64Decode(image['src']!
//                                                   .split(',')
//                                                   .last),
//                                               width: 48,
//                                               height: 48,
//                                               fit: BoxFit.cover,
//                                             )
//                                           : Image.network(
//                                               image['src']!,
//                                               width: 48,
//                                               height: 48,
//                                               fit: BoxFit.cover,
//                                             ),
//                                     );
//                                   },
//                                 ),
//                               )
//                             : CircleAvatar(
//                                 radius: 24,
//                                 backgroundColor: Colors.grey.shade100,
//                                 child: Image.asset(AppImages.picImage),
//                               ),
//                         const SizedBox(height: 12),
//                         Text(
//                           "Click to Upload Front Side of Card",
//                           style:
//                               TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                             color: AppColor.blackColor,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w800,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           "(Max. File size: 25 MB)",
//                           style:
//                               TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                             color: AppColor.blackColor,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w800,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 UIHelper.verticalSpace(10),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Description',
//                     style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                       color: AppColor.blackColor,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                 ),
//                 // * Description editor (unchanged)...
//                 Padding(
//                   padding: const EdgeInsets.all(5),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[100],
//                       border: Border.all(color: Colors.red, width: 1),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: SingleChildScrollView(
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 4, vertical: 2),
//                               color: Colors.grey[200],
//                               height: 48,
//                               child: SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child: Row(
//                                   children: [
//                                     DropdownButton<String>(
//                                       value: fontStyle,
//                                       items: <String>[
//                                         'Calibri',
//                                         'Arial',
//                                         'Times New Roman'
//                                       ]
//                                           .map<DropdownMenuItem<String>>(
//                                             (String value) =>
//                                                 DropdownMenuItem<String>(
//                                               value: value,
//                                               child: Text(value,
//                                                   style: const TextStyle(
//                                                       fontSize: 14)),
//                                             ),
//                                           )
//                                           .toList(),
//                                       onChanged: (String? newValue) =>
//                                           setState(() => fontStyle = newValue!),
//                                     ),
//                                     const SizedBox(width: 4),
//                                     DropdownButton<double>(
//                                       value: fontSize,
//                                       items: [12.0, 14.0, 16.0, 18.0, 20.0]
//                                           .map<DropdownMenuItem<double>>(
//                                             (double value) =>
//                                                 DropdownMenuItem<double>(
//                                               value: value,
//                                               child: Text('$value',
//                                                   style: const TextStyle(
//                                                       fontSize: 14)),
//                                             ),
//                                           )
//                                           .toList(),
//                                       onChanged: (double? newValue) =>
//                                           setState(() => fontSize = newValue!),
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.format_bold,
//                                           size: 20),
//                                       onPressed: _toggleBold,
//                                       color:
//                                           _isBold ? Colors.black : Colors.grey,
//                                       tooltip: 'Bold',
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.format_italic,
//                                           size: 20),
//                                       onPressed: _toggleItalic,
//                                       color: _isItalic
//                                           ? Colors.black
//                                           : Colors.grey,
//                                       tooltip: 'Italic',
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.format_underlined,
//                                           size: 20),
//                                       onPressed: _toggleUnderline,
//                                       color: _isUnderlined
//                                           ? Colors.black
//                                           : Colors.grey,
//                                       tooltip: 'Underline',
//                                     ),
//                                     // IconButton(
//                                     //   icon: const Icon(Icons.photo_library,
//                                     //       size: 20),
//                                     //   onPressed: _pickImageFromGallery,
//                                     //   tooltip: 'Add image from Gallery',
//                                     // ),
//                                     // IconButton(
//                                     //   icon: const Icon(Icons.image, size: 20),
//                                     //   onPressed: _addImageFromUrl,
//                                     //   tooltip: 'Add image from URL',
//                                     // ),
//                                     IconButton(
//                                       icon: const Icon(Icons.link, size: 20),
//                                       onPressed: _addCustomLink,
//                                       tooltip: 'Wrap image with custom link',
//                                     ),
//                                     DropdownButton<TextAlign>(
//                                       value: _alignment,
//                                       items: const [
//                                         DropdownMenuItem(
//                                             value: TextAlign.left,
//                                             child: Text('Left')),
//                                         DropdownMenuItem(
//                                             value: TextAlign.center,
//                                             child: Text('Center')),
//                                         DropdownMenuItem(
//                                             value: TextAlign.right,
//                                             child: Text('Right')),
//                                       ],
//                                       onChanged: (TextAlign? newValue) {
//                                         if (newValue != null)
//                                           _setAlignment(newValue);
//                                       },
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.done, size: 20),
//                                       onPressed: _saveText,
//                                       color: Colors.green,
//                                       tooltip: 'Done',
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.delete_outline,
//                                           size: 20),
//                                       onPressed: _resetFile,
//                                       color: Colors.red,
//                                       tooltip: 'Delete',
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             if (_images.isNotEmpty) // Changed to _images
//                               Container(
//                                 width: double.infinity,
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 8, vertical: 6),
//                                 child: Column(
//                                   children:
//                                       _images.asMap().entries.map((entry) {
//                                     final index = entry.key + 1;
//                                     final image = entry.value;
//                                     return Row(
//                                       children: [
//                                         Text('Image $index:',
//                                             style:
//                                                 const TextStyle(fontSize: 12)),
//                                         const SizedBox(width: 8),
//                                         Expanded(
//                                           child: Text(
//                                             image['src']!.startsWith('data:')
//                                                 ? 'Gallery image (base64)'
//                                                 : image['src']!,
//                                             overflow: TextOverflow.ellipsis,
//                                             style: const TextStyle(
//                                                 fontSize: 12,
//                                                 color: Colors.black54),
//                                           ),
//                                         ),
//                                         TextButton(
//                                           onPressed: () => setState(() {
//                                             _images.removeAt(index - 1);
//                                             _descriptionController.text =
//                                                 _descriptionController.text
//                                                     .replaceAll(
//                                                         '[image$index]', '');
//                                             _imageCounter = _images.length;
//                                           }),
//                                           child: const Text('Remove'),
//                                         ),
//                                       ],
//                                     );
//                                   }).toList(),
//                                 ),
//                               ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Material(
//                                 child: TextField(
//                                   controller: _descriptionController,
//                                   maxLines: null,
//                                   minLines: 20,
//                                   textAlign: _alignment,
//                                   decoration: const InputDecoration(
//                                     hintText: 'Write here...',
//                                     border: OutlineInputBorder(),
//                                   ),
//                                   style: TextStyle(
//                                     fontFamily: fontStyle,
//                                     fontSize: fontSize,
//                                     fontWeight: _isBold
//                                         ? FontWeight.bold
//                                         : FontWeight.normal,
//                                     fontStyle: _isItalic
//                                         ? FontStyle.italic
//                                         : FontStyle.normal,
//                                     decoration: _isUnderlined
//                                         ? TextDecoration.underline
//                                         : TextDecoration.none,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Rest of the UI (Core Features, Category, Subcategory, Properties, etc.) remains unchanged...
//                 UIHelper.verticalSpace(10),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Core Features',
//                     style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                       color: AppColor.blackColor,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                 ),
//                 // Core Features editor (unchanged, but uses _images)...
//                 Padding(
//                   padding: const EdgeInsets.all(5),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[100],
//                       border: Border.all(color: Colors.red, width: 1),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: SingleChildScrollView(
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 4, vertical: 2),
//                               color: Colors.grey[200],
//                               height: 48,
//                               child: SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child: Row(
//                                   children: [
//                                     DropdownButton<String>(
//                                       value: fontStyle,
//                                       items: <String>[
//                                         'Calibri',
//                                         'Arial',
//                                         'Times New Roman'
//                                       ]
//                                           .map<DropdownMenuItem<String>>(
//                                             (String value) =>
//                                                 DropdownMenuItem<String>(
//                                               value: value,
//                                               child: Text(value,
//                                                   style: const TextStyle(
//                                                       fontSize: 14)),
//                                             ),
//                                           )
//                                           .toList(),
//                                       onChanged: (String? newValue) =>
//                                           setState(() => fontStyle = newValue!),
//                                     ),
//                                     const SizedBox(width: 4),
//                                     DropdownButton<double>(
//                                       value: fontSize,
//                                       items: [12.0, 14.0, 16.0, 18.0, 20.0]
//                                           .map<DropdownMenuItem<double>>(
//                                             (double value) =>
//                                                 DropdownMenuItem<double>(
//                                               value: value,
//                                               child: Text('$value',
//                                                   style: const TextStyle(
//                                                       fontSize: 14)),
//                                             ),
//                                           )
//                                           .toList(),
//                                       onChanged: (double? newValue) =>
//                                           setState(() => fontSize = newValue!),
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.format_bold,
//                                           size: 20),
//                                       onPressed: _toggleBold,
//                                       color:
//                                           _isBold ? Colors.black : Colors.grey,
//                                       tooltip: 'Bold',
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.format_italic,
//                                           size: 20),
//                                       onPressed: _toggleItalic,
//                                       color: _isItalic
//                                           ? Colors.black
//                                           : Colors.grey,
//                                       tooltip: 'Italic',
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.format_underlined,
//                                           size: 20),
//                                       onPressed: _toggleUnderline,
//                                       color: _isUnderlined
//                                           ? Colors.black
//                                           : Colors.grey,
//                                       tooltip: 'Underline',
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.photo_library,
//                                           size: 20),
//                                       onPressed: _pickImageFromGallery,
//                                       tooltip: 'Add image from Gallery',
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.image, size: 20),
//                                       onPressed: _addImageFromUrl,
//                                       tooltip: 'Add image from URL',
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.link, size: 20),
//                                       onPressed: _addCustomLink,
//                                       tooltip: 'Wrap image with custom link',
//                                     ),
//                                     DropdownButton<TextAlign>(
//                                       value: _alignment,
//                                       items: const [
//                                         DropdownMenuItem(
//                                             value: TextAlign.left,
//                                             child: Text('Left')),
//                                         DropdownMenuItem(
//                                             value: TextAlign.center,
//                                             child: Text('Center')),
//                                         DropdownMenuItem(
//                                             value: TextAlign.right,
//                                             child: Text('Right')),
//                                       ],
//                                       onChanged: (TextAlign? newValue) {
//                                         if (newValue != null)
//                                           _setAlignment(newValue);
//                                       },
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.done, size: 20),
//                                       onPressed: _saveText,
//                                       color: Colors.green,
//                                       tooltip: 'Done',
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.delete_outline,
//                                           size: 20),
//                                       onPressed: _resetFile,
//                                       color: Colors.red,
//                                       tooltip: 'Delete',
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             if (_images.isNotEmpty)
//                               Container(
//                                 width: double.infinity,
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 8, vertical: 6),
//                                 child: Column(
//                                   children:
//                                       _images.asMap().entries.map((entry) {
//                                     final index = entry.key + 1;
//                                     final image = entry.value;
//                                     return Row(
//                                       children: [
//                                         Text('Image $index:',
//                                             style:
//                                                 const TextStyle(fontSize: 12)),
//                                         const SizedBox(width: 8),
//                                         Expanded(
//                                           child: Text(
//                                             image['src']!.startsWith('data:')
//                                                 ? 'Gallery image (base64)'
//                                                 : image['src']!,
//                                             overflow: TextOverflow.ellipsis,
//                                             style: const TextStyle(
//                                                 fontSize: 12,
//                                                 color: Colors.black54),
//                                           ),
//                                         ),
//                                         TextButton(
//                                           onPressed: () => setState(() {
//                                             _images.removeAt(index - 1);
//                                             _coreFeaturesController.text =
//                                                 _coreFeaturesController.text
//                                                     .replaceAll(
//                                                         '[image$index]', '');
//                                             _imageCounter = _images.length;
//                                           }),
//                                           child: const Text('Remove'),
//                                         ),
//                                       ],
//                                     );
//                                   }).toList(),
//                                 ),
//                               ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Material(
//                                 child: TextField(
//                                   controller: _coreFeaturesController,
//                                   maxLines: null,
//                                   minLines: 20,
//                                   textAlign: _alignment,
//                                   decoration: const InputDecoration(
//                                     hintText: 'Write here...',
//                                     border: OutlineInputBorder(),
//                                   ),
//                                   style: TextStyle(
//                                     fontFamily: fontStyle,
//                                     fontSize: fontSize,
//                                     fontWeight: _isBold
//                                         ? FontWeight.bold
//                                         : FontWeight.normal,
//                                     fontStyle: _isItalic
//                                         ? FontStyle.italic
//                                         : FontStyle.normal,
//                                     decoration: _isUnderlined
//                                         ? TextDecoration.underline
//                                         : TextDecoration.none,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Rest of the UI remains unchanged...
//                 UIHelper.verticalSpace(10),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Item Details',
//                     style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                       color: AppColor.blackColor,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                 ),
//                 UIHelper.verticalSpace(10),
//                 StreamBuilder<CategoryModel>(
//                   stream: getCategoryAPIRXObj.dataFetcher,
//                   builder: (context, snapshot) {
//                     // Unchanged Category StreamBuilder...
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const CircularProgressIndicator();
//                     }

//                     if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     }

//                     final categoryData = snapshot.data;
//                     final categories = categoryData?.data ?? [];

//                     if (selectedCategoryId == null && categories.isNotEmpty) {
//                       WidgetsBinding.instance.addPostFrameCallback((_) {
//                         setState(() {
//                           selectedCategoryId = categories.first.id;
//                           selectedCategoryTitle = categories.first.title;
//                           _categoryController.text =
//                               categories.first.title ?? '';
//                           final subcategories =
//                               categories.first.subcategories ?? [];
//                           if (subcategories.isNotEmpty) {
//                             selectedSubCategoryId = subcategories.first.id;
//                             selectedSubCategoryTitle =
//                                 subcategories.first.title;
//                             _subCategoryController.text =
//                                 subcategories.first.title ?? '';
//                           } else {
//                             selectedSubCategoryId = null;
//                             selectedSubCategoryTitle = null;
//                             _subCategoryController.text =
//                                 'No subcategories available';
//                           }
//                         });
//                       });
//                     }

//                     final selectedCategory = categories.firstWhere(
//                       (category) => category.id == selectedCategoryId,
//                       orElse: () =>
//                           categories.isNotEmpty ? categories.first : Datum(),
//                     );
//                     final subCategoryOptions = selectedCategory.subcategories
//                             ?.map((sub) => sub.title ?? '')
//                             .toList() ??
//                         [];

//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 'Category*',
//                                 style: TextFontStyle.textLine7w400cFFFFFFDmSans
//                                     .copyWith(
//                                   color: AppColor.blackColor,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w800,
//                                 ),
//                               ),
//                             ),
//                             UIHelper.verticalSpace(10),
//                             DropDownCustomTextField(
//                               fieldWidth: 170.w,
//                               hintText: "Category",
//                               hintTextStyle: TextFontStyle
//                                   .textLine7w400cFFFFFFDmSans
//                                   .copyWith(
//                                 color: AppColor.blackColor,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                               controller: _categoryController,
//                               dropdownItems: categories
//                                   .map((category) => category.title ?? '')
//                                   .toList(),
//                               onItemSelected: (value) {
//                                 setState(() {
//                                   final selected = categories.firstWhere(
//                                     (category) => category.title == value,
//                                     orElse: () => Datum(),
//                                   );
//                                   selectedCategoryId = selected.id;
//                                   selectedCategoryTitle = selected.title;
//                                   _categoryController.text = value;
//                                   selectedSubCategoryId = null;
//                                   selectedSubCategoryTitle = null;
//                                   _subCategoryController.clear();
//                                   final subcategories =
//                                       selected.subcategories ?? [];
//                                   if (subcategories.isNotEmpty) {
//                                     selectedSubCategoryId =
//                                         subcategories.first.id;
//                                     selectedSubCategoryTitle =
//                                         subcategories.first.title;
//                                     _subCategoryController.text =
//                                         subcategories.first.title ?? '';
//                                   } else {
//                                     _subCategoryController.text =
//                                         'No subcategories available';
//                                   }
//                                 });
//                                 print("Category ID: $selectedCategoryId");
//                               },
//                             ),
//                           ],
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 'Sub Category*',
//                                 style: TextFontStyle.textLine7w400cFFFFFFDmSans
//                                     .copyWith(
//                                   color: AppColor.blackColor,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w800,
//                                 ),
//                               ),
//                             ),
//                             UIHelper.verticalSpace(10),
//                             DropDownCustomTextField(
//                               fieldWidth: 170.w,
//                               hintText: subCategoryOptions.isEmpty
//                                   ? "No subcategories available"
//                                   : "Sub-Category",
//                               hintTextStyle: TextFontStyle
//                                   .textLine7w400cFFFFFFDmSans
//                                   .copyWith(
//                                 color: AppColor.blackColor,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                               controller: _subCategoryController,
//                               dropdownItems: subCategoryOptions,
//                               isEnabled: subCategoryOptions.isNotEmpty,
//                               onItemSelected: (value) {
//                                 setState(() {
//                                   final selected = selectedCategory
//                                       .subcategories
//                                       ?.firstWhere(
//                                     (sub) => sub.title == value,
//                                     orElse: () => Subcategory(),
//                                   );
//                                   selectedSubCategoryId = selected?.id;
//                                   selectedSubCategoryTitle = selected?.title;
//                                   _subCategoryController.text = value;
//                                 });
//                                 log("Sub Category ID: $selectedSubCategoryId");
//                               },
//                             ),
//                           ],
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//                 UIHelper.verticalSpaceMedium,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Add Properties',
//                       style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                         color: AppColor.blackColor,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           final lastRow = propertyRows.last;
//                           final selectedTitle =
//                               lastRow['selectedTitle'] as String?;
//                           final selectedValue =
//                               lastRow['selectedValue'] as String?;
//                           if (selectedTitle != null &&
//                               selectedValue != null &&
//                               selectedTitle.isNotEmpty &&
//                               selectedValue.isNotEmpty &&
//                               selectedTitle != 'Add New Item' &&
//                               selectedValue != 'Add New Item') {
//                             if (!valueOptions.contains(selectedValue)) {
//                               valueOptions.insert(
//                                   valueOptions.length - 1, selectedValue);
//                             }
//                             if (titleValuePairs.length >
//                                 propertyRows.length - 1) {
//                               titleValuePairs.last = {
//                                 'title': selectedTitle,
//                                 'value': selectedValue,
//                               };
//                             } else {
//                               titleValuePairs.add({
//                                 'title': selectedTitle,
//                                 'value': selectedValue,
//                               });
//                             }
//                           }
//                           propertyRows.add({
//                             'selectedTitle': '',
//                             'selectedValue': '',
//                             'titleController': TextEditingController(),
//                             'valueController': TextEditingController(),
//                           });
//                           print('Title-Value Pairs: $titleValuePairs');
//                         });
//                       },
//                       child: Text(
//                         'Add',
//                         style:
//                             TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                           color: AppColor.c4275F6,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 UIHelper.verticalSpaceMedium,
//                 StreamBuilder<PropertyModel>(
//                   stream: getPropertyAPIRXObj.dataFetcher,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     }

//                     if (snapshot.hasError) {
//                       return Center(child: Text('Error: ${snapshot.error}'));
//                     }

//                     final propertyData = snapshot.data;
//                     final titleOptions = [
//                       ...?propertyData?.data
//                           ?.map((datum) => datum.title ?? '')
//                           .toList(),
//                       'Add New Item'
//                     ];

//                     return Column(
//                       children: List.generate(propertyRows.length, (index) {
//                         final row = propertyRows[index];
//                         final titleController =
//                             row['titleController'] as TextEditingController;
//                         final valueController =
//                             row['valueController'] as TextEditingController;
//                         return Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     'Title*',
//                                     style: TextFontStyle
//                                         .textLine7w400cFFFFFFDmSans
//                                         .copyWith(
//                                       color: AppColor.blackColor,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w800,
//                                     ),
//                                   ),
//                                 ),
//                                 UIHelper.verticalSpace(10),
//                                 SizedBox(
//                                   width: 150.w,
//                                   child: DropDownCustomTextField(
//                                     fieldWidth: 150.w,
//                                     hintText: 'Title',
//                                     hintTextStyle: TextFontStyle
//                                         .textLine7w400cFFFFFFDmSans
//                                         .copyWith(
//                                       color: AppColor.blackColor,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                     controller: titleController,
//                                     dropdownItems: titleOptions,
//                                     onItemSelected: (value) {
//                                       setState(() {
//                                         if (value == 'Add New Item') {
//                                           row['selectedTitle'] = '';
//                                           titleController.clear();
//                                         } else {
//                                           row['selectedTitle'] = value;
//                                           titleController.text = value;
//                                         }
//                                         if (index < titleValuePairs.length) {
//                                           titleValuePairs[index] = {
//                                             'title':
//                                                 row['selectedTitle'] as String,
//                                             'value':
//                                                 row['selectedValue'] as String,
//                                           };
//                                         }
//                                       });
//                                     },
//                                     onChanged: (value) {
//                                       setState(() {
//                                         row['selectedTitle'] = value;
//                                         if (index < titleValuePairs.length) {
//                                           titleValuePairs[index] = {
//                                             'title': value,
//                                             'value':
//                                                 row['selectedValue'] as String,
//                                           };
//                                         }
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     'Value*',
//                                     style: TextFontStyle
//                                         .textLine7w400cFFFFFFDmSans
//                                         .copyWith(
//                                       color: AppColor.blackColor,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w800,
//                                     ),
//                                   ),
//                                 ),
//                                 UIHelper.verticalSpace(10),
//                                 StreamBuilder<SubPropertyModel>(
//                                   stream: getSubPropertyAPIRXObj.dataFetcher,
//                                   builder: (context, snapshot) {
//                                     return SizedBox(
//                                       width: 150.w,
//                                       child: DropDownCustomTextField(
//                                         fieldWidth: 150.w,
//                                         hintText: 'Value',
//                                         hintTextStyle: TextFontStyle
//                                             .textLine7w400cFFFFFFDmSans
//                                             .copyWith(
//                                           color: AppColor.blackColor,
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                         controller: valueController,
//                                         dropdownItems: valueOptions,
//                                         onItemSelected: (value) {
//                                           setState(() {
//                                             if (value == 'Add New Item') {
//                                               row['selectedValue'] = '';
//                                               valueController.clear();
//                                             } else {
//                                               row['selectedValue'] = value;
//                                               valueController.text = value;
//                                             }
//                                             if (index <
//                                                 titleValuePairs.length) {
//                                               titleValuePairs[index] = {
//                                                 'title': row['selectedTitle']
//                                                     as String,
//                                                 'value': row['selectedValue']
//                                                     as String,
//                                               };
//                                             }
//                                           });
//                                         },
//                                         onChanged: (value) {
//                                           setState(() {
//                                             row['selectedValue'] = value;
//                                             if (index <
//                                                 titleValuePairs.length) {
//                                               titleValuePairs[index] = {
//                                                 'title': row['selectedTitle']
//                                                     as String,
//                                                 'value': value,
//                                               };
//                                             }
//                                           });
//                                         },
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   if (index < titleValuePairs.length) {
//                                     titleValuePairs.removeAt(index);
//                                   }
//                                   propertyRows[index]['titleController']
//                                       ?.dispose();
//                                   propertyRows[index]['valueController']
//                                       ?.dispose();
//                                   propertyRows.removeAt(index);
//                                   print('Title-Value Pairs: $titleValuePairs');
//                                 });
//                               },
//                               child: Padding(
//                                 padding: EdgeInsets.only(top: 30.h),
//                                 child: SvgPicture.asset(
//                                   AppIcons.blueCross,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       }),
//                     );
//                   },
//                 ),
//                 UIHelper.verticalSpaceMedium,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     CustomButton(
//                       onTap: () {},
//                       text: 'Back',
//                       context: context,
//                       minWidth: 170,
//                       color: AppColor.cF3F2F2,
//                       textStyle:
//                           TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                         color: AppColor.blackColor,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                     CustomButton(
//                       onTap: () {
//                         log(" Description Text:${_descriptionController.text}");
//                       },
//                       text: 'Next',
//                       context: context,
//                       minWidth: 170,
//                       textStyle:
//                           TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                         color: AppColor.cFFFFFF,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DropDownCustomTextField extends StatelessWidget {
//   final String? hintText;
//   final String? labelText;
//   final TextEditingController? controller;
//   final TextInputType? inputType;
//   final double? fieldHeight;
//   final double? fieldWidth;
//   final String? Function(String?)? validator;
//   final bool isEnabled;
//   final bool readOnly;
//   final Widget? prefixIcon;
//   final bool obscureText;
//   final double? borderRadius;
//   final EdgeInsetsGeometry? padding;
//   final TextStyle? hintTextStyle;
//   final Color? fieldColor;
//   final Function(String)? onChanged;

//   /// New dropdown items
//   final List<String>? dropdownItems;
//   final Function(String)? onItemSelected;

//   const DropDownCustomTextField({
//     super.key,
//     this.hintText,
//     this.labelText,
//     this.controller,
//     this.inputType,
//     this.fieldHeight,
//     this.fieldWidth,
//     this.validator,
//     this.isEnabled = true,
//     this.obscureText = false,
//     this.prefixIcon,
//     this.borderRadius,
//     this.padding,
//     this.hintTextStyle,
//     this.fieldColor,
//     this.onChanged,
//     this.readOnly = false,
//     this.dropdownItems,
//     this.onItemSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: fieldColor ?? AppColor.whiteColor,
//         borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
//         border: Border.all(
//           color: AppColor.blackColor.withOpacity(0.1),
//           width: 1.w,
//         ),
//       ),
//       height: fieldHeight ?? 55.h,
//       width: fieldWidth ?? 343.w,
//       child: TextFormField(
//         controller: controller,
//         validator: validator,
//         enabled: isEnabled,
//         obscureText: obscureText,
//         readOnly: readOnly,
//         minLines: 1,
//         style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//           color: AppColor.blackColor,
//         ),
//         onChanged: onChanged,
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.only(bottom: 17.h),
//           hintText: hintText,
//           hintStyle: hintTextStyle ??
//               TextStyle(
//                 fontSize: 12.sp,
//                 color: AppColor.c7B7B7B,
//                 height: 1.50.h,
//                 fontWeight: FontWeight.w300,
//               ),
//           labelText: labelText,
//           labelStyle: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//             fontSize: 10.sp,
//             color: AppColor.c000000,
//             fontWeight: FontWeight.w300,
//           ),
//           floatingLabelBehavior: FloatingLabelBehavior.auto,
//           prefixIcon: prefixIcon,

//           /// 👇 suffix icon for dropdown
//           suffixIcon: dropdownItems != null
//               ? GestureDetector(
//                   onTap: () async {
//                     final RenderBox button =
//                         context.findRenderObject() as RenderBox;
//                     final RenderBox overlay = Overlay.of(context)
//                         .context
//                         .findRenderObject() as RenderBox;

//                     final RelativeRect position = RelativeRect.fromRect(
//                       Rect.fromPoints(
//                         button.localToGlobal(Offset.zero, ancestor: overlay),
//                         button.localToGlobal(
//                             button.size.bottomRight(Offset.zero),
//                             ancestor: overlay),
//                       ),
//                       Offset.zero & overlay.size,
//                     );

//                     final String? selected = await showMenu<String>(
//                       context: context,
//                       position: position,
//                       items: dropdownItems!
//                           .map((e) => PopupMenuItem(
//                                 value: e,
//                                 child: Text(
//                                   e,
//                                   style: TextFontStyle
//                                       .textLine7w400cFFFFFFDmSans
//                                       .copyWith(
//                                     color: AppColor.blackColor,
//                                   ),
//                                 ),
//                               ))
//                           .toList(),
//                     );

//                     if (selected != null) {
//                       controller?.text = selected;
//                       if (onItemSelected != null) {
//                         onItemSelected!(selected);
//                       }
//                     }
//                   },
//                   child: const Icon(Icons.arrow_drop_down),
//                 )
//               : null,

//           enabledBorder: InputBorder.none,
//           focusedBorder: InputBorder.none,
//           errorBorder: InputBorder.none,
//           disabledBorder: InputBorder.none,
//         ),
//         keyboardType: inputType,
//       ),
//     );
//   }
// }

// class DottedBorderContainer extends StatelessWidget {
//   final Widget child;

//   const DottedBorderContainer({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 160,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: Colors.grey.shade400,
//           style: BorderStyle.solid,
//           width: 1,
//         ),
//       ),
//       child: child,
//     );
//   }
// }

// ignore_for_file: unused_element

import 'dart:developer';
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_appbar.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/features/admin_app/auction_screen/final_auction_screen.dart';
import 'package:ddavila/features/admin_app/auction_screen/model/category_model.dart';
import 'package:ddavila/features/admin_app/auction_screen/model/property_model.dart';
import 'package:ddavila/features/admin_app/auction_screen/model/sub_property_model.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class CreateAuctionScreen extends StatefulWidget {
  final void Function(String) onNotification;

  static void _defaultNotification(String message) {}

  const CreateAuctionScreen({super.key, required this.onNotification});

  @override
  State<CreateAuctionScreen> createState() => _CreateAuctionScreenState();
}

class _CreateAuctionScreenState extends State<CreateAuctionScreen> {
  final TextEditingController _coreFeaturesController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String fontStyle = 'Calibri';
  String selectedTitle = '';
  String coreFeaturesHtml = '';
  String descriptionHtml = '';
  String descriptionHtmlText = '';
  double fontSize = 12;
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderlined = false;
  TextAlign _alignment = TextAlign.left;
  List<Map<String, String>> _images = []; // For Core Features editor images
  List<Map<String, String>> _cardImages =
      []; // For DottedBorderContainer images
  List<String> imagePaths = [];
  int _imageCounter = 0;

  int? selectedCategoryId;
  String? selectedCategoryTitle;
  int? selectedSubCategoryId;
  String? selectedSubCategoryTitle;
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _subCategoryController = TextEditingController();
  List<Map<String, dynamic>> propertyRows = [];
  List<String> valueOptions = ['Add New Item'];
  List<Map<String, String>> titleValuePairs = [];

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

  Future<void> _resetFile() async {
    try {
      final file = File(
          '${(await getApplicationDocumentsDirectory()).path}/editor_text.html');
      if (await file.exists()) await file.delete();
      if (mounted) {
        setState(() {
          _coreFeaturesController.text = '';
          _descriptionController.text = '';
          _images.clear();
          _imageCounter = 0;
        });
        widget.onNotification('Content reset successfully!');
      }
    } catch (e) {
      if (mounted) {
        widget.onNotification('Failed to reset content');
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

      final RegExp imageRegex = RegExp(
          r'<a href="([^"]*)"><img src="([^"]*)" alt="Inserted Image"[^>]*></a>',
          multiLine: true);
      final imageMatches = imageRegex.allMatches(savedText).toList();
      _images.clear();
      _imageCounter = 0;

      for (var match in imageMatches) {
        _imageCounter++;
        _images.add({
          'src': match.group(2) ?? '',
          'link': match.group(1) ?? '',
        });
      }

      textContent = textContent
          .replaceAll('<br>', '\n')
          .replaceAllMapped(imageRegex, (Match match) {
        final index = imageMatches.indexOf(match as RegExpMatch) + 1;
        return '[image$index]';
      }).replaceAll(RegExp(r'[^\x00-\x7F\n\[\]\d]'), '');

      if (mounted) {
        setState(() {
          _coreFeaturesController.text = textContent;
          _descriptionController.text = '';
        });
      }
    } catch (e) {
      if (mounted) {
        widget.onNotification('Failed to load saved content');
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

      for (int i = 0; i < _images.length; i++) {
        final image = _images[i];
        final src = image['src']!;
        final link = image['link']!.isNotEmpty ? image['link']! : src;
        final imageBlock = '''
<a href="$link" target="_blank" rel="noopener">
  <img src="$src" alt="Inserted Image" style="max-width: 100%; height: auto; display: inline; vertical-align: middle;">
</a>
''';
        styledCoreFeatures =
            styledCoreFeatures.replaceAll('[image${i + 1}]', imageBlock);
      }

      // Process Description
      String descriptionText = _descriptionController.text;
      String styledDescription = descriptionText
          .replaceAll('&', '&amp;')
          .replaceAll('<', '&lt;')
          .replaceAll('>', '&gt;');

      if (_isBold) styledDescription = '<b>$styledDescription</b>';
      if (_isItalic) styledDescription = '<i>$styledDescription</i>';
      if (_isUnderlined) styledDescription = '<u>$styledDescription</u>';

      // Combine both for saving to file
      String htmlContent = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <style>
    body { font-family: $fontStyle; font-size: ${fontSize}px; margin: 16px; }
    .bold { font-weight: bold; }
    .italic { font-style: italic; }
    .underline { text-decoration: underline; }
    .left { text-align: left; }
    .center { text-align: center; }
    .right { text-align: right; }
    a { color: #1a73e8; }
    img { vertical-align: middle; }
  </style>
</head>
<body class="${_alignment == TextAlign.center ? 'center' : _alignment == TextAlign.right ? 'right' : 'left'}">
  <div>
    <h2>Core Features</h2>
    ${styledCoreFeatures.replaceAll('\n', '<br>')}
    <h2>Description</h2>
    ${styledDescription.replaceAll('\n', '<br>')}
  </div>
</body>
</html>
''';

      // Save to file
      await file.writeAsString(htmlContent);

      // Log the HTML content separately
      coreFeaturesHtml = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <style>
    body { font-family: $fontStyle; font-size: ${fontSize}px; margin: 16px; }
    .bold { font-weight: bold; }
    .italic { font-style: italic; }
    .underline { text-decoration: underline; }
    .left { text-align: left; }
    .center { text-align: center; }
    .right { text-align: right; }
    a { color: #1a73e8; }
    img { vertical-align: middle; }
  </style>
</head>
<body class="${_alignment == TextAlign.center ? 'center' : _alignment == TextAlign.right ? 'right' : 'left'}">
  <div>
    ${styledCoreFeatures.replaceAll('\n', '<br>')}
  </div>
</body>
</html>
''';

      descriptionHtmlText = descriptionHtml = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <style>
    body { font-family: $fontStyle; font-size: ${fontSize}px; margin: 16px; }
    .bold { font-weight: bold; }
    .italic { font-style: italic; }
    .underline { text-decoration: underline; }
    .left { text-align: left; }
    .center { text-align: center; }
    .right { text-align: right; }
    a { color: #1a73e8; }
    img { vertical-align: middle; }
  </style>
</head>
<body class="${_alignment == TextAlign.center ? 'center' : _alignment == TextAlign.right ? 'right' : 'left'}">
  <div>
    ${styledDescription.replaceAll('\n', '<br>')}
  </div>
</body>
</html>
''';

      // Log both HTML contents
      log('Core Features HTML:\n$coreFeaturesHtml');
      log('Description HTML:\n$descriptionHtml');

      if (mounted) {
        widget.onNotification('Saved as HTML and logged successfully!');
      }
    } catch (e) {
      if (mounted) {
        widget.onNotification('Failed to save content');
      }
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
          widget.onNotification('Image ${picked.name} exceeds 25 MB limit');
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
        widget.onNotification('Images added from gallery');
      }
    } catch (e) {
      if (mounted) {
        widget.onNotification('Failed to add images from gallery: $e');
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
        widget.onNotification('Image exceeds 25 MB limit');
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
        widget.onNotification('Image added from camera');
      }
    } catch (e) {
      if (mounted) {
        widget.onNotification('Failed to add image from camera: $e');
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

  Future<void> _pickImageFromGallery() async {
    try {
      final picker = ImagePicker();
      final XFile? picked =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
      if (!mounted || picked == null) return;

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
        _imageCounter++;
        _images.add({'src': dataUrl, 'link': ''});
        _insertImagePlaceholder(_imageCounter);
      });

      if (mounted) {
        widget.onNotification('Image added from gallery');
      }
    } catch (e) {
      if (mounted) {
        widget.onNotification('Failed to add image from gallery');
      }
    }
  }

  Future<void> _addImageFromUrl() async {
    final urlController = TextEditingController();
    final url = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Image URL'),
        content: TextField(
          controller: urlController,
          decoration:
              const InputDecoration(hintText: 'https://example.com/image.jpg'),
          keyboardType: TextInputType.url,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () =>
                  Navigator.pop(context, urlController.text.trim()),
              child: const Text('OK')),
        ],
      ),
    );

    if (!mounted || url == null || url.isEmpty) return;

    setState(() {
      _imageCounter++;
      _images.add({'src': url, 'link': ''});
      _insertImagePlaceholder(_imageCounter);
    });
  }

  Future<void> _addCustomLink() async {
    final urlController = TextEditingController();
    final url = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Link URL (optional)'),
        content: TextField(
          controller: urlController,
          decoration: const InputDecoration(hintText: 'https://example.com'),
          keyboardType: TextInputType.url,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () =>
                  Navigator.pop(context, urlController.text.trim()),
              child: const Text('OK')),
        ],
      ),
    );

    if (!mounted || url == null || url.isEmpty || _images.isEmpty) return;

    setState(() {
      _images.last['link'] = url;
    });
  }

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
                    'Item Details',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10),
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
                                      child: image['src']!.startsWith('data:')
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
                                    IconButton(
                                      icon: const Icon(Icons.link, size: 20),
                                      onPressed: _addCustomLink,
                                      tooltip: 'Wrap image with custom link',
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
                            if (_images.isNotEmpty)
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                child: Column(
                                  children:
                                      _images.asMap().entries.map((entry) {
                                    final index = entry.key + 1;
                                    final image = entry.value;
                                    return Row(
                                      children: [
                                        Text('Image $index:',
                                            style:
                                                const TextStyle(fontSize: 12)),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            image['src']!.startsWith('data:')
                                                ? 'Gallery image (base64)'
                                                : image['src']!,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () => setState(() {
                                            _images.removeAt(index - 1);
                                            _descriptionController.text =
                                                _descriptionController.text
                                                    .replaceAll(
                                                        '[image$index]', '');
                                            _coreFeaturesController.text =
                                                _coreFeaturesController.text
                                                    .replaceAll(
                                                        '[image$index]', '');
                                            _imageCounter = _images.length;
                                          }),
                                          child: const Text('Remove'),
                                        ),
                                      ],
                                    );
                                  }).toList(),
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
                    'Core Features',
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
                                    IconButton(
                                      icon: const Icon(Icons.photo_library,
                                          size: 20),
                                      onPressed: _pickImageFromGallery,
                                      tooltip: 'Add image from Gallery',
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.image, size: 20),
                                      onPressed: _addImageFromUrl,
                                      tooltip: 'Add image from URL',
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.link, size: 20),
                                      onPressed: _addCustomLink,
                                      tooltip: 'Wrap image with custom link',
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
                                        if (newValue != null) {
                                          _setAlignment(newValue);
                                        }
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
                            if (_images.isNotEmpty)
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                child: Column(
                                  children:
                                      _images.asMap().entries.map((entry) {
                                    final index = entry.key + 1;
                                    final image = entry.value;
                                    return Row(
                                      children: [
                                        Text('Image $index:',
                                            style:
                                                const TextStyle(fontSize: 12)),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            image['src']!.startsWith('data:')
                                                ? 'Gallery image (base64)'
                                                : image['src']!,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () => setState(() {
                                            _images.removeAt(index - 1);
                                            _coreFeaturesController.text =
                                                _coreFeaturesController.text
                                                    .replaceAll(
                                                        '[image$index]', '');

                                            _imageCounter = _images.length;
                                          }),
                                          child: const Text('Remove'),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                child: TextField(
                                  controller: _coreFeaturesController,
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
                          print('Title-Value Pairs: $titleValuePairs');
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
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                        } else {
                                          row['selectedTitle'] = value;
                                          titleController.text = value;
                                          selectedTitle = titleController.text;
                                        }
                                        if (index < titleValuePairs.length) {
                                          titleValuePairs[index] = {
                                            'title':
                                                row['selectedTitle'] as String,
                                            'value':
                                                row['selectedValue'] as String,
                                          };
                                        }
                                      });
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        row['selectedTitle'] = value;
                                        if (index < titleValuePairs.length) {
                                          titleValuePairs[index] = {
                                            'title': value,
                                            'value':
                                                row['selectedValue'] as String,
                                          };
                                        }
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
                                StreamBuilder<SubPropertyModel>(
                                  stream: getSubPropertyAPIRXObj.dataFetcher,
                                  builder: (context, snapshot) {
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
                                        dropdownItems: valueOptions,
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
                                            }
                                            log('Selected Title: ${row['selectedTitle']}');
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
                                  propertyRows[index]['valueController']
                                      ?.dispose();
                                  propertyRows.removeAt(index);
                                  print('Title-Value Pairs: $titleValuePairs');
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
                      onTap: () {
                        _saveText();
                        log("Description Data:- ${descriptionHtml}");
                        log("Core Features Data:- ${coreFeaturesHtml}");
                        log("Image List all:- ${imagePaths}");
                        log("Select Sub Category:- ${selectedSubCategoryId}");
                        log("Select Category:- ${selectedCategoryId}");
                        log("Select Title:- ${selectedTitle}");
                        Get.to(() => FinalAuctionScreen());
                        // Call _saveText to log HTML content
                      },
                      text: 'Next',
                      context: context,
                      minWidth: 170,
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
