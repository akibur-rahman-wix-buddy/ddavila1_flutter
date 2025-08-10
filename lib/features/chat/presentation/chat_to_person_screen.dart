


import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/features/chat/model/chat_to_person.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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



  @override
  void initState() {
    super.initState();
    print("Receiver Id: ${widget.participantableId}");
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
          participantableId:  widget.participantableId);

      if (mounted && response?.data?.conversations?.messages != null) {
        setState(() {
          _messages = response?.data?.conversations?.messages?.reversed.toList()??[];
          youBLock = response!.data!.youblocked! ;
          blockedYou = response.data!.blockedyou! ;

          nullMessage =response.data?.conversations?.messages ==[]? true : false;
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
        authorizationDelegate: EndpointAuthorizableChannelTokenAuthorizationDelegate
                .forPrivateChannel(
          authorizationEndpoint:
              Uri.parse("https://app.thehobbynexus.com/api/broadcasting/auth"),
          headers: {
           "Authorization": "Bearer ${appData.read(kKeyAccessToken)}",
           //  "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FwcC50aGVob2JieW5leHVzLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3NTQ3MzUxMDMsImV4cCI6MTc1NDczODcwMywibmJmIjoxNzU0NzM1MTAzLCJqdGkiOiJBc2VPNzVLQkg1WGxxUzYwIiwic3ViIjoiMyIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.sDyi_E8XfDrC2Zj1PV0uG646_PPjc6DeqKLs1OQML78",
          },
        ),
      );

      // Step 4: Subscribe to connection established
      _connectionSubs = _pusherClient!.onConnectionEstablished.listen((_) {
        log('Pusher connected successfully');
        myPrivateChannel.subscribeIfNotUnsubscribed();
      });

      // Step 5: Listen to incoming messages
      _channelEventSubs = myPrivateChannel.bind("App\\Events\\MessageCustomEvent").listen((event) {

        print("=======================in the pushar: ${event.data}");


        try {
          // if (event.data != null) {
          //   print("=======================Pusher event data: ${event.data}");
          //
          //   final Map<String, dynamic> messageData = json.decode(event.data);
          //   print(
          //       "=======================Pusher sender id data: ${messageData['id']}");
          //   print(
          //       "=======================Pusher receiver id data: ${messageData['receiver_id']}");
          //   print(
          //       "=======================Pusher sender id data: ${messageData["sendable_id"]}");
          //   print(
          //       "=======================Pusher sender body: ${messageData["body"]}");
          //   print("=======================Pusher sender my Id: $myId");
          //
          //   final newMessage = Message(
          //     id: messageData['id'] ?? 0,
          //     body: messageData['body'],
          //     type: 'text',
          //     createdAt: DateTime.parse(messageData['created_at']),
          //     isMe: messageData["sender_id"].toString() == 2.toString()
          //         ? true
          //         : false,
          //     // reactions: [], // Empty array if no reactions
          //   );
          //
          //   if (mounted) {
          //     setState(() {
          //       _messages.insert(0, newMessage);
          //     });
          //     _scrollToBottom();
          //   }
          // }
          if (event.data != null) {
            print("=======================Pusher event data: ${event.data}");

            final Map<String, dynamic> messageData = json.decode(event.data);
            print("=======================Pusher message ID: ${messageData['id']}");
            print("=======================Pusher conversation ID: ${messageData['conversation_id']}");
            print("=======================sendable_id: ${messageData["sendable_id"]}");
            print("=======================Pusher message content: ${messageData["content"]}");
            print("=======================Pusher my ID: $myId");
            print("=======================Pusher isMe: ${messageData["isMe"]}");

            final newMessage = Message(
              id: messageData['id'] ?? 0,
              body: messageData['content'], // Changed from 'body' to 'content'
              type: 'text',
              createdAt: DateTime.parse(messageData['created_at']),
              isMe: messageData["sendable_id"] == myId ? true : false, // Changed to compare with myId
              // reactions: [], // Empty array if no reactions
            );

            if (mounted) {
              setState(() {
                _messages.insert(0, newMessage);
              });
              _scrollToBottom();
            }
          }








          else{
            print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> event issue");
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

  void _sendMessage() {
    if (chatController.text.isNotEmpty) {
      final messageText = chatController.text.trim();
      log("Sending message: $messageText");
      sendMessageRx
          .addChat(
        message: messageText,
        toUserId: widget.participantableId,
          avatars: []
      )
          .then((response) {
        if (response != null) {
          log("Message sent successfully");
          _scrollToBottom();
        } else {
          log("Failed to send message");
          Fluttertoast.showToast(
            msg: "Failed to send message",
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 3,
            gravity: ToastGravity.BOTTOM,
          );
        }
      }).catchError((error) {
        log("Error sending message: $error");
        Fluttertoast.showToast(
          msg: "Message rejected: $error",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      });
      setState(() {
        chatController.clear();
      });
    }
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
            mainAxisAlignment:MainAxisAlignment.spaceBetween ,

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
                width: 32,  // double the radius (16 * 2)
                height: 32,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 32,
                    height: 32,
                    color: Colors.grey,  // Fallback color
                    child: Image.asset(AppImages.profileIcon),
                  );
                },
                        ),
                      ),
                const SizedBox(width: 8),
                SizedBox(width: 200.w,
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
                onTap: () {



                 // Get.to( PersonInboxInfo(blockStatus:blockStatus,blockId: widget.receiverId,conversationId: widget.conversationId,));




                          // if(  true) {
                          //   Get.to(GroupIntoScreen(
                          //     conversionId: widget.conversationId,
                          //     type: "",
                          //   ));
                          // } else {
                          //   Get.to(UserGroupIntoScreen());
                          // }
                        }
               ,
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
                    child: Text("Data is loading...", style: TextStyle(color: Colors.white)),
                  )
                      : _errorMessage != null
                      ? Center(child: Text(_errorMessage!))
                      : _messages.isEmpty?



                      Center(
                        child: Container(
                          height: 200.h,
                          width: 300.h,
                          child: Column(

                            children: [
                              ClipOval(
                                child: Image.network(
                                  widget.image.toString(),
                                  width: 106,  // double the radius (16 * 2)
                                  height: 106,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 32,
                                      height: 32,
                                      color: Colors.grey,  // Fallback color
                                      child: Image.asset(AppImages.profileIcon),
                                    );
                                  },
                                ),
                              ),
                              UIHelper.verticalSpace(12.h),
                              
                              Text(widget.name.toString(),style:TextFontStyle.buttonTextStyle),
                              // UIHelper.verticalSpace(8.h),
                              Text("Start Conversation .Say Hi",style:TextFontStyle.buttonTextStyle,),
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

                      print(">>>>>>>>>>>>>>>>>>>>> is me ? ${message.isMe}");


                      final isSentByCurrentUser = message.isMe ?? false;

                      return Align(
                        alignment: isSentByCurrentUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: isSentByCurrentUser
                            ? UserChatWidget(
                          time: formatUtcToTimeAMPM(
                              utcTimeString: message.createdAt.toString()),
                          message: message.body ?? "",
                          // image: message.sender?.avatar.toString() ?? "",
                        )
                            : AdminChatWidget(
                          id: 3,
                          time: formatUtcToTimeAMPM(
                              utcTimeString: message.createdAt.toString()),
                          senderName: widget.name,
                          message: message.body ?? "",
                          image: widget.image ?? "",
                        ),
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


                ChatBottomBarWidget(
                  chatController: chatController,
                  onTapAdd: () {},
                  onTapMic: () {},
                  onSendTap: _sendMessage,
                ) ,
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




class ChatBottomBarWidget extends StatelessWidget {
  final VoidCallback onTapAdd;
  final VoidCallback onTapMic;
  final VoidCallback onSendTap;
  final TextEditingController chatController;

  const ChatBottomBarWidget({
    super.key,
    required this.onTapMic,
    required this.onTapAdd,
    required this.onSendTap,
    required this.chatController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                controller: chatController,
                style:TextFontStyle.buttonTextStyle
                    .copyWith(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  // prefixIcon: IconButton(
                  //   onPressed: onTapAdd,
                  //   icon: const Icon(
                  //     Icons.add,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  // suffixIcon: IconButton(
                  //   onPressed: onTapMic,
                  //   icon: const Icon(Icons.mic, color: Colors.white),
                  // ),
                  hintText: "Send a message...",
                  hintStyle: TextFontStyle.buttonTextStyle
                      .copyWith(color: Colors.white, fontSize: 14),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Colors.white, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 1),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onSendTap,
            child: Container(
              height: 50,
              width: 50,
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(50.r)
              ),
              child: Icon(Icons.send_sharp,color: Colors.white,)
            ),
          ),
        ],
      ),
    );
  }
}





class AdminChatWidget extends StatelessWidget {
  final String message;
  final String senderName;
  final String image;
  final dynamic id;
  final String time;


  const AdminChatWidget({
    super.key,
    required this.message,
    required this.senderName,
    required this.image, required this.time,required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              // userProfileDialogBox(
              //   name: senderName,
              //   image: image,
              //   id: id,
              //   context: context
              // );
            },
            child: Text(
              senderName,
              style: TextFontStyle.buttonTextStyle.copyWith(color: Colors.white,fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  // userProfileDialogBox(
                  //     name: senderName,
                  //     image: image,
                  //     id: id,
                  //     context: context
                  // );
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(image),
                ),
              ),
              UIHelper.horizontalSpace(5.w),
              GestureDetector(
                onLongPress: () {
                  Clipboard.setData(ClipboardData(text: message));
                  ToastUtil.showLongToast("Test copied");
                },
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.83),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: TextFontStyle.buttonTextStyle
                            .copyWith(fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      Text(
                        time,
                        style: TextFontStyle.buttonTextStyle
                            .copyWith(fontWeight: FontWeight.w700, fontSize: 12,color: Colors.white60),
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
}

class UserChatWidget extends StatelessWidget {
  final String message;
  // final String image;
  final String time;


  const UserChatWidget({super.key, required this.message,
    // required this.image,
    required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(

            onLongPress: () {
              Clipboard.setData(ClipboardData(text: message));
              ToastUtil.showLongToast("Test copied");
            },
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              decoration: const BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message,
                    style: TextFontStyle.buttonTextStyle
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    time,
                    style: TextFontStyle.buttonTextStyle
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.white60),
                  ),
                ],
              ),
            ),
          ),
          UIHelper.horizontalSpace(10),
        ],
      ),
    );
  }
}

class ShimmerList extends StatelessWidget {
  final int itemCount;
  const ShimmerList({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          color: Colors.grey[300],
        ),
      ),
    );
  }
}


class _EmojiReactionOverlay extends StatelessWidget {
  final Function(String) onEmojiSelected;
  final Offset position;

  const _EmojiReactionOverlay({
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