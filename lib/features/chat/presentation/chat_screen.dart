import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/core/di/injection.dart';
import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/common/widgets/app_text_form_field.dart';
import 'package:servicenear/common/widgets/custom_app_bar.dart';
import 'package:servicenear/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:servicenear/features/chat/presentation/cubit/chat_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatScreen extends StatefulWidget {
  final AppUser receiver;

  const ChatScreen({super.key, required this.receiver});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChatCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          title: "${widget.receiver.firstName} ${widget.receiver.lastName}",
          subtitle: widget.receiver.email,
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final msg = state.messages[index];

                      final isSender = msg.senderType == "worker";

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
                              bottomLeft: Radius.circular(
                                isSender ? 20.r : 0.r,
                              ),
                              bottomRight: Radius.circular(
                                isSender ? 0.r : 20.r,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadow,
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
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
                        borderSide: const BorderSide(color: AppColors.primary),
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
                    onTap: () async {
                      final currentUser =
                          Supabase.instance.client.auth.currentUser;

                      if (currentUser == null) {
                        debugPrint("User not logged in");
                        return;
                      }

                      final senderId = currentUser.id;

                      // determine sender type
                      final senderType = widget.receiver.id == senderId
                          ? 'worker'
                          : 'customer';

                      context.read<ChatCubit>().sendMessage(
                        senderId: senderId,
                        receiverId: widget.receiver.id,
                        senderType: senderType,
                        receiverType: senderType == 'worker'
                            ? 'customer'
                            : 'worker',
                        messageText: _controller.text,
                      );
                      print(
                        '===============================================================',
                      );
                      print('receiver Id:${widget.receiver.id}');
                      print('current Id:${currentUser.id}');
                      print(' SenderType:${senderType}');

                      print(
                        '===============================================================',
                      );

                      _controller.clear();
                    },
                    child: Container(
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
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
      ),
    );
  }
}
