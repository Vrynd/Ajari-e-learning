import 'package:flutter/material.dart';

// Import discussion components
class ChatMessage {
  final String username;
  final String content;
  final String avatarUrl;
  final bool isMe;
  final DateTime timestamp;

  ChatMessage({
    required this.username,
    required this.content,
    required this.avatarUrl,
    required this.isMe,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class ChatContact {
  final String username;
  final String avatarUrl;
  String lastMessage;
  DateTime lastMessageTime;
  final List<ChatMessage> messages;

  ChatContact({
    required this.username,
    required this.avatarUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.messages,
  });
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    // Fallback avatar image (network) in case message.avatarUrl is empty
    const String fallbackAvatar = 'https://i.pravatar.cc/100?img=64';

    final avatar = message.avatarUrl.isNotEmpty
        ? NetworkImage(message.avatarUrl)
        : NetworkImage(fallbackAvatar);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: message.isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Incoming message: avatar on the left
          if (!message.isMe) ...[
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: avatar,
            ),
            const SizedBox(width: 8),
          ],

          // Message bubble
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.isMe
                    ? Theme.of(context).primaryColor
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                message.content,
                style: TextStyle(
                  color: message.isMe ? Colors.white : Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
          ),

          // Outgoing message: avatar on the right
          if (message.isMe) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: avatar,
            ),
          ],
        ],
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;

  const ChatScreen({super.key, this.onBackToHome});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  ChatContact? _selectedContact;
  // User's profile avatar (used for outgoing messages)
  final String _myAvatarUrl = 'https://i.pravatar.cc/100?img=10';

  final List<ChatContact> _contacts = [
    ChatContact(
      username: 'Kevin Sirait',
      avatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
      lastMessage: 'Halo! Ada yang bisa saya bantu?',
      lastMessageTime: DateTime.now(),
      messages: [
        ChatMessage(
          username: 'Kevin Sirait',
          content: 'Halo! Ada yang bisa saya bantu?',
          avatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
          isMe: false,
        ),
      ],
    ),
    ChatContact(
      username: 'Sarah Johnson',
      avatarUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      lastMessage: 'Hi! Saya instruktur UI/UX Design.',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 30)),
      messages: [
        ChatMessage(
          username: 'Sarah Johnson',
          content: 'Hi! Saya instruktur UI/UX Design.',
          avatarUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
          isMe: false,
        ),
      ],
    ),
    ChatContact(
      username: 'David Lee',
      avatarUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
      lastMessage: 'Selamat datang di kelas Programming!',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
      messages: [
        ChatMessage(
          username: 'David Lee',
          content: 'Selamat datang di kelas Programming!',
          avatarUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
          isMe: false,
        ),
      ],
    ),
  ];

  void _sendMessage(String message) {
    if (message.trim().isEmpty || _selectedContact == null) return;

    final newMessage = ChatMessage(
      username: 'Saya',
      content: message,
      avatarUrl: _myAvatarUrl,
      isMe: true,
    );

    setState(() {
      _selectedContact!.messages.add(newMessage);
      _selectedContact!.lastMessage = message;
      _selectedContact!.lastMessageTime = DateTime.now();
    });

    // Simulate auto-reply after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      final autoReply = ChatMessage(
        username: _selectedContact!.username,
        content: _getAutoReply(message),
        avatarUrl: _selectedContact!.avatarUrl,
        isMe: false,
      );

      setState(() {
        _selectedContact!.messages.add(autoReply);
        _selectedContact!.lastMessage = autoReply.content;
        _selectedContact!.lastMessageTime = DateTime.now();
      });
    });

    _messageController.clear();
  }

  String _getAutoReply(String message) {
    message = message.toLowerCase();
    if (message.contains('halo') ||
        message.contains('hi') ||
        message.contains('hello')) {
      return 'Hai! Ada yang bisa saya bantu?';
    } else if (message.contains('kelas') || message.contains('course')) {
      return 'Kami memiliki banyak kelas yang menarik. Kelas apa yang anda minati?';
    } else if (message.contains('terima kasih')) {
      return 'Sama-sama! Jika ada pertanyaan lain, silakan tanyakan saja.';
    } else {
      return 'Mohon maaf, saya tidak mengerti. Bisa dijelaskan lebih detail?';
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'Baru saja';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} menit yang lalu';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} jam yang lalu';
    } else {
      return '${difference.inDays} hari yang lalu';
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Mirror the AppBar back behavior for the system back button
        if (_selectedContact != null) {
          setState(() {
            _selectedContact = null;
          });
          // we handled the pop by returning to contact list
          return false;
        }

        if (widget.onBackToHome != null) {
          widget.onBackToHome!();
          // prevent popping the route; parent handled navigation
          return false;
        }

        // If there is no parent callback, confirm before exiting the screen
        final shouldExit =
            await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Konfirmasi'),
                content: const Text('Keluar dari layar chat?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Keluar'),
                  ),
                ],
              ),
            ) ??
            false;

        return shouldExit;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // If a contact is selected, go back to the contact list view.
              if (_selectedContact != null) {
                setState(() {
                  _selectedContact = null;
                });
              } else {
                // If no contact is selected (we're on the contact list),
                // call the parent-provided callback to switch to Home if available.
                if (widget.onBackToHome != null) {
                  widget.onBackToHome!();
                } else {
                  // If there is no parent callback, ask for confirmation before popping
                  showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Konfirmasi'),
                      content: const Text('Keluar dari layar chat?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Keluar'),
                        ),
                      ],
                    ),
                  ).then((value) {
                    if (value == true) Navigator.pop(context);
                  });
                }
              }
            },
          ),
          title: Text(
            _selectedContact == null ? 'Chat' : _selectedContact!.username,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: _selectedContact == null
            ? _buildContactList()
            : _buildChatScreen(),
      ),
    );
  }

  Widget _buildContactList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _contacts.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final contact = _contacts[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(contact.avatarUrl),
            radius: 25,
          ),
          title: Text(
            contact.username,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            contact.lastMessage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            _formatTime(contact.lastMessageTime),
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
          onTap: () => setState(() => _selectedContact = contact),
        );
      },
    );
  }

  Widget _buildChatScreen() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            reverse: true, // Show the latest message at the bottom
            padding: const EdgeInsets.all(16),
            itemCount: _selectedContact!.messages.length,
            itemBuilder: (context, index) {
              // Reverse the order to show the newest messages last
              final message = _selectedContact!
                  .messages[_selectedContact!.messages.length - 1 - index];
              return _ChatBubble(message: message);
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Ketik pesan...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  onSubmitted: _sendMessage,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.send),
                color: Theme.of(context).primaryColor,
                onPressed: () => _sendMessage(_messageController.text),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
