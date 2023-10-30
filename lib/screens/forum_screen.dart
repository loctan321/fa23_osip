import 'package:flutter/material.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  final List<String> _posts = []; // List to store posts

  final TextEditingController _postController = TextEditingController();

  void _addPost() {
    setState(() {
      _posts.add(_postController.text);
      _postController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_posts[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _postController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your post here',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _addPost,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
