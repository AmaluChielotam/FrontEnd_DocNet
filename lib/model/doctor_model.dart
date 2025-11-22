class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String hospital;
  final double rating;
  final int votes;
  final String imageUrl;
  final bool isOnline;
  final String experience;
  final bool isVerified;
  final String location;
  final String bio;
  final int connections;
  final List<String> skills;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.hospital,
    required this.rating,
    required this.votes,
    required this.imageUrl,
    required this.isOnline,
    required this.experience,
    required this.isVerified,
    required this.location,
    required this.bio,
    required this.connections,
    required this.skills,
  });
}

class Post {
  final String id;
  final Doctor author;
  final String content;
  final DateTime timestamp;
  final int likes;
  final int comments;
  final List<String> tags;

  Post({
    required this.id,
    required this.author,
    required this.content,
    required this.timestamp,
    required this.likes,
    required this.comments,
    required this.tags,
  });
}


enum MessageType {
  text,
  image,
  file,
  system,
}

class ChatMessage {
  final String id;
  final String conversationId;
  final Doctor sender;
  final String content;
  final DateTime timestamp;
  final bool isRead;
  final MessageType type;
  final String? fileUrl;
  final String? fileName;
  final double? fileSize;

  ChatMessage({
    required this.id,
    required this.conversationId,
    required this.sender,
    required this.content,
    required this.timestamp,
    required this.isRead,
    this.type = MessageType.text,
    this.fileUrl,
    this.fileName,
    this.fileSize,
  });
}

class ChatConversation {
  final String id;
  final List<Doctor> participants;
  final List<ChatMessage> messages;
  final DateTime lastActivity;
  final String? lastMessage;

  ChatConversation({
    required this.id,
    required this.participants,
    required this.messages,
    required this.lastActivity,
    this.lastMessage,
  });
}