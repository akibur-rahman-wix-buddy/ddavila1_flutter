// ignore_for_file: unused_element

import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_appbar.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/common_widgets/custom_textfiled.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  // * ###############################################################################################
  final TextEditingController _controller = TextEditingController();
  String fontStyle = 'Calibri';
  double fontSize = 12;
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderlined = false;
  TextAlign _alignment = TextAlign.left;
  List<Map<String, String>> _images = [];
  int _imageCounter = 0;

  @override
  void initState() {
    super.initState();
    _loadSavedText();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          _controller.text = textContent;
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
      String textWithImages = _controller.text;

      String styledText = textWithImages
          .replaceAll('&', '&amp;')
          .replaceAll('<', '&lt;')
          .replaceAll('>', '&gt;');

      if (_isBold) styledText = '<b>$styledText</b>';
      if (_isItalic) styledText = '<i>$styledText</i>';
      if (_isUnderlined) styledText = '<u>$styledText</u>';

      for (int i = 0; i < _images.length; i++) {
        final image = _images[i];
        final src = image['src']!;
        final link = image['link']!.isNotEmpty ? image['link']! : src;
        final imageBlock = '''
<a href="$link" target="_blank" rel="noopener">
  <img src="$src" alt="Inserted Image" style="max-width: 100%; height: auto; display: inline; vertical-align: middle;">
</a>
''';
        styledText = styledText.replaceAll('[image${i + 1}]', imageBlock);
      }

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
    ${styledText.replaceAll('\n', '<br>')}
  </div>
</body>
</html>
''';

      await file.writeAsString(htmlContent);
      if (mounted) {
        widget.onNotification('Saved as HTML successfully!');
      }
    } catch (e) {
      if (mounted) {
        widget.onNotification('Failed to save content');
      }
    }
  }

  Future<void> _resetFile() async {
    try {
      final file = File(
          '${(await getApplicationDocumentsDirectory()).path}/editor_text.html');
      if (await file.exists()) await file.delete();
      if (mounted) {
        setState(() {
          _controller.text = '';
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

  void _toggleBold() => setState(() => _isBold = !_isBold);
  void _toggleItalic() => setState(() => _isItalic = !_isItalic);
  void _toggleUnderline() => setState(() => _isUnderlined = !_isUnderlined);
  void _setAlignment(TextAlign alignment) =>
      setState(() => _alignment = alignment);

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

  void _insertImagePlaceholder(int index) {
    final cursorPos = _controller.selection.baseOffset;
    final text = _controller.text;
    final placeholder = '[image$index]';
    final newText = cursorPos >= 0
        ? text.replaceRange(cursorPos, cursorPos, placeholder)
        : '$text$placeholder';
    if (mounted) {
      setState(() {
        _controller.text = newText;
        _controller.selection = TextSelection.collapsed(
            offset: cursorPos >= 0
                ? cursorPos + placeholder.length
                : newText.length);
      });
    }
  }
  // * ########################################################################################

  @override
  Widget build(BuildContext context) {
    final hasAnyImage = _images.isNotEmpty;
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
              DottedBorderContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey.shade100,
                      child: Image.asset(AppImages.picImage),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Click to Upload Front Side of Card",
                      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        color: AppColor.blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "(Max. File size: 25 MB)",
                      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        color: AppColor.blackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
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
              // * TEXT TO HTML Editor
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SingleChildScrollView(
                    // Added to prevent overflow
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
                                    icon:
                                        const Icon(Icons.format_bold, size: 20),
                                    onPressed: _toggleBold,
                                    color: _isBold ? Colors.black : Colors.grey,
                                    tooltip: 'Bold',
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.format_italic,
                                        size: 20),
                                    onPressed: _toggleItalic,
                                    color:
                                        _isItalic ? Colors.black : Colors.grey,
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
                          if (hasAnyImage)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              child: Column(
                                children: _images.asMap().entries.map((entry) {
                                  final index = entry.key + 1;
                                  final image = entry.value;
                                  return Row(
                                    children: [
                                      Text('Image $index:',
                                          style: const TextStyle(fontSize: 12)),
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
                                          _controller.text = _controller.text
                                              .replaceAll('[image$index]', '');
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
                              // Added Material widget
                              child: TextField(
                                controller: _controller,
                                maxLines: null, // Dynamic height
                                minLines: 20, // Minimum 1 line
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
              // * TEXT TO HTML Editor
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SingleChildScrollView(
                    // Added to prevent overflow
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
                                    icon:
                                        const Icon(Icons.format_bold, size: 20),
                                    onPressed: _toggleBold,
                                    color: _isBold ? Colors.black : Colors.grey,
                                    tooltip: 'Bold',
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.format_italic,
                                        size: 20),
                                    onPressed: _toggleItalic,
                                    color:
                                        _isItalic ? Colors.black : Colors.grey,
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
                          if (hasAnyImage)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              child: Column(
                                children: _images.asMap().entries.map((entry) {
                                  final index = entry.key + 1;
                                  final image = entry.value;
                                  return Row(
                                    children: [
                                      Text('Image $index:',
                                          style: const TextStyle(fontSize: 12)),
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
                                          _controller.text = _controller.text
                                              .replaceAll('[image$index]', '');
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
                              // Added Material widget
                              child: TextField(
                                controller: _controller,
                                maxLines: null, // Dynamic height
                                minLines: 20, // Minimum 1 line
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Category*',
                          style:
                              TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      CustomTextField(
                        fieldWidth: 170,
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
                          style:
                              TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      CustomTextField(
                        fieldWidth: 170,
                      ),
                    ],
                  )
                ],
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
                  Text(
                    'Add',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.c4275F6,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Title*',
                          style:
                              TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      CustomTextField(
                        fieldWidth: 170,
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
                          style:
                              TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      CustomTextField(
                        fieldWidth: 170,
                      ),
                    ],
                  )
                ],
              ),
              UIHelper.verticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
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
                    text: 'Next',
                    context: context,
                    minWidth: 170,
                    textStyle:
                        TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.cFFFFFF,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      )),
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
