import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/common/widgets/app_text_form_field.dart';
import 'package:servicenear/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:servicenear/features/chat/presentation/cubit/chat_state.dart';
import 'package:servicenear/features/home/presentation/widgets/chat_item.dart';

class ChatListView extends StatefulWidget {
  final String currentUserId;
  final ChatCubit cubit;

  const ChatListView({
    super.key,
    required this.currentUserId,
    required this.cubit,
  });

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().loadAllChats(widget.currentUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text("Messages", style: AppStyles.font24BlueBold),
              SizedBox(height: 20.h),

              AppTextFormField(
                hintText: 'Search for services or workers',
                validator: (_) => null,
                hintStyle: AppStyles.font14GrayRegular,
                prefixIcon: const Icon(Icons.search, color: AppColors.textHint),
                backgroundColor: AppColors.scaffoldBackground,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 20.h,
                ),
              ),

              SizedBox(height: 20.h),

              Expanded(
                child: BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    if (state is ChatLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is ChatConversationLoaded) {
                      if (state.chats.isEmpty) {
                        return const Center(
                          child: Text("No conversations yet"),
                        );
                      }

                      return ListView.separated(
                        itemCount: state.chats.length,
                        separatorBuilder: (_, _) =>
                            Divider(color: AppColors.divider),
                        itemBuilder: (context, index) {
                          final chat = state.chats[index];

                          return InkWell(
                            onTap: () {
                              print(
                                "Tapped on chat with ${chat.userName} (ID: ${chat.userId})",
                              );
                              context.read<ChatCubit>().markMessagesAsRead(
                                chat,
                              );
                            },
                            child: ChatItem(
                              name: chat.userName,
                              lastMessage: chat.lastMessage,
                              time: chat.lastMessageTime,
                              unreadCount: chat.unreadCount,
                            ),
                          );
                        },
                      );
                    }

                    if (state is ChatError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
