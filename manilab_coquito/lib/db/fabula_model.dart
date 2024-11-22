import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FabulaModel {
  late int id;
  late String name;
  late String message;
  late AssetImage imageBody;
  late AssetImage imageHeader;
  FabulaModel({
    required this.id,
    required this.name,
    required this.message,
    required this.imageBody,
    required this.imageHeader,
  });

  factory FabulaModel.fromJson(Map<String, dynamic> json) {
    return FabulaModel(
      id: json['id'],
      name: json['name'],
      message: json['message'],
      // imageBody: Image(
      //   image: AssetImage(json['image']),
      // ),
      imageBody: AssetImage(json['image']),
      // imageHeader: Image(
      //   image: AssetImage(json['imageHeader']),
      // ),
      imageHeader: AssetImage(json['imageHeader']),
    );
  }
}

// List<FabulaModel> dataSource = [
//   FabulaModel(
//     id: 1, 
//     name: "El asno y el lobo",
//     imageUrl: const Image(
//       image: AssetImage('assets/header_1.jpg'),
//       // width: 40,
//       // height: 40,
//     ),
//   )
// ];

// Read From JSON
Future<List<FabulaModel>> loadFabulas() async {
  final String jsonString = await rootBundle.loadString('assets/db/data.json');
  final List<dynamic> jsonData = json.decode(jsonString);
  return jsonData.map((json) => FabulaModel.fromJson(json)).toList();
}