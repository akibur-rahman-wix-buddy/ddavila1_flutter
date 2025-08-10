import 'dart:io';

import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ChatBottomBarWidget extends StatefulWidget {
  final TextEditingController chatController;
  final VoidCallback onSendTap;
  final ValueChanged<List<XFile>> onImagesSelected;
  final List<XFile> initialImages;

  const ChatBottomBarWidget({
    super.key,
    required this.chatController,
    required this.onSendTap,
    required this.onImagesSelected,
    required this.initialImages,
  });

  @override
  State<ChatBottomBarWidget> createState() => _ChatBottomBarWidgetState();
}

class _ChatBottomBarWidgetState extends State<ChatBottomBarWidget> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedImages = [];
  @override
  void initState() {
    super.initState();
    _selectedImages = List.from(widget.initialImages); // Initialize with passed images
  }
  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() {
          _selectedImages.add(image);
        });
        widget.onImagesSelected(_selectedImages);
      }
    } catch (e) {
      debugPrint('Camera error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to capture image: ${e.toString()}')),
      );
    }
  }

  Future<void> _pickImagesFromGallery() async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage(
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );
      if (images != null && images.isNotEmpty) {
        setState(() {
          _selectedImages.addAll(images);
        });
        widget.onImagesSelected(_selectedImages);
      }
    } catch (e) {
      debugPrint('Gallery error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick images: ${e.toString()}')),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
    widget.onImagesSelected(_selectedImages);
  }

  void _showImageSourceBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImagesFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreviews() {
    if (_selectedImages.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _selectedImages.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: FileImage(File(_selectedImages[index].path)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () => _removeImage(index),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(2),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Selected images preview
        _buildImagePreviews(),

        // Text input field and send button
        SizedBox(
          height: 50,
          width: double.infinity,
          child: Row(
            children: [
              Flexible(
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: TextField(
                    cursorColor: Colors.white,
                    controller: widget.chatController,
                    style: TextFontStyle.buttonTextStyle
                        .copyWith(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: _showImageSourceBottomSheet,
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                      hintText: "Send a message...",
                      hintStyle: TextFontStyle.buttonTextStyle
                          .copyWith(color: Colors.white, fontSize: 14),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 15),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide:
                        const BorderSide(color: Colors.white, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 1),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: widget.onSendTap,
                child: Container(
                  height: 50,
                  width: 50,
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: const Icon(Icons.send_sharp, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}