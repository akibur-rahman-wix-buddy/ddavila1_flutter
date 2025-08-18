import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/features/chat/model/chat_list_data_model.dart';
import 'package:ddavila/features/chat/presentation/chat_to_person_screen.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
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

  @override
  void initState() {
    getAllChatListRx.getChatListInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: SizedBox(),
        centerTitle: true,
        title: Text("Chat",style: TextFontStyle.textLine20w400cFFFFFFDvSans,),

        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
        child: StreamBuilder<ChatListModelData>(
          stream: getAllChatListRx.dataFetcher,
          builder: (context, snapshot) {
            String formatMessageTime(String? dateTimeString) {
              if (dateTimeString == null || dateTimeString.isEmpty) return "";
              try {
                final dateTime = DateTime.parse(dateTimeString);
                return DateFormat('h:mm a').format(dateTime);
              } catch (e) {
                return "";
              }
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(child: CircularProgressIndicator(color: Colors.white,)),
                  UIHelper.verticalSpace(10.h),
                  const Text("Loading...", style: TextStyle(color: Colors.white))
                ],
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong!"));
            } else if (!snapshot.hasData || snapshot.data!.data == null) {
              return const Center(child: Text("No conversations found."));
            } else {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 80),
                itemCount: snapshot.data!.data!.conversations?.length ?? 0,
                itemBuilder: (context, index) {
                  final conversation =
                  snapshot.data!.data!.conversations?[index];

                  // Always get the first participant (index 0)
                  final participant =
                  conversation?.participants?.isNotEmpty == true
                      ? conversation!.participants![0].participantable
                      : null;

                  // Get participant info safely
                  final participantName = participant?.name ?? "Unknown";
                  final participantAvatar = participant?.avatar;
                  final participantId =conversation?.participants?.isNotEmpty == true
                      ? conversation!.participants![0].participantableId
                      : null;

                  final lastMessage =
                      conversation?.lastMessage?.body ?? "No messages";
                  final messageTime =
                  formatMessageTime(conversation?.lastMessage?.createdAt.toString());

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
                          print('check the  conversation id : ${conversation?.id.toString()}');
                          if (participantId != null) {
                            Get.to(ChatToPersonScreen(
                              conversationId: conversation?.participants?.first.conversationId
                                  .toString(), // Use conversation.id instead
                              name: participantName,
                              image: participantAvatar,
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
                                participantAvatar,
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
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          participantName??"",
                                          style:
                                          TextFontStyle.buttonTextStyle.copyWith(
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
                                          color: AppColor.blackColor                                              .withOpacity(0.6),
                                        ),
                                      )
                                    ],
                                  ),
                                  UIHelper.verticalSpace(7),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          lastMessage,
                                          style: TextFontStyle.buttonTextStyle.copyWith(
                                              fontWeight: selectedIndexes
                                                  .contains(index)
                                                  ? FontWeight.w400
                                                  : FontWeight.w600,
                                              fontSize: 12,
                                              color: selectedIndexes
                                                  .contains(index)
                                                  ? AppColor.blackColor
                                                  .withOpacity(0.7)
                                                  : AppColor.blackColor),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      UIHelper.horizontalSpace(30),
                                      if (conversation?.readable == false)
                                        CircleAvatar(
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
    );
  }
}
