// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/features/chat/model/chat_to_person.dart';
import 'package:ddavila/features/chat/widget/admin_chat_widget.dart';
import 'package:ddavila/features/chat/widget/chat_bottom_bar.dart';
import 'package:ddavila/features/chat/widget/user_chat_widget.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ChatToPersonScreen extends StatefulWidget {
  final dynamic participantableId;
  final dynamic name;
  final dynamic image;
  final dynamic conversationId;

  const ChatToPersonScreen({
    super.key,
    required this.participantableId,
    required this.name,
    required this.image,
    required this.conversationId,
  });

  @override
  State<ChatToPersonScreen> createState() => _ChatToPersonScreenState();
}

class _ChatToPersonScreenState extends State<ChatToPersonScreen> {
  bool isKeyboardVisible = false;
  final TextEditingController chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final StreamSubscription<bool> _keyboardVisibilitySubscription;

  PusherChannelsClient? _pusherClient;
  StreamSubscription? _connectionSubs;
  StreamSubscription<ChannelReadEvent>? _channelEventSubs;
  bool _isLoading = true;
  String? _errorMessage;
  List<Message> _messages = [];
  bool nullMessage = false;
  dynamic myId = appData.read(kKeyUserID);
  bool youBLock = true;
  bool blockedYou = true;
  XFile? selectedImage;
  bool isMessageSending = false;

  @override
  void initState() {
    super.initState();
    print("participant Id: ${widget.participantableId}");
    print("Conversation Id: ${widget.conversationId}");
    print("my Id: ${myId}");
    _loadInitialMessages();
    _initializePusher();
  }

  String formatUtcToTimeAMPM({required String utcTimeString}) {
    DateTime utcDateTime = DateTime.parse(utcTimeString).toUtc();

    // Convert to your local time (e.g. GMT+6 for Bangladesh)
    DateTime localTime = utcDateTime.add(Duration(hours: 6));

    // Format to 12-hour with AM/PM
    String formattedTime = DateFormat('hh:mm a').format(localTime);
    return formattedTime;
  }

  Future<void> _loadInitialMessages() async {
    try {
      setState(() => _isLoading = true);
      final response = await getChatMessageRx.getChatList(
          participantableId: widget.participantableId);

      if (mounted && response?.data?.conversations?.messages != null) {
        setState(() {
          _messages =
              response?.data?.conversations?.messages?.reversed.toList() ?? [];
          youBLock = response!.data!.youblocked!;
          blockedYou = response.data!.blockedyou!;

          nullMessage =
          response.data?.conversations?.messages == [] ? true : false;
          _isLoading = false;
        });
        _scrollToBottom();
      } else {
        setState(() {
          _errorMessage = 'No messages found';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to load messages: $e';
          _isLoading = false;
        });
      }
    }
  }

  ///>>>>>>>>>>>>>>>>>>>> here is the block status >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  void _initializePusher() {
    try {
      const hostOptions = PusherChannelsOptions.fromHost(
        scheme: 'wss',
        host: 'app.thehobbynexus.com',
        key: '5bcus2pmxhiwlo28uzz3',
        shouldSupplyMetadataQueries: true,
        metadata: PusherChannelsOptionsMetadata.byDefault(),
        port: 8083,
      );

      // Step 2: Create Pusher client
      _pusherClient = PusherChannelsClient.websocket(
        options: hostOptions,
        connectionErrorHandler: (exception, trace, refresh) async {
          log("Connection error: $exception", error: trace);
          await Future.delayed(const Duration(seconds: 2));
          refresh();
        },
      );

      // Step 3: Create private channel
      final myPrivateChannel = _pusherClient!.privateChannel(
        "private-chat.${widget.conversationId}",
        // "private-chat.${widget.conversationId}",
        authorizationDelegate:
        EndpointAuthorizableChannelTokenAuthorizationDelegate
            .forPrivateChannel(
          authorizationEndpoint: Uri.parse(
              "https://ddvila.softvencefsd.xyz/api/broadcasting/auth"),
          headers: {
            "Authorization": "Bearer ${appData.read(kKeyAccessToken)}",
          },
        ),
      );

      // Step 4: Subscribe to connection established
      _connectionSubs = _pusherClient!.onConnectionEstablished.listen((_) {
        log('Pusher connected successfully');
        myPrivateChannel.subscribeIfNotUnsubscribed();
      });

      // Step 5: Listen to incoming messages
      // _channelEventSubs = myPrivateChannel
      //     .bind("App\\Events\\MessageCustomEvent")
      //     .listen((event) {
      //   print("=======================in the pushar: ${event.data}");
      //
      //   try {
      //     if (event.data != null) {
      //       print("=======================Pusher event data: ${event.data}");
      //
      //       final Map<String, dynamic> messageData = json.decode(event.data);
      //       print(
      //           "=======================Pusher message ID: ${messageData['id']}");
      //       print(
      //           "=======================Pusher conversation ID: ${messageData['conversation_id']}");
      //       print(
      //           "=======================sendable_id: ${messageData["sendable_id"]}");
      //       print(
      //           "=======================Pusher message content: ${messageData["content"]}");
      //       print("=======================Pusher my ID: $myId");
      //       print("=======================Pusher isMe: ${messageData["isMe"]}");
      //
      //       final newMessage = Message(
      //         id: messageData['id'] ?? 0,
      //         body: messageData['content'], // Changed from 'body' to 'content'
      //         type: 'text',
      //         createdAt: DateTime.parse(messageData['created_at']),
      //         isMe: messageData["sendable_id"] == myId
      //             ? true
      //             : false, // Changed to compare with myId
      //         // reactions: [], // Empty array if no reactions
      //       );
      //
      //       if (mounted) {
      //         setState(() {
      //           _messages.insert(0, newMessage);
      //         });
      //         _scrollToBottom();
      //       }
      //     } else {
      //       print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> event issue");
      //     }
      //   } catch (e, stack) {
      //     log("Error in main pusher : $e", error: stack);
      //   }
      // });




      _channelEventSubs = myPrivateChannel
          .bind("App\\Events\\MessageCustomEvent")
          .listen((event) {
        print("=======================in the pushar: ${event.data}");

        try {
          if (event.data != null) {
            print("=======================Pusher event data: ${event.data}");

            final Map<String, dynamic> messageData = json.decode(event.data);

            // Check if there's image attachment
            bool hasImageAttachment = false;
            List<Attachment> attachments = [];

            if (messageData['attachment'] != null && messageData['attachment'] is List) {
              List<dynamic> attachmentList = messageData['attachment'];
              if (attachmentList.isNotEmpty) {
                hasImageAttachment = true;
                for (var attachmentData in attachmentList) {
                  attachments.add(Attachment(
                    id: attachmentData['id'] ?? 0,
                    filePath: attachmentData['file_path'] ?? '',
                    fileName: attachmentData['file_name'] ?? '',
                    originalName: attachmentData['original_name'] ?? '',
                    url: attachmentData['url'] ?? '',
                    mimeType: attachmentData['mime_type'] ?? '',
                  ));
                }
              }
            }

            final newMessage = Message(
              id: messageData['id'] ?? 0,
              body: hasImageAttachment ? '' : messageData['content'], // Empty string for images
              type: hasImageAttachment ? 'image' : 'text',
              createdAt: DateTime.parse(messageData['created_at']),
              isMe: messageData["sendable_id"] == myId,
              attachment: attachments,
            );

            if (mounted) {
              setState(() {
                _messages.insert(0, newMessage);
              });
              _scrollToBottom();
            }
          }
        } catch (e, stack) {
          log("Error in main pusher : $e", error: stack);
        }
      });





















      _pusherClient!.connect();
    } catch (e, stack) {
      log("Pusher initialization failed: $e", error: stack);
      if (mounted) {
        Fluttertoast.showToast(
          msg: "Failed to initialize real-time connection",
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // void _sendMessage() {
  //   setState(() {
  //     isMessageSending = true;
  //   });
  //   log("Sending message: ${chatController.text ?? ""} with ${selectedImages.length} images");
  //   log("this is the message ${chatController.text}");
  //
  //   sendMessageRx
  //       .addChat(
  //     message: chatController.text.trim(),
  //     toUserId: widget.participantableId,
  //     avatars: selectedImages,
  //   )
  //       .then((response) {
  //     if (response != null) {
  //       setState(() {
  //         isMessageSending = false;
  //       });
  //       log("Message sent successfully");
  //       _scrollToBottom();
  //       setState(() {
  //         chatController.clear();
  //         selectedImages.clear(); // Clear parent's list
  //       });
  //     } else {
  //       setState(() {
  //         isMessageSending = false;
  //       });
  //       _showError("Failed to send message");
  //     }
  //   }).catchError((error) {
  //     setState(() {
  //       isMessageSending = false;
  //     });
  //     _showError("Message rejected: $error");
  //   });
  // }



  void _clearImageAfterSend() {
    setState(() {
      selectedImage = null; // ইমেজ clear করুন
    });
  }

// _sendMessage method update করুন
  void _sendMessage() {
    setState(() {
      isMessageSending = true;
    });

    log("Sending message: ${chatController.text ?? ""} with image: ${selectedImage?.path}");

    sendMessageRx
        .addChat(
      message: chatController.text.trim(),
      toUserId: widget.participantableId,
      avatar: selectedImage,
    )
        .then((response) {
      if (response != null) {
        setState(() {
          isMessageSending = false;
          chatController.clear();
          // selectedImage = null; // এখানে না করে callback এর মাধ্যমে করবেন
        });

        _clearImageAfterSend(); // ইমেজ clear করুন
        log("Message sent successfully");
        _scrollToBottom();
      } else {
        setState(() {
          isMessageSending = false;
        });
        _showError("Failed to send message");
      }
    }).catchError((error) {
      setState(() {
        isMessageSending = false;
      });
      _showError("Message rejected: $error");
    });
  }




  void _showError(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    chatController.dispose();
    _keyboardVisibilitySubscription.cancel();
    _connectionSubs?.cancel();
    _channelEventSubs?.cancel();
    _pusherClient?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent, // Make sure to set this
          leadingWidth: 30,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    ///>>>>>>>>>>>>>>>>>>>>>> here you can send the profile>>>>>>>>>>>>>>>>>>>>>>>>>>>

                    // onTap:(){
                    //   Get.to(ProfileScreen(id: widget.receiverId,));
                    // },

                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.network(
                            widget.image.toString(),
                            width: 32, // double the radius (16 * 2)
                            height: 32,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 32,
                                height: 32,
                                color: Colors.grey, // Fallback color
                                child: Image.asset(AppImages.profileIcon),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 200.w,
                          child: Text(
                            widget.name,
                            style: TextFontStyle.buttonTextStyle
                                .copyWith(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  AppImages.appLogo,
                  color: Colors.white,
                  width: 20.w,
                  height: 20.h,
                ),
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple.shade300,
                  Colors.blue.shade200,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple.shade300,
                Colors.blue.shade200,
                Colors.blue.shade200,
                Colors.blue.shade200,
                Colors.blue.shade200,
                Colors.blue.shade200,
                Colors.blue.shade200,
                Colors.blue.shade200,
                Colors.purple.shade200,
                Colors.purple.shade300,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Expanded(
                  child: _isLoading
                      ? const Center(
                    child: Text("Data is loading...",
                        style: TextStyle(color: Colors.white)),
                  )
                      : _errorMessage != null
                      ? Center(child: Text(_errorMessage!))
                      : _messages.isEmpty
                      ? Center(
                    child: SizedBox(
                      height: 200.h,
                      width: 300.h,
                      child: Column(
                        children: [
                          ClipOval(
                            child: Image.network(
                              widget.image.toString(),
                              width: 106,
                              height: 106,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) {
                                return Container(
                                  width: 32,
                                  height: 32,
                                  color: Colors.grey,
                                  child: Image.asset(
                                      AppImages.profileIcon),
                                );
                              },
                            ),
                          ),
                          UIHelper.verticalSpace(12.h),
                          Text(widget.name.toString(),
                              style:
                              TextFontStyle.buttonTextStyle),
                          Text(
                            "Start Conversation .Say Hi",
                            style: TextFontStyle.buttonTextStyle,
                          ),
                        ],
                      ),
                    ),
                  )
                      : ListView.builder(
                    controller: _scrollController,
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 20),
                    reverse: true,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final isSentByCurrentUser =
                          message.isMe ?? false;

                      // Check if we need to show a date header
                      final currentMessageDate =
                          message.createdAt;
                      final bool showDateHeader;

                      if (index == _messages.length - 1) {
                        // First message (since list is reversed)
                        showDateHeader = true;
                      } else {
                        final previousMessage =
                        _messages[index + 1];
                        final previousMessageDate =
                            previousMessage.createdAt;

                        // Show header if dates are different
                        showDateHeader =
                            currentMessageDate != null &&
                                previousMessageDate != null &&
                                !_isSameDay(currentMessageDate,
                                    previousMessageDate);
                      }

                      // print(">>>>>>>>>>>>>>> this is screen site list of attachment ${message.attachment?.map((item){item.filePath.toString();})}");

                      print(
                          ">>>>>>>>>>>>>>> this is screen site list of attachment ${message.attachment?.map((item) {
                            return item.filePath.toString();
                          }).toList()}");

                      return Column(
                        children: [
                          if (showDateHeader)
                            DateHeader(
                                date: formatUtcToDate(
                                    message.createdAt)),
                          Align(
                            alignment: isSentByCurrentUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: isSentByCurrentUser
                                ? UserChatWidget(
                              attachments:
                              message.attachment ?? [],
                              time: formatUtcToTimeAMPM(
                                  utcTimeString: message
                                      .createdAt
                                      .toString()),
                              message: message.body ?? "",
                              isMe: message.isMe!,
                            )
                                : AdminChatWidget(
                              attachments:
                              message.attachment ?? [],
                              id: 3,
                              time: formatUtcToTimeAMPM(
                                  utcTimeString: message
                                      .createdAt
                                      .toString()),
                              senderName: widget.name,
                              message: message.body ?? "",
                              image: widget.image ?? "",
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                // blockStatus == false?
                // ChatBottomBarWidget(
                //   chatController: chatController,
                //   onTapAdd: () {},
                //   onTapMic: () {},
                //   onSendTap: _sendMessage,
                // ) : CustomElevatedButton(onPressed: (){
                //
                //   UserBlockDialogueBox(context: context,
                //       onStatusChanged : _updateBlockStatus
                //       ,blockId:widget.receiverId ,blockStatus: blockStatus);
                //
                // }, text:"Unblock",),

// In your build method:

                ChatBottomBarWidget(
                  onMessageSent: _clearImageAfterSend,
                  chatController: chatController,
                  onSendTap: _sendMessage,
                  isMessageSend: isMessageSending,
                  onImageSelected: (image) { // Changed from onImagesSelected
                    setState(() {
                      selectedImage = image; // Store single image
                    });
                  },
                  selectedImage: selectedImage, // Pass single image
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmojiReactionOverlay extends StatelessWidget {
  final Function(String) onEmojiSelected;
  final Offset position;

  const EmojiReactionOverlay({
    required this.onEmojiSelected,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    final emojis = ['👍', '❤️', '😂', '😮', '😢', '🙏'];

    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: emojis.map((emoji) {
              return GestureDetector(
                onTap: () => onEmojiSelected(emoji),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text(
                    emoji,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

String formatUtcToDate(DateTime? utcDateTime) {
  if (utcDateTime == null) return '';

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final messageDate =
  DateTime(utcDateTime.year, utcDateTime.month, utcDateTime.day);

  if (messageDate == today) {
    return 'Today';
  } else if (messageDate == yesterday) {
    return 'Yesterday';
  } else {
    return '${_getMonthName(messageDate.month)} ${messageDate.day}, ${messageDate.year}';
  }
}

String _getMonthName(int month) {
  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  return months[month - 1];
}

bool _isSameDay(DateTime? date1, DateTime? date2) {
  if (date1 == null || date2 == null) return false;
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

// Date Header Widget
class DateHeader extends StatelessWidget {
  final String date;

  const DateHeader({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          // color: Colors.grey[200],
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          date,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
