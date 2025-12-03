import 'package:flutter/material.dart';

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class AiAssistant extends StatefulWidget {
  const AiAssistant({super.key});

  @override
  State<AiAssistant> createState() => _AiAssistantState();
}

class _AiAssistantState extends State<AiAssistant> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<ChatMessage> messages = [
    ChatMessage(
      text:
          "Я готов помочь с любым вопросом! Начните с одного из предложенных ниже.",
      isUser: false,
    ),
  ];

  bool _isTyping = false;

  final List<String> _quickPrompts = [
    "Напиши рецепт пасты",
    "Идеи для отпуска в Азии",
    "Объясни квантовую физику (просто)",
  ];

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _handleSendMessage({String? text}) {
    final messageText = text ?? _textController.text.trim();
    if (messageText.isEmpty) return;

    setState(() {
      messages.add(ChatMessage(text: messageText, isUser: true));
      _textController.clear();
      _isTyping = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _isTyping = false;
        messages.add(
          ChatMessage(
            text:
                "Вы спросили: \"$messageText\". Это очень интересный вопрос! Вот мой тестовый ответ...",
            isUser: false,
          ),
        );
      });
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2F),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _buildHeader(),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                itemCount: messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == messages.length && _isTyping) {
                    return _TypingIndicator();
                  }
                  return _buildMessageBubble(messages[index]);
                },
              ),
            ),
            if (messages.length == 1 &&
                !_isTyping &&
                _textController.text.isEmpty)
              _buildPromptSuggestions(),
            _buildInputArea(),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Ai Assistant',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white70),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final bool isUser = message.isUser;
    final Color bubbleColor = isUser
        ? const Color(0xFF5A5A9A)
        : const Color(0xFF2C2C4A);
    final Alignment alignment = isUser
        ? Alignment.centerRight
        : Alignment.centerLeft;
    final BorderRadius borderRadius = BorderRadius.circular(16.0).copyWith(
      bottomRight: isUser
          ? const Radius.circular(4)
          : const Radius.circular(16),
      bottomLeft: isUser ? const Radius.circular(16) : const Radius.circular(4),
    );

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: borderRadius,
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.white70,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget _buildPromptSuggestions() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0, left: 4.0),
            child: Text(
              'Идеи для начала:',
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
          ),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _quickPrompts.map((prompt) {
              return ActionChip(
                label: Text(prompt),
                labelStyle: const TextStyle(
                  color: Color(0xFFC3C3E5),
                  fontWeight: FontWeight.w500,
                ),
                backgroundColor: const Color(0xFF2C2C4A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Color(0xFF4B4B6C), width: 1),
                ),
                onPressed: () => _handleSendMessage(text: prompt),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    final bool isInputEmpty = _textController.text.isEmpty;

    return Container(
      padding: const EdgeInsets.only(
        bottom: 8.0,
        top: 8.0,
        left: 10.0,
        right: 10.0,
      ),
      color: const Color(0xFF1A1A2F),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C4A),
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(color: const Color(0xFF4B4B6C), width: 1),
              ),
              child: TextField(
                controller: _textController,
                onChanged: (text) {
                  setState(() {});
                },
                onSubmitted: (_) => _handleSendMessage(),
                style: const TextStyle(color: Colors.white, fontSize: 16.0),
                decoration: const InputDecoration(
                  hintText: 'Сообщение...',
                  hintStyle: TextStyle(color: Colors.white54),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 12.0,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const SizedBox(width: 8.0),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: isInputEmpty ? _buildVoiceButton() : _buildSendButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return FloatingActionButton(
      key: const ValueKey('sendButton'),
      onPressed: _handleSendMessage,
      backgroundColor: const Color(0xFF5A5A9A),
      elevation: 0,
      mini: false,
      child: const Icon(Icons.send, color: Colors.white, size: 20),
    );
  }

  Widget _buildVoiceButton() {
    return SizedBox(
      key: const ValueKey('voiceButton'),
      width: 48,
      height: 48,
      child: FloatingActionButton(
        onPressed: () {
          _handleSendMessage(text: "Начало записи голоса...");
        },
        backgroundColor: const Color(0xFF5A5A9A),
        elevation: 0,
        child: const Icon(Icons.mic, color: Colors.white, size: 24),
      ),
    );
  }
}

class _TypingIndicator extends StatefulWidget {
  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildBar(int index) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final delay = index * 0.15;
        double animationValue = (_controller.value + delay) % 1.0;
        double currentProgress = 0.0;
        if (animationValue <= 0.5) {
          currentProgress = Curves.easeInOut.transform(animationValue * 2);
        } else {
          currentProgress = Curves.easeInOut.transform(
            (1 - animationValue) * 2,
          );
        }
        final double animatedHeight = 4.0 + (12.0 * currentProgress);
        return Container(
          width: 4.0,
          height: animatedHeight,
          margin: const EdgeInsets.symmetric(horizontal: 1.5),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(2.0),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C4A),
          borderRadius: BorderRadius.circular(
            16.0,
          ).copyWith(bottomLeft: const Radius.circular(4)),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.3,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[_buildBar(0), _buildBar(1), _buildBar(2)],
        ),
      ),
    );
  }
}
