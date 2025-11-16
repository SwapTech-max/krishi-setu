import 'package:flutter/material.dart';

@immutable
class LearningContent {
  const LearningContent({
    required this.id,
    required this.title,
    required this.summary,
    required this.imageUrl,
    required this.type,
    required this.duration,
  });

  final String id;
  final String title;
  final String summary;
  final String imageUrl;
  final String type;
  final String duration;
}

