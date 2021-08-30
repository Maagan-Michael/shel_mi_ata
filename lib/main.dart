// Copyright 2020, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getToken();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessageOpenedApp.listen((event) { print('kami');});
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

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
  MyHomePage({Key? key, required this.title}) : super(key: key);

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




  final moviesRef = FirebaseFirestore.instance
      .collection('firestore-example-app')
      .add({'hey': 10});

  void _incrementCounter() async {
    final moviesRef = await FirebaseFirestore.instance
        .collection('firestore-example-app')
        .add({'hey': 10});

    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }


  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Wrap(
            children: [
              Container(
                width: 100,
                child: TextFormField(
                  initialValue: builder.siblingSeparation.toString(),
                  decoration: InputDecoration(labelText: "Sibling Separation"),
                  onChanged: (text) {
                    builder.siblingSeparation = int.tryParse(text) ?? 100;
                    this.setState(() {});
                  },
                ),
              ),
              Container(
                width: 100,
                child: TextFormField(
                  initialValue: builder.levelSeparation.toString(),
                  decoration: InputDecoration(labelText: "Level Separation"),
                  onChanged: (text) {
                    builder.levelSeparation = int.tryParse(text) ?? 100;
                    this.setState(() {});
                  },
                ),
              ),
              Container(
                width: 100,
                child: TextFormField(
                  initialValue: builder.subtreeSeparation.toString(),
                  decoration: InputDecoration(labelText: "Subtree separation"),
                  onChanged: (text) {
                    builder.subtreeSeparation = int.tryParse(text) ?? 100;
                    this.setState(() {});
                  },
                ),
              ),
              Container(
                width: 100,
                child: TextFormField(
                  initialValue: builder.orientation.toString(),
                  decoration: InputDecoration(labelText: "Orientation"),
                  onChanged: (text) {
                    builder.orientation = int.tryParse(text) ?? 100;
                    this.setState(() {});
                  },
                ),
              ),
              RaisedButton(
                onPressed: () {
                  final node12 = Node(rectangleWidget(r.nextInt(100)));
                  var edge =
                      graph.getNodeAtPosition(r.nextInt(graph.nodeCount()));
                  print(edge);
                  graph.addEdge(edge, node12);
                  setState(() {});
                },
                child: Text("Add"),
              )
            ],
          ),
          Expanded(
            child: InteractiveViewer(
              constrained: false,
              boundaryMargin: EdgeInsets.all(100),
              minScale: 0.01,
              maxScale: 5.6,
              child:
              GraphView(
                graph: graph,
                algorithm:
                    BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
                paint: Paint()
                  ..color = Colors.green
                  ..strokeWidth = 3
                  ..style = PaintingStyle.stroke,
                builder: (Node node) {
                  // I can decide what widget should be shown here based on the id
                  var a = node.key!.value as int;

                  return rectangleWidget(a);
                },
              ),
            ),
          ),
        ],
      )),
    );
  }

  Random r = Random();

  Widget rectangleWidget(int a) {
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
            ],
          ),
          child: Text('Node ${a}')),
    );
  }

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
var a;
  @override
  void initState() {


    final node1 = Node.Id(1);
    final node2 = Node.Id(2);
    final node3 = Node.Id(3);
    final node4 = Node.Id(4);
    final node5 = Node.Id(5);
    final node6 = Node.Id(6);
    final node8 = Node.Id(7);
    final node7 = Node.Id(100);
    final node9 = Node.Id(9);
    final node10 = Node(rectangleWidget(
        10)); //using deprecated mechanism of directly placing the widget here
    final node11 = Node(rectangleWidget(11));
    final node12 = Node(rectangleWidget(12));

    graph.addEdge(node1, node2);
    graph.addEdge(node1, node3, paint: Paint()..color = Colors.red);
    graph.addEdge(node1, node4, paint: Paint()..color = Colors.blue);
    graph.addEdge(node2, node5);
    graph.addEdge(node2, node6);
    graph.addEdge(node6, node7, paint: Paint()..color = Colors.red);
    graph.addEdge(node6, node8, paint: Paint()..color = Colors.red);
    graph.addEdge(node4, node9);
    graph.addEdge(node4, node10, paint: Paint()..color = Colors.black);
    graph.addEdge(node4, node11, paint: Paint()..color = Colors.red);
    graph.addEdge(node11, node12);


    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
    super.initState();
  }
}
