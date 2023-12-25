// ignore_for_file: use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../gen/assets/assets.gen.dart';
import '../../../services/chatgpt_services.dart';
import '../../../theme/app_style.dart';
import '../model/chatgpt_message_model.dart';

part 'chat_gpt_state.dart';

class ChatGptCubit extends Cubit<ChatGptState> {
  final chatController = TextEditingController();
  final listScrollController = ScrollController();
  ChatGptCubit() : super(const ChatGptState());

  Future sendMessageFCT({required BuildContext context}) async {
    if (state.isTyping) {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed((const Duration(seconds: 2)), () {
              Navigator.of(context).pop();
            });
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Assets.images.alertPassword.image(height: 56),
              content: Text(
                'You cant send multiple message at a time',
                textAlign: TextAlign.center,
                style: AppTextStyle.H4(color: Colors.red),
              ),
            );
          });
      return;
    }
    try {
      String message = chatController.text;
      emit(state.copyWith(isTyping: true));
      List<ChatModel> updatedChatList = List.from(state.chatList);
      updatedChatList.add(ChatModel(message: message, chatIndex: 0));
      emit(state.copyWith(chatList: updatedChatList));
      chatController.clear();

      updatedChatList
          .addAll(await ChatGptServices().sendMessage(message: message));

      emit(state.copyWith(chatList: updatedChatList));
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed((const Duration(seconds: 2)), () {
              Navigator.of(context).pop();
            });
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Assets.images.alertPassword.image(height: 56),
              content: Text(
                'Some error occured pls try again',
                textAlign: TextAlign.center,
                style: AppTextStyle.H4(color: Colors.red),
              ),
            );
          });
    } finally {
      scrollListToEnd();
      emit(state.copyWith(isTyping: false));
    }
  }

  scrollListToEnd() {
    listScrollController.animateTo(
        listScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut);
  }
}
