import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/features/chat/model/chat_list_data_model.dart';
import 'package:ddavila/features/chat/presentation/chat_to_person_screen.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Set<int> selectedIndexes = {};
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Conversation> _allConversations = [];
  List<Conversation> _filteredConversations = [];

  @override
  void initState() {
    getAllChatListRx.getChatListInfo();
    super.initState();

    // Add listener to search controller for live search
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
        _filterConversations();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterConversations() {
    if (_searchQuery.isEmpty) {
      _filteredConversations = List.from(_allConversations);
    } else {
      _filteredConversations = _allConversations.where((conversation) {
        final participant = conversation.participants?.isNotEmpty == true
            ? conversation.participants![0].participantable
            : null;
        final participantName = participant?.name?.toLowerCase() ?? '';

        return participantName.contains(_searchQuery.toLowerCase());
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const SizedBox(),
        centerTitle: true,
        title: Text("Chat", style: TextFontStyle.textLine20w400cFFFFFFDvSans),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
        child: Column(
          children: [
            // Search Bar
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by name...',
                  border: InputBorder.none,
                  icon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      _searchController.clear();
                    },
                  )
                      : null,
                ),
              ),
            ),

            Expanded(
              child: StreamBuilder<ChatListModelData>(
                stream: getAllChatListRx.dataFetcher,
                builder: (context, snapshot) {
                  String formatMessageTime(String? dateTimeString) {
                    if (dateTimeString == null || dateTimeString.isEmpty) return "";

                    try {
                      final dateTime = DateTime.parse(dateTimeString);

                      // Handle timezone offset if present in string
                      final now = DateTime.now();
                      final today = DateTime(now.year, now.month, now.day);
                      final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

                      if (messageDate.isAtSameMomentAs(today)) {
                        return DateFormat('h:mm a').format(dateTime);
                      } else if (messageDate.isAfter(today.subtract(const Duration(days: 1)))) {
                        return 'Yesterday ${DateFormat('h:mm a').format(dateTime)}';
                      } else {
                        return DateFormat('MMM d, h:mm a').format(dateTime);
                      }
                    } catch (e) {
                      return "";
                    }
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(child: CircularProgressIndicator(color: Colors.white)),
                        UIHelper.verticalSpace(10.h),
                        const Text("Loading...", style: TextStyle(color: Colors.white))
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong!"));
                  } else if (!snapshot.hasData || snapshot.data!.data == null) {
                    return const Center(child: Text("No conversations found."));
                  } else {
                    // Store all conversations and filter them
                    if (_allConversations.isEmpty) {
                      _allConversations = snapshot.data!.data!.conversations ?? [];
                      _filteredConversations = List.from(_allConversations);
                    }

                    return _filteredConversations.isEmpty && _searchQuery.isNotEmpty
                        ? const Center(child: Text("No matching conversations found."))
                        : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      itemCount: _filteredConversations.length,
                      itemBuilder: (context, index) {
                        final conversation = _filteredConversations[index];

                        // Always get the first participant (index 0)
                        final participant = conversation.participants?.isNotEmpty == true
                            ? conversation.participants![0].participantable
                            : null;

                        // Get participant info safely
                        final participantName = participant?.name ?? "Unknown";
                        final participantAvatar = participant?.avatar;
                        final participantId = conversation.participants?.isNotEmpty == true
                            ? conversation.participants![0].participantableId
                            : null;

                        final lastMessage = conversation.lastMessage?.body ?? "No messages";
                        final messageTime = formatMessageTime(conversation.lastMessage?.createdAt.toString());

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: SizedBox(
                            height: 54,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              onPressed: () {
                                print('check the conversation id : ${conversation.id.toString()}');
                                if (participantId != null) {
                                  Get.to(ChatToPersonScreen(
                                    conversationId: conversation.participants?.first.conversationId.toString(),
                                    name: participantName,
                                    image: "$image_url${participantAvatar}",
                                    participantableId: participantId,
                                  ));
                                  setState(() {
                                    selectedIndexes.add(index);
                                  });
                                }
                              },
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: participantAvatar != null
                                        ? Image.network(
                                      "$image_url$participantAvatar",
                                      height: 53,
                                      width: 53,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          height: 53,
                                          width: 53,
                                          color: Colors.grey,
                                          child: const Icon(Icons.person, color: Colors.white),
                                        );
                                      },
                                    )
                                        : Container(
                                      height: 53,
                                      width: 53,
                                      color: Colors.grey,
                                      child: const Icon(Icons.person, color: Colors.white),
                                    ),
                                  ),
                                  UIHelper.horizontalSpace(10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                participantName,
                                                style: TextFontStyle.buttonTextStyle.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: AppColor.blackColor,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              messageTime,
                                              style: TextFontStyle.buttonTextStyle.copyWith(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColor.blackColor.withOpacity(0.6),
                                              ),
                                            )
                                          ],
                                        ),
                                        UIHelper.verticalSpace(7),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                lastMessage,
                                                style: TextFontStyle.buttonTextStyle.copyWith(
                                                    fontWeight: selectedIndexes.contains(index)
                                                        ? FontWeight.w400
                                                        : FontWeight.w600,
                                                    fontSize: 12,
                                                    color: selectedIndexes.contains(index)
                                                        ? AppColor.blackColor.withOpacity(0.7)
                                                        : AppColor.blackColor),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            UIHelper.horizontalSpace(30),
                                            if (conversation.readable == false)
                                              const CircleAvatar(
                                                radius: 5,
                                                backgroundColor: Colors.blue,
                                              )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}












 ///>>>>>>>>>> brodcusting code please no remove this >>>>>>>>>>>>>>>>>
//
//
//
// import 'dart:async';
//
// import 'package:dart_pusher_channels/dart_pusher_channels.dart';
// import 'package:ddavila/assets_helper/app_colors.dart';
// import 'package:ddavila/assets_helper/text_font_style.dart';
// import 'package:ddavila/constants/app_constants.dart';
// import 'package:ddavila/features/chat/model/chat_list_data_model.dart';
// import 'package:ddavila/features/chat/presentation/chat_to_person_screen.dart';
// import 'package:ddavila/helpers/di.dart';
// import 'package:ddavila/helpers/ui_helpers.dart';
// import 'package:ddavila/networks/api_acess.dart';
// import 'package:ddavila/networks/endpoints.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   Set<int> selectedIndexes = {};
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';
//   List<Conversation> _allConversations = [];
//   List<Conversation> _filteredConversations = [];
//   PusherChannelsClient? _pusherClient;
//   StreamSubscription<dynamic>? _connectionSubs;
//   StreamSubscription<dynamic>? _channelEventSubs;
//
//   @override
//   void initState() {
//     super.initState();
//     getAllChatListRx.getChatListInfo();
//
//     // Add listener to search controller for live search
//     _searchController.addListener(() {
//       setState(() {
//         _searchQuery = _searchController.text;
//         _filterConversations();
//       });
//     });
//
//     // Initialize Pusher for real-time updates
//     _initializePusher();
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     _pusherClient?.disconnect();
//     _connectionSubs?.cancel();
//     _channelEventSubs?.cancel();
//     super.dispose();
//   }
//
//   void _filterConversations() {
//     if (_searchQuery.isEmpty) {
//       _filteredConversations = List.from(_allConversations);
//     } else {
//       _filteredConversations = _allConversations.where((conversation) {
//         final participant = conversation.participants?.isNotEmpty == true
//             ? conversation.participants![0].participantable
//             : null;
//         final participantName = participant?.name?.toLowerCase() ?? '';
//
//         return participantName.contains(_searchQuery.toLowerCase());
//       }).toList();
//     }
//   }
//
//   void _initializePusher() async {
//     try {
//       const hostOptions = PusherChannelsOptions.fromHost(
//         scheme: 'wss',
//         host: 'app.thehobbynexus.com',
//         key: '5bcus2pmxhiwlo28uzz3',
//         shouldSupplyMetadataQueries: true,
//         metadata: PusherChannelsOptionsMetadata.byDefault(),
//         port: 8083,
//       );
//
//       // Create Pusher client
//       _pusherClient = PusherChannelsClient.websocket(
//         options: hostOptions,
//         connectionErrorHandler: (exception, trace, refresh) async {
//           print("Connection error: $exception");
//           await Future.delayed(const Duration(seconds: 2));
//           refresh();
//         },
//       );
//
//       // Subscribe to connection established
//       _connectionSubs = _pusherClient!.onConnectionEstablished.listen((_) {
//         print('Pusher connected successfully');
//
//         // Subscribe to all user's conversations for real-time updates
//         _subscribeToUserConversations();
//       });
//
//       _pusherClient!.connect();
//     } catch (e) {
//       print("Pusher initialization failed: $e");
//       if (mounted) {
//         Fluttertoast.showToast(
//           msg: "Failed to initialize real-time connection",
//           toastLength: Toast.LENGTH_LONG,
//         );
//       }
//     }
//   }
//
//   void _subscribeToUserConversations() {
//     // This is a simplified approach - you might need to adjust based on your backend
//     // Typically you'd subscribe to a user-specific channel that gets all conversation updates
//     final userChannel = _pusherClient!.privateChannel(
//       "private-participant.4170705c4d6f64656c735c55736572.${appData.read(kKeyUserID)}", // You need to implement getCurrentUserId()
//       authorizationDelegate: EndpointAuthorizableChannelTokenAuthorizationDelegate
//           .forPrivateChannel(
//         authorizationEndpoint: Uri.parse("https://ddvila.softvencefsd.xyz/broadcasting/auth"),
//         headers: {
//           "Authorization": "Bearer ${getAccessToken()}", // You need to implement getAccessToken()
//         },
//       ),
//     );
//
//     _channelEventSubs = userChannel
//         .bind("Namu\\WireChat\\Events\\NotifyParticipant") // Adjust event name based on your backend
//         .listen((event) {
//       print("Conversation update received: ${event.data}");
//
//       // Refresh chat list when a conversation is updated
//       if (mounted) {
//         getAllChatListRx.getChatListInfo();
//       }
//     });
//
//     userChannel.subscribeIfNotUnsubscribed();
//   }
//
//   // Helper methods to get user data (you need to implement these based on your app)
//   String getCurrentUserId() {
//     // Return current user ID from your app state
//     return "user_id_here";
//   }
//
//   String getAccessToken() {
//     // Return access token from your app state
//     return "access_token_here";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: const SizedBox(),
//         centerTitle: true,
//         title: Text("Chat", style: TextFontStyle.textLine20w400cFFFFFFDvSans),
//         backgroundColor: Colors.black,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
//         child: Column(
//           children: [
//             // Search Bar
//             Container(
//               margin: const EdgeInsets.only(bottom: 20),
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               child: TextField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   hintText: 'Search by name...',
//                   border: InputBorder.none,
//                   icon: const Icon(Icons.search, color: Colors.grey),
//                   suffixIcon: _searchQuery.isNotEmpty
//                       ? IconButton(
//                     icon: const Icon(Icons.clear, color: Colors.grey),
//                     onPressed: () {
//                       _searchController.clear();
//                     },
//                   )
//                       : null,
//                 ),
//               ),
//             ),
//
//             Expanded(
//               child: StreamBuilder<ChatListModelData>(
//                 stream: getAllChatListRx.dataFetcher,
//                 builder: (context, snapshot) {
//                   String formatMessageTime(String? dateTimeString) {
//                     if (dateTimeString == null || dateTimeString.isEmpty) return "";
//
//                     try {
//                       final dateTime = DateTime.parse(dateTimeString);
//                       final now = DateTime.now();
//                       final today = DateTime(now.year, now.month, now.day);
//                       final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
//
//                       if (messageDate.isAtSameMomentAs(today)) {
//                         return DateFormat('h:mm a').format(dateTime);
//                       } else if (messageDate.isAfter(today.subtract(const Duration(days: 1)))) {
//                         return 'Yesterday ${DateFormat('h:mm a').format(dateTime)}';
//                       } else {
//                         return DateFormat('MMM d, h:mm a').format(dateTime);
//                       }
//                     } catch (e) {
//                       return "";
//                     }
//                   }
//
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Center(child: CircularProgressIndicator(color: Colors.black)),
//                         UIHelper.verticalSpace(10.h),
//                         const Text("Loading...", style: TextStyle(color: Colors.black))
//                       ],
//                     );
//                   } else if (snapshot.hasError) {
//                     return const Center(child: Text("Something went wrong!"));
//                   } else if (!snapshot.hasData || snapshot.data!.data == null) {
//                     return const Center(child: Text("No conversations found."));
//                   } else {
//                     // Store all conversations and filter them
//                     _allConversations = snapshot.data!.data!.conversations ?? [];
//                     if (_searchQuery.isEmpty) {
//                       _filteredConversations = List.from(_allConversations);
//                     } else {
//                       _filterConversations();
//                     }
//
//                     return _filteredConversations.isEmpty && _searchQuery.isNotEmpty
//                         ? const Center(child: Text("No matching conversations found."))
//                         : ListView.builder(
//                       padding: const EdgeInsets.only(bottom: 80),
//                       itemCount: _filteredConversations.length,
//                       itemBuilder: (context, index) {
//                         final conversation = _filteredConversations[index];
//
//                         // Always get the first participant (index 0)
//                         final participant = conversation.participants?.isNotEmpty == true
//                             ? conversation.participants![0].participantable
//                             : null;
//
//                         // Get participant info safely
//                         final participantName = participant?.name ?? "Unknown";
//                         final participantAvatar = participant?.avatar;
//                         final participantId = conversation.participants?.isNotEmpty == true
//                             ? conversation.participants![0].participantableId
//                             : null;
//
//                         final lastMessage = conversation.lastMessage?.body ?? "No messages";
//                         final messageTime = formatMessageTime(conversation.lastMessage?.createdAt.toString());
//
//                         return Padding(
//                           padding: const EdgeInsets.only(bottom: 20),
//                           child: SizedBox(
//                             height: 54,
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.transparent,
//                                 shadowColor: Colors.transparent,
//                                 padding: EdgeInsets.zero,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(0),
//                                 ),
//                               ),
//                               onPressed: () {
//                                 if (participantId != null) {
//                                   Get.to(ChatToPersonScreen(
//                                     conversationId: conversation.id.toString(),
//                                     name: participantName,
//                                     image: "$image_url${participantAvatar}",
//                                     participantableId: participantId,
//                                   ));
//                                   setState(() {
//                                     selectedIndexes.add(index);
//                                   });
//                                 }
//                               },
//                               child: Row(
//                                 children: [
//                                   ClipOval(
//                                     child: participantAvatar != null
//                                         ? Image.network(
//                                       "$image_url$participantAvatar",
//                                       height: 53,
//                                       width: 53,
//                                       fit: BoxFit.cover,
//                                       errorBuilder: (context, error, stackTrace) {
//                                         return Container(
//                                           height: 53,
//                                           width: 53,
//                                           color: Colors.grey,
//                                           child: const Icon(Icons.person, color: Colors.white),
//                                         );
//                                       },
//                                     )
//                                         : Container(
//                                       height: 53,
//                                       width: 53,
//                                       color: Colors.grey,
//                                       child: const Icon(Icons.person, color: Colors.white),
//                                     ),
//                                   ),
//                                   UIHelper.horizontalSpace(10),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Expanded(
//                                               child: Text(
//                                                 participantName,
//                                                 style: TextFontStyle.buttonTextStyle.copyWith(
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize: 16,
//                                                   color: AppColor.blackColor,
//                                                 ),
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                             ),
//                                             Text(
//                                               messageTime,
//                                               style: TextFontStyle.buttonTextStyle.copyWith(
//                                                 fontWeight: FontWeight.w400,
//                                                 fontSize: 12,
//                                                 color: AppColor.blackColor.withOpacity(0.6),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                         UIHelper.verticalSpace(7),
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Expanded(
//                                               child: Text(
//                                                 lastMessage,
//                                                 style: TextFontStyle.buttonTextStyle.copyWith(
//                                                     fontWeight: selectedIndexes.contains(index)
//                                                         ? FontWeight.w400
//                                                         : FontWeight.w600,
//                                                     fontSize: 12,
//                                                     color: selectedIndexes.contains(index)
//                                                         ? AppColor.blackColor.withOpacity(0.7)
//                                                         : AppColor.blackColor),
//                                                 maxLines: 1,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                             ),
//                                             UIHelper.horizontalSpace(30),
//                                             if (conversation.readable == false)
//                                               const CircleAvatar(
//                                                 radius: 5,
//                                                 backgroundColor: Colors.blue,
//                                               )
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }