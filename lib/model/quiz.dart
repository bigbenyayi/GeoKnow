import 'dart:convert';

import 'package:flutter/material.dart';

class Quiz {
  final String imageUrl;
  final String answer;

  Quiz({required this.imageUrl, required this.answer});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      imageUrl: json['imageUrl'] as String,
      answer: json['answer'] as String,
    );
  }

  static Future<List<Quiz>> loadFromAsset(BuildContext context) async {
    final dynamic jsonString = await DefaultAssetBundle.of(context).loadString('assets/data/bollard_quiz.json');
    final List<dynamic> data = json.decode(jsonString);
    return data.map((dynamic e) => Quiz.fromJson(e)).toList();
  }
}
