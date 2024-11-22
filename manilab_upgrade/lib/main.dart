import 'dart:convert';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
// import 'package:new_version/new_version.dart';
import 'package:package_info_plus/package_info_plus.dart';
// import 'package:upgrader/upgrader.dart';
import 'package:http/http.dart' as http;
// import 'package:html/parser.dart'; // Biblioteca para analizar el HTML
// import 'package:html/dom.dart'; // Para manipular el DOM
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String androidLatestVersion = '';
  String iosLatestVersion = '';
  PackageInfo? packageInfo;
  // final newVersion = NewVersion(
  //   iOSId: 'com.google.Vespa',
  //   androidId: 'com.qhanati.qtiauthenticator',
  // );

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  bool laterMesssage() {
    return true;
  }
  //call initiaze function
  @override
  void initState() {
    super.initState();
    // _checkPlayStore('com.qhanati.qtiauthenticator').then((value) => versionApp = value);
    _checkPlayStore('com.qhanati.qtiauthenticator');
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        this.packageInfo = packageInfo;
      });
    });
    _checkAppStore('org.nadadventist.actsauthenticator').then((value) => iosLatestVersion = value!);
    scrapeWebsite();
    Future.delayed(Duration.zero, () {
      showDialog(context: context, 
      builder: (BuildContext context) {
        return showAlert();
      });
    });
  }

  _checkPlayStore(String packageName) async {
    try {
      final uri = Uri.https("play.google.com", "/store/apps/details", {"id": packageName});
      // late String latestVersion;
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        // updateView();
        setState(() {
          androidLatestVersion = RegExp(r',\[\[\["([0-9,\.]*)"]],').firstMatch(response.body)!.group(1)!;
        });
      }
      // return latestVersion; 
    } catch (e) {
      print('Error checking Play Store version: $e');      
    }
  }
  updateView() {
    setState(() {});
  }
  Future<String?> _checkAppStore(String bundleId) async {
    try {
      final uri = Uri.https("itunes.apple.com", "/lookup", {"bundleId": bundleId});
      final response = await http.get(uri);
      // body > div.ember-view > main > div.animation-wrapper.is-visible > section.l-content-width.section.section--bordered.whats-new > div.l-row.whats-new__content > div.l-column.small-12.medium-3.large-4.small-valign-top.whats-new__latest > div > p
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['resultCount'] > 0) {
          return data['results'][0]['version'];
        }
      }
      return null;
    } catch (e) {
      print('Error checking App Store version: $e');
      return null;
    }
  }

  Widget showAlert() {
    // var versionApp = _checkPlayStore('com.qhanati.qtiauthenticator');
    // return UpgradeAlert(
    //   upgrader: Upgrader(
    //     storeController: UpgraderStoreController(
    //       onAndroid: () => UpgraderAppcastStore(appcastURL: 'https://play.google.com/store/apps/details?id=com.qhanati.qtiauthenticator'),
    //     )
    //   ),
    //   showReleaseNotes: true,
    //   showLater: true,
    //   onLater: () => laterMesssage(),
    //   child: Card(
    //     margin: EdgeInsets.all(50),
    //     child: Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           Text('Play Store Version: $latestVersion'),
    //           Text('App Version: ${packageInfo!.version}'),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    // return Container(
    //   margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
    //   child: UpgradeCard(
    //     upgrader: Upgrader(
    //       storeController: UpgraderStoreController(
    //         onAndroid: () => UpgraderPlayStore(
    //         ),
    //         oniOS: () => UpgraderAppcastStore(appcastURL: 'https://itunes.apple.com/us/app/your-app-name/id284882215?mt=8'),
    //       ),
    //     ),
    //     margin: EdgeInsets.all(20),
    //     showReleaseNotes: true,
    //   ),
    // );

    // return PopScope(
    //   canPop: false,
    //   child: Card(
    //     margin: EdgeInsets.symmetric(horizontal: 5*9, vertical: 20*12),
    //     child: Center(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Text('********* ONLINE Version ***********'),
    //           Text('Play Store Version: $androidLatestVersion'),
    //           Text('Apple Store Version: $iosLatestVersion'),
    //           Text('********* LOCAL Version ***********'),
    //           Text('Android App Version: ${packageInfo!.version}'),
    //           Text('iOS App Version: VERSION ${packageInfo!.version}'),
    //           ElevatedButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             }, 
    //             child: const Text('Update')
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    return AlertDialog(
      title: const Text('Update Available'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('********* ONLINE Version ***********'),
          Text('Play Store Version: $androidLatestVersion'),
          Text('Apple Store Version: $iosLatestVersion'),
          Text('********* LOCAL Version ***********'),
          Text('Android App Version: ${packageInfo!.version}'),
          Text('iOS App Version: VERSION ${packageInfo!.version}'),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // Navigator.of(context).pop();
            _launchURL();
          },
          child: const Text('Update'),
        ),
      ],
    );
  }

  _launchURL() async {
    final Uri url = Uri.parse('https://play.google.com/store/apps/details?id=com.qhanati.qtiauthenticator');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          throw Exception('Could not launch $url');
      }
  }
  Future<void> scrapeWebsite() async {
    final url = Uri.parse('https://apps.apple.com/us/app/acts-authenticator/id6503090953');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final document = parse(response.body);
        final titles = document.querySelectorAll('body > div.ember-view > main > div.animation-wrapper.is-visible > section.l-content-width.section.section--bordered.whats-new > div.l-row.whats-new__content > div.l-column.small-12.medium-3.large-4.small-valign-top.whats-new__latest > div > p'); // Modifica el selector según el sitio web
        for (var title in titles) {
          print(title.text.trim());
          // iosLatestVersion = title.text.trim().toUpperCase();
          // updateView();
          setState(() {
            iosLatestVersion = title.text.trim().toUpperCase();
          });
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Ocurrió un error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // newVersion.showAlertIfNecessary(context: context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            FloatingActionButton(
              onPressed: () => {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return showAlert();
                  }
                )
              }, 
              child: const Icon(Icons.cloud)
            ),
            SizedBox(height: 10,),
            FloatingActionButton(
              onPressed: () => {
                scrapeWebsite()
              }, 
              child: const Icon(Icons.person)
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
