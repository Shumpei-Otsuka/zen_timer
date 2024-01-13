import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zen_timer/zen.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const ZenApp());
}

class ZenApp extends StatelessWidget {
  const ZenApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    return MaterialApp(
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
      title: 'ZEN Timer',
      home: const ZenHomePage(title: 'ZEN Timer Home'),
    );
  }
}

class ZenHomePage extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String? startDateTime;
  const ZenHomePage({super.key, required this.title, this.startDateTime});

  @override
  State<ZenHomePage> createState() => _ZenHomePageState();
}

class _ZenHomePageState extends State<ZenHomePage> {

  String _startDateTime = '';
  void _onStartDateTimeUpdate() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _startDateTime =
          DateFormat('yyyy-MM-dd – kk:mm:ss').format(DateTime.now());
    });
  }

  String _endDateTime = '';
  void _onEndDateTimeReceived(String endDateTime) {
    setState(() {
      _endDateTime = endDateTime;
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
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor: Colors.white70,
        title: Text(widget.title, selectionColor: Colors.black),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
              ),
              onPressed: () {
                _onStartDateTimeUpdate();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ZenPage(onDateTimeReceived: _onEndDateTimeReceived,)),
                );
              },
              child: SvgPicture.asset('assets/Enso.svg', // Replace with your asset path
                width: 150.0, // Optional, to set the width
                height: 150.0, // Optional, to set the height
              ),
            ),
            const SizedBox(
                height: 30
            ),
            const Text(
              'Start Datetime:',
            ),
            Text(
              '$_startDateTime',
            ),
            const Text(
              'End Datetime:',
            ),
            Text(
              '$_endDateTime',
            ),
          ],
        ),
      ),
    );
  }
}
