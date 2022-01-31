import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/io.dart';

class ChatPage extends StatefulWidget {
  String ID, dName;
  bool hastaMi;
  ChatPage.doktor(
      {this.ID, // kendi girer
      this.dName,
      this.hastaMi}); // doktor kendi ıd 'sini verdi ve Hasta 3 yazısı
  ChatPage.hasta(
      {this.ID, // seçer
      this.dName,
      this.hastaMi}); // hasta doktor id si ve doktorun ismini aldı
  @override
  State<StatefulWidget> createState() {
    return ChatPageState(ID, dName, hastaMi);
  }
}

class ChatPageState extends State<ChatPage> {
  ChatPageState(this.rID, this.receiverName, this.hastaMi);

  IOWebSocketChannel channel; // websocket
  bool connected; //  connection status
  String rID;
  String myId;
  bool hastaMi;
  String receiverName;
  String auth = "chatapphdfgjd34534hjdfk"; //auth key

  List<MessageData> listOfMessages = [];
  TextEditingController controller = TextEditingController();

  //String myId = "JCCjWSWbxuBinkSXc7eH"; //my id
  //String recieverid = "JCCjWSWbxuBinkSXc7eH"; //reciever id

  @override
  void initState() {
    idBul(rID);
    connected = false;
    controller.text = "";
    channelconnect();
    super.initState();
  }

  void idBul(String num) {
    if (hastaMi) {
      myId = "100";
      rID = num;
    } else {
      myId = num;
      rID = "100";
    }
  }

  channelconnect() {
    //function to connect
    try {
      channel = IOWebSocketChannel.connect(
          "ws://192.168.18.6:6060/${myId}"); //channel IP : Port
      channel.stream.listen(
        (message) {
          print(message);
          setState(() {
            if (message == "connected") {
              connected = true;
              setState(() {});
              print("Connection establised.");
            } else if (message == "send:success") {
              print("Message send success");
              setState(() {
                controller.text = "";
              });
            } else if (message == "send:error") {
              print("Message send error");
            } else if (message.substring(0, 6) == "{'cmd'") {
              print("Message data");
              message = message.replaceAll(RegExp("'"), '"');
              var jsondata = json.decode(message);

              listOfMessages.add(MessageData(
                //on message recieve, add data to model
                msgtext: jsondata["msgtext"],
                userid: jsondata["userid"],
                byMe: false,
              ));
              setState(() {
                //update UI after adding data to message model
              });
            }
          });
        },
        onDone: () {
          //if WebSocket is disconnected
          print("Web socket is closed");
          setState(() {
            connected = false;
          });
        },
        onError: (error) {
          print(error.toString());
        },
      );
    } catch (_) {
      print("error on connecting to websocket.");
    }
  }

  Future<void> sendmsg(String sendmsg, String id) async {
    if (connected == true) {
      String msg =
          "{'auth':'$auth','cmd':'send','userid':'$id', 'msgtext':'$sendmsg'}";
      setState(() {
        controller.text = "";
        listOfMessages
            .add(MessageData(msgtext: sendmsg, userid: myId, byMe: true));
      });
      channel.sink.add(msg); //send message to reciever channel
    } else {
      channelconnect();
      print("Websocket is not connected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(receiverName),
          leading: Icon(Icons.circle,
              color: connected ? Colors.greenAccent : Colors.redAccent),
          //if app is connected to node.js then it will be gree, else red.
          titleSpacing: 0,
        ),
        body: Container(
            child: Stack(
          children: [
            Positioned(
                top: 0,
                bottom: 70,
                left: 0,
                right: 0,
                child: Container(
                    padding: EdgeInsets.all(15),
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Container(
                          child: Text("Your Messages",
                              style: TextStyle(fontSize: 20)),
                        ),
                        Text("My ID : ${myId} Receiver ID: ${rID}"),
                        Container(
                            child: Column(
                          children: listOfMessages.map((onemsg) {
                            return Container(
                                margin: EdgeInsets.only(
                                  //if is my message, then it has margin 40 at left
                                  left: onemsg.byMe ? 40 : 0,
                                  right: onemsg.byMe
                                      ? 0
                                      : 40, //else margin at right
                                ),
                                child: Card(
                                    color: onemsg.byMe
                                        ? Colors.blue[100]
                                        : Colors.red[100],
                                    //if its my message then, blue background else red background
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Text(onemsg.byMe
                                                  ? "Ben"
                                                  : receiverName)),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text(onemsg.msgtext,
                                                style: TextStyle(fontSize: 17)),
                                          ),
                                        ],
                                      ),
                                    )));
                          }).toList(),
                        ))
                      ],
                    )))),
            Positioned(
              //position text field at bottom of screen

              bottom: 0, left: 0, right: 0,
              child: Container(
                  color: Colors.black12,
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          controller: controller,
                          decoration:
                              InputDecoration(hintText: "Enter your Message"),
                        ),
                      )),
                      Container(
                          margin: EdgeInsets.all(10),
                          child: ElevatedButton(
                            child: Icon(Icons.send),
                            onPressed: () {
                              if (controller.text != "") {
                                sendmsg(controller.text,
                                    rID); //send message with webspcket
                              } else {
                                print("Enter message");
                              }
                            },
                          ))
                    ],
                  )),
            )
          ],
        )));
  }
}

class MessageData {
  //message data model
  MessageData({this.msgtext, this.userid, this.byMe});
  String msgtext;
  String userid;
  bool byMe;
}