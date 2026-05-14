import 'dart:ui';
class TimelineItemModel {
  final String title;
  final String? statusLabel;
  final String value;
  final bool highlight;
  final String? reason;
  final Color? statusColor;
  final String? changedByName;

  TimelineItemModel({
    required this.title,
    required this.value,
    this.statusLabel,
    this.highlight = false,
    this.reason,
    this.statusColor,
    this.changedByName,
  });
}