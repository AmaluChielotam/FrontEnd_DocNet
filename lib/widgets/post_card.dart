import 'package:flutter/material.dart';
import '../model/doctor_model.dart';
import 'doctor_card.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Author info
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=${post.author.id}'),
              backgroundColor: Color(0xFF2D5B8F).withOpacity(0.1),
            ),
            title: Text(
              post.author.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D5B8F),
              ),
            ),
            subtitle: Text(
              '${post.author.specialty} • ${post.author.hospital}',
              style: TextStyle(fontSize: 12),
            ),
            trailing: Text(
              _formatTime(post.timestamp),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),

          // Post content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              post.content,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),

          SizedBox(height: 12),

          // Tags
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              children: post.tags.map((tag) => Chip(
                label: Text(
                  '#$tag',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF2D5B8F),
                  ),
                ),
                backgroundColor: Color(0xFF2D5B8F).withOpacity(0.1),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              )).toList(),
            ),
          ),

          SizedBox(height: 16),

          // Actions
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[200]!),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(Icons.thumb_up_outlined, 'Like', post.likes),
                _buildActionButton(Icons.comment_outlined, 'Comment', post.comments),
                _buildActionButton(Icons.share_outlined, 'Share', 0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, int count) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          if (count > 0) ...[
            SizedBox(width: 4),
            Text(
              count.toString(),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}