import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../gen/assets/assets.gen.dart';
import '../../../theme/app_style.dart';
import '../../../theme/color_paletes.dart';
import '../cubit/chat_gpt_cubit.dart';
import '../widget/chat_widget.dart';

class ChatGptScreen extends StatefulWidget {
  const ChatGptScreen({super.key});
  static const String routeName = '/ChatGptScreen';

  @override
  State<ChatGptScreen> createState() => _ChatGptScreenState();
}

class _ChatGptScreenState extends State<ChatGptScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatGptCubit, ChatGptState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorPalettes.chatGptBackgroundColor,
          appBar: AppBar(
            centerTitle: true,
            elevation: 2,
            backgroundColor: ColorPalettes.cardColor,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            title: Row(
              children: [
                Assets.images.chatLogo.image(height: 40, width: 40),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'ChatGPT',
                  style: AppTextStyle.H4(color: Colors.white),
                ),
              ],
            ),
          ),
          body: SafeArea(
              child: Form(
            key: formKey,
            child: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                      controller:
                          context.read<ChatGptCubit>().listScrollController,
                      itemCount: state.chatList.length,
                      itemBuilder: (context, index) {
                        return ChatWidget(
                          message: state.chatList[index].message,
                          chatIndex: state.chatList[index].chatIndex,
                          showAnimate: state.chatList.length - 1 == index,
                        );
                      }),
                ),
                state.isTyping
                    ? const SpinKitThreeBounce(
                        color: Colors.white,
                        size: 18,
                      )
                    : Container(),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  color: ColorPalettes.cardColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Pls enter some text';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) async {
                            if (formKey.currentState!.validate()) {
                              context
                                  .read<ChatGptCubit>()
                                  .sendMessageFCT(context: context);
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          controller:
                              context.read<ChatGptCubit>().chatController,
                          decoration: InputDecoration(
                            hintText: 'How can I help you',
                            hintStyle: AppTextStyle.paragraphMedium(
                                color: Colors.grey),
                          ),
                        )),
                        IconButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                context
                                    .read<ChatGptCubit>()
                                    .sendMessageFCT(context: context);
                              }
                            },
                            icon: const Icon(
                              Icons.send,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
        );
      },
    );
  }
}
