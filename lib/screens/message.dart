import 'package:flutter/material.dart';
import 'package:flutterprojects/model/doctor_model.dart';
import 'package:flutterprojects/widgets/message_card.dart';
import 'chat.dart';

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  // Sample conversations list
  final List<ChatConversation> _conversations = [
    ChatConversation(
      id: '1',
      participants: [
        Doctor(
          id: '1',
          name: 'Dr. Sarah Chen',
          specialty: 'Cardiology',
          hospital: 'Mayo Clinic',
          rating: 4.9,
          votes: 284,
          imageUrl: 'assets/doctor1.jpg',
          isOnline: true,
          experience: '15 years',
          isVerified: true,
          location: 'Rochester, MN',
          bio: 'Cardiologist specializing in minimally invasive procedures',
          connections: 342,
          skills: ['Echocardiography', 'Cardiac Catheterization', 'Patient Care'],
        ),
        Doctor(
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
      ],
      messages: [
        ChatMessage(
          id: '1',
          conversationId: '1',
          sender: Doctor(
            id: '1',
            name: 'Dr. Sarah Chen',
            specialty: 'Cardiology',
            hospital: 'Mayo Clinic',
            rating: 4.9,
            votes: 284,
            imageUrl: 'assets/doctor1.jpg',
            isOnline: true,
            experience: '15 years',
            isVerified: true,
            location: 'Rochester, MN',
            bio: 'Cardiologist specializing in minimally invasive procedures',
            connections: 342,
            skills: ['Echocardiography', 'Cardiac Catheterization', 'Patient Care'],
          ),
          content: 'Hi there! I saw your post about the new cardiac procedure. Would love to discuss it further.',
          timestamp: DateTime.now().subtract(Duration(hours: 2)),
          isRead: true,
        ),
        ChatMessage(
          id: '2',
          conversationId: '1',
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
          content: 'Thanks for reaching out! I\'d be happy to share more details about the procedure.',
          timestamp: DateTime.now().subtract(Duration(hours: 1)),
          isRead: true,
        ),
      ],
      lastActivity: DateTime.now(),
      lastMessage: 'Thanks for reaching out! I\'d be happy to share more details about the procedure.',
    ),
    ChatConversation(
      id: '2',
      participants: [
        Doctor(
          id: '2',
          name: 'Dr. Michael Rodriguez',
          specialty: 'Neurology',
          hospital: 'Johns Hopkins',
          rating: 4.8,
          votes: 196,
          imageUrl: 'assets/doctor2.jpg',
          isOnline: false,
          experience: '12 years',
          isVerified: true,
          location: 'Baltimore, MD',
          bio: 'Neurologist with focus on migraine treatments and research',
          connections: 287,
          skills: ['EEG Interpretation', 'Migraine Management', 'Clinical Research'],
        ),
        Doctor(
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
      ],
      messages: [
        ChatMessage(
          id: '3',
          conversationId: '2',
          sender: Doctor(
            id: '2',
            name: 'Dr. Michael Rodriguez',
            specialty: 'Neurology',
            hospital: 'Johns Hopkins',
            rating: 4.8,
            votes: 196,
            imageUrl: 'assets/doctor2.jpg',
            isOnline: false,
            experience: '12 years',
            isVerified: true,
            location: 'Baltimore, MD',
            bio: 'Neurologist with focus on migraine treatments and research',
            connections: 287,
            skills: ['EEG Interpretation', 'Migraine Management', 'Clinical Research'],
          ),
          content: 'The conference next month looks promising. Are you attending?',
          timestamp: DateTime.now().subtract(Duration(hours: 3)),
          isRead: true,
        ),
      ],
      lastActivity: DateTime.now().subtract(Duration(hours: 3)),
      lastMessage: 'The conference next month looks promising. Are you attending?',
    ),
  ];

  // Get other participant (not current user)
  Doctor _getOtherParticipant(ChatConversation conversation) {
    return conversation.participants.firstWhere(
          (doctor) => doctor.id != 'current_user',
      orElse: () => conversation.participants.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          'Messages',
          style: TextStyle(
            color: Color(0xFF2D5B8F),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Color(0xFF2D5B8F)),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Color(0xFF2D5B8F)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search messages...',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
            ),
          ),

          // Online Doctors
          Container(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildOnlineStatus('Dr. Sarah Chen', 'https://i.pravatar.cc/150?img=1', true),
                _buildOnlineStatus('Dr. James Wilson', 'https://i.pravatar.cc/150?img=5', true),
                _buildOnlineStatus('Dr. Lisa Park', 'https://i.pravatar.cc/150?img=6', true),
                _buildOnlineStatus('Dr. Robert Brown', 'https://i.pravatar.cc/150?img=7', false),
              ],
            ),
          ),

          SizedBox(height: 16),

          // Conversations List
          Expanded(
            child: ListView.builder(
              itemCount: _conversations.length,
              itemBuilder: (context, index) {
                final conversation = _conversations[index];
                final otherParticipant = _getOtherParticipant(conversation);
                final lastMessage = conversation.messages.isNotEmpty
                    ? conversation.messages.last
                    : ChatMessage(
                  id: '0',
                  conversationId: conversation.id,
                  sender: otherParticipant,
                  content: 'Start a conversation',
                  timestamp: DateTime.now(),
                  isRead: true,
                );

                return ListTile(
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=${otherParticipant.id}'),
                      ),
                      if (otherParticipant.isOnline)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Color(0xFF4CAF50),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  title: Text(
                    otherParticipant.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D5B8F),
                    ),
                  ),
                  subtitle: Text(
                    lastMessage.content,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: lastMessage.isRead ? Colors.grey : Color(0xFF2D5B8F),
                      fontWeight: lastMessage.isRead ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _formatTime(lastMessage.timestamp),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      if (!lastMessage.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Color(0xFF2D5B8F),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(conversation: conversation),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnlineStatus(String name, String imageUrl, bool isOnline) {
    return Container(
      width: 70,
      margin: EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(imageUrl),
              ),
              if (isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            name.split(' ')[1],
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inDays}d';
    }
  }
}