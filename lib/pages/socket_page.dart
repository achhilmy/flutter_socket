import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketPage extends StatefulWidget {
  SocketPage({super.key, this.channel});

  WebSocketChannel? channel;

  @override
  State<SocketPage> createState() => _SocketPageState();
}

class _SocketPageState extends State<SocketPage> {
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text(
            'Example Socket',
            style: TextStyle(color: Colors.white),
          )),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          Form(
              child: TextFormField(
            decoration: InputDecoration(labelText: "Ketikan pesan"),
            controller: messageController,
          )),
          StreamBuilder(
              stream: widget.channel?.stream,
              builder: (context, snapshot) {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                      snapshot.hasData ? "${snapshot.data}" : "Data Kosong"),
                );
              })
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: _sendMessage,
          // print(messageController.text.toString());

        
      ),
    );
  }

  void _sendMessage() {
    if (messageController.text.isNotEmpty) {
      widget.channel?.sink.add(messageController.text);
    }
  }

  @override
  void dispose() {
    widget.channel?.sink.close();
  }
}
