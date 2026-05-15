import 'package:flutter/material.dart';

class TimelineItemModel {
  final String title;
  final String? statusLabel;
  final String value;
  final DateTime dateTime;

  final String? reason;
  final Color? statusColor;

  final String? changedByName;

  // 🔥 ADD THESE
  final String? fromName;
  final String? toName;

  TimelineItemModel({
    required this.title,
    required this.value,
    required this.dateTime,
    this.statusLabel,
    this.reason,
    this.statusColor,
    this.changedByName,
    this.fromName,
    this.toName,
  });
}