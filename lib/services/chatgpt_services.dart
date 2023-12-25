import 'dart:io';

import 'package:dio/dio.dart';

import '../api_key.dart';
import '../features/chatgpt/model/chatgpt_message_model.dart';

class ChatGptServices {
  final dio = Dio();

  Future<List<ChatModel>> sendMessage({required String message}) async {
    try {
      final response = await dio.post(
          'https://api.openai.com/v1/chat/completions',
          data: {
            'model': 'gpt-3.5-turbo',
            'messages': [
              {"role": "user", "content": message}
            ],
          },
          options: Options(headers: {
            'Authorization': 'Bearer $API_KEY',
            'Content-Type': 'application/json'
          }));

      Map json = response.data;

      if (json['error'] != null) {
        throw HttpException(json['error']['message']);
      }
      List<ChatModel> listChat = [];
      if (json['choices'].length > 0) {
        listChat = List.generate(
            json['choices'].length,
            (index) => ChatModel(
                message: json["choices"][index]["message"]['content'],
                chatIndex: 1));
      }

      return listChat;
    } catch (e) {
      throw e.toString();
    }
  }
}
