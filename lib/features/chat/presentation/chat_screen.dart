import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/common/widgets/app_text_form_field.dart';
import 'package:servicenear/common/widgets/custom_app_bar.dart';
import 'package:servicenear/features/chat/domain/entites/message_entity.dart';
import 'package:servicenear/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:servicenear/features/chat/presentation/cubit/chat_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;

  const ChatScreen({super.key, required this.receiverId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    final currentUser = Supabase.instance.client.auth.currentUser;

    if (currentUser != null) {
      context.read<ChatCubit>().loadMessagesBetweenCustomerAndWorker(
        currentUser.id,
        widget.receiverId,
        "worker",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        AppUser? receiver;
        List<MessageEntity> messages = [];

        if (state is ChatReceiverLoaded) {
          receiver = state.receiverName;
        }
        if (state is ChatLoaded) {
          receiver = state.receiver;
          messages = List.from(state.messages)
            ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
        }

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: CustomAppBar(
            title: receiver != null
                ? "${receiver.firstName} ${receiver.lastName}"
                : "Loading...",
            subtitle: receiver?.email ?? "",
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final currentUserId =
                        Supabase.instance.client.auth.currentUser?.id;

                    final isSender = msg.senderId == currentUserId;

                    return Align(
                      alignment: isSender
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 6.h),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        constraints: BoxConstraints(maxWidth: 250.w),
                        decoration: BoxDecoration(
                          color: isSender ? AppColors.primary : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r),
                            bottomLeft: Radius.circular(isSender ? 20.r : 0.r),
                            bottomRight: Radius.circular(isSender ? 0.r : 20.r),
                          ),
                        ),
                        child: Text(
                          msg.messageText,
                          style: AppStyles.font14DarkRegular.copyWith(
                            color: isSender
                                ? Colors.white
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    Expanded(
                      child: AppTextFormField(
                        controller: _controller,
                        hintText: "Type a message...",
                        backgroundColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 14.h,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        validator: (_) => null,
                      ),
                    ),
                    SizedBox(width: 12.w),

                    GestureDetector(
                      onTap: () {
                        final currentUser =
                            Supabase.instance.client.auth.currentUser;
                        if (currentUser == null) return;

                        context.read<ChatCubit>().sendMessage(
                          senderId: currentUser.id,
                          receiverId: widget.receiverId,
                          senderType: 'customer',
                          receiverType: 'worker',
                          messageText: _controller.text,
                        );

                        _controller.clear();
                      },
                      child: Container(
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
