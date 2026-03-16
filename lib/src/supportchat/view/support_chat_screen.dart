import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/drawer_menu/view/drawer_menu.dart'
    show DrawerMenu;
import 'package:go_router/go_router.dart' show GoRouterHelper;
import '../../app/color_palette.dart';

class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({super.key});

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, dynamic>> _messages = [
    {
      "text": "Hey Rahul! How may i help you?",
      "isMe": false,
      "time": "10:00 AM",
    },
    {
      "text": "Hey Rahul! How may i help you?",
      "isMe": true,
      "time": "10:01 AM",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorPalette.background,
      drawer: const DrawerMenu(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.go('/home');
          },
        ),
        title: const Text(
          "Support Chat",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),

          const Text(
            "Today",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 6),

          Text.rich(
            const TextSpan(
              children: [
                TextSpan(
                  text: 'Rahul ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: 'Joined the chat',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _messages.length,
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                return _buildChatBubble(_messages[index]);
              },
            ),
          ),

          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(Map<String, dynamic> msg) {
    bool isMe = msg["isMe"];

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMe) ...[
          const CircleAvatar(
            radius: 14,
            backgroundColor: Colors.white,
            child: Text(
              "A",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],

        Container(
          width: 256,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),

          decoration: BoxDecoration(
            color: const Color(0xFF24232A),
            borderRadius: BorderRadius.circular(10),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                msg["text"],
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),

              const SizedBox(height: 6),

              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  msg["time"],
                  style: const TextStyle(color: Colors.white, fontSize: 8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),

      child: Container(
        height: 50,

        decoration: BoxDecoration(
          color: const Color(0xFF24232A),
          borderRadius: BorderRadius.circular(10),
        ),

        child: Row(
          children: [
            const SizedBox(width: 15),

            Expanded(
              child: TextField(
                controller: _messageController,
                style: const TextStyle(color: Colors.white),

                decoration: const InputDecoration(
                  hintText: "Write Something...",
                  hintStyle: TextStyle(color: Colors.white38, fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),

            IconButton(
              icon: const Icon(Icons.mic, color: Colors.white54),
              onPressed: () {},
            ),

            IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                if (_messageController.text.isNotEmpty) {
                  setState(() {
                    _messages.add({
                      "text": _messageController.text,
                      "isMe": true,
                      "time": "10:02 AM",
                    });
                  });

                  _messageController.clear();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
