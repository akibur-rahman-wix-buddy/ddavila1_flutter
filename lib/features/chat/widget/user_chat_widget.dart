// import 'package:ddavila/features/chat/model/chat_to_person.dart';
// import 'package:ddavila/networks/endpoints.dart';
// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
//
// // Mock classes for completeness (replace with your actual implementations)
//
//
// class UserChatWidget extends StatelessWidget {
//   final String message;
//   final List<Attachment> attachments;
//   final String time;
//   final bool isMe;
//
//   const UserChatWidget({
//     super.key,
//     required this.message,
//     required this.attachments,
//     required this.time,
//     required this.isMe,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//         children: [
//           if (!isMe) ...[
//             CircleAvatar(
//               backgroundImage: attachments.isNotEmpty && attachments.first.filePath != null
//                   ? NetworkImage('${image_url}${attachments.first.filePath}')
//                   : null,
//               child: attachments.isEmpty || attachments.first.filePath == null
//                   ? const Icon(Icons.person)
//                   : null,
//             ),
//             const SizedBox(width: 8),
//           ],
//           Flexible(
//             child: Container(
//               constraints: BoxConstraints(
//                 maxWidth: MediaQuery.of(context).size.width * 0.7,
//               ),
//               decoration: BoxDecoration(
//                 color: isMe ? Colors.blue[400] : Colors.grey[300],
//                 borderRadius: BorderRadius.only(
//                   topLeft: const Radius.circular(16),
//                   topRight: const Radius.circular(16),
//                   bottomLeft: Radius.circular(isMe ? 16 : 0),
//                   bottomRight: Radius.circular(isMe ? 0 : 16),
//                 ),
//               ),
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Show attachments if they exist
//                   if (attachments.isNotEmpty)
//                     _buildAttachments(context, attachments),
//
//                   // Show message text if it exists
//                   if (message.isNotEmpty)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8),
//                       child: Text(
//                         message,
//                         style: TextStyle(
//                           color: isMe ? Colors.white : Colors.black,
//                         ),
//                       ),
//                     ),
//
//                   // Timestamp
//                   Padding(
//                     padding: const EdgeInsets.only(top: 4),
//                     child: Text(
//                       time,
//                       style: TextStyle(
//                         color: isMe ? Colors.white70 : Colors.grey[600],
//                         fontSize: 10,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAttachments(BuildContext context, List<Attachment> attachments) {
//     return Column(
//       children: attachments.map((attachment) {
//         // Construct the image URL, ensuring no double slashes
//         final imageUrl = attachment.filePath != null
//             ? '$image_url${attachment.filePath}'
//             : null;
//
//         // Log the image URL for debugging
//         debugPrint('Image URL: $imageUrl');
//
//         if (imageUrl == null) {
//           return Container(
//             margin: const EdgeInsets.only(bottom: 8),
//             constraints: BoxConstraints(
//               maxHeight: 200,
//               maxWidth: MediaQuery.of(context).size.width * 0.6,
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Container(
//                 color: Colors.grey[200],
//                 child: const Icon(Icons.broken_image),
//               ),
//             ),
//           );
//         }
//
//         return GestureDetector(
//           onTap: () => _showFullScreenImage(context, imageUrl),
//           child: Container(
//             margin: const EdgeInsets.only(bottom: 8),
//             constraints: BoxConstraints(
//               maxHeight: 200,
//               maxWidth: MediaQuery.of(context).size.width * 0.6,
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.network(
//                 imageUrl,
//                 fit: BoxFit.cover,
//                 loadingBuilder: (context, child, loadingProgress) {
//                   if (loadingProgress == null) return child;
//                   return Center(
//                     child: CircularProgressIndicator(
//                       value: loadingProgress.expectedTotalBytes != null
//                           ? loadingProgress.cumulativeBytesLoaded /
//                           loadingProgress.expectedTotalBytes!
//                           : null,
//                     ),
//                   );
//                 },
//                 errorBuilder: (context, error, stackTrace) {
//                   debugPrint('Image load error: $error');
//                   return Container(
//                     color: Colors.grey[200],
//                     child: const Icon(Icons.broken_image),
//                   );
//                 },
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   void _showFullScreenImage(BuildContext context, String imageUrl) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => Scaffold(
//           backgroundColor: Colors.black,
//           appBar: AppBar(
//             backgroundColor: Colors.black,
//             iconTheme: const IconThemeData(color: Colors.white),
//           ),
//           body: Center(
//             child: PhotoView(
//               imageProvider: NetworkImage(imageUrl),
//               minScale: PhotoViewComputedScale.contained,
//               maxScale: PhotoViewComputedScale.covered * 2,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

























import 'package:ddavila/features/chat/model/chat_to_person.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserChatWidget extends StatelessWidget {
  final String message;
  final List<Attachment> attachments;
  final String time;
  final bool isMe;

  const UserChatWidget({
    super.key,
    required this.message,
    required this.attachments,
    required this.time,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              backgroundImage: attachments.isNotEmpty && attachments.first.filePath != null
                  ? NetworkImage('${image_url}${attachments.first.filePath}')
                  : null,
              child: attachments.isEmpty || attachments.first.filePath == null
                  ? const Icon(Icons.person)
                  : null,
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: BoxDecoration(
                color: isMe ? Colors.blue[400] : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isMe ? 16 : 0),
                  bottomRight: Radius.circular(isMe ? 0 : 16),
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
                        style: TextStyle(
                          color: isMe ? Colors.white : Colors.black,
                        ),
                      ),
                    ),

                  // Timestamp
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      time,
                      style: TextStyle(
                        color: isMe ? Colors.white70 : Colors.grey[600],
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
              final imageUrl = attachment.filePath != null
                  ? '$image_url${attachment.filePath}'
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

class GalleryScreen extends StatefulWidget {
  final List<Attachment> attachments;

  const GalleryScreen({super.key, required this.attachments});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          '${_currentIndex + 1}/${widget.attachments.length}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.attachments.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final attachment = widget.attachments[index];
          final imageUrl = attachment.filePath != null
              ? '$image_url${attachment.filePath}'
              : null;

          return Center(
            child: PhotoView(
              imageProvider: imageUrl != null ? NetworkImage(imageUrl) : null,
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
              loadingBuilder: (context, event) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorBuilder: (context, error, stackTrace) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: Colors.white, size: 50),
                    const SizedBox(height: 10),
                    Text(
                      'Failed to load image',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}