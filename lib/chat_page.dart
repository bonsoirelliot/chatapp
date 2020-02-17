import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  static const String id = 'CHAT';

  final FirebaseUser user;

  const Chat({Key key, this.user}) : super(key: key);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future<void> callback() async {
    if (messageController.text.length > 0) {
      await _firestore.collection('messages').add({
        'text': messageController.text,
        'from': widget.user.email,
        'date': DateTime.now().toIso8601String().toString(),
      });
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
      //messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        /* leading: Hero(
          tag: 'logo',
          child: Container(
            height: 50.0,
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
        ),*/

        title: Text('Nikitagram Chat'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _auth.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  _firestore.collection('messages').orderBy('date').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                List<DocumentSnapshot> docs = snapshot.data.documents;

                List<Widget> messages = docs
                    .map((doc) => Message(
                          from: doc.data['from'],
                          text: doc.data['text'],
                          me: widget.user.email == doc.data['from'],
                        ))
                    .toList();

                return ListView(
                  controller: ScrollController(),
                  children: <Widget>[
                    ...messages,
                  ],
                );
              },
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onSubmitted: (value) {
                      callback();
                      messageController.clear();
                    },
                    decoration: InputDecoration(
                      hintText: 'Ваше драгоценное послание',
                      border: const OutlineInputBorder(),
                    ),
                    controller: messageController,
                  ),
                ),
                SendButton(
                  callback: () {
                    callback();
                    messageController.clear();
                  },
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}

class SendButton extends StatelessWidget {
  final VoidCallback callback;

  const SendButton({Key key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.send),
      onPressed: callback,
      splashColor: Colors.blue,
      iconSize: 40.0,
    );
  }
}

class Message extends StatelessWidget {
  final String from;
  final String text;

  final bool me;

  const Message({Key key, this.from, this.text, this.me}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment:
              me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              from,
            ),
            Material(
              color: me ? Colors.teal : Colors.red,
              borderRadius: BorderRadius.circular(10.0),
              elevation: 6.0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Text(
                  text,
                ),
              ),
            )
          ],
        ));
  }
}
