import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'package:google_ai/messageBox.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.googleApiKey,
  });
  final String googleApiKey;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

TextEditingController inputControler = TextEditingController();
List<MessageBox> messages = [];
bool isSender = false;

final scrollController = ScrollController();

class _ChatScreenState extends State<ChatScreen> {
  // API Request
  void aiRequest(String input) async {
    final model =
        GenerativeModel(model: 'gemini-pro', apiKey: widget.googleApiKey);

    final prompt = input;
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    setState(() {
      messages.add(MessageBox(
        message: response.text.toString(),
        isSender: isSender,
      ));
    });

    //print(response.text);
  }

  // Send text
  void sendMessage(String message) {
    setState(() {
      messages.add(MessageBox(
        message: message,
      ));
    });
  }

  // scroll controller
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn);
      }
    });

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Chat Screen'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 640,
                      child: ListView(
                        controller: _scrollController,
                        children: messages
                            .map((text) => MessageBox(
                                  message: text.message,
                                  isSender: text.isSender,
                                ))
                            .toList(),
                      ),
                    ),
                    TextField(
                      controller: inputControler,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Type a message',
                        suffixIcon: IconButton(
                          onPressed: () {
                            sendMessage(inputControler.text);
                            aiRequest(inputControler.text);
                            inputControler.clear();
                          },
                          icon: const Icon(Icons.send),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
