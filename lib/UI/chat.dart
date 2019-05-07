import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String imgUrl;
  final String firstName;
  final String lastName;
  final String year;

  const ChatPage(
      {Key key, this.imgUrl, this.firstName, this.lastName, this.year})
      : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Bubble(
              time: '12:00',
              message: 'Hello , ${widget.firstName}.',
              delivered: true,
              isMe: true,
            ),
            Bubble(
              time: '12:01',
              message: 'Hi Teacher, how are you?',
              delivered: true,
              isMe: false,
            ),
            Bubble(
              time: '12:02',
              message: 'I\'m good and you?',
              delivered: true,
              isMe: true,
            ),
            Bubble(
              time: '12:05',
              message: 'I\'m great thank you!',
              delivered: true,
              isMe: false,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 4.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.circular(50.0)),
                  height: 50,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 8.0),
              child: Container(
                width: 60,
                height: 60,
                child: Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: Icon(
                    Icons.send,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(50.0)),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.videocam,size: 30,)),
          Padding(
            
            padding: const EdgeInsets.only(right:8.0),
            child: IconButton(
              onPressed: (){},
              icon: Icon(Icons.phone,size: 30,)),
          ),
       

        ],
        title: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(widget.imgUrl),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.firstName + " " + widget.lastName),
                Text(
                  widget.year,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Bubble extends StatelessWidget {
  Bubble({this.message, this.time, this.delivered, this.isMe});

  final String message, time;
  final delivered, isMe;

  @override
  Widget build(BuildContext context) {
    final bg = !isMe ? Colors.white : Colors.blue.shade100;
    final align = !isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final icon = delivered ? Icons.done_all : Icons.done;
    final radius = !isMe
        ? BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          );
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: .5,
                  spreadRadius: 1.0,
                  color: Colors.black.withOpacity(.12))
            ],
            color: bg,
            borderRadius: radius,
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 60.0),
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    Text(time,
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 12.0,
                        )),
                    SizedBox(width: 3.0),
                    Visibility(
                      visible: isMe,
                      child: Icon(
                        icon,
                        size: 16.0,
                        color: delivered ? Colors.blue : Colors.black38,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
