part of 'chat_gpt_cubit.dart';

class ChatGptState extends Equatable {
  const ChatGptState({
    this.isTyping = false,
    this.currentModel = 'gpt-3.5-turbo',
    this.chatList = const [],
  });
  final bool isTyping;
  final String currentModel;
  final List<ChatModel> chatList;

  ChatGptState copyWith({
    bool? isTyping,
    String? currentModel,
    List<ChatModel>? chatList,
  }) {
    return ChatGptState(
      isTyping: isTyping ?? this.isTyping,
      currentModel: currentModel ?? this.currentModel,
      chatList: chatList ?? this.chatList,
    );
  }

  @override
  List<Object> get props => [isTyping, currentModel, chatList];
}
