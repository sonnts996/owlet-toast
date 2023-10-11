import 'package:example/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:overlay_manager/overlay_manager.dart';
import 'package:owlet_toast/owlet_toast.dart';

void main() {
  final navKey = GlobalKey<NavigatorState>();
  final appToast = AppToast(overlayManager: GlobalOverlayManager(navigatorKey: navKey));
  runApp(MyApp(
    appToast: appToast,
    navKey: navKey,
  ));
}



class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.navKey, required this.appToast});

  final GlobalKey<NavigatorState> navKey;
  final AppToast appToast;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Owlet Toast Demo', appToast: appToast),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.appToast});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final AppToast appToast;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
                onPressed: () {
                  widget.appToast.showInformation('Hello World');
                },
                child: const Text('Show Information Toast')),
            const SizedBox(height: 8),
            ElevatedButton(
                onPressed: () {
                  widget.appToast.showError('This is error message');
                },
                child: const Text('Show Error Toast')),
            const SizedBox(height: 8),
            ElevatedButton(
                onPressed: () {
                  widget.appToast.showWaring('Position of toast is relative');
                },
                child: const Text('Show Warning Toast')),
            const SizedBox(height: 8),
            ElevatedButton(
                onPressed: () {
                  widget.appToast.showSuccess('Celebration!');
                },
                child: const Text('Show Success Toast')),
            const SizedBox(height: 8),
            ElevatedButton(
                onPressed: () {
                  widget.appToast.showLottieSuccess('The icon appear after the toast showing!');
                },
                child: const Text('Lottie Success Toast')),
            const SizedBox(height: 8),
            ElevatedButton(
                onPressed: () {
                  widget.appToast.showAnimated('Celebration!');
                },
                child: const Text('Show Animated Toast')),
            const SizedBox(height: 8),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
