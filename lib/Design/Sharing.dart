import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';



class Sharing extends StatefulWidget {
  static String id="Sharing";
  @override
  _SharingState createState() => _SharingState();
}

class _SharingState extends State<Sharing> {

  @override
  Widget build(BuildContext context) {
    String msg = 'hello,this is my github:https://github.com/lizhuoyuan';
    String base64Image =
        "";

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.memory(
                  base64.decode(base64Image.split(',')[1]),
                  height: 312,
                  width: 175.3,
                  fit: BoxFit.fill,
                  gaplessPlayback: true,
                ),
                SizedBox(height: 30),
                RaisedButton(
                  child: Text('share to twitter'),
                  onPressed: () async {
                    var response = await FlutterShareMe().shareToTwitter(
                        url: 'https://github.com/lizhuoyuan', msg: msg);
                    if (response == 'success') {
                      print('navigate success');
                    }
                  },
                ),
                RaisedButton(
                  child: Text('share to WhatsApp'),
                  onPressed: () {
                    FlutterShareMe()
                        .shareToWhatsApp(base64Image: base64Image, msg: msg);
                  },
                ),
                RaisedButton(
                  child: Text('share to WhatsApp Business'),
                  onPressed: () {
                    FlutterShareMe()
                        .shareToWhatsApp4Biz(base64Image: base64Image, msg: msg);
                  },
                ),
                RaisedButton(
                  child: Text('share to shareFacebook'),
                  onPressed: () {
                    FlutterShareMe().shareToFacebook(
                        url: 'https://github.com/lizhuoyuan', msg: msg);
                  },
                ),
                RaisedButton(
                  child: Text('share to System'),
                  onPressed: () async {
                    var response = await FlutterShareMe().shareToSystem(msg: msg);
                    if (response == 'success') {
                      print('navigate success');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }
  }}
