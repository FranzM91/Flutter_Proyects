import 'package:flutter/material.dart';
import 'package:mani_overlay/home_page.dart';
import 'package:mani_overlay/overlays/messanger_chathead.dart';
import 'package:mani_overlay/overlays/text_field_overlay.dart';
import 'package:mani_overlay/overlays/true_caller_overlay.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: TrueCallerOverlay(),
      // home: TextFieldOverlay(),
      home: MessangerChatHead(),
      // home: Material(
      //   child: Text("Overlay"),
      // ),
      // home: Text(''),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}