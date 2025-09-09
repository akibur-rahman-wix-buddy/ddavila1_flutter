import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/features/chat/model/chat_to_person.dart';
import 'package:ddavila/features/chat/widget/user_chat_widget.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AdminChatWidget extends StatelessWidget {
  final String message;
  final List<Attachment> attachments;
  final String time;
  final String senderName;
  final String image;
  final dynamic id;

  const AdminChatWidget({
    super.key,
    required this.message,
    required this.attachments,
    required this.time,
    required this.senderName,
    required this.image,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    print(">>>>>>>>>>>>>>> this is admin site list of attachment ${attachments.map((item){item.filePath.toString();}).toString()}");
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sender name (admin)
          GestureDetector(
            onTap: () {
              // userProfileDialogBox(
              //   name: senderName,
              //   image: image,
              //   id: id,
              //   context: context
              // );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 48.0), // Align with avatar
              // child: Text(
              //   senderName,
              //   style: TextFontStyle.buttonTextStyle.copyWith(
              //     color: Colors.white,
              //     fontWeight: FontWeight.w700,
              //   ),
              // ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Admin avatar
              GestureDetector(
                onTap: () {
                  // userProfileDialogBox(
                  //   name: senderName,
                  //   image: image,
                  //   id: id,
                  //   context: context
                  // );
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(image),
                ),
              ),
              const SizedBox(width: 8),
              // Message content
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.83),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Show attachments if they exist
                      if (attachments.isNotEmpty)
                        _buildAttachmentsGrid(context, attachments),

                      // Show message text if it exists
                      if (message.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            message,
                            style: TextFontStyle.buttonTextStyle.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),

                      // Timestamp
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          time,
                          style: TextFontStyle.buttonTextStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Colors.white60,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget _buildAttachmentsGrid(BuildContext context, List<Attachment> attachments) {
  //   final imageCount = attachments.length;
  //   final maxImagesToShow = 4;
  //   final remainingImages = imageCount > maxImagesToShow ? imageCount - maxImagesToShow : 0;
  //
  //   return GestureDetector(
  //     onTap: () => _openImageGallery(context, attachments),
  //     child: Container(
  //       constraints: BoxConstraints(
  //         maxWidth: MediaQuery.of(context).size.width * 0.6,
  //       ),
  //       child: GridView.count(
  //         shrinkWrap: true,
  //         physics: const NeverScrollableScrollPhysics(),
  //         crossAxisCount: imageCount == 1 ? 1 : 2,
  //         mainAxisSpacing: 4,
  //         crossAxisSpacing: 4,
  //         childAspectRatio: 1,
  //         children: List.generate(
  //           imageCount > maxImagesToShow ? maxImagesToShow : imageCount,
  //               (index) {
  //             final attachment = attachments[index];
  //             final imageUrl = attachment.filePath != null
  //                 ? '$image_url${attachment.filePath}'
  //                 : null;
  //
  //             // For the 4th image when there are more than 4 images
  //             if (index == maxImagesToShow - 1 && remainingImages > 0) {
  //               return Stack(
  //                 fit: StackFit.expand,
  //                 children: [
  //                   _buildImageItem(context, imageUrl),
  //                   Container(
  //                     color: Colors.black54,
  //                     alignment: Alignment.center,
  //                     child: Text(
  //                       '+$remainingImages',
  //                       style: const TextStyle(
  //                         color: Colors.white,
  //                         fontSize: 24,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               );
  //             }
  //
  //             return _buildImageItem(context, imageUrl);
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }









  Widget _buildAttachmentsGrid(BuildContext context, List<Attachment> attachments) {
    final imageCount = attachments.length;
    final maxImagesToShow = 4;
    final remainingImages = imageCount > maxImagesToShow ? imageCount - maxImagesToShow : 0;

    return GestureDetector(
      onTap: () => _openImageGallery(context, attachments),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.6,
        ),
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: imageCount == 1 ? 1 : 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: 1,
          children: List.generate(
            imageCount > maxImagesToShow ? maxImagesToShow : imageCount,
                (index) {
              final attachment = attachments[index];

              // Fix the file path by replacing backslashes with forward slashes
              final fixedPath = attachment.filePath?.replaceAll(r"\/", "//");
              final imageUrl = fixedPath != null
                  ? '$image_url$fixedPath'
                  : null;

              // For the 4th image when there are more than 4 images
              if (index == maxImagesToShow - 1 && remainingImages > 0) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildImageItem(context, imageUrl),
                    Container(
                      color: Colors.black54,
                      alignment: Alignment.center,
                      child: Text(
                        '+$remainingImages',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              }

              return _buildImageItem(context, imageUrl);
            },
          ),
        ),
      ),
    );
  }





  Widget _buildImageItem(BuildContext context, String? imageUrl) {
    if (imageUrl == null) {
      return Container(
        color: Colors.grey[200],
        child: const Icon(Icons.broken_image),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: Colors.grey[200],
        child: const Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey[200],
        child: const Icon(Icons.broken_image),
      ),
    );
  }

  void _openImageGallery(BuildContext context, List<Attachment> attachments) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryScreen(attachments: attachments),
      ),
    );
  }
}

// Reuse the same GalleryScreen class from UserChatWidget