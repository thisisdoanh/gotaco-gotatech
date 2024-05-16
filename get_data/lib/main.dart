import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StompClient? stompClient;

  void connectStompClient() {
    stompClient = StompClient(
      config: StompConfig.sockJS(
        url: 'http://54.151.200.98:8080/ws',
        onConnect: onStompConnect,
        onWebSocketError: (dynamic error) {
          print(error.toString());
        },
      ),
    );

    try {
      stompClient!.activate();
    } catch (e) {
      print(e.toString());
    }
  }

  String text1 = "";
  String text2 = "";

  void onStompConnect(StompFrame frame) {
    stompClient!.subscribe(
      destination: '/topic/messages',
      callback: (StompFrame frame) {
        text1 = frame.command;
        text2 = frame.body ?? "";
        printWrapped(text2);
        setState(() {});
      },
    );
  }

  void printWrapped(String text) {
    print("object\n\n");
    final pattern = RegExp('.{1,200}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
    print("\n\nobject");
  }

  @override
  void initState() {
    connectStompClient();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(text1),
            SizedBox(
              height: 20,
            ),
            Text(text2),
          ],
        ),
      ),
    );
  }
}
