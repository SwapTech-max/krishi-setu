import 'package:flutter/material.dart';

@immutable
class QnaItem {
  const QnaItem({
    required this.id,
    required this.question,
    required this.answer,
    required this.askedBy,
    required this.expertName,
    required this.answeredAt,
  });

  final String id;
  final String question;
  final String answer;
  final String askedBy;
  final String expertName;
  final DateTime answeredAt;
}

