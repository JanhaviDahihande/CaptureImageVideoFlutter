import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  File videoFile;
  File imageFile;

  _camera() async {
    File theImage = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (theImage != null) {
      setState(() {
        imageFile = theImage;
      });
    }
  }

  _picture() async {
    File theImage = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (theImage != null) {
      setState(() {
        imageFile = theImage;
      });
    }
  }

  _video() async {
    File theVideo = await ImagePicker.pickVideo(
      source: ImageSource.gallery,
    );
    if (theVideo != null) {
      setState(() {
        videoFile = theVideo;
      });
    }
  }

  _record() async {
    File theVideo = await ImagePicker.pickVideo(
      source: ImageSource.camera,
    );
    if (theVideo != null) {
      setState(() {
        videoFile = theVideo;
      });
    }
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                color: Colors.brown,
                height: MediaQuery.of(context).size.height * (30 / 100),
                width: MediaQuery.of(context).size.width,
                child: videoFile == null
                    ? Center(
                        child: Icon(
                          Icons.videocam,
                          color: Colors.red,
                        ),
                      )
                    : FittedBox(
                        fit: BoxFit.contain,
                        child: mounted
                            ? Chewie(
                                controller: ChewieController(
                                    videoPlayerController:
                                        VideoPlayerController.file(videoFile),
                                    aspectRatio: 1,
                                    autoPlay: true,
                                    looping: true))
                            : Container())),
            Container(
                color: Colors.lightGreen,
                height: MediaQuery.of(context).size.height * (30 / 100),
                width: MediaQuery.of(context).size.width,
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: imageFile == null
                        ? Center(
                            child: Icon(
                            Icons.photo,
                            color: Colors.blueAccent,
                          ))
                        : Image.file(imageFile))),
            RaisedButton(
              color: Colors.blue,
              onPressed: () => {_camera()},
              child: Text(
                'Camera',
                style: TextStyle(color: Colors.white),
              ),
            ),
            RaisedButton(
              color: Colors.indigo,
              onPressed: () => {_picture()},
              child: Text(
                'Picture',
                style: TextStyle(color: Colors.white),
              ),
            ),
            RaisedButton(
              color: Colors.green,
              onPressed: () => {_video()},
              child: Text(
                'Video',
                style: TextStyle(color: Colors.white),
              ),
            ),
            RaisedButton(
              color: Colors.red,
              onPressed: () => {_record()},
              child: Text(
                'Record',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
