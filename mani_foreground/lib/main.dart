import 'dart:async';
import 'dart:io';
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// import 'package:background_mode_new/background_mode_new.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mani_foreground/service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';
// import 'package:workmanager/workmanager.dart';

const platform = MethodChannel('com.example.app/channel');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ForegroundService.initializeService();
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
  // int _counter = 0;

  // final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
  // Timer? _timer;

  @override
  void initState() {
    super.initState();
    // initializeWorkManager();
    // initializeNotifications();
    // toForeground();
    // initializeWorkManager();
    initializeAlarmManager();
  }

  // Future<void> initializeNotifications() async {
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');

  //   final InitializationSettings initializationSettings =
  //       InitializationSettings(android: initializationSettingsAndroid);

  //   await notificationsPlugin.initialize(initializationSettings);
  // }

  // void toForeground() {
  //   print('TODO: FM App is in foreground');
  //   _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
  //     print('TODO: FM Load App');
  //     await showHighPriorityNotification();
  //   });
  // }

  // Future<void> showHighPriorityNotification() async {
  //   const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
  //     'foreground_service',
  //     'Foreground Service',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     fullScreenIntent: true,
  //     category: AndroidNotificationCategory.alarm,
  //     visibility: NotificationVisibility.public,
  //   );

  //   await notificationsPlugin.show(
  //     0,
  //     'Atención Requerida',
  //     'Tu aplicación necesita atención',
  //     const NotificationDetails(android: androidDetails),
  //   );
  // }

  // @override
  // void dispose() {
  //   _timer?.cancel();
  //   super.dispose();
  // }

  // Future<void> initializeWorkManager() async {
  //   await Workmanager().initialize(
  //     callbackDispatcher,
  //     isInDebugMode: true
  //   );
    
  //   await Workmanager().registerPeriodicTask(
  //     "foregroundTask",
  //     "foregroundTask",
  //     frequency: Duration(minutes: 15), // Mínimo 15 minutos en Android
  //     constraints: Constraints(
  //       networkType: NetworkType.connected,
  //       requiresBatteryNotLow: false,
  //     ),
  //   );
  // }

  // toForeground() {
  //   print('TODO: FM App is in foreground');
  //   Timer.periodic(const Duration(seconds: 10), (timer) {
  //     print('TODO: FM Load App');
  //     BackgroundMode.bringToForeground();
  //     // startMainActivity();
  //     // initializeWorkManager();
  //   });
  // }
  // void _incrementCounter() {
  //   setState(() {
  //     // Timer.periodic(const Duration(seconds: 10), (timer) {
  //     //   print('TODO: FM Load App');
  //     //   traerAlFrente();
  //     // });
  //     _counter++;
  //   });
  // }

  // Future<void> startMainActivity() async {
  //   try {
  //     // TODO: FM LoadApp
  //     print('FM Load APP');
  //     await platform.invokeMethod('startMainActivity');
  //   } on PlatformException catch (e) {
  //     print('Failed to start main activity: ${e.message}');
  //   }
  // }

  // @pragma('vm:entry-point')
  // void callbackDispatcher() {
  //   Workmanager().executeTask((taskName, inputData) {
  //     // Your background task logic here
  //     return Future.value(true);
  //   });
  // }

  // static Future<void> realizarTareaPeriodica() async {
  //   // Implementa aquí tu lógica de tarea periódica
  //   print('Ejecutando tarea periódica...');
  //   // Por ejemplo:
  //   // await actualizarDatos();
  //   // await sincronizarConServidor();
  // }
  
  // static Future<void> cancelarTareas() async {
  //   await Workmanager().cancelAll();
  //   print('Todas las tareas han sido canceladas');
  // }
  // Future<void> requestNotificationPermission() async {
  //   if (Platform.isAndroid) {
  //     final androidInfo = await DeviceInfoPlugin().androidInfo;
  //     if (androidInfo.version.sdkInt >= 33) {
  //       final status = await Permission.notification.request();
  //       if (status.isDenied) {
  //         // Manejar el caso cuando el usuario niega los permisos
  //       }
  //     }
  //   }
  // }
  // Future<void> traerAlFrente() async {
  //   await ForegroundService.bringToForeground();
  // }
  Future<void> initializeAlarmManager() async {
    await AndroidAlarmManager.initialize();
    
    await AndroidAlarmManager.periodic(
      const Duration(minutes: 1),
      0, // ID único para la alarma
      foregroundCallback,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );
  }

  @pragma('vm:entry-point')
  static Future<void> foregroundCallback() async {
    final FlutterLocalNotificationsPlugin notifications = 
        FlutterLocalNotificationsPlugin();
    
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'foreground_service',
      'Foreground Service',
      importance: Importance.max,
      priority: Priority.high,
      fullScreenIntent: true,
    );

    await notifications.show(
      0,
      'Atención Requerida',
      'Tu aplicación necesita atención',
      const NotificationDetails(android: androidDetails),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Workmanager().initialize(
    //   callbackDispatcher, // Pass the top-level function
    //   isInDebugMode: true
    // );
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
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            SizedBox(
              height: 20,
            ),
            // ElevatedButton(
            //   onPressed: requestNotificationPermission,
            //   child: const Text('Solicitar permiso de notificación'),
            // ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     // Muestra la notificación de alta prioridad
//     await showHighPriorityNotification();
//     return Future.value(true);
//   });
// }