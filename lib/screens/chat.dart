import 'package:flutter/material.dart';
import 'package:flutterprojects/model/doctor_model.dart';
import 'package:flutterprojects/widgets/message_card.dart';

class ChatScreen extends StatefulWidget {
  final ChatConversation conversation;

  const ChatScreen({Key? key, required this.conversation}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  bool _isTyping = false;

  // Get the other participant (not current user)
  Doctor get _otherParticipant {
    return widget.conversation.participants.firstWhere(
          (doctor) => doctor.id != 'current_user',
      orElse: () => widget.conversation.participants.first,
    );
  }

  @override
  void initState() {
    super.initState();
    // Auto-scroll to bottom when keyboard appears
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _scrollToBottom();
      }
    });

    // Initial scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    // Create new message
    final newMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      conversationId: widget.conversation.id,
      sender: Doctor(
        id: 'current_user',
        name: 'Dr. Alex Thompson',
        specialty: 'Internal Medicine',
        hospital: 'Massachusetts General Hospital',
        rating: 4.8,
        votes: 198,
        imageUrl: 'assets/doctor12.jpg',
        isOnline: true,
        experience: '8 years',
        isVerified: true,
        location: 'Boston, MA',
        bio: 'Internal Medicine Physician',
        connections: 147,
        skills: ['Preventive Medicine', 'Chronic Disease Management'],
      ),
      content: message,
      timestamp: DateTime.now(),
      isRead: false,
      type: MessageType.text,
    );

    // Add to conversation
    setState(() {
      widget.conversation.messages.add(newMessage);
    });

    // Clear input and scroll to bottom
    _messageController.clear();
    _scrollToBottom();

    // Simulate typing indicator
    _simulateReply();
  }

  void _simulateReply() async {
    setState(() {
      _isTyping = true;
    });

    // Simulate typing delay
    await Future.delayed(Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isTyping = false;
      });

      // Add automated reply
      final replies = [
        "Thanks for sharing that information!",
        "I'll review the case and get back to you.",
        "That's an interesting approach. Have you considered...",
        "I've had similar cases. Let me share my experience.",
        "Could you send me the lab results when you have a moment?",
      ];

      final randomReply = replies[DateTime.now().millisecondsSinceEpoch % replies.length];

      final replyMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        conversationId: widget.conversation.id,
        sender: _otherParticipant,
        content: randomReply,
        timestamp: DateTime.now(),
        isRead: false,
        type: MessageType.text,
      );

      setState(() {
        widget.conversation.messages.add(replyMessage);
      });

      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF2D5B8F)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=${_otherParticipant.id}'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _otherParticipant.isOnline ? Color(0xFF4CAF50) : Colors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _otherParticipant.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D5B8F),
                    ),
                  ),
                  Text(
                    _otherParticipant.isOnline ? 'Online' : 'Last seen recently',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.phone, color: Color(0xFF2D5B8F)),
            onPressed: () {
              // Implement voice call
            },
          ),
          IconButton(
            icon: Icon(Icons.videocam, color: Color(0xFF2D5B8F)),
            onPressed: () {
              // Implement video call
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat messages area
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16),
              itemCount: widget.conversation.messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isTyping && index == widget.conversation.messages.length) {
                  return _buildTypingIndicator();
                }

                final message = widget.conversation.messages[index];
                final isMe = message.sender.id == 'current_user';

                return MessageCard(message: message, isMe: isMe);
              },
            ),
          ),

          // Message input area
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Row(
              children: [
                // Attachment button
                IconButton(
                  icon: Icon(Icons.attach_file, color: Color(0xFF2D5B8F)),
                  onPressed: () {
                    // Implement attachment
                  },
                ),

                // Message input field
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            focusNode: _focusNode,
                            decoration: InputDecoration(
                              hintText: 'Type a message...',
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            maxLines: null,
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) => _sendMessage(),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.emoji_emotions_outlined, color: Color(0xFF2D5B8F)),
                          onPressed: () {
                            // Implement emoji picker
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Send button
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2D5B8F),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 8,
            height: 8,
            margin: EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8),
          Text(
            '${_otherParticipant.name.split(' ')[0]} is typing...',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}