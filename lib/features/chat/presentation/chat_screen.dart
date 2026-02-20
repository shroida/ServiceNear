import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/common/widgets/app_text_form_field.dart';
import 'package:servicenear/common/widgets/custom_app_bar.dart';

class ChatScreen extends StatefulWidget {
  final String chatTitle;
  final String chatSubtitle;

  const ChatScreen({
    super.key,
    required this.chatTitle,
    required this.chatSubtitle,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [
    {'text': 'Hi! How can I help you?', 'isSender': false},
    {'text': 'Hello! I want to book your service.', 'isSender': true},
    {'text': 'Sure! When do you need it?', 'isSender': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: widget.chatTitle,
        subtitle: widget.chatSubtitle,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return Align(
                  alignment: msg['isSender']
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
                      color: msg['isSender'] ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                        bottomLeft: Radius.circular(
                          msg['isSender'] ? 20.r : 0.r,
                        ),
                        bottomRight: Radius.circular(
                          msg['isSender'] ? 0.r : 20.r,
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
                      msg['text'],
                      style: AppStyles.font14DarkRegular.copyWith(
                        color: msg['isSender']
                            ? Colors.white
                            : AppColors.textPrimary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// Input section
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
                  onTap: () {
                    if (_controller.text.trim().isEmpty) return;
                    setState(() {
                      messages.add({
                        'text': _controller.text.trim(),
                        'isSender': true,
                      });
                      _controller.clear();
                    });
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
    );
  }
}
