import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool animationRunning = true;
  bool platformThreadBusy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Blocking platform thread")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                animationRunning
                    ? const CircularProgressIndicator()
                    : const Text('> Animation stopped <'),
                const SizedBox(height: 16),
                ElevatedButton(
                    style: platformThreadBusy
                        ? ElevatedButton.styleFrom(backgroundColor: Colors.red)
                        : null,
                    onPressed: () async {
                      const platform =
                          MethodChannel('blocking_platform_thread');
                      setState(() {
                        platformThreadBusy = true;
                      });
                      await platform.invokeMethod('work5seconds');
                      setState(() {
                        platformThreadBusy = false;
                      });
                    },
                    child: const Text('Make platform thread busy for 5s')),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      animationRunning = !animationRunning;
                    });
                  },
                  child: animationRunning
                      ? const Text('Stop Animation')
                      : const Text('Start Animation'),
                ),
              ],
            ),
          ),
        ));
  }
}
