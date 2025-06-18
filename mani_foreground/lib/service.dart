import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:background_mode_new/background_mode_new.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ForegroundService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initializeService() async {
    await AndroidAlarmManager.initialize();
    
    // Configurar notificaciones
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> bringToForeground() async {
    // Verifica la versión de Android
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = androidInfo.version.sdkInt;

      if (sdkInt >= 31) { // Android 12 o superior
        // Usar notificación de alta prioridad
        const AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'foreground_service',
          'Foreground Service',
          importance: Importance.max,
          priority: Priority.high,
          fullScreenIntent: true,
          category: AndroidNotificationCategory.alarm,
        );

        await flutterLocalNotificationsPlugin.show(
          0,
          'Atención requerida',
          'Toca para abrir la aplicación',
          const NotificationDetails(android: androidPlatformChannelSpecifics),
        );
      } else {
        // Para versiones anteriores, usar el método antiguo
        try {
          BackgroundMode.bringToForeground();
        } catch (e) {
          print('Error al traer app al frente: $e');
        }
      }
    }
  }
}